library ieee;
use ieee.std_logic_1164.all;

entity plus_minus_one is 
	port(	a	: in 	std_logic_vector(2 downto 0);
		b	: out	std_logic_vector(2 downto 0);
		sel	: in	std_logic
	);
end entity plus_minus_one;