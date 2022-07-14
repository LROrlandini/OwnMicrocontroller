--
-- Saxion University of Applied Sciences
-- Embedded Systems
--	Spring 2020/2021
--
-- Luciano Regis Orlandini
-- 460952
--
-- ESP32 ULP Co-Processor based design
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity ulp is
	port (	
		data:		inout  std_logic_vector(21 downto 0);
		address: out	 std_logic_vector(7 downto 0);
		oe: 		out	 std_logic;
		we: 		out 	 std_logic; 
		rst:	 	in 	 std_logic;
		clk: 		in 	 std_logic);
end;


architecture behaviour of ulp is
	type registers is array(0 to 4) of std_logic_vector(16 downto 0);
	
	shared variable r: 	registers;  						 -- R0 = Accu; R1, R2, R3 and R4 - GP registers
	signal zero:	std_logic;  						 -- Zero flag
	signal st_cnt:	std_logic_vector(7 downto 0);  -- Stage count for loops
	signal addr:	std_logic_vector(7 downto 0);
	signal pc:		std_logic_vector(7 downto 0);
	signal state:	std_logic_vector(3 downto 0);
	shared variable i, j: integer;
	
begin
	process(clk, rst)
	begin
	   
		if (rst = '0') then 
			r := (others => (others => '0')); -- Initialises all registers and accu with zeros
			zero          <= '0';
			-- st_cnt        <= (others => '0');
			addr	        <= (others => '0');				 -- start execution at memory location 0 
			pc 	        <= (others => '0');
			state	        <= "1111";
		
		elsif rising_edge(clk) then
			if (state = "1111") then 
				pc	<= addr + 1; 
				addr	<= data(15 downto 8);
			else	
				addr	<= pc;
				i := to_integer(unsigned(data(7 downto 4)));
				j := to_integer(unsigned(data(3 downto 0)));
			end if;
		end if;

		case state is
			-- Fetching...
			when "1111" => null;											-- Fetching instruction
			-- SET k
			when "0000" => r(0) := "0" & data(15 downto 0); 	-- R0 = k
			-- ADD Rx, Rx
			when "0001" => r(0) := r(i) + r(j); 					-- R0 = Rx + Rx
			-- SUB Rx, Rx
			when "0010" => r(0) := r(i) - r(j);					 	-- R0 = Rx - Rx
			-- AND Rx, Rx
			when "0011" => r(0) := r(i) AND r(j);				 	-- R0 = Rx AND Rx			
			-- OR Rx, Rx
			when "0100" => r(0) := r(i) OR r(j); 					-- R0 = Rx OR Rx
			-- NOT Rx
			when "0101" => r(0) := NOT r(i);		 					-- R0 = NOT Rx			
			-- MOVE Rsrc, Rdst
			when "0110" => r(j) := r(i); 								-- Rdst = Rsrc	
			-- ST Mem, Rsrc
			when "0111" => null;											-- mem[data(15 downto 8)] = Rsrc	
			-- LD Mem, Rdst
			when "1000" => null;											-- Rdst = mem[data(15 downto 8)]
			-- JUMP Cond, k
			when "1001" => zero <= '0';								-- Jumps to destination
			when others => null;
		end case;	
			
			
			--when "010" => akku <= ("0" & akku(7 downto 0)) + ("0" & data); 	-- add
			--when "011" => akku(7 downto 0) <= akku(7 downto 0) nor data;	-- nor
			--when "101" => akku(8) <= '0';					-- branch not taken, clear carry
			--when others => null;						-- instr. fetch, jcc taken (000), sta (001) 
		
		
		-- Returns to fetch state and checks zero flag
		if (state /= "1111") then
			state <= "1111";
			if (data(21 downto 18) = "0000" OR
				 data(21 downto 18) = "0001" OR
				 data(21 downto 18) = "0010" OR
				 data(21 downto 18) = "0011" OR
				 data(21 downto 18) = "0100" OR
				 data(21 downto 18) = "0101") then
				if (r(0) = "00000000000000000") then
					zero <= '1';
				end if;
			end if;
		-- JUMP
		elsif (data(21 downto 18) = "1001") then
			if (data(17 downto 16) = "00") then
				state <= "1111";
			elsif (data(17 downto 16) = "01") then
				if (zero = '1') then
					state <= "1111";
				else
					state <= "1001";
				end if;
			else
				if (r(0)(16) = '1') then
					state <= "1111";
					r(0)(16) := '0';
				else
					state <= "1001";
				end if;
			end if;		
		else  
			state <= data(21 downto 18);	
		end if;	
	end process;
	
			-- State machine
		--if (states /= "000") then states <= "000"; 				-- fetch next opcode
		--elsif (data(7 downto 6) = "11" and akku(8)='1') then states <= "101";	-- branch not taken
			--else  states <= "0" & not data(7 downto 6); 			-- execute instruction	
		--end if;	
	
	
	
	
	-- output
	address	<= addr when state /= "0111" else data(15 downto 8);
	data 	<= "ZZZZZZZZZZZZZZZZZZZZZZ" when state /= "0111" else "00000" & r(to_integer(unsigned(data(7 downto 4))));
	oe <= '1' when (clk='1' or state  = "0111" or rst='0' or state = "1001") else '0';
	we <= '1' when (clk='1' or state /= "0111" or rst='0') else '0'; 
	
end behaviour;
	
