library ieee;
use ieee.std_logic_1164.all;

entity fsm_sel is 
	port(	idle_1	: in	std_logic;
		idle_2	: in	std_logic;
		idle_3 	: in	std_logic;

		s_type	: out	std_logic;
		reset	: out	std_logic
	);
end entity;
