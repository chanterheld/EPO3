library ieee;
use ieee.std_logic_1164.all;

entity clk_cnt_8 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		cnt	: out	std_logic_vector(7 downto 0)
	);
end clk_cnt_8;
