library ieee;
use ieee.std_logic_1164.all;

entity dim_conv is
	port(	dip_sw		: in	std_logic_vector(1 downto 0);
		block_size	: out	std_logic_vector(4 downto 0)
	);
end entity dim_conv;
