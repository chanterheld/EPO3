library ieee;
use ieee.std_logic_1164.all;

architecture behav of f_add is 
begin 
 s <= (a xor b xor c_in);
 c_out <= ((a and b) or (c_in and a) or (c_in and b)); 
end behav;
