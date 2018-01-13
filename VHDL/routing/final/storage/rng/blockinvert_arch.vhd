library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of blockinvert is
begin
s(0) <= (not address(2)) and seed(6);
s(1) <= (address(2) and seed(7)) and (address(0) or address(1));
s(2) <= (not address(5)) and seed(8);
s(3) <= (address(5) and seed(9)) and (address(3) or address(4));
end behaviour;

