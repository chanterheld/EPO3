library ieee;
use ieee.std_logic_1164.all;

entity bit_storage is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		wr_adr	: in	std_logic_vector(5 downto 0);
		r_adr	: in	std_logic_vector(5 downto 0);

		bit_out	: out	std_logic
	);
end entity;