library ieee;
use ieee.std_logic_1164.all;

architecture structural of controller is
component gated_reg_1 is
	port(	clk	: in	std_logic; 
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
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

component adr_mod is
	port(	clk	: in	std_logic;
		reg_sel	: in	std_logic;
		ad_sel	: in	std_logic;
		x_ins	: in	std_logic;
		y_ins	: in	std_logic;
		x_l	: in	std_logic;
		x_r	: in	std_logic;
		y_l	: in	std_logic;
		y_r	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);

		edge	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0)		
	);
end component;

component hit_det is
	port(	s_type	: in	std_logic;
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);
		hit	: out	std_logic
	);
end component;

component fsm_1 is --going through field
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		hit	: in	std_logic;
		edge	: in	std_logic;
		flag	: in 	std_logic;
		start	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;
		x_l	: out	std_logic;
		y_l	: out	std_logic;
		d_l	: out	std_logic;
		x_r	: out	std_logic;
		y_r	: out	std_logic;
		set_fl	: out	std_logic;
	
		idle	: out	std_logic;
		start_2 : out	std_logic;
		start_3	: out	std_logic
	);
end component;

component fsm_2 is --checking side
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		hit	: in	std_logic;
		edge	: in	std_logic;
		flag	: in	std_logic;
		start	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;
		set_fl	: out	std_logic;
		r_w	: out	std_logic;
		c_l	: out	std_logic;

		idle	: out	std_logic;
		start_1	: out	std_logic
	);
end component;

component fsm_3 is --eof checks
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		start	: in	std_logic;
		max	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		d_reg	: in	std_logic;
		c_reg	: in	std_logic;

		ad_sel	: out	std_logic;
		reg_sel	: out	std_logic;
		x_ins	: out	std_logic;
		y_ins	: out	std_logic;
		x_l	: out	std_logic;
		y_l	: out	std_logic;
		x_r	: out	std_logic;
		y_r	: out	std_logic;
		d_r	: out	std_logic;
		c_r	: out	std_logic;
		lvl_up	: out	std_logic;
		game_d	: out	std_logic;
		rst_sc	: out	std_logic;

		idle	: out	std_logic;
		start_1	: out	std_logic
	);
end component;

component fsm_sel is --passing controlls between fsm's
	port(	idle_1	: in	std_logic;
		idle_2	: in	std_logic;
		idle_3 	: in	std_logic;

		s_type	: out	std_logic;
		reset	: out	std_logic
	);
end component;

signal ad_sel, ad_sel_1, ad_sel_2, ad_sel_3, reg_sel, reg_sel_1, reg_sel_2, reg_sel_3, x_ins, x_ins_1, x_ins_2, x_ins_3, y_ins, y_ins_1, y_ins_2, y_ins_3, idle_1, idle_2, idle_3: std_logic;
signal x_l, x_l_1, x_l_3, y_l, y_l_1, y_l_3, x_r, x_r_1, x_r_3, y_r, y_r_1, y_r_3, d_r, c_r, d_l, c_l, c_l_fsm, d_reg, c_reg, d_reg_t, set_fl_1, set_fl_2 : std_logic;
signal start_1, start_2, start_3, start_1_2, start_1_3, fsm_reset, fsm_err, s_type, hit, edge : std_logic;
signal lvl_interconnect, lvl_reset, lvl_up_s : std_logic;
signal dip_sw_s : std_logic_vector(1 downto 0);
begin
fsm_1_l: fsm_1 port map(clk, fsm_reset, hit, edge, flag, start_1, ad_sel_1, reg_sel_1, x_ins_1, y_ins_1, x_l_1, y_l_1, d_l, x_r_1, y_r_1, set_fl_1, idle_1, start_2, start_3);
fsm_2_l: fsm_2 port map(clk, fsm_reset, hit, edge, flag, start_2, ad_sel_2, reg_sel_2, x_ins_2, y_ins_2, set_fl_2, r_w, c_l_fsm, idle_2, start_1_2);
fsm_3_l: fsm_3 port map(clk, reset, game_rst, start_3, max, dip_sw_s, d_reg, c_reg, ad_sel_3, reg_sel_3, x_ins_3, y_ins_3, x_l_3, y_l_3, x_r_3, y_r_3, d_r, c_r, lvl_up_s, game_end, rst_sc, idle_3, start_1_3);
fsm_sel_l: fsm_sel port map(idle_1, idle_2, idle_3, s_type, fsm_err);
adr_mod_l: adr_mod port map(clk, reg_sel, ad_sel, x_ins, y_ins, x_l, x_r, y_l, y_r, dip_sw_s, edge, address);
hit_det_l: hit_det port map(s_type, live_clr, data_in, hit);
d_reg_l: gated_reg_1 port map(clk, d_r, d_l, d_reg_t, d_reg);
c_reg_l: gated_reg_1 port map(clk, c_r, c_l, '1', c_reg);
dip_sw_1: t_ff port map (clk, lvl_reset, lvl_interconnect, dip_sw_s(1));
dip_sw_0: up_cnt_cell port map(clk, lvl_reset, lvl_up_s, dip_sw_s(0), lvl_interconnect);

ad_sel <= ad_sel_1 or ad_sel_2 or ad_sel_3;
reg_sel <= reg_sel_1 or reg_sel_2 or reg_sel_3;
x_ins <= x_ins_1 or x_ins_2 or x_ins_3;
y_ins <= y_ins_1 or y_ins_2 or y_ins_3;

x_l <= x_l_1 or x_l_3;
y_l <= y_l_1 or y_l_3;
x_r <= x_r_1 or x_r_3;
y_r <= y_r_1 or y_r_3;
set_flag <= set_fl_1 or set_fl_2;
start_1 <= start_1_2 or start_1_3;

lvl_reset <= reset or game_rst;

d_reg_t <= not(d_reg) nand data_in(2);
c_l <= c_l_fsm or update;

fsm_reset <= reset or fsm_err;

dip_sw <= dip_sw_s;
lvl_up <= lvl_up_s;

end structural;
