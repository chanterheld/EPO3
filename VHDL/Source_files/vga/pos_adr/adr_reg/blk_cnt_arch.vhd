library ieee;
use ieee.std_logic_1164.all;

 architecture structural of blk_cnt is
component up_one_cnt_3 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		cnt	: out	std_logic_vector(2 downto 0)
	);
end component;

signal reset_s, intrm_1, comp_out  : std_logic;
signal cnt_s, grid_size : std_logic_vector(2 downto 0);
begin
l1: up_one_cnt_3	port map(clk, reset_s, up_one, cnt_s);
comp_out <=		'1' when (cnt_s = '1'&dip_sw) else '0'; --comp

intrm_1 <= (comp_out and up_one);
reset_s <= (intrm_1 or reset);
blk_nr <= cnt_s;
cnt_rst <= intrm_1;
end structural; 
