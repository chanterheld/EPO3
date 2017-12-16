library ieee;
use ieee.std_logic_1164.all;

entity storage_fsm is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		a_flag	: in	std_logic;
		fsm_out	: out	std_logic
	);
end entity storage_fsm;