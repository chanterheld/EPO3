library ieee;
use ieee.std_logic_1164.all;

entity fsm_sel is 
	port(	idle_1	: in	std_logic;
		idle_2	: in	std_logic;
		idle_3 	: in	std_logic;

		ad_sel_1: in	std_logic;
		reg_sel_1: in	std_logic;
		x_ins_1	: in	std_logic;
		y_ins_1	: in	std_logic;

		ad_sel_2: in	std_logic;
		reg_sel_2: in	std_logic;
		x_ins_2	: in	std_logic;
		y_ins_2	: in	std_logic;

		ad_sel_3: in	std_logic;
		reg_sel_3: in	std_logic;
		x_ins_3	: in	std_logic;
		y_ins_3	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;

		s_type	: out	std_logic;
		reset	: out	std_logic
	);
end entity;
