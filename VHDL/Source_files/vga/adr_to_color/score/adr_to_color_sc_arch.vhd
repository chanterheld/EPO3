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

component mplex2t1_4 is 
	port(	a	: in 	std_logic_vector(3 downto 0);
		b	: in	std_logic_vector(3 downto 0);
		sel	: in	std_logic;
		q	: out	std_logic_vector(3 downto 0)
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
l1: score_cnt port map(clk, reset, game_rst, plus_one, tens, ones);
l2: mplex2t1_4 port map(tens_resized, ones, y_adr(3), bcd);
l3: bcd_to_seg port map(bcd, seg);
l4: num_decoder port map(x_adr, y_adr(2 downto 0), seg, e_n);

tens_resized <= "00"&tens;
color <= ones(2 downto 1);
end structural;
