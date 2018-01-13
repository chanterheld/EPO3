library ieee;
use ieee.std_logic_1164.all;

architecture structural of color_sel is

component stk_gated_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

component decoder_3to7_e is
	port(	enable	: in	std_logic;
		x	: in	std_logic_vector(2 downto 0);
		y	: out	std_logic_vector(6 downto 0)
	);
end component;

signal read_e: std_logic_vector(7 downto 0);
signal write_e: std_logic_vector(6 downto 0);
signal ff_out: std_logic_vector(13 downto 0);

begin
l_wr_deco: decoder_3to7_e port map(wr_e, wr_adr, write_e);

reg_gen:
for i in 0 to 6 generate
	l_reg: stk_gated_reg_2 port map(clk, reset, write_e(i), wr_bus, ff_out(2*i+1 downto 2*i));
end generate ;
--mux
clr_out <=	ff_out(1 downto 0) when (x_adr = "001") else
		ff_out(3 downto 2) when (x_adr = "010") else
		ff_out(5 downto 4) when (x_adr = "011") else
		ff_out(7 downto 6) when (x_adr = "100") else
		ff_out(9 downto 8) when (x_adr = "101") else
		ff_out(11 downto 10) when (x_adr = "110") else
		ff_out(13 downto 12) when (x_adr = "111") else "--";
end structural;