library ieee;
use ieee.std_logic_1164.all;

entity xpos_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(1 downto 0)
	);
end entity xpos_to_nr_adr;
