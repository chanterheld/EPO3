-- 40 ms
library IEEE;
use IEEE.std_logic_1164.all;

entity clk_cnt_tb is
end entity clk_cnt_tb;

architecture behav of clk_cnt_tb is
component tr_sync is
	port(	clk	: in	std_logic;	
		reset	: in	std_logic;
		r_reset_x: out	std_logic;
		r_reset_y: out	std_logic;
		cnt_x	: out	std_logic_vector(7 downto 0);
		cnt_y	: out	std_logic_vector(7 downto 0);
		h_sync	: out 	std_logic;
		v_sync	: out	std_logic
	);
end component;

signal clk, reset,  h_sync, v_sync,r_reset_x ,r_reset_y: std_logic;
signal x_cnt_s, y_cnt_s: std_logic_vector(7 downto 0);

begin
clk 	<= 	'1' after 0 ns,
         	'0' after 81380 ps when clk /= '0' else '1' after 81380 ps; --6144015 Hz +- 6.144MHz
reset <= 	'1' after 0 ns,
		'0' after 200 ns;

l5: tr_sync	port map(clk, reset, r_reset_x, r_reset_y, x_cnt_s, y_cnt_s, h_sync, v_sync);
end architecture;