library ieee;
use ieee.std_logic_1164.all;

entity num_decoder is
	port(	x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		seg	: in	std_logic_vector(12 downto 0);
		e_n	: out	std_logic
	);
end entity num_decoder;
