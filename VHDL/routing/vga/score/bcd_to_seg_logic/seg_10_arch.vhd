library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_1 is

begin
state <= not( d or ( not( b ) nor a ) or ( c xor ( a nand not( b ) ) ) );

end behav;
