library ieee;
use ieee.std_logic_1164.all;

architecture behav of fst_cnt_cell is
	signal tmp: std_logic;
begin

process (clk)
begin
	if rising_edge(clk) then
		tmp <= (tmp nor reset);
	end if;
end process;
q <= tmp;
end behav;
