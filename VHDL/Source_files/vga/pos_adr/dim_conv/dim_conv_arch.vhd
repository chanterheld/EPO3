library ieee;
use ieee.std_logic_1164.all;

 architecture behav of dim_conv is
signal intrm: std_logic;
begin
intrm <= (dip_sw(1) xnor dip_sw(0));
block_size(4) <= dip_sw(1) nand dip_sw(0);
block_size(3) <= intrm;
block_size(2) <= dip_sw(0);
block_size(1) <= '1';
block_size(0) <= intrm;
end behav;
