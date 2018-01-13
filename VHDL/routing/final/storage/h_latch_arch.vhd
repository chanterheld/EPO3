library ieee;
use ieee.std_logic_1164.all;

architecture behav of h_latch is
signal intrm_1, intrm_2, intrm_3, q_s : std_logic;
begin
intrm_1 <= (t nor hold);
intrm_2 <= ((not(t)) nor hold);
intrm_3 <= (q_s nor intrm_2);
q_s <= (intrm_1 nor intrm_3);
q <= q_s;
end behav;
