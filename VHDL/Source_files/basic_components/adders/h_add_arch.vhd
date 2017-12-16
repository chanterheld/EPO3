library ieee;
use ieee.std_logic_1164.all;

architecture behav of h_add is 
begin 
 s <= (a xor b);
 c_out <= (a and b); 
end behav;
