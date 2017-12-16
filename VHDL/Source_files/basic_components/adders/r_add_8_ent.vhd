library ieee;
use ieee.std_logic_1164.all;

entity r_add_8 is
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		sum	: out	std_logic_vector(7 downto 0)
	);
end entity r_add_8;
