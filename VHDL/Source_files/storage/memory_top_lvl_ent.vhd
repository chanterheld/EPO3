library ieee;
use ieee.std_logic_1164.all;

entity storage_top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		vga_s_fl: in	std_logic;
		ctrl_s_fl: in	std_logic;
		r_w_in	: in	std_logic;
		live_clr: in 	std_logic_vector(1 downto 0);
		vga_adr	: in	std_logic_vector(5 downto 0);
		ctlr_adr: in	std_logic_vector(5 downto 0);

		vga_flag: out	std_logic;
		ctrl_flag: out	std_logic;
		vga_data: out	std_logic_vector(1 downto 0);
		ctrl_data: out	std_logic_vector(2 downto 0)
	);
end entity storage_top_lvl;
