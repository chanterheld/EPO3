library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_tb is
end entity comp_tb;

architecture behav of comp_tb is
component comp_gen is
	generic(size : integer);
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		equal	: out	std_logic
	);
end component;

signal a, b : std_logic_vector(7 downto 0);
signal equal : std_logic;
begin
a	<=	std_logic_vector(to_signed(0,8)) after 0 ns,
		std_logic_vector(to_signed(10,8)) after 40 ns,
		std_logic_vector(to_signed(60,8)) after 80 ns,
		std_logic_vector(to_signed(112,8)) after 120 ns,
		std_logic_vector(to_signed(178,8)) after 160 ns,
		std_logic_vector(to_signed(256,8)) after 200 ns,
		std_logic_vector(to_signed(366,8)) after 240 ns,
		std_logic_vector(to_signed(450,8)) after 280 ns;

b	<=	std_logic_vector(to_signed(0,8)) after 0 ns,
		std_logic_vector(to_signed(10,8)) after 20 ns,
		std_logic_vector(to_signed(60,8)) after 60 ns,
		std_logic_vector(to_signed(112,8)) after 80 ns,
		std_logic_vector(to_signed(178,8)) after 140 ns,
		std_logic_vector(to_signed(256,8)) after 180 ns,
		std_logic_vector(to_signed(366,8)) after 220 ns,
		std_logic_vector(to_signed(450,8)) after 260 ns;

l1: comp_gen	generic map(8)
		port map(a, b, equal);

end behav;
