library ieee;
use ieee.std_logic_1164.all;

entity gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end gated_reg_1;
