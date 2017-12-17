library ieee;
use ieee.std_logic_1164.all;

entity mplex7t1_1 is
	port(	input	: in	std_logic_vector(6 downto 0);
		sel	: in	std_logic_vector(2 downto 0);
		output	: out	std_logic
	);
end entity;