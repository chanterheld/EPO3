library ieee;
use ieee.std_logic_1164.all;

 architecture structural of ypos_to_nr_adr is
component r_add_8 is
	port(	a	: in	std_logic_vector(7 downto 0);
		b	: in	std_logic_vector(7 downto 0);
		sum	: out	std_logic_vector(7 downto 0)
	);
end component;

component mplex2t1_5 is 
	port(	a	: in 	std_logic_vector(4 downto 0);
		b	: in	std_logic_vector(4 downto 0);
		sel	: in	std_logic;
		q	: out	std_logic_vector(4 downto 0)
	);
end component;

component nr_cnt_y is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		up_one	: in	std_logic;
		reg_rst	: out	std_logic;
		blk_nr	: out	std_logic_vector(3 downto 0)
	);
end component;

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

signal pos_reg, pos_next, mplex_resized  : std_logic_vector(7 downto 0);
signal mplex_out, block_size: std_logic_vector (4 downto 0);
signal address_s: std_logic_vector(3 downto 0);
signal comp_out, reg_nor, reg_load, reg_reset, cnt_reset, reset_s, intrm: std_logic;

begin
mplex_out <=	"01110" when (reg_nor = '1') else block_size; --mplex
l3: gated_reg_8	port map(clk, reg_reset, reg_load, pos_next, pos_reg);
l4: r_add_8	port map(pos_reg, mplex_resized, pos_next);
l5: comp_8	port map(pos_reg, posi, comp_out);
reg_nor <=	'1' when (pos_reg = "00000000") else '0'; --comp
l7: nr_cnt_y	port map(clk, reset_s, comp_out, cnt_reset, address_s);

mplex_resized <= "000"&mplex_out;
reg_load <= comp_out or reg_nor;
reg_reset <= reset_s or cnt_reset;
reset_s <= reset or r_reset;
address <= address_s;
intrm <= (address_s(0) nand address_s(2));
block_size <= '0'&address_s(0)&intrm&intrm&intrm;
end architecture;
