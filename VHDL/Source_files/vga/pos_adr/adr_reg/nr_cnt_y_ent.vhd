library ieee;
use ieee.std_logic_1164.all;

entity nr_cnt_y is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		up_one	: in	std_logic;
		reg_rst	: out	std_logic;
		blk_nr	: out	std_logic_vector(3 downto 0)
	);
end entity nr_cnt_y;
