library ieee;
use ieee.std_logic_1164.all;

entity top_lvl_tb is
end entity;

architecture behav of top_lvl_tb is

component top_lvl is
	port(	xi	: in	std_logic;
		xo	: inout	std_logic;
		clk_e	: in	std_logic;
		reset	: in	std_logic;
		game_rst_l: in	std_logic;
		game_rst_r: in	std_logic;
		c_input_l	: in	std_logic_vector(3 downto 0);
		c_input_r	: in	std_logic_vector(3 downto 0);

		config_clk: in	std_logic;
		config_d	: in	std_logic;

		testi_clk : in	std_logic;
		testi_d	: in	std_logic;

		testo_clk : in	std_logic;
		testo_e	: in std_logic;
		testo_d	: out std_logic;

		clk_out	: out	std_logic;
		h_sync_l	: out	std_logic;
		v_sync_l	: out	std_logic;
		h_sync_r	: out	std_logic;
		v_sync_r	: out	std_logic;
		rgb_l	: out	std_logic_vector(2 downto 0);
		rgb_r	: out	std_logic_vector(2 downto 0)
	);
end component;

signal xi, xo, clk_e, reset, game_rst_l, game_rst_r, config_clk, config_d, testi_clk, testi_d, testo_clk, testo_e, testo_d, clk_out, h_sync_l, v_sync_l, h_sync_r, v_sync_r : std_logic;
signal c_input_l, c_input_r : std_logic_vector(3 downto 0);
signal rgb_l, rgb_r : std_logic_vector(2 downto 0);

begin
L1: top_lvl port map(xi, xo, clk_e, reset, game_rst_l, game_rst_r, config_clk, config_d, testi_clk, testi_d, testo_clk, testo_e, testo_d, clk_out, h_sync_l, v_sync_l, h_sync_r, v_sync_r, rgb_l, rgb_r);

xi 	<= 	'1' after 0 ns,
         	'0' after 81380 ps when clk /= '0' else '1' after 81380 ps;
			
reset <= 	'1' after 0 ns,
		'0' after 200 ns;

game_rst_l <= '1' after 16748204 ns,
			  '0' after 20000000 ns;
			 
game_rst_r <= '1' after 33496408 ns,
			  '0' after 50000000 ns;
			 
c_input_l <= "10" after 33496408 ns,
			"11" after 50244612 ns,
			"01" after 66992816 ns,
			"00" after 83741020 ns,
			"01" after 100489224 ns,
			"10" after 117237428 ns,
			"11" after 133985632 ns,
			"00" after 150733836 ns;
			

			
c_input_r <= "01" after 16748204 ns,
			"10" after 33496408 ns,
			"11" after 50244612 ns,
			"01" after 66992816 ns,
			"00" after 83741020 ns,
			"01" after 100489224 ns,
			"10" after 117237428 ns, 
			"11" after 133985632 ns,
			"00" after 150733836 ns;
			
xo <= '0';		
clk_e <= '0';			
config_clk <= '0';			
config_d <= '0';			
testi_clk <= '0';			
testi_d <= '0';			
testo_clk <= '0';			
testo_e <= '0';				