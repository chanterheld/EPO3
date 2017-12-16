library ieee;
use ieee.std_logic_1164.all;

entity score_cnt is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		tens	: out	std_logic_vector(1 downto 0);
		ones	: out	std_logic_vector(3 downto 0)
	);
end entity score_cnt;