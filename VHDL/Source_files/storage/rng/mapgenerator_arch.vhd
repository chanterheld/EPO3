library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of mapgenerator is
signal x0r0, x0r1, x0r2, x0r3, x0r4, x0r5, x0r6, x0r7, x1r0, x1r1, x1r2, x1r3, x1r4, x1r5, x1r6, x1r7: std_logic; --logic voor de rijen
signal a0, a1, a2, a3, a4, a5 : std_logic;
signal c0, c1, s1, s2, s3, s4 : std_logic;

begin
a5 <= address(5) xor seed(5);
a4 <= address(4) xor seed(4);
a3 <= address(3) xor seed(3);
a2 <= address(2) xor seed(2);
a1 <= address(1) xor seed(1);
a0 <= address(0) xor seed(0);

x0r0 <= (a1 and a0) or (a2 and not(a0));
x1r0 <= (not(a2) and not(a1)) or ((a2 and a1) and a0);

x0r1 <= (a1 and a0) or (a2 and a0);
x1r1 <= (not(a2) and a1) or (a2 and not(a1) and a0); 

x0r2 <= a0 or not(a2);
x1r2 <= (a1 and not(a0)) or (a2 and a1);

x0r3 <= a2 and a1;
x1r3 <= not(a2) and a1;

x0r4 <= (not(a2) and a1) or (a1 and not(a0)) or (a2 and not(a1) and a0);
x1r4 <= a2 or not(a1) or not(a0);

x0r5 <= a2 and a1 and a0;
x1r5 <= (a1 and a0) or (a2 and a0);

x0r6 <= a2 or not(a1) or not(a0);
x1r6 <= (not(a2) and a1) or (a2 and not(a1) and a0);

x0r7 <= not(a0) or (not(a2) and a1);
x1r7 <= a2 or not(a0);

process(a5, a4, a3, clk)
begin
if (rising_edge(clk)) then
	if (a5 = '0' and a4 = '0'  and a3 = '1') then 
		c0 <= x1r1;
		c1 <= x0r1;

	elsif (a5 = '0' and a4 = '1'  and a3 = '0') then
		c0 <= x1r2;
		c1 <= x0r2;

	elsif (a5 = '0' and a4 = '1'  and a3 = '1') then
		c0 <= x1r3;
		c1 <= x0r3;

	elsif (a5 = '1' and a4 = '0'  and a3 = '0') then
		c0 <= x1r4;
		c1 <= x0r4;

	elsif (a5 = '1' and a4 = '0'  and a3 = '1') then
		c0 <= x1r5;
		c1 <= x0r5;

	elsif (a5 = '1' and a4 = '1'  and a3 = '0') then
		c0 <= x1r6;
		c1 <= x0r6;

	elsif (a5 = '0' and a4 = '0' and a3 = '0') then
		c0 <= x1r0;
		c1 <= x0r0;
	else
		c0 <= x1r7;
		c1 <= x0r7;
	end if;
end if;
end process;
s1 <= (not address(2)) and seed(6);
s2 <= (address(2) and seed(7)) and (address(0) or address(1));
s3 <= (not address(5)) and seed(8);
s4 <= (address(5) and seed(9)) and (address(3) or address(4));

color(0) <= (((c0 xor s1) xor s2) xor s3) xor s4;
color(1) <= (((c1 xor s1) xor s2) xor s3) xor s4;
end architecture;
