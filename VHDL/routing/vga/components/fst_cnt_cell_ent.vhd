library ieee;
use ieee.std_logic_1164.all;
 
entity fst_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		q	: out 	std_logic
	);
end fst_cnt_cell;
