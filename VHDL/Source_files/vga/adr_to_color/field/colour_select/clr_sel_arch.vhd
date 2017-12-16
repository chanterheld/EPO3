library ieee;
use ieee.std_logic_1164.all;

architecture structural of color_sel is
component c_reg is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		re	: in	std_logic_vector(6 downto 0);
		we	: in	std_logic_vector(6 downto 0);
		write_bus: in	std_logic_vector(1 downto 0);
		read_bus: out	std_logic_vector(1 downto 0)
	);
end component;

component decoder_3to7_e is
	port(	enable	: in	std_logic;
		x	: in	std_logic_vector(2 downto 0);
		y	: out	std_logic_vector(6 downto 0)
	);
end component;

component decoder_3to8 is
  port(
    x  :  in  std_logic_vector(2 downto 0);
    y  :  out  std_logic_vector(7 downto 0)
	);
end component;

signal read_e: std_logic_vector(7 downto 0);
signal write_e: std_logic_vector(6 downto 0);

begin
l1: c_reg port map(clk, reset, read_e(7 downto 1), write_e, wr_bus, clr_out);
l2: decoder_3to7_e port map(wr_e, wr_adr, write_e);
l3: decoder_3to8 port map(x_adr, read_e);


end structural;