library ieee;
use ieee.std_logic_1164.all;

architecture structural of one_adder_3 is

signal interconnect : std_logic_vector(2 downto 0);

component h_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

begin

h_add_gen:
for i in 0 to 1 generate
	lx: h_add port map(a(i), interconnect(i), sum(i), interconnect(i+1));
end generate;

interconnect(0) <= '1';
sum(2) <= interconnect(2) xor a(2);
end structural;
