library ieee;
use ieee.std_logic_1164.all;

architecture behav of tr_buf_2 is
begin
q <= t when (en = '1') else (others => 'Z');
end behav;
