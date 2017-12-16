library ieee;
use ieee.std_logic_1164.all;

entity color_sel is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		x_adr	: in	std_logic_vector(2 downto 0);
		wr_adr	: in	std_logic_vector(2 downto 0);
		wr_bus	: in	std_logic_vector(1 downto 0);
		wr_e	: in	std_logic;
		
		clr_out	: out	std_logic_vector(1 downto 0)
	);
end color_sel;
