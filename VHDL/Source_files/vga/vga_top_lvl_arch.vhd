library ieee;
use ieee.std_logic_1164.all;

 architecture structural of vga_top_lvl is
component dim_conv is
	port(	dip_sw		: in	std_logic_vector(1 downto 0);
		block_size	: out	std_logic_vector(4 downto 0)
	);
end component;

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


component xpos_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		block_size	: in	std_logic_vector(4 downto 0);
		address	: out	std_logic_vector(2 downto 0)
	);
end component;

component ypos_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		block_size	: in	std_logic_vector(4 downto 0); 
		address	: out	std_logic_vector(2 downto 0);
		up	: out	std_logic
	);
end component;

component xpos_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(1 downto 0)
	);
end component;

component ypos_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(3 downto 0)
	);
end component;

component adr_to_colo_f is
	port(	clk 	: in	std_logic;
		reset	: in	std_logic;
		flag	: in	std_logic;
		y_up	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		x_adr	: in	std_logic_vector(2 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		data_in	: in	std_logic_vector(1 downto 0);

		set_flag: out	std_logic;
		e_n	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0);	
		color	: out	std_logic_vector(1 downto 0)
	);
end component;

component adr_to_color_sc is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		e_n	: out	std_logic;
		color	: out	std_logic_vector(1 downto 0)
		
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

signal r_reset_x, r_reset_y, e_n_field1, e_n_field2, e_n_score, y_adr_up : std_logic;
signal nr_adr_x, color_field, color_score : std_logic_vector(1 downto 0);
signal blk_adr_x, blk_adr_y : std_logic_vector(2 downto 0);
signal nr_adr_y : std_logic_vector(3 downto 0);
signal block_size: std_logic_vector(4 downto 0);
signal x_posi, y_posi : std_logic_vector(7 downto 0);
begin
l1: tr_sync port map(clk, reset, r_reset_x, r_reset_y, x_posi, y_posi, h_sync, v_sync);
l5: xpos_to_blk_adr port map(clk, reset, r_reset_x, dip_sw, x_posi, block_size, blk_adr_x);
l6: ypos_to_blk_adr port map(clk, reset, r_reset_y, dip_sw, y_posi, block_size, blk_adr_y, y_adr_up);
l7: xpos_to_nr_adr port map(clk, reset, r_reset_x, x_posi, nr_adr_x);
l8: ypos_to_nr_adr port map(clk, reset, r_reset_y, y_posi, nr_adr_y);
l9: adr_to_colo_f port map(clk, reset, flag, y_adr_up, dip_sw, blk_adr_x, blk_adr_y, data_in, set_flag, e_n_field1, address, color_field);
l10: adr_to_color_sc port map(clk, reset, game_rst, score_up, nr_adr_x, nr_adr_y, e_n_score, color_score);
l11: rgb_decoder port map(e_n_field2, e_n_score, color_field, color_score, rgb);
l12: dim_conv port map(dip_sw, block_size);

e_n_field2 <= e_n_field1 or game_rst;
end structural;
