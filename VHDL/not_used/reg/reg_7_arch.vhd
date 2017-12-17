library ieee;
use ieee.std_logic_1164.all;

 architecture behav of reg_7 is

begin
process (clk)
begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			q <= (others => '0');
		else
			q <= t;
		end if;
	end if;
end process;
end behav;
