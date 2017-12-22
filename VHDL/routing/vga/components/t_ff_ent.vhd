library ieee;
use ieee.std_logic_1164.all;

 
entity t_ff is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic
	);
end t_ff;
