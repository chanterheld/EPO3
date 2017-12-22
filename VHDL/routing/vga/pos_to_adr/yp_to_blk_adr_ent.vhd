library ieee;
use ieee.std_logic_1164.all;

entity yp_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(2 downto 0);
		up	: out	std_logic
	);
end entity yp_to_blk_adr;
