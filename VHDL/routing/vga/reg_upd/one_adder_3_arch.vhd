library ieee;
use ieee.std_logic_1164.all;

architecture structural of one_adder_3 is

signal interconnect : std_logic_vector(1 downto 0);

component h_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

begin

sum(0) <= not(a(0));
interconnect(0) <= a(0);
h_add_1: h_add port map(a(1), interconnect(0), sum(1), interconnect(1));
sum(2) <= interconnect(1) xor a(2);

end structural;
