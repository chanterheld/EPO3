library ieee;
use ieee.std_logic_1164.all;

entity input_bf is
	port(	clk	: in	std_logic;
		input	: in	std_logic_vector(3 downto 0);

		update	: out	std_logic;
		output	: out	std_logic_vector(1 downto 0)
	);
end input_bf;
