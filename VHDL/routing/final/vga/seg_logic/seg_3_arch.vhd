library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_3 is

begin
state <= not( ( ( b nand a ) and c ) or d or (b nor a) );

end behav;
