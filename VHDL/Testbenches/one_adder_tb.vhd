library ieee;
use ieee.std_logic_1164.all;

entity one_adder_gen_tb is
end entity one_adder_gen_tb;

architecture structural of one_adder_gen_tb is
component one_adder_gen is
	generic(n : integer);
	port(	a	: in	std_logic_vector(n-1 downto 0);
		sum	: out	std_logic_vector(n-1 downto 0)
	);
end component;

signal a, sum : std_logic_vector(7 downto 0);

begin
l1: one_adder_gen	generic map(8)
			port map(a, sum);

a <=	"00000000" after 0 ns,
	"00100001" after 20 ns,
	"00000100" after 40 ns,
	"00011111" after 60 ns,
	"01010101" after 80 ns,
	"11111111" after 100 ns;
end structural;
