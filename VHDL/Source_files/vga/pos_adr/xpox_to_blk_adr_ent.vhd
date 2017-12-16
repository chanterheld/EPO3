library ieee;
use ieee.std_logic_1164.all;

entity xpos_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		block_size	: in	std_logic_vector(4 downto 0);
		address	: out	std_logic_vector(2 downto 0)
	);
end entity xpos_to_blk_adr;
