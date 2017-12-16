library ieee;
use ieee.std_logic_1164.all;

 architecture structural of nr_cnt_y is
component up_one_cnt_3 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		cnt	: out	std_logic_vector(2 downto 0)
	);
end component;

component t_ff is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic
	);
end component;

signal reset_s, intrm_1, comp_out, nr_select  : std_logic;
signal cnt_s : std_logic_vector(2 downto 0);
begin
l1: up_one_cnt_3	port map(clk, reset_s, up_one, cnt_s);
comp_out <=		'1' when (cnt_s = "101") else '0'; --comp
l3: t_ff		port map(clk, reset, intrm_1, nr_select);

intrm_1 <= (comp_out and up_one);
reset_s <= (intrm_1 or reset);
blk_nr <= (nr_select&cnt_s);
reg_rst <= (intrm_1 and nr_select);
end structural; 
