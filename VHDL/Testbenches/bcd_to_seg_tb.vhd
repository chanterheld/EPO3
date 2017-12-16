--100 ns
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_to_seg_tb  is
end entity bcd_to_seg_tb;

architecture structural of bcd_to_seg_tb is

component bcd_to_seg is
	port(	bcd	: in	std_logic_vector(3 downto 0); 
		seg	: out	std_logic_vector(12 downto 0)
	);
end component bcd_to_seg;
signal bcd : std_logic_vector(3 downto 0);
signal seg : std_logic_vector (12 downto 0);

begin
         
  bcd <= 	"0000" after 0 ns,
		"0001" after 10 ns,
		"0010" after 20 ns,
		"0011" after 30 ns,
		"0100" after 40 ns,
		"0101" after 50 ns,
		"0110" after 60 ns,
		"0111" after 70 ns,
		"1000" after 80 ns,
		"1001" after 90 ns;
  
L01: bcd_to_seg port map (bcd, seg);  
end architecture structural; 