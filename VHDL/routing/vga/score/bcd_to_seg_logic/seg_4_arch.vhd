library ieee;
use ieee.std_logic_1164.all;

architecture behav of seg_4 is

begin
state <= ( b xor a ) and c;

end behav;
