library ieee;
use ieee.std_logic_1164.all;

architecture behav of hit_det is

begin
hit <= '1' when (data_in = s_type&live_clr) else '0';
end behav;
