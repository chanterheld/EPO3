library ieee;
use ieee.std_logic_1164.all;

architecture structural of flag_reg_2 is
component gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

component gated_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

signal reset_s: std_logic;
begin
data_reg: gated_reg_2 port map(clk, reset, clr_flag, t, q);
flag_reg: gated_reg_1 port map(clk, reset_s, set_flag, '1', flag);
reset_s <= reset or clr_flag;
end structural;
