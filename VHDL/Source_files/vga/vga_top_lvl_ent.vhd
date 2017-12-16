library ieee;
use ieee.std_logic_1164.all;

entity vga_top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		flag	: in	std_logic;
		score_up: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(1 downto 0);

		set_flag: out	std_logic;
		h_sync	: out	std_logic;
		v_sync	: out	std_logic;
		rgb	: out	std_logic_vector(2 downto 0);
		address	: out	std_logic_vector(5 downto 0)
	);
end entity;
