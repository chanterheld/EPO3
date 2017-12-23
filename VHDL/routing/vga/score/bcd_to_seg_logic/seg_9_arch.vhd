library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_1 is

begin
state <= not( c or not( b ) or a );

end behav;
