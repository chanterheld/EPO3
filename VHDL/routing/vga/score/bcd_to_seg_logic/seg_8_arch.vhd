library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_8 is

begin
state <= not( ( c nor a ) or ( not( b ) nor a ) );

end behav;
