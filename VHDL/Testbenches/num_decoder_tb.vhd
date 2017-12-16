library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity num_decoder_tb is
end entity num_decoder_tb;

architecture behav of num_decoder_tb is
component num_decoder is
	port(	x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		seg	: in	std_logic_vector(12 downto 0);
		e_n	: out	std_logic
	);
end component;

signal clk, e_n: std_logic;
signal count: std_logic_vector(4 downto 0);
signal x_adr: std_logic_vector(1 downto 0);
signal y_adr: std_logic_vector(2 downto 0);
signal seg: std_logic_vector(12 downto 0);
begin
  clk 	<= 	'0' after 0 ns,
         	'1' after 10 ns when clk /= '1' else '0' after 10 ns;

cnt: process (clk)
variable tmp : integer range 0 to 31 := 0;
begin
	if (rising_edge(clk)) then
		if tmp = 31 then
			tmp := 0;
		else
			tmp := tmp + 1;
		end if;
	end if;

count <= std_logic_vector(to_signed(tmp,5));
end process;

x_adr <= count(4 downto 3);
y_adr <= count(2 downto 0);

seg <=	"0000000000000" after 0 ns,
	"0000000000001" after 175 ns, --1,1
	"0000000000000" after 180 ns,
	"0000000001000" after 195 ns, --1,4
	"0000000000000" after 200 ns,
	"0000000100000" after 215 ns, --1,6
	"0000000000000" after 220 ns,
	"0000100000000" after 235 ns, --1,9
	"0000000000000" after 240 ns,
	"0010000000000" after 255 ns, --1,11
	"0000000000000" after 260 ns,
	"0000000000010" after 335 ns, --2,1
	"0000000000000" after 340 ns,
	"0000001000000" after 375 ns, --2,3
	"0000000000000" after 380 ns,
	"0100000000000" after 415 ns,
	"0000000000000" after 420 ns,
	"0000000000100" after 495 ns,
	"0000000000000" after 500 ns,
	"0000000010000" after 515 ns,
	"0000000000000" after 520 ns,
	"0000010000000" after 535 ns,
	"0000000000000" after 540 ns,
	"0001000000000" after 555 ns,
	"0000000000000" after 560 ns,
	"1000000000000" after 575 ns,
	"0000000000000" after 580 ns;



L1: num_decoder port map(x_adr, y_adr, seg, e_n);
end behav;
