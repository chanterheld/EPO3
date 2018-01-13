library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of addresscomb is
begin
a(5) <= address(5) xor seed(5);
a(4) <= address(4) xor seed(4);
a(3) <= address(3) xor seed(3);
a(2) <= address(2) xor seed(2);
a(1) <= address(1) xor seed(1);
a(0) <= address(0) xor seed(0);

end behaviour;


