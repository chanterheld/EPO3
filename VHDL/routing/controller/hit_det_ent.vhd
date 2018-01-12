library ieee;
use ieee.std_logic_1164.all;

entity hit_det is
	port(	s_type	: in	std_logic;
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);
		hit	: out	std_logic
	);
end hit_det;
