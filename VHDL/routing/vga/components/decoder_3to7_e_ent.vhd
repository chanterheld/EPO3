library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to7_e is
	port(	enable	: in	std_logic;
		x	: in	std_logic_vector(2 downto 0);
		y	: out	std_logic_vector(6 downto 0)
	);
end decoder_3to7_e;
