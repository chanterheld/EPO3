library ieee;
use ieee.std_logic_1164.all;

entity tr_sync is
	port(	clk	: in	std_logic;	
		reset	: in	std_logic;
		r_reset_x: out	std_logic;
		r_reset_y: out	std_logic;
		cnt_x	: out	std_logic_vector(7 downto 0);
		cnt_y	: out	std_logic_vector(7 downto 0);
		h_sync	: out 	std_logic;
		v_sync	: out	std_logic
	);
end entity;
