library ieee;
use ieee.std_logic_1164.all;

entity fsm_2 is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		hit	: in	std_logic;
		edge	: in	std_logic;
		flag	: in	std_logic;
		start	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;
		set_fl	: out	std_logic;
		r_w	: out	std_logic;
		c_l	: out	std_logic;

		idle	: out	std_logic;
		start_1	: out	std_logic
	);
end fsm_2;
