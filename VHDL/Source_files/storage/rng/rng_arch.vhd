architecture behav of randomblock is 
signal tap6 : std_logic;
signal x0r0, x0r1, x0r2, x0r3, x0r4, x0r5, x0r6, x0r7, x1r0, x1r1, x1r2, x1r3, x1r4, x1r5, x1r6, x1r7: std_logic;
signal a0, a1, a2, a3, a4, a5 : std_logic;
signal c0, c1, s1, s2, s3, s4 : std_logic;
signal mux_in : std_logic_vector(2 downto 0);
signal seed : std_logic_vector (9 downto 0);

begin
process (clk, reset, restart)
begin
if (clk'event and clk = '1') then
	if (reset = '1') then
		seed <= "0000000000";
	elsif (restart = '1') then 
		seed <= (seed(8) & seed(7) & tap6 & seed(5) & seed(4) & seed(3) & seed(2)& seed(1) & seed(0)
			  & seed(9));
	else
		seed <= seed;
	end if;
end if;
end process;
tap6 <= seed(6) xor not(seed(9));

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

mux_in <= a5&a4&a3;

c0 <= 	x1r1 when (mux_in = "001") else
	x1r2 when (mux_in = "010") else
	x1r3 when (mux_in = "011") else
	x1r4 when (mux_in = "100") else
	x1r5 when (mux_in = "101") else
	x1r6 when (mux_in = "110") else
	x1r0 when (mux_in = "000") else x1r7;

c1 <= 	x0r1 when (mux_in = "001") else
	x0r2 when (mux_in = "010") else
	x0r3 when (mux_in = "011") else
	x0r4 when (mux_in = "100") else
	x0r5 when (mux_in = "101") else
	x0r6 when (mux_in = "110") else
	x0r0 when (mux_in = "000") else x0r7;

s1 <= (not address(2)) and seed(6);
s2 <= (address(2) and seed(7)) and (address(0) or address(1));
s3 <= (not address(5)) and seed(8);
s4 <= (address(5) and seed(9)) and (address(3) or address(4));

color(0) <= (((c0 xor s1) xor s2) xor s3) xor s4;
color(1) <= (((c1 xor s1) xor s2) xor s3) xor s4;
end behav;
