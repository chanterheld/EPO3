library ieee;
use ieee.std_logic_1164.all;

entity c_reg is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		re	: in	std_logic_vector(6 downto 0);
		we	: in	std_logic_vector(6 downto 0);
		write_bus: in	std_logic_vector(1 downto 0);
		read_bus: out	std_logic_vector(1 downto 0)
	);
end c_reg;
