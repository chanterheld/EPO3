library ieee;
use ieee.std_logic_1164.all;

architecture structural of score_cnt is

component t_ff is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic
	);
end component;

component up_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic;
		and_out	: out	std_logic
	);	
end component;

signal ones_r, tens_r, ones_max, uo2_int: std_logic;
signal ones_s, uo4_int: std_logic_vector(3 downto 0);
begin
--l_tens: up_one_cnt_2 port map(clk, tens_r, ones_max, tens);
tens_1: t_ff port map(clk, tens_r, uo2_int, tens(1));
tens_0: up_cnt_cell port map(clk, tens_r, ones_max, tens(0), uo2_int);

--l_ones: up_one_cnt_4 port map(clk, ones_r, plus_one, ones_s);
ones_3: t_ff port map(clk, ones_r, uo4_int(3), ones_s(3));
ff_gen:
for i in 0 to 2 generate
	ones: up_cnt_cell port map(clk, ones_r, uo4_int(i), ones_s(i), uo4_int(i+1));
end generate;
uo4_int(0) <= plus_one;

ones_max <= ones_s(3) and ones_s(0) and plus_one;
tens_r <= reset or game_rst; 
ones_r <= ones_max or tens_r;
ones <= ones_s;
end structural;