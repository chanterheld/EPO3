library ieee;
use ieee.std_logic_1164.all;

entity dim_conv_tb is
end entity dim_conv_tb;

architecture behav of dim_conv_tb is
component dim_conv is
	port(	dip_sw		: in	std_logic_vector(1 downto 0);
		block_size	: out	std_logic_vector(4 downto 0)
	);
end component;

signal dip_sw:std_logic_vector(1 downto 0);
signal	block_size : std_logic_vector(4 downto 0);
begin
dip_sw <= 	"00" after 0 ns,
		"01" after 40 ns,
		"10" after 80 ns,
		"11" after 120 ns;

l1: dim_conv port map(dip_sw, block_size);

end behav;
