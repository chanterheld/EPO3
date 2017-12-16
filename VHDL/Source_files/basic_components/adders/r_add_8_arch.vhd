library ieee;
use ieee.std_logic_1164.all;

architecture structural of r_add_8 is
component h_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

component f_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		c_in 	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

signal interconnect : std_logic_vector(6 downto 0);

begin
l1: h_add port map(a(0), b(0), sum(0), interconnect(0));

add_gen:
for i in 0 to 5 generate
	lx: f_add port map(a(i+1), b(i+1), interconnect(i), sum(i+1), interconnect(i+1));
end generate;

sum(7) <= (a(7) xor b(7) xor interconnect(6));

end structural;
