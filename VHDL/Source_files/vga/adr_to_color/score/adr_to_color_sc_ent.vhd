library ieee;
use ieee.std_logic_1164.all;

entity adr_to_color_sc is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		e_n	: out	std_logic;
		color	: out	std_logic_vector(1 downto 0)
		
	);
end entity adr_to_color_sc;
