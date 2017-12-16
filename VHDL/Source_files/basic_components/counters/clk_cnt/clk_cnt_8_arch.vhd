library ieee;
use ieee.std_logic_1164.all;

architecture structural of clk_cnt_8 is
component fst_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		q	: out 	std_logic
	);
end component;

component t_ff is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic
	);
end component;

component up_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic;
		and_out	: out	std_logic
	);	
end component;

signal interconnect : std_logic_vector(6 downto 0);

begin
l1: fst_cnt_cell port map(clk, reset, interconnect(0));
l2: t_ff port map(clk, reset, interconnect(6), cnt(7));

ff_gen:
for i in 0 to (5) generate
	lx: up_cnt_cell port map(clk, reset, interconnect(i), cnt(i+1), interconnect(i+1));
end generate;

cnt(0) <= interconnect(0);
end structural;
