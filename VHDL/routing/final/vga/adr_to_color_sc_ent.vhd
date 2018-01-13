library ieee;
use ieee.std_logic_1164.all;

entity adr_to_color_sc is
	port(	tens	: in	std_logic_vector(1 downto 0);
		ones	: in	std_logic_vector(3 downto 0);
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		e_n	: out	std_logic	
	);
end entity adr_to_color_sc;
