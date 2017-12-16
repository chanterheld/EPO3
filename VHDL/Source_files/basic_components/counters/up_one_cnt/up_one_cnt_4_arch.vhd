library ieee;
use ieee.std_logic_1164.all;

architecture structural of up_one_cnt_4 is

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

signal interconnect : std_logic_vector(3 downto 0);

begin
l2: t_ff port map(clk, reset, interconnect(3), cnt(3));

ff_gen:
for i in 0 to 2 generate
	lx: up_cnt_cell port map(clk, reset, interconnect(i), cnt(i), interconnect(i+1));
end generate;

interconnect(0) <= t;
end structural;
