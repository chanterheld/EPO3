library ieee;
use ieee.std_logic_1164.all;

entity controller_routing_tb is
end controller_routing_tb;

architecture behav of controller_routing_tb is

component controller is 
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		max	: in	std_logic;
		flag	: in	std_logic;
		update	: in	std_logic;
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);		

		lvl_up	: out	std_logic;
		dip_sw	: out	std_logic_vector(1 downto 0);
		game_end: out	std_logic;
		rst_sc	: out	std_logic; 			--!
		set_flag: out	std_logic;
		r_w	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0)		
	);
end component;

signal clk, reset, game_rst, max, flag, update, lvl_up, game_end, rst_sc, set_flag, r_w : std_logic;
signal live_clr, dip_sw : std_logic_vector(1 downto 0);
signal data_in: std_logic_vector(2 downto 0);
signal address : std_logic_vector(5 downto 0);
begin
L1: controller port map(clk, reset, game_rst, max, flag, update, live_clr, data_in, lvl_up, dip_sw, game_end, rst_sc, set_flag, r_w, address);

clk 	<=	'0' after 0 ns,
         	'1' after 10 ns when clk /= '1' else '0' after 10 ns;

reset <=	'1' after 0 ns,
		'0' after 50 ns;

game_rst <=	'0' after 0 ns,
		'1' after 90 ns,
		'0' after 110 ns;

max <= 		'0';

flag <= 	'0';

update <=	'0';

live_clr <=	"00";

data_in <=	"011";



end behav;