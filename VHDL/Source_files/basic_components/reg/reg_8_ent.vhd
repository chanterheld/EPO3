library ieee;
use ieee.std_logic_1164.all;

entity reg_8 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic_vector(7 downto 0);
		q	: out	std_logic_vector(7 downto 0)
	);
end reg_8;
