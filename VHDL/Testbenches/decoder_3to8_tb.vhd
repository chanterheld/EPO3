library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder_3to8_tb is
end entity decoder_3to8_tb;

architecture structural of decoder_3to8_tb is

component decoder_3to8 is
  port(
    x  :  in  std_logic_vector(2 downto 0);
    y  :  out  std_logic_vector(7 downto 0)
	);
end component decoder_3to8;
signal x : std_logic_vector(2 downto 0);
signal y : std_logic_vector(7 downto 0);
begin         
  x <= "000" after 0 ns, "001" after 10 ns, "010" after 20 ns, "011" after 30 ns, "100" after 40 ns, "101" after 50 ns, "110" after 60 ns, "111" after 70 ns;
  
L01: decoder_3to8 port map (x,y);
  
end architecture structural; 
