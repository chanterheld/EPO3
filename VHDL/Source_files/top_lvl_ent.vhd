library ieee;
use ieee.std_logic_1164.all;

entity top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		c_input	: in	std_logic_vector(3 downto 0);

		h_sync	: out	std_logic;
		v_sync	: out	std_logic;
		rgb	: out	std_logic_vector(2 downto 0)
	);
end entity;
