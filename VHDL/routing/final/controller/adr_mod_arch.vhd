library ieee;
use ieee.std_logic_1164.all;

architecture behav of adr_mod is

component plus_minus_one is 
	port(	a	: in 	std_logic_vector(2 downto 0);
		b	: out	std_logic_vector(2 downto 0);
		sel	: in	std_logic
	);
end component;

component gated_reg_1 is
	port(	clk	: in	std_logic; 
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

signal adder_in, adder_out, x_reg, y_reg, x_out, y_out, edge_val : std_logic_vector(2 downto 0);

begin

pmo: plus_minus_one port map(adder_in, adder_out, ad_sel);

reg_x_0: gated_reg_1 port map (clk, x_r, x_l, x_out(0), x_reg(0));
reg_x_1: gated_reg_1 port map (clk, x_r, x_l, x_out(1), x_reg(1));
reg_x_2: gated_reg_1 port map (clk, x_r, x_l, x_out(2), x_reg(2));

reg_y_0: gated_reg_1 port map (clk, y_r, y_l, y_out(0), y_reg(0));
reg_y_1: gated_reg_1 port map (clk, y_r, y_l, y_out(1), y_reg(1));
reg_y_2: gated_reg_1 port map (clk, y_r, y_l, y_out(2), y_reg(2));

x_out <=  adder_out when (x_ins = '1') else x_reg;
y_out <=  adder_out when (y_ins = '1') else y_reg;
adder_in <=  y_reg when (reg_sel = '1') else x_reg;
edge_val <= '1'&dip_sw when (ad_sel = '1') else "001";

edge <= '1' when (edge_val = adder_in) else '0';

address <= x_out&y_out;

end behav;
