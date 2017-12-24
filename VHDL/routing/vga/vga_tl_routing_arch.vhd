library ieee;
use ieee.std_logic_1164.all;

 architecture structural of vga_top_lvl is
component tr_sync is
	port(	clk	: in	std_logic;	
		reset	: in	std_logic;
		r_reset_x: out	std_logic;
		r_reset_y: out	std_logic;
		cnt_x	: out	std_logic_vector(7 downto 0);
		cnt_y	: out	std_logic_vector(7 downto 0);
		h_sync	: out 	std_logic;
		v_sync	: out	std_logic
	);
end component;

component xp_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(2 downto 0)
	);
end component;

component yp_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(2 downto 0);
		up	: out	std_logic
	);
end component;

component xp_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		game_d	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(1 downto 0)
	);
end component;

component yp_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(3 downto 0)
	);
end component;

component color_sel is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		x_adr	: in	std_logic_vector(2 downto 0);
		wr_adr	: in	std_logic_vector(2 downto 0);
		wr_bus	: in	std_logic_vector(1 downto 0);
		wr_e	: in	std_logic;
		
		clr_out	: out	std_logic_vector(1 downto 0)
	);
end component;

component vga_reg_upd is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		y_up	: in	std_logic;

		set_flag: out	std_logic;
		write_en: out	std_logic;
		reg_x	: out	std_logic_vector(2 downto 0);
		reg_y	: out	std_logic_vector(2 downto 0)
	);
end component;

component adr_to_color_sc is
	port(	tens	: in	std_logic_vector(1 downto 0);
		ones	: in	std_logic_vector(3 downto 0);
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		e_n	: out	std_logic	
	);
end component;

component score_cnt is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		tens	: out	std_logic_vector(1 downto 0);
		ones	: out	std_logic_vector(3 downto 0)
	);
end component;

component rgb_decoder is
	port(	e1_n	: in	std_logic; 
		e2_n	: in	std_logic; 
		color_1	: in	std_logic_vector(1 downto 0);
		color_2	: in	std_logic_vector(1 downto 0);
		rgb	: out	std_logic_vector(2 downto 0)
	);
end component;

signal r_reset_x, r_reset_y, en_field, en_score, y_adr_up, write_en, x_nor, y_nor : std_logic;
signal nr_adr_x, color_field, color_score, tens : std_logic_vector(1 downto 0);
signal blk_adr_x, blk_adr_y, reg_x, reg_y : std_logic_vector(2 downto 0);
signal nr_adr_y, ones : std_logic_vector(3 downto 0);
signal block_size: std_logic_vector(4 downto 0);
signal x_posi, y_posi : std_logic_vector(7 downto 0);
begin
l_tr_sync:		tr_sync port map(clk, reset, r_reset_x, r_reset_y, x_posi, y_posi, h_sync, v_sync);

l_xpos_to_blk_adr: 	xp_to_blk_adr port map(clk, reset, r_reset_x, dip_sw, x_posi, blk_adr_x);
l_ypos_to_blk_adr: 	yp_to_blk_adr port map(clk, reset, r_reset_y, dip_sw, y_posi, blk_adr_y, y_adr_up);
l_xpos_to_nr_adr:	xp_to_nr_adr port map(clk, reset, r_reset_x, game_d, x_posi, nr_adr_x);
l_ypos_to_nr_adr:	yp_to_nr_adr port map(clk, reset, r_reset_y, y_posi, nr_adr_y);

l_score_cnt: 		score_cnt port map(clk, reset, game_rst, score_up, tens, ones);
l_adr_to_color_sc:	adr_to_color_sc port map(tens, ones, nr_adr_x, nr_adr_y, en_score);

l_color_sel:		color_sel port map(clk, reset, blk_adr_x, reg_x, data_in, write_en, color_field);
l_vga_reg_upd:		vga_reg_upd port map(clk, reset, flag, dip_sw, blk_adr_y, y_adr_up, set_flag, write_en, reg_x, reg_y);

l_rgb_decoder:		rgb_decoder port map(en_field, en_score, color_field, color_score, rgb);

x_nor <=	'1' when (blk_adr_x = "000") else '0';
y_nor <=	'1' when (blk_adr_y = "000") else '0';
en_field <= x_nor or y_nor or game_d or game_rst;

max <= '1' when (tens = "11") else '0';

address <= reg_x&reg_y;
end structural;
