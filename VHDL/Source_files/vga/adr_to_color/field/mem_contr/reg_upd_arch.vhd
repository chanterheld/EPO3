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

component one_adder_3 is
	port(	a	: in	std_logic_vector(2 downto 0);
		sum	: out	std_logic_vector(2 downto 0)
	);
end component;

component mplex2t1_3 is 
	port(	a	: in 	std_logic_vector(2 downto 0);
		b	: in	std_logic_vector(2 downto 0);
		sel	: in	std_logic;
		q	: out	std_logic_vector(2 downto 0)
	);
end component;

component gated_reg_3 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(2 downto 0);
		q	: out	std_logic_vector(2 downto 0)
	);
end component;

signal reg_s, adder_in, adder_out, nxt_row : std_logic_vector(2 downto 0);
signal lb5, lst_blk, reg_r, reg_l: std_logic;
begin
l1: mplex2t1_3 port map(y_adr, reg_s, lb5, adder_in);
l4: mplex2t1_3 port map(nxt_row, y_adr, lb5, reg_y);
l2: one_adder_3 port map(adder_in, adder_out);
nxt_row <= "001" when (lst_blk = '1') else adder_out;
lst_blk <= '1' when (adder_in = '1'&dip_sw) else '0';
l7: gated_reg_3 port map(clk, reset, reg_l, nxt_row, reg_s);
l10: vga_reg_upd_fsm port map(clk, reset, flag, lst_blk, y_up, lb5, set_flag, write_en, reg_l);

reg_x <= reg_s;
end architecture;