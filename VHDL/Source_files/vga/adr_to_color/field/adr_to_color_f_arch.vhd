library ieee;
use ieee.std_logic_1164.all;

architecture structural of adr_to_colo_f is
component color_sel is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		x_adr	: in	std_logic_vector(2 downto 0);
		wr_adr	: in	std_logic_vector(2 downto 0);
		wr_bus	: in	std_logic_vector(1 downto 0);
		wr_e	: in	std_logic;
		
		clr_out	: out	std_logic_vector(1 downto 0)
	);
end component;

component vga_reg_upd is
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
end component;

component comp_3 is
	port(	a	: in	std_logic_vector(2 downto 0);
		b	: in	std_logic_vector(2 downto 0);
		equal	: out	std_logic
	);
end component;

signal wr_e, x_nor, y_nor: std_logic;
signal reg_x, reg_y, wr_adr : std_logic_vector(2 downto 0);
begin
l1: color_sel port map(clk, reset, x_adr, wr_adr, data_in, wr_e, color);
l2: vga_reg_upd port map(clk, reset, flag, dip_sw, y_adr,  y_up, set_flag, wr_e, reg_x, reg_y);
x_nor <= '1' when (x_adr = "000") else '0'; --comp
y_nor <= '1' when (y_adr = "000") else '0'; --comp

e_n <= x_nor or y_nor;
wr_adr <= reg_x;
address <= reg_x&reg_y;
end structural;
