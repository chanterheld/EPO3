library ieee;
use ieee.std_logic_1164.all;

entity gated_reg_7 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(6 downto 0);
		q	: out	std_logic_vector(6 downto 0)
	);
end gated_reg_7;