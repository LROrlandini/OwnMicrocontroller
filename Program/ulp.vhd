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
	type registers is array(4 downto 0) of std_logic_vector(16 downto 0);
	
	shared variable r: 	registers;  						 -- R0 = Accu; R1, R2, R3 and R4 - GP registers
	signal zero:			std_logic;  						 -- Zero flag
	signal st_cnt:			unsigned(7 downto 0);  			 -- Stage count for loops
	signal addreg:			std_logic_vector(7 downto 0);
	signal pc:				std_logic_vector(7 downto 0);
	signal state:			std_logic_vector(3 downto 0);
	shared variable i, j:integer range 0 to 15;
	
begin
	process(clk, rst)
	begin
	   
		if (rst = '0') then 
			r(4 downto 1)    := (others => (others => '0')); -- Initialises all registers and accu with zeros
			r(0)    	  := "ZZZZZZZZZZZZZZZZZ";			 		 -- To avoid setting zero flag at initialization
			zero       <= '0';										 -- Zero flag
			st_cnt     <= (others => '0');
			addreg     <= (others => '0');				 		 -- Start execution at memory location 0 
			pc 	     <= (others => '0');
			state	     <= "1111";									 -- Set to fetch
		
		elsif rising_edge(clk) then
			if (state = "1111") then 
				pc	<= addreg + 1; 
				i := to_integer(unsigned(data(7 downto 4)));
				j := to_integer(unsigned(data(3 downto 0)));
			else	
				addreg	<= pc;
			end if;
		

		case state is
			-- Fetching...
			when "1111" => null;															-- Fetching instruction
			-- SET k
			when "0000" => r(0) := "0" & data(15 downto 0); 					-- R0 = k
			-- ADD Rx, Rx
			when "0001" => r(0) := r(i) + r(j); 									-- R0 = Rx + Rx
			-- SUB Rx, Rx
			when "0010" => r(0) := r(i) - r(j);					 					-- R0 = Rx - Rx
			-- AND Rx, Rx
			when "0011" => r(0) := r(i) AND r(j);				 					-- R0 = Rx AND Rx			
			-- OR Rx, Rx
			when "0100" => r(0) := r(i) OR r(j); 									-- R0 = Rx OR Rx
			-- NOT Rx
			when "0101" => r(0)(15 downto 0) := NOT r(i)(15 downto 0);		-- R0 = NOT Rx (does not affect carry)			
			-- MOVE Rsrc, Rdst
			when "0110" => r(j) := r(i); 												-- Rdst = Rsrc	
			-- ST Mem, Rsrc
			when "0111" => null;															-- mem[data(15 downto 8)] = Rsrc	
			-- LD Mem, Rdst
			when "1000" => r(j) := data(16 downto 0);								-- Rdst = mem[data(15 downto 8)]
			-- JUMP Cond, Addr
			when "1001" => zero <= '0';												-- Jump based or not on condition
			-- JUMPS Cond, Addr
			when "1010" => null;															-- Jump based on stage count
			-- STAGE_INC k
			when "1011" => st_cnt <= st_cnt + (unsigned(data(7 downto 0)));-- Increase stage count by specified amount 
			-- STAGE_DEC k
			when "1100" => st_cnt <= st_cnt - (unsigned(data(7 downto 0)));-- Decrease stage count by specified amount
			-- STAGE_RST
			when "1101" => st_cnt <= "00000000";									-- Reset stage count 
			when others => null;
		end case;	
			
		
		-- Return to fetch state and set/clear zero flag
		if (state /= "1111") then
			state <= "1111";
			if (r(0) = "00000000000000000") then
					zero <= '1';
			else
					zero <= '0';
			end if;
		
		-- JUMP
		elsif (data(21 downto 18) = "1001") then
			if (data(17 downto 16) = "00") then
				state <= "1001";
				addreg <= data(15 downto 8);
				pc <= data(15 downto 8);
			elsif (data(17 downto 16) = "01") then
				if (zero = '1') then
					state <= "1111";
					addreg <= data(15 downto 8);
					pc <= data(15 downto 8);
				elsif (zero = '0') then
					state <= "1001";
				end if;
			elsif (data(17 downto 16) = "10") then
				if (r(0)(16) = '1') then
					state <= "1111";
					addreg <= data(15 downto 8);
					pc <= data(15 downto 8);
					r(0)(16) := '0';
				else
					state <= "1001";
				end if;
			end if;
			
		-- JUMPS
		elsif (data(21 downto 18) = "1010") then
			if (data(17 downto 16) = "01") then
				if (st_cnt <= unsigned(data(7 downto 0))) then
					state <= "1111";
					addreg <= data(15 downto 8);
					pc <= data(15 downto 8);
				else
					state <= "1010";
				end if;
			elsif (data(17 downto 16) = "10") then
				if (st_cnt >= unsigned(data(7 downto 0))) then
					state <= "1111";
					addreg <= data(15 downto 8);
					pc <= data(15 downto 8);
				else
					state <= "1010";
				end if;
			end if;
	
		-- ST
		elsif (data(21 downto 18) = "0111") then
			addreg <= data(15 downto 8);
			state <= "0111";
	
		-- LD
		elsif (data(21 downto 18) = "1000") then
			addreg <= data(15 downto 8);
			state <= "1000";
		
		else  
			state <= data(21 downto 18);	
		end if;	
	end if;
	end process;
	
	
	-- Output
	address	<= addreg;
	data 	<= "ZZZZZZZZZZZZZZZZZZZZZZ" when state /= "0111" else ("11110" & r(i));
	oe <= '1' when (clk='1' or state  = "0111" or rst='0' or state = "1001") else '0';
	we <= '1' when (clk='1' or state /= "0111" or rst='0') else '0'; 
	
end behaviour;
	
