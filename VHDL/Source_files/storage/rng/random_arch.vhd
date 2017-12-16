library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of random is
signal tap6 : std_logic;

begin
process (clk, reset, restart)
begin
if (clk'event and clk = '1') then
	if (reset = '1') then
		seed <= "0000000000";
	elsif (restart = '1') then 
		seed <= (seed(8) & seed(7) & tap6 & seed(5) & seed(4) & seed(3) & seed(2)& seed(1) & seed(0)
			  & seed(9));
	else
		seed <= seed;
	end if;
end if;
end process;
tap6 <= seed(6) xor not(seed(9));

end architecture;