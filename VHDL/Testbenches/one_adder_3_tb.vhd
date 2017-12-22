library ieee;
use ieee.std_logic_1164.all;

entity one_adder_3_tb is
end entity one_adder_3_tb;

architecture structural of one_adder_3_tb is
component one_adder_3 is
	port(	a	: in	std_logic_vector(2 downto 0);
		sum	: out	std_logic_vector(2 downto 0)
	);
end component;

signal a, sum : std_logic_vector(2 downto 0);

begin
l1: one_adder_3	port map(a, sum);

a <=	"000" after 0 ns,
	"001" after 20 ns,
	"010" after 40 ns,
	"011" after 60 ns,
	"100" after 80 ns,
	"101" after 100 ns,
	"110" after 120 ns,
	"111" after 140 ns;
end structural;
