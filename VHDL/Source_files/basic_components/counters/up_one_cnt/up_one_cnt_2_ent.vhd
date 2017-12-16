library ieee;
use ieee.std_logic_1164.all;

entity up_one_cnt_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		cnt	: out	std_logic_vector(1 downto 0)
	);
end up_one_cnt_2;
