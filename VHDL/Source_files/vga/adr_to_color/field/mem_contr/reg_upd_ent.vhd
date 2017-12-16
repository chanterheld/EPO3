library ieee;
use ieee.std_logic_1164.all;

entity vga_reg_upd is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		y_up	: in	std_logic;

		set_flag: out	std_logic;
		write_en: out	std_logic;
		reg_x	: out	std_logic_vector(2 downto 0);
		reg_y	: out	std_logic_vector(2 downto 0)
	);
end entity vga_reg_upd;
