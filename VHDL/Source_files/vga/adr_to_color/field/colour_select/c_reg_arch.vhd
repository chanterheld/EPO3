library ieee;
use ieee.std_logic_1164.all;

architecture structural of c_reg is
component gated_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

component tr_buf_2 is
	port(	t	: in	std_logic_vector(1 downto 0);
		en	: in	std_logic;
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

signal ff_out: std_logic_vector(13 downto 0);
begin
reg_gen:
for i in 0 to 6 generate
	ll_1: gated_reg_2 port map(clk, reset, we(i), write_bus, ff_out(2*i+1 downto 2*i));
	ll_2: tr_buf_2 port map(ff_out(2*i+1 downto 2*i), re(i),read_bus);
end generate ;
end structural;
