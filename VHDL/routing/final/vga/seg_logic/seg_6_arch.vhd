library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_6 is

begin
state <= not( ( c xor b ) or d or ( not( b ) nor a ) );

end behav;
