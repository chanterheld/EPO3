-- 70 ms
library ieee;
use ieee.std_logic_1164.all;

entity vga_reg_upd_tb is
end entity;

architecture behav of vga_reg_upd_tb is

component vga_reg_upd is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		val_l	: in	std_logic_vector(2 downto 0);
		val_r	: in	std_logic_vector(2 downto 0);

		load_val: out	std_logic;
		hold_val: out	std_logic;
		set_flag: out	std_logic;
		reg_x	: out	std_logic_vector(2 downto 0);
		reg_y	: out	std_logic_vector(2 downto 0)

	);
end component;

signal clk, reset, flag, flag_next, clr_flag, load_val, hold_val, set_flag : std_logic;
signal y_adr, val_l, val_r, reg_x, reg_y : std_logic_vector(2 downto 0);
signal dip_sw : std_logic_vector(1 downto 0);

begin
l1: vga_reg_upd port map(clk, reset, flag, dip_sw, y_adr, val_l, val_r, load_val, hold_val, set_flag, reg_x, reg_y);

clk 	<=	'0' after 0 ns,
         	'1' after 10 ns when clk /= '1' else '0' after 10 ns;

reset	<= 	'1' after 0 ns,
		'0' after 50 ns;

dip_sw	<= 	"11" after 0 ns;

y_adr	<= 	"010" after 0 ns,
		"011" after 100 ns,
		"111" after 1100 ns;
		

val_l	<= 	"011" after 0 ns;

val_r	<=	"001" after 0 ns,
		"000" after 1700 ns;

process (clk, set_flag, clr_flag, flag)
begin
	if flag = '1' then
		flag_next <= '1';
	else
		flag_next <= '0';
	end if;
	if set_flag = '1' then
		flag_next <= '1';
	elsif clr_flag = '1' then
		flag_next <= '0';
	end if;
	if (rising_edge(clk)) then
		flag <= flag_next;
	end if;	

end process; 

clr_flag <= flag after 60 ns;
end behav;