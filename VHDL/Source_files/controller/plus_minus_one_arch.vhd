library ieee;
use ieee.std_logic_1164.all;

architecture behav of plus_minus_one is
component f_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		c_in 	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

signal not_sel : std_logic;
signal carry : std_logic_vector(1 downto 0);

begin
b(0) <= not(a(0));
carry(0) <= a(0);
l1: f_add port map(a(1), not_sel, carry(0), b(1), carry(1));
b(2) <= (a(2) xor not_sel xor carry(1));
not_sel <= not(sel);
end behav;
