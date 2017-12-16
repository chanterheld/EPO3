library ieee;
use ieee.std_logic_1164.all;

entity adr_to_colo_f is
	port(	clk 	: in	std_logic;
		reset	: in	std_logic;
		flag	: in	std_logic;
		y_up	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		x_adr	: in	std_logic_vector(2 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		data_in	: in	std_logic_vector(1 downto 0);

		set_flag: out	std_logic;
		e_n	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0);	
		color	: out	std_logic_vector(1 downto 0)
	);
end adr_to_colo_f;
