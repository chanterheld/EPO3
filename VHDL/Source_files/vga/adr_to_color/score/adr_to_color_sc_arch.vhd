library ieee;
use ieee.std_logic_1164.all;


architecture structural of adr_to_color_sc is
component score_cnt is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		tens	: out	std_logic_vector(1 downto 0);
		ones	: out	std_logic_vector(3 downto 0)
	);
end component;

component bcd_to_seg is
	port(	bcd	: in	std_logic_vector(3 downto 0);
		seg	: out	std_logic_vector(12 downto 0)
	);
end component;

component num_decoder is
	port(	x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		seg	: in	std_logic_vector(12 downto 0);
		e_n	: out	std_logic
	);
end component;

signal tens: std_logic_vector(1 downto 0);
signal tens_resized, ones, bcd: std_logic_vector(3 downto 0);
signal seg: std_logic_vector(12 downto 0);
begin
l_cnt: score_cnt port map(clk, reset, game_rst, plus_one, tens, ones);
l_t_seg: bcd_to_seg port map(bcd, seg);
l_deco: num_decoder port map(x_adr, y_adr(2 downto 0), seg, e_n);
--mux
bcd <= ones when (y_adr(3) = '1') else tens_resized;

tens_resized <= "00"&tens;
color <= ones(2 downto 1);
max <= '1' when (tens = "11") else '0';
end structural;
