-- 250 ns
library ieee;
use ieee.std_logic_1164.all;

entity input_bf_tb is
end input_bf_tb;

architecture behav of input_bf_tb is
component input_bf is
	port(	clk	: in	std_logic;
		input	: in	std_logic_vector(3 downto 0);

		update	: out	std_logic;
		output	: out	std_logic_vector(1 downto 0)
	);
end component;
type colour_type is (red, green, blue, yellow, undef);
signal input_c, output_c : colour_type;
signal clk, update : std_logic;
signal output: std_logic_vector(1 downto 0);
signal input: std_logic_vector(3 downto 0);
begin
L1: input_bf port map(clk, input, update, output);

clk <=		'1' after 0 ns,
		'0' after 10 ns when clk /= '0' else '1' after 10 ns;

input <=	"1000" after 0 ns,
		"1100" after 30 ns,
		"0100" after 50 ns,
		"0011" after 90 ns,
		"0010" after 130 ns,
		"0001" after 150 ns,
		"1001" after 170 ns,
		"0000" after 190 ns,
		"0101" after 230 ns;
p_input: process (input)
begin
	if input(3) = '1' then
		input_c <= red;
	elsif input(2) = '1' then
		input_c <= green;
	elsif input(1) = '1' then
		input_c <= blue;
	elsif input(0) = '1' then
		input_c <= yellow;
	else
		input_c <= undef;
	end if;
end process;

p_output: process(output)
begin
	if output = "00" then
		output_c <= blue;
	elsif output = "01" then
		output_c <= green;
	elsif output = "10" then
		output_c <= red;
	elsif output = "11" then
		output_c <= yellow;
	else
		output_c <= undef;
	end if;
end process;

end behav;
