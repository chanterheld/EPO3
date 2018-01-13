library ieee;
use ieee.std_logic_1164.all;

entity rgb_decoder is
	port(	e1_n	: in	std_logic; 
		e2_n	: in	std_logic; 
		color_1	: in	std_logic_vector(1 downto 0);
		color_2	: in	std_logic_vector(1 downto 0);
		rgb	: out	std_logic_vector(2 downto 0)
	);
end rgb_decoder;
