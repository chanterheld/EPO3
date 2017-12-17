library ieee;
use ieee.std_logic_1164.all;


architecture behav of comp_8 is
begin
equal <= '1' when (a = b) else '0';
end behav;
