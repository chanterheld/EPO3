 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adr_to_color_sc_tb is
end entity;

architecture behav of adr_to_color_sc_tb is
component adr_to_color_sc is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		e_n	: out	std_logic;
		color	: out	std_logic_vector(1 downto 0)
		
	);
end component;

signal clk, reset, plus_one, e_n, cnt_gen: std_logic;
signal x_adr, color: std_logic_vector(1 downto 0);
signal y_adr: std_logic_vector(3 downto 0);
signal intrm : std_logic_vector(5 downto 0);

begin
L1: adr_to_color_sc port map(clk, reset, reset, plus_one, x_adr, y_adr, e_n, color);

clk <=		'1' after 0 ns,
		'0' after 10 ns when clk /= '0' else '1' after 10 ns;

reset <=	'1' after 0 ns,
		'0' after 50 ns;

cnt_gen <= 	'0' after 0 ns,
         	'1' after 10 ns when cnt_gen /= '1' else '0' after 10 ns;

cnt: process (cnt_gen)
variable tmp : integer range 0 to 63 := 0;
begin
	if (rising_edge(cnt_gen)) then
		if tmp = 63 then
			tmp := 0;
			plus_one <= '1';
		else
			tmp := tmp + 1;
			plus_one <= '0';
		end if;
	end if;
intrm <= std_logic_vector(to_unsigned(tmp,6));
end process;

y_adr <= intrm(5 downto 2);
x_adr <= intrm(1 downto 0);

end behav;