library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of rowselect0 is
signal x0r0, x0r1, x0r2, x0r3, x0r4, x0r5, x0r6, x0r7: std_logic; --logic voor de rijen
signal mux_in : std_logic_vector(2 downto 0);
begin

x0r0 <= (a(1) and a(0)) or (a(2) and not(a(0)));

x0r1 <= (a(1) and a(0)) or (a(2) and a(0));

x0r2 <= a(0) or not(a(2));

x0r3 <= a(2) and a(1);

x0r4 <= (not(a(2)) and a(1)) or (a(1) and not(a(0))) or (a(2) and not(a(1)) and a(0));

x0r5 <= a(2) and a(1) and a(0);

x0r6 <= a(2) or not(a(1)) or not(a(0));

x0r7 <= not(a(0)) or (not(a(2)) and a(1));

mux_in <= a(5)&a(4)&a(3);


c0 <=	x0r1 when (mux_in = "001") else
	x0r2 when (mux_in = "010") else
	x0r3 when (mux_in = "011") else
	x0r4 when (mux_in = "100") else
	x0r5 when (mux_in = "101") else
	x0r6 when (mux_in = "110") else
	x0r0 when (mux_in = "000") else x0r7;
end behaviour;
