library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rgb_decoder_tb is
end entity rgb_decoder_tb;

architecture structural of rgb_decoder_tb is

component rgb_decoder is
  PORT(
    e1_n	 :  IN   STD_LOGIC; 
    e2_n     :  IN   STD_LOGIC; 
    color_1  :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
    color_2  :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
    rgb      :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
end component rgb_decoder;
signal e1_n, e2_n: std_logic;
signal color_1, color_2 : STD_LOGIC_VECTOR(1 downto 0);
signal rgb : STD_LOGIC_VECTOR(2 downto 0);
begin         
  e1_n <= '1' after 0 ns,
           '0' after 100 ns;
  e2_n <= '0' after 0 ns,
           '1' after 90 ns,
		   '0' after 180 ns;
  color_1 <= "00" after 0 ns, "01" after 10 ns, "10" after 20 ns, "11" after 30 ns, "00" after 50 ns, "01" after 60 ns, "10" after 80 ns, "11" after 110 ns, "00" after 120 ns, "01" after 130 ns, "10" after 140 ns, "11" after 160 ns;
  color_2 <= "11" after 5 ns, "00" after 25 ns, "01" after 50 ns, "10" after 60 ns, "00" after 90 ns, "11" after 105 ns, "10" after 120 ns, "10" after 150 ns;
  
L01: rgb_decoder port map (e1_n, e2_n, color_1, color_2, rgb);
  
end architecture structural; 
