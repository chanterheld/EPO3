library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of bit_row is


component dnl_gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load_1	: in	std_logic;
		load_2	: in	std_logic;
		q	: out	std_logic
	);
end component;

component mplex7t1_1 is
	port(	input	: in	std_logic_vector(6 downto 0);
		sel	: in	std_logic_vector(2 downto 0);
		output	: out	std_logic
	);
end component;


signal data_r: std_logic_vector(6 downto 0);
begin
l0: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(0), data_r(0));
l1: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(1), data_r(1));
l2: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(2), data_r(2));
l3: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(3), data_r(3));
l4: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(4), data_r(4));
l5: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(5), data_r(5));
l6: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(6), data_r(6));

mplex: mplex7t1_1 port map(data_r, x_adr_r, plex_out);
end behaviour;