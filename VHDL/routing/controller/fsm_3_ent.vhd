library ieee;
use ieee.std_logic_1164.all;

entity fsm_3 is --eof checks
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		start	: in	std_logic;
		max	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		d_reg	: in	std_logic;
		c_reg	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;
		x_l	: out	std_logic;
		y_l	: out	std_logic;
		x_r	: out	std_logic;
		y_r	: out	std_logic;
		d_r	: out	std_logic;
		c_r	: out	std_logic;
		lvl_up	: out	std_logic;
		game_d	: out	std_logic;
		rst_sc	: out	std_logic;

		idle	: out	std_logic;
		start_1	: out	std_logic
	);
end fsm_3;
