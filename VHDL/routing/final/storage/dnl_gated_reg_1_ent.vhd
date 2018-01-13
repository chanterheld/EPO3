library ieee;
use ieee.std_logic_1164.all;

entity dnl_gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load_1	: in	std_logic;
		load_2	: in	std_logic;
		q	: out	std_logic
	);
end dnl_gated_reg_1;
