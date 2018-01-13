library ieee;
use ieee.std_logic_1164.all;

entity h_latch is
	port(	t	: in	std_logic;
		hold	: in	std_logic;
		q	: out	std_logic
	);
end h_latch;
