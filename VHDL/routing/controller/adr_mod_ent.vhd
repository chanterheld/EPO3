library ieee;
use ieee.std_logic_1164.all;

entity adr_mod is
	port(	clk	: in	std_logic;
		reg_sel	: in	std_logic;
		ad_sel	: in	std_logic;
		x_ins	: in	std_logic;
		y_ins	: in	std_logic;
		x_l	: in	std_logic;
		x_r	: in	std_logic;
		y_l	: in	std_logic;
		y_r	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);

		edge	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0)		
	);
end adr_mod;

