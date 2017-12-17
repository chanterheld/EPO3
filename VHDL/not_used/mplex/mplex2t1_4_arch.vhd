library ieee;
use ieee.std_logic_1164.all;

 architecture behav of mplex2t1_4 is
begin
	q <= b when (sel = '1') else a;
end behav;
