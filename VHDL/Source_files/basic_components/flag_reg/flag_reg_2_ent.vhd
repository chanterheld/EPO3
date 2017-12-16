library ieee;
use ieee.std_logic_1164.all;

entity flag_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		set_flag: in	std_logic;
		clr_flag: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);

		q	: out	std_logic_vector(1 downto 0);
		flag	: out	std_logic
	);
end entity flag_reg_2;
