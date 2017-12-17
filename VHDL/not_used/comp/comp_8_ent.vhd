library ieee;
use ieee.std_logic_1164.all;

entity comp_8 is
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		equal	: out	std_logic
	);
end entity comp_8;
