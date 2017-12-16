library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end entity adder_tb;

architecture behav of adder_tb is
component r_adder_gen is
	generic(size : integer);
	port(	a	: in	std_logic_vector(size-1 downto 0);
		b	: in	std_logic_vector(size-1 downto 0);
		sum	: out	std_logic_vector(size-1 downto 0)
	);
end component;

signal a, b, sum : std_logic_vector(9 downto 0);
begin
a	<=	std_logic_vector(to_signed(0,10)) after 0 ns,
		std_logic_vector(to_signed(15,10)) after 40 ns,
		std_logic_vector(to_signed(83,10)) after 80 ns,
		std_logic_vector(to_signed(133,10)) after 120 ns,
		std_logic_vector(to_signed(205,10)) after 160 ns,
		std_logic_vector(to_signed(301,10)) after 200 ns,
		std_logic_vector(to_signed(413,10)) after 240 ns,
		std_logic_vector(to_signed(499,10)) after 280 ns;

b	<=	std_logic_vector(to_signed(0,10)) after 0 ns,
		std_logic_vector(to_signed(10,10)) after 20 ns,
		std_logic_vector(to_signed(60,10)) after 60 ns,
		std_logic_vector(to_signed(112,10)) after 100 ns,
		std_logic_vector(to_signed(178,10)) after 140 ns,
		std_logic_vector(to_signed(256,10)) after 180 ns,
		std_logic_vector(to_signed(366,10)) after 220 ns,
		std_logic_vector(to_signed(450,10)) after 260 ns,
		std_logic_vector(to_signed(512,10)) after 300 ns;

l1: r_adder_gen	generic map(10)
		port map(a, b, sum);

end behav;
