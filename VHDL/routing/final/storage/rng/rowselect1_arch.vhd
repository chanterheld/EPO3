library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of rowselect1 is
signal x1r0, x1r1, x1r2, x1r3, x1r4, x1r5, x1r6, x1r7: std_logic; --logic voor de rijen
signal mux_in : std_logic_vector(2 downto 0);
begin

x1r0 <= (not(a(2)) and not(a(1))) or ((a(2) and a(1)) and a(0));

x1r1 <= (not(a(2)) and a(1)) or (a(2) and not(a(1)) and a(0)); 

x1r2 <= (a(1) and not(a(0))) or (a(2) and a(1));

x1r3 <= not(a(2)) and a(1);

x1r4 <= a(2) or not(a(1)) or not(a(0));

x1r5 <= (a(1) and a(0)) or (a(2) and a(0));

x1r6 <= (not(a(2)) and a(1)) or (a(2) and not(a(1)) and a(0));

x1r7 <= a(2) or not(a(0));

mux_in <= a(5)&a(4)&a(3);

c1 <=	x1r1 when (mux_in = "001") else
	x1r2 when (mux_in = "010") else
	x1r3 when (mux_in = "011") else
	x1r4 when (mux_in = "100") else
	x1r5 when (mux_in = "101") else
	x1r6 when (mux_in = "110") else
	x1r0 when (mux_in = "000") else x1r7;
end behaviour;
