library ieee;
use ieee.std_logic_1164.all;

architecture structural of up_one_cnt_2 is

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

signal interconnect : std_logic_vector(1 downto 0);

begin
l2: t_ff port map(clk, reset, interconnect(1), cnt(1));
l3: up_cnt_cell port map(clk, reset, interconnect(0), cnt(0), interconnect(1));

interconnect(0) <= t;
end structural;
