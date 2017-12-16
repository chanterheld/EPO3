library ieee;
use ieee.std_logic_1164.all;

architecture behavior of bcd_to_seg is
signal seg_s : std_logic_vector(12 downto 0);
begin
seg_s(0) <= seg_s(1) and seg_s(3);
seg_s(1) <= not((bcd(2) xnor bcd(0)) or bcd(3) or bcd(1));
seg_s(2) <= '0';
seg_s(3) <= not(((bcd(1) nand bcd(0)) and bcd(2)) or bcd(3) or (bcd(1) nor bcd(0)));
seg_s(4) <= (bcd(1) xor bcd(0)) and bcd(2);
seg_s(5) <= seg_s(3) and seg_s(6) and seg_s(8); --seg(3) or seg(6) or seg(8)
seg_s(6) <= not((bcd(2) xor bcd(1)) or bcd(3) or (not(bcd(1)) nor bcd(0)));
seg_s(7) <= '0';
seg_s(8) <= not((bcd(2) nor bcd(0)) or (not(bcd(1)) nor bcd(0)));
seg_s(9) <= not(bcd(2) or not(bcd(1)) or bcd(0));
seg_s(10) <= not(bcd(3) or (not(bcd(1)) nor bcd(0)) or (bcd(2) xor (bcd(0) nand not(bcd(1)))));
seg_s(11) <= seg_s(10);
seg_s(12) <= '0';
seg <= seg_s;
end behavior;
