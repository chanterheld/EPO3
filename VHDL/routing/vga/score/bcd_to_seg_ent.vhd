library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_seg is
	port(	bcd	: in	std_logic_vector(3 downto 0); 
		seg	: out	std_logic_vector(12 downto 0)
	);
end bcd_to_seg;
