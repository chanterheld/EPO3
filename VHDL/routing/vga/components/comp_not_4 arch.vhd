library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of comp_nor_8 is
begin
nor_out <= '1' when (a = "00000000") else '0';
comp_out <= '1' when (a = comp_s) else '0';
end behaviour;
