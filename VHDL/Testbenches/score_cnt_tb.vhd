library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity score_cnt_tb is
end entity;

architecture behav of score_cnt_tb is
component score_cnt is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		tens	: out	std_logic_vector(1 downto 0);
		ones	: out	std_logic_vector(3 downto 0)
	);
end component;

signal clk, reset, plus_one : std_logic;
signal tens: std_logic_vector(1 downto 0);
signal ones :std_logic_vector(3 downto 0);
begin
L1: score_cnt port map (clk, reset, reset, plus_one, tens, ones);

clk <=		'1' after 0 ns,
		'0' after 10 ns when clk /= '0' else '1' after 10 ns;

reset <=	'1' after 0 ns,
		'0' after 50 ns,
		'1' after 910 ns,
		'0' after 950 ns;

plus_one <=	'0' after 0 ns,
		'1' after 110 ns, 
		'0' after 710 ns,
		'1' after 810 ns;

end behav;
