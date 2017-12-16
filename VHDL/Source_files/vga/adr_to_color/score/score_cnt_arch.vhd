library ieee;
use ieee.std_logic_1164.all;

architecture structural of score_cnt is
component up_one_cnt_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		cnt	: out	std_logic_vector(1 downto 0)
	);
end component;

component up_one_cnt_4 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		cnt	: out	std_logic_vector(3 downto 0)
	);
end component;

signal ones_r, tens_r, ones_max: std_logic;
signal ones_s: std_logic_vector(3 downto 0);
begin
l1: up_one_cnt_2 port map(clk, tens_r, ones_max, tens);
l2: up_one_cnt_4 port map(clk, ones_r, plus_one, ones_s);

ones_max <= ones_s(3) and ones_s(0) and plus_one;
tens_r <= reset or game_rst; 
ones_r <= ones_max or tens_r;
ones <= ones_s;
end structural;