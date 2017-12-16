library ieee;
use ieee.std_logic_1164.all;

entity blk_cnt is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		up_one	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		cnt_rst	: out	std_logic;
		blk_nr	: out	std_logic_vector(2 downto 0)
	);
end entity blk_cnt;
