library ieee;
use ieee.std_logic_1164.all;

architecture structural of vga_reg_upd is
component vga_reg_upd_fsm is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		lst_blk : in 	std_logic;
		adr_up	: in	std_logic;

		plex_sel: out	std_logic;
		set_flag: out	std_logic;
		write_en: out	std_logic;
		reg_l	: out	std_logic
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

component one_adder_3 is
	port(	a	: in	std_logic_vector(2 downto 0);
		sum	: out	std_logic_vector(2 downto 0)
	);
end component;

signal reg_x_s, adder_in, adder_out, nxt_row : std_logic_vector(2 downto 0);
signal lb5, lst_blk, reg_r, reg_l: std_logic;

signal plex_out : std_logic_vector(2 downto 0);
begin
l_fsm: vga_reg_upd_fsm port map(clk, reset, flag, lst_blk, y_up, lb5, set_flag, write_en, reg_l);

--gated_reg_3
reg_0: gated_reg_1 port map(clk, reset, reg_l, nxt_row(0), reg_x_s(0));
reg_1: gated_reg_1 port map(clk, reset, reg_l, nxt_row(1), reg_x_s(1));
reg_2: gated_reg_1 port map(clk, reset, reg_l, nxt_row(2), reg_x_s(2));

--plus one adder_3
adder: one_adder_3 port map(adder_in, adder_out);

--mux
adder_in <= reg_x_s when (lb5 = '1') else y_adr;
reg_y <= y_adr when (lb5 = '1') else nxt_row;
nxt_row <= "001" when (lst_blk = '1') else adder_out;

--comp
lst_blk <= '1' when (adder_in = '1'&dip_sw) else '0';

reg_x <= reg_x_s;
end architecture;