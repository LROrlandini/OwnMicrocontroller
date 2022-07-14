library ieee;
use ieee.std_logic_1164.all;


entity ulpsystem is
	port (clk:	in	std_logic;
	      reset:	in	std_logic
	);
end;


architecture main of ulpsystem is
	component ulp
		port (	
			data:		inout	std_logic_vector(21 downto 0);
			address:	out	std_logic_vector(7 downto 0);
			oe:		out	std_logic;
			we:		out	std_logic;
			rst:		in		std_logic;
			clk:		in		std_logic
		);
	end component;

	component sram64kx22 
		port (
			ncs1:		in		std_logic;
			cs2: 		in 	std_logic;        
			addr: 	in 	std_logic_vector(15 downto 0);
			data: 	inout std_logic_vector(21 downto 0);
			nwe:		in 	std_logic;        					-- not write enable
			noe: 		in 	std_logic        						-- not output enable 
		);
	end component;

	signal	ncs,cs:	std_logic;
	signal	oe,we:	std_logic;
	signal	data:		std_logic_vector(21 downto 0);
	signal  	adrram: 	std_logic_vector(15 downto 0);
	signal  	adrcpu:	std_logic_vector(7 downto 0);
	
	begin
		CPU:	ulp			port map(rst => reset, clk => clk, oe => oe, we => we, data => data, address => adrcpu); 
		RAM:	sram64kx22	port map(ncs1 => ncs, cs2 => cs, data => data, addr => adrram, nwe => we, noe => oe);	

		ncs <= '0';
		cs  <= '1';
		adrram <= "00000000" & adrcpu;
end;

library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end;

architecture testmain of testbench is

component ulpsystem
	port (
		clk:	 in	std_logic;
	   reset: in	std_logic
	);
end component;

signal clk,reset:	std_logic;

begin
	SYS: ulpsystem	port map(clk => clk, reset => reset);

process
	begin
		clk <= '0';
		reset <= '1';
		report "CPU init";
		WAIT FOR 50 ns;
		clk <= '0';
		reset <= '0';
		report "CPU reset";
		WAIT FOR 50 ns;
		clk <= '1';
		WAIT FOR 25 ns;
		reset <= '1';
		WAIT FOR 25 ns;
		report "CPU running";
		loop
			clk <= '0';
		   WAIT FOR 50 ns;
		   clk <= '1';
		   WAIT FOR 50 ns;		-- clock.
		end loop;
		report "end";
  end process;
end;

configuration tb_cfg of testbench is
	for testmain
	end for;
end tb_cfg;






