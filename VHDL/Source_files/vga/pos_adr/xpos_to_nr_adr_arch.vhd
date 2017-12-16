library ieee;
use ieee.std_logic_1164.all;

 architecture structural of xpos_to_nr_adr is
component r_add_8 is
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		sum	: out	std_logic_vector(7 downto 0)
	);
end component;

component nr_cnt_x is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		up_one	: in	std_logic;
		reg_rst	: out	std_logic;
		blk_nr	: out	std_logic_vector(1 downto 0)
	);
end component nr_cnt_x;

component gated_reg_8 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(7 downto 0);
		q	: out	std_logic_vector(7 downto 0)
	);
end component;

component comp_8 is
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		equal	: out	std_logic
	);
end component;

signal pos_reg, pos_next, mplex_out, block_size : std_logic_vector(7 downto 0);
signal address_s: std_logic_vector(1 downto 0);
signal comp_out, reg_nor, reg_load, reg_reset, cnt_reset, reset_s: std_logic;

begin
mplex_out <=	"01111010" when (reg_nor = '1') else block_size;
l3: gated_reg_8	port map(clk, reg_reset, reg_load, pos_next, pos_reg);
l4: r_add_8	port map(pos_reg, mplex_out, pos_next);
l5: comp_8	port map(pos_reg, posi, comp_out);
reg_nor <= 	'1' when (pos_reg = "00000000") else '0';
l7: nr_cnt_x	port map(clk, reset_s, comp_out, cnt_reset, address_s);

reg_load <= comp_out or reg_nor;
reg_reset <= reset_s or cnt_reset;
reset_s <= reset or r_reset;
address <= address_s;
block_size <= "000"&address_s(0)&'0'&not(address_s(0))&"11";
end architecture;
