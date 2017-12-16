library ieee;
use ieee.std_logic_1164.all;

entity controller is 
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		update	: in	std_logic;
		flag	: in	std_logic;
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);		

		lvl_up	: out	std_logic;
		dip_sw	: out	std_logic_vector(1 downto 0);
		game_end: out	std_logic;
		set_flag: out	std_logic;
		r_w	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0)		
	);
end entity controller;
