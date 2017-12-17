library ieee;
use ieee.std_logic_1164.all;

entity tr_buf_2 is
	port(	t	: in	std_logic_vector(1 downto 0);
		en	: in	std_logic;
		q	: out	std_logic_vector(1 downto 0)
	);
end entity tr_buf_2;
