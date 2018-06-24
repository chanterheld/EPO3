library IEEE;
use ieee.std_logic_1164.all;

architecture structural of top_lvl is

--component osc10
--	port( e, xi : in std_logic; xo : inout std_logic;  f : out std_logic);
--end component;

component input_bf is
	port(	clk	: in	std_logic;
		input	: in	std_logic_vector(3 downto 0);

		update	: out	std_logic;
		output	: out	std_logic_vector(1 downto 0)
	);
end component;

component controller is 
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		max	: in	std_logic;
		flag	: in	std_logic;
		update	: in	std_logic;
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);		

		lvl_up	: out	std_logic;
		dip_sw	: out	std_logic_vector(1 downto 0);
		game_end: out	std_logic;
		rst_sc	: out	std_logic; 	
		set_flag: out	std_logic;
		r_w	: out	std_logic;
		address	: out	std_logic_vector(5 downto 0)		
	);
end component;

component storage_top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		vga_s_fl: in	std_logic;
		ctrl_s_fl: in	std_logic;
		r_w_in	: in	std_logic;
		live_clr: in 	std_logic_vector(1 downto 0);
		vga_adr	: in	std_logic_vector(5 downto 0);
		ctlr_adr: in	std_logic_vector(5 downto 0);

		vga_flag: out	std_logic;
		ctrl_flag: out	std_logic;
		vga_data: out	std_logic_vector(1 downto 0);
		ctrl_data: out	std_logic_vector(2 downto 0)
	);
end component;

component vga_top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		flag	: in	std_logic;
		score_up: in	std_logic;
		game_d	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(1 downto 0);

		max	: out	std_logic;
		set_flag: out	std_logic;
		h_sync	: out	std_logic;
		v_sync	: out	std_logic;
		rgb	: out	std_logic_vector(2 downto 0);
		address	: out	std_logic_vector(5 downto 0)
	);
end component;

component side_input_sel is
   port(above   :in    std_logic;
        mid     :in    std_logic;
        test_reg:in    std_logic;
        sel     :in    std_logic_vector(1 downto 0);
        output  :out   std_logic);
end component;

component mid_input_2 is
   port(above   :in    std_logic;
        side    :in    std_logic;
        test_reg:in    std_logic;
        sel     :in    std_logic_vector(1 downto 0);
        output  :out   std_logic);
end component;

component sh_out_cell is
   port(clk     :in    std_logic;
        sel     :in    std_logic;
        data_in :in    std_logic;
        chain_in:in    std_logic;
        data_out:out   std_logic);
end component;

component dfn10
	port( D, CK : in std_logic;  Q : out std_logic);
end component;

component mu111
	port( A, B, S : in std_logic;  Y : out std_logic);
end component;

--signal clk, press, score_up, max, ctrl_s_flag, vga_s_flag, ctrl_flag, vga_flag, lvl_up, game_end, r_w, storage_rst, rst_sc, vga_rst : std_logic;
--signal enc_in, vga_data, dip_sw	: std_logic_vector(1 downto 0);
--signal ctrl_data : std_logic_vector(2 downto 0);
--signal ctrl_adr, vga_adr : std_logic_vector(5 downto 0);

--general
signal clk : std_logic;

--input buffer + game_reset
--in
signal c_input_m : std_logic_vector(3 downto 0);
--out
signal press_l_buf, press_m_buf, press_r_buf : std_logic;
signal enc_in_l_buf, enc_in_m_buf, enc_in_r_buf: std_logic_vector(1 downto 0);



--controller
--in
signal max_l_ctrl, max_m_ctrl : std_logic;
signal ctrl_flag_l_ctrl, ctrl_flag_m_ctrl : std_logic; 
signal press_l_ctrl, press_m_ctrl : std_logic;
signal enc_in_l_ctrl, enc_in_m_ctrl : std_logic_vector(1 downto 0);
signal ctrl_data_l_ctrl, ctrl_data_m_ctrl : std_logic_vector(2 downto 0);	
--out
signal lvl_up_l_ctrl, lvl_up_m_ctrl : std_logic;
signal dip_sw_l_ctrl, dip_sw_m_ctrl : std_logic_vector(1 downto 0);
signal game_end_l_ctrl, game_end_m_ctrl : std_logic;
signal rst_sc_l_ctrl, rst_sc_m_ctrl : std_logic;
signal ctrl_s_flag_l_ctrl, ctrl_s_flag_m_ctrl : std_logic;
signal r_w_l_ctrl, r_w_m_ctrl : std_logic;
signal ctrl_adr_l_ctrl, ctrl_adr_m_ctrl : std_logic_vector(5 downto 0);



--storage
--in
signal storage_rst_l, storage_rst_m : std_logic;
signal lvl_up_l_strg, lvl_up_m_strg : std_logic;
signal vga_s_flag_l_strg, vga_s_flag_m_strg : std_logic;
signal ctrl_s_flag_l_strg, ctrl_s_flag_m_strg : std_logic;
signal r_w_l_strg, r_w_m_strg : std_logic;
signal enc_in_l_strg, enc_in_m_strg : std_logic_vector(1 downto 0);
signal vga_adr_l_strg, vga_adr_m_strg : std_logic_vector(5 downto 0);
signal ctrl_adr_l_strg, ctrl_adr_m_strg : std_logic_vector(5 downto 0);
--out
signal vga_flag_l_strg, vga_flag_m_strg : std_logic;
signal ctrl_flag_l_strg, ctrl_flag_m_strg : std_logic;
signal vga_data_l_strg, vga_data_m_strg : std_logic_vector(1 downto 0);
signal ctrl_data_l_strg, ctrl_data_m_strg : std_logic_vector(2 downto 0);





--vga
--in
signal vga_rst_l, vga_rst_m : std_logic;
signal score_up_l, score_up_m : std_logic;
signal press_l_vga, press_m_vga : std_logic;
signal game_end_l_vga, game_end_m_vga : std_logic;
signal rst_sc_l_vga, rst_sc_m_vga : std_logic;
signal vga_flag_l_vga, vga_flag_m_vga : std_logic;
signal dip_sw_l_vga, dip_sw_m_vga : std_logic_vector(1 downto 0);
signal vga_data_l_vga, vga_data_m_vga : std_logic_vector(1 downto 0);
--out
signal max_l_vga, max_m_vga : std_logic;
signal vga_s_flag_l_vga, vga_s_flag_m_vga : std_logic;
signal vga_adr_l_vga, vga_adr_m_vga : std_logic_vector(5 downto 0);


--test tegisters
--to components
signal t_l: std_logic_vector(10 downto 0); --vga 
--from components
signal f_l: std_logic_vector(13 downto 0);
signal f_m: std_logic_vector(13 downto 0);
signal f_lm: std_logic_vector(13 downto 0);
--registerbank interconeects
signal sh_o_reg_l_int: std_logic_vector(14 downto 0);

--config signals
signal conf : std_logic_vector(38 downto 0);


begin

--oscilator : osc10 port map(clk_e, xi, xo, clk);
clk <= xi;

---l
l_input_bf_l:	input_bf port map (clk, c_input_l, press_l_buf, enc_in_l_buf);


--
l_controller_l :	controller port map(clk, reset, game_rst_l, max_l_ctrl, ctrl_flag_l_ctrl, press_l_ctrl, enc_in_l_ctrl, ctrl_data_l_ctrl, lvl_up_l_ctrl, dip_sw_l_ctrl, game_end_l_ctrl, rst_sc_l_ctrl, ctrl_s_flag_l_ctrl, r_w_l_ctrl, ctrl_adr_l_ctrl);

max_l_ctrl_s :  side_input_sel port map (max_l_vga, max_m_vga, '0', conf(14 downto 13), max_l_ctrl);

ctrl_flag_l_ctrl_s: side_input_sel port map(ctrl_flag_l_strg, ctrl_flag_m_strg, t_l(0), conf(16 downto 15), ctrl_flag_l_ctrl);

press_l_ctrl_s : side_input_sel port map(press_l_buf, press_m_buf, '0', conf(18 downto 17), press_l_ctrl);

enc_in_l_ctrl_s0: side_input_sel port map(enc_in_l_buf(0), enc_in_m_buf(0), t_l(1), conf(18 downto 17), enc_in_l_ctrl(0));
enc_in_l_ctrl_s1: side_input_sel port map(enc_in_l_buf(1), enc_in_m_buf(1), t_l(2), conf(18 downto 17), enc_in_l_ctrl(1));

ctrl_data_l_ctrl_s0: side_input_sel port map(ctrl_data_l_strg(0), ctrl_data_m_strg(0), t_l(3), conf(16 downto 15), ctrl_data_l_ctrl(0)); 
ctrl_data_l_ctrl_s1: side_input_sel port map(ctrl_data_l_strg(1), ctrl_data_m_strg(1), t_l(4), conf(16 downto 15), ctrl_data_l_ctrl(1)); 
ctrl_data_l_ctrl_s2: side_input_sel port map(ctrl_data_l_strg(2), ctrl_data_m_strg(2), t_l(5), conf(16 downto 15), ctrl_data_l_ctrl(2)); 


--
l_storage_l :	storage_top_lvl port map(clk, reset, storage_rst_l, vga_s_flag_l_strg, ctrl_s_flag_l_strg, r_w_l_strg, enc_in_l_strg, vga_adr_l_strg, ctrl_adr_l_strg, vga_flag_l_strg, ctrl_flag_l_strg, vga_data_l_strg, ctrl_data_l_strg);
storage_rst_l <= game_rst_l or lvl_up_l_strg; 

lvl_up_l_strg_s: side_input_sel port map(lvl_up_l_ctrl, lvl_up_m_ctrl, '0', conf(11 downto 10), lvl_up_l_strg);

vga_s_flag_l_strg_s: side_input_sel port map(vga_s_flag_l_vga, vga_s_flag_m_vga, t_l(0), conf(7 downto 6), vga_s_flag_l_strg);

ctrl_s_flag_l_strg_s: side_input_sel port map(ctrl_s_flag_l_ctrl, ctrl_s_flag_m_ctrl, t_l(1), conf(11 downto 10), ctrl_s_flag_l_strg);

r_w_l_strg_s: side_input_sel port map(r_w_l_ctrl, r_w_m_ctrl, t_l(2), conf(11 downto 10), r_w_l_strg);

enc_in_l_strg_s0: side_input_sel port map(enc_in_l_buf(0), enc_in_m_buf(0), t_l(3), conf(9 downto 8), enc_in_l_strg(0));
enc_in_l_strg_s1: side_input_sel port map(enc_in_l_buf(1), enc_in_m_buf(1), t_l(4), conf(9 downto 8), enc_in_l_strg(1));

vga_adr_l_strg_s0: side_input_sel port map(vga_adr_l_vga(0), vga_adr_m_vga(0), t_l(5), conf(7 downto 6), vga_adr_l_strg(0));
vga_adr_l_strg_s1: side_input_sel port map(vga_adr_l_vga(1), vga_adr_m_vga(1), t_l(6), conf(7 downto 6), vga_adr_l_strg(1));
vga_adr_l_strg_s2: side_input_sel port map(vga_adr_l_vga(2), vga_adr_m_vga(2), t_l(7), conf(7 downto 6), vga_adr_l_strg(2));
vga_adr_l_strg_s3: side_input_sel port map(vga_adr_l_vga(3), vga_adr_m_vga(3), t_l(8), conf(7 downto 6), vga_adr_l_strg(3));
vga_adr_l_strg_s4: side_input_sel port map(vga_adr_l_vga(4), vga_adr_m_vga(4), t_l(9), conf(7 downto 6), vga_adr_l_strg(4));
vga_adr_l_strg_s5: side_input_sel port map(vga_adr_l_vga(5), vga_adr_m_vga(5), t_l(10), conf(7 downto 6), vga_adr_l_strg(5));

ctrl_adr_l_strg_s0: side_input_sel port map(ctrl_adr_l_ctrl(0), ctrl_adr_m_ctrl(0), t_l(5), conf(11 downto 10), ctrl_adr_l_strg(0));
ctrl_adr_l_strg_s1: side_input_sel port map(ctrl_adr_l_ctrl(1), ctrl_adr_m_ctrl(1), t_l(6), conf(11 downto 10), ctrl_adr_l_strg(1));
ctrl_adr_l_strg_s2: side_input_sel port map(ctrl_adr_l_ctrl(2), ctrl_adr_m_ctrl(2), t_l(7), conf(11 downto 10), ctrl_adr_l_strg(2));
ctrl_adr_l_strg_s3: side_input_sel port map(ctrl_adr_l_ctrl(3), ctrl_adr_m_ctrl(3), t_l(8), conf(11 downto 10), ctrl_adr_l_strg(3));
ctrl_adr_l_strg_s4: side_input_sel port map(ctrl_adr_l_ctrl(4), ctrl_adr_m_ctrl(4), t_l(9), conf(11 downto 10), ctrl_adr_l_strg(4));
ctrl_adr_l_strg_s5: side_input_sel port map(ctrl_adr_l_ctrl(5), ctrl_adr_m_ctrl(5), t_l(10), conf(11 downto 10), ctrl_adr_l_strg(5));


--
l_vga_l :	vga_top_lvl port map(clk, reset, vga_rst_l, vga_flag_l_vga, score_up_l, game_end_l_vga, dip_sw_l_vga, vga_data_l_vga, max_l_vga, vga_s_flag_l_vga, h_sync_l, v_sync_l, rgb_l, vga_adr_l_vga);
score_up_l <= not(press_l_vga) nor game_end_l_vga;
vga_rst_l <= game_rst_l or rst_sc_l_vga;

press_l_vga_s: side_input_sel port map(press_l_buf, press_m_buf, '0', conf(1 downto 0), press_l_vga);

game_end_l_vga_s: side_input_sel port map(game_end_l_ctrl, game_end_m_ctrl, '0', conf(5 downto 4), game_end_l_vga);

rst_sc_l_vga_s: side_input_sel port map(rst_sc_l_ctrl, rst_sc_m_ctrl, '0', conf(5 downto 4), rst_sc_l_vga);

vga_flag_l_vga_s: side_input_sel port map(vga_flag_l_strg, vga_flag_m_strg, t_l(6), conf(3 downto 2), vga_flag_l_vga);

dip_sw_l_vga_s0: side_input_sel port map(dip_sw_l_ctrl(0), dip_sw_m_ctrl(0), t_l(7), conf(5 downto 4), dip_sw_l_vga(0));
dip_sw_l_vga_s1: side_input_sel port map(dip_sw_l_ctrl(1), dip_sw_m_ctrl(1), t_l(8), conf(5 downto 4), dip_sw_l_vga(1));

vga_data_l_vga_s0: side_input_sel port map(vga_data_l_strg(0), vga_data_m_strg(0), t_l(9), conf(3 downto 2), vga_data_l_vga(0));
vga_data_l_vga_s1: side_input_sel port map(vga_data_l_strg(1), vga_data_m_strg(1), t_l(10), conf(3 downto 2), vga_data_l_vga(1));


--m/r aka 2
l_input_bf_m:	input_bf port map (clk, c_input_r, press_m_buf, enc_in_m_buf);

--
l_controller_m:	controller port map(clk, reset, game_rst_r, max_m_ctrl, ctrl_flag_m_ctrl, press_m_ctrl, enc_in_m_ctrl, ctrl_data_m_ctrl, lvl_up_m_ctrl, dip_sw_m_ctrl, game_end_m_ctrl, rst_sc_m_ctrl, ctrl_s_flag_m_ctrl, r_w_m_ctrl, ctrl_adr_m_ctrl);

max_m_ctrl_s : side_input_sel port map(max_m_vga, max_l_vga, '0', conf(34 downto 33), max_m_ctrl);

ctrl_flag_m_ctrl_s : side_input_sel port map(ctrl_flag_m_strg, ctrl_flag_l_strg, t_l(0), conf(36 downto 35), ctrl_flag_m_ctrl);

press_m_ctrl_s : side_input_sel port map(press_m_buf, press_l_buf, '0', conf(38 downto 37), press_m_ctrl);

enc_in_m_ctrl_s0: side_input_sel port map(enc_in_m_buf(0), enc_in_l_buf(0), t_l(1), conf(38 downto 37), enc_in_m_ctrl(0));
enc_in_m_ctrl_s1: side_input_sel port map(enc_in_m_buf(1), enc_in_l_buf(1), t_l(2), conf(38 downto 37), enc_in_m_ctrl(1));

ctrl_data_m_ctrl_s0: side_input_sel port map(ctrl_data_m_strg(0), ctrl_data_l_strg(0), t_l(3), conf(36 downto 35), ctrl_data_m_ctrl(0));
ctrl_data_m_ctrl_s1: side_input_sel port map(ctrl_data_m_strg(1), ctrl_data_l_strg(1), t_l(4), conf(36 downto 35), ctrl_data_m_ctrl(1));
ctrl_data_m_ctrl_s2: side_input_sel port map(ctrl_data_m_strg(2), ctrl_data_l_strg(2), t_l(5), conf(36 downto 35), ctrl_data_m_ctrl(2));


--
l_storage_m:	storage_top_lvl port map(clk, reset, storage_rst_m, vga_s_flag_m_strg, ctrl_s_flag_m_strg, r_w_m_strg, enc_in_m_strg, vga_adr_m_strg, ctrl_adr_m_strg, vga_flag_m_strg, ctrl_flag_m_strg, vga_data_m_strg, ctrl_data_m_strg);
storage_rst_m <= game_rst_r or lvl_up_m_strg; 

lvl_up_m_strg_s: side_input_sel port map(lvl_up_m_ctrl, lvl_up_l_ctrl, '0', conf(31 downto 30), lvl_up_m_strg);

vga_s_flag_m_strg_s: side_input_sel port map(vga_s_flag_m_vga, vga_s_flag_l_vga, t_l(0), conf(27 downto 26), vga_s_flag_m_strg);

ctrl_s_flag_m_strg_s: side_input_sel port map(ctrl_s_flag_m_ctrl, ctrl_s_flag_l_ctrl, t_l(1), conf(31 downto 30), ctrl_s_flag_m_strg);

r_w_m_strg_s: side_input_sel port map(r_w_m_ctrl, r_w_l_ctrl, t_l(2), conf(31 downto 30), r_w_m_strg);

enc_in_m_strg_s0: side_input_sel port map(enc_in_m_buf(0), enc_in_l_buf(0), t_l(3), conf(29 downto 28), enc_in_m_strg(0));
enc_in_m_strg_s1: side_input_sel port map(enc_in_m_buf(1), enc_in_l_buf(1), t_l(4), conf(29 downto 28), enc_in_m_strg(1));

vga_adr_m_strg_s0: side_input_sel port map(vga_adr_m_vga(0), vga_adr_l_vga(0), t_l(5), conf(27 downto 26), vga_adr_m_strg(0));
vga_adr_m_strg_s1: side_input_sel port map(vga_adr_m_vga(1), vga_adr_l_vga(1), t_l(6), conf(27 downto 26), vga_adr_m_strg(1));
vga_adr_m_strg_s2: side_input_sel port map(vga_adr_m_vga(2), vga_adr_l_vga(2), t_l(7), conf(27 downto 26), vga_adr_m_strg(2));
vga_adr_m_strg_s3: side_input_sel port map(vga_adr_m_vga(3), vga_adr_l_vga(3), t_l(8), conf(27 downto 26), vga_adr_m_strg(3));
vga_adr_m_strg_s4: side_input_sel port map(vga_adr_m_vga(4), vga_adr_l_vga(4), t_l(9), conf(27 downto 26), vga_adr_m_strg(4));
vga_adr_m_strg_s5: side_input_sel port map(vga_adr_m_vga(5), vga_adr_l_vga(5), t_l(10), conf(27 downto 26), vga_adr_m_strg(5));

ctrl_adr_m_strg_s0: side_input_sel port map(ctrl_adr_m_ctrl(0), ctrl_adr_l_ctrl(0), t_l(5), conf(31 downto 30), ctrl_adr_m_strg(0));
ctrl_adr_m_strg_s1: side_input_sel port map(ctrl_adr_m_ctrl(1), ctrl_adr_l_ctrl(1), t_l(6), conf(31 downto 30), ctrl_adr_m_strg(1));
ctrl_adr_m_strg_s2: side_input_sel port map(ctrl_adr_m_ctrl(2), ctrl_adr_l_ctrl(2), t_l(7), conf(31 downto 30), ctrl_adr_m_strg(2));
ctrl_adr_m_strg_s3: side_input_sel port map(ctrl_adr_m_ctrl(3), ctrl_adr_l_ctrl(3), t_l(8), conf(31 downto 30), ctrl_adr_m_strg(3));
ctrl_adr_m_strg_s4: side_input_sel port map(ctrl_adr_m_ctrl(4), ctrl_adr_l_ctrl(4), t_l(9), conf(31 downto 30), ctrl_adr_m_strg(4));
ctrl_adr_m_strg_s5: side_input_sel port map(ctrl_adr_m_ctrl(5), ctrl_adr_l_ctrl(5), t_l(10), conf(31 downto 30), ctrl_adr_m_strg(5));


--
l_vga_m:	vga_top_lvl port map(clk, reset, vga_rst_m, vga_flag_m_vga, score_up_m, game_end_m_vga, dip_sw_m_vga, vga_data_m_vga, max_m_vga, vga_s_flag_m_vga, h_sync_r, v_sync_r, rgb_r, vga_adr_m_vga);
score_up_m <= not(press_m_vga) nor game_end_m_vga;
vga_rst_m <= game_rst_r or rst_sc_m_vga;

press_m_vga_s: side_input_sel port map(press_m_buf, press_l_buf, '0', conf(20 downto 19), press_m_vga);

game_end_m_vga_s: side_input_sel port map(game_end_m_ctrl, game_end_l_ctrl, '0', conf(24 downto 23), game_end_m_vga);

rst_sc_m_vga_s: side_input_sel port map(rst_sc_m_ctrl, rst_sc_l_ctrl, '0', conf(24 downto 23), rst_sc_m_vga);

vga_flag_m_vga_s: side_input_sel port map(vga_flag_m_strg, vga_flag_l_strg, t_l(6), conf(22 downto 21), vga_flag_m_vga);

dip_sw_m_vga_s0: side_input_sel port map(dip_sw_m_ctrl(0), dip_sw_l_ctrl(0), t_l(7), conf(24 downto 23), dip_sw_m_vga(0));
dip_sw_m_vga_s1: side_input_sel port map(dip_sw_m_ctrl(1), dip_sw_l_ctrl(1), t_l(8), conf(24 downto 23), dip_sw_m_vga(1));

vga_data_m_vga_s0: side_input_sel port map(vga_data_m_strg(0), vga_data_l_strg(0), t_l(9), conf(22 downto 21), vga_data_m_vga(0));
vga_data_m_vga_s1: side_input_sel port map(vga_data_m_strg(1), vga_data_l_strg(1), t_l(10), conf(22 downto 21), vga_data_m_vga(1));



--output
clk_out <= clk;

--from components to shift reg
--f_l
f_l_s0: mu111 port map(enc_in_l_buf(0), vga_flag_l_strg, conf(12), f_l(0));
f_l_s1: mu111 port map(enc_in_l_buf(1), ctrl_flag_l_strg, conf(12), f_l(1));
f_l_s2: mu111 port map(dip_sw_l_ctrl(0), vga_data_l_strg(0), conf(12), f_l(2));
f_l_s3: mu111 port map(dip_sw_l_ctrl(1), vga_data_l_strg(1), conf(12), f_l(3));
f_l_s4: mu111 port map(ctrl_s_flag_l_ctrl, ctrl_data_l_strg(0), conf(12), f_l(4));
f_l_s5: mu111 port map(r_w_l_ctrl, ctrl_data_l_strg(1), conf(12), f_l(5));
f_l_s6: mu111 port map(ctrl_adr_l_ctrl(0), ctrl_data_l_strg(2), conf(12), f_l(6));
f_l_s7: mu111 port map(ctrl_adr_l_ctrl(1), vga_s_flag_l_vga, conf(12), f_l(7));
f_l_s8: mu111 port map(ctrl_adr_l_ctrl(2), vga_adr_l_vga(0), conf(12), f_l(8));
f_l_s9: mu111 port map(ctrl_adr_l_ctrl(3), vga_adr_l_vga(1), conf(12), f_l(9));
f_l_s10: mu111 port map(ctrl_adr_l_ctrl(4), vga_adr_l_vga(2), conf(12), f_l(10));
f_l_s11: mu111 port map(ctrl_adr_l_ctrl(5), vga_adr_l_vga(3), conf(12), f_l(11));
f_l(12) <= vga_adr_l_vga(4);
f_l(13) <= vga_adr_l_vga(5);

--f_m
f_m_s0: mu111 port map(enc_in_m_buf(0), vga_flag_m_strg, conf(32), f_m(0));
f_m_s1: mu111 port map(enc_in_m_buf(1), ctrl_flag_m_strg, conf(32), f_m(1));
f_m_s2: mu111 port map(dip_sw_m_ctrl(0), vga_data_m_strg(0), conf(32), f_m(2));
f_m_s3: mu111 port map(dip_sw_m_ctrl(1), vga_data_m_strg(1), conf(32), f_m(3));
f_m_s4: mu111 port map(ctrl_s_flag_m_ctrl, ctrl_data_m_strg(0), conf(32), f_m(4));
f_m_s5: mu111 port map(r_w_m_ctrl, ctrl_data_m_strg(1), conf(32), f_m(5));
f_m_s6: mu111 port map(ctrl_adr_m_ctrl(0), ctrl_data_m_strg(2), conf(32), f_m(6));
f_m_s7: mu111 port map(ctrl_adr_m_ctrl(1), vga_s_flag_m_vga, conf(32), f_m(7));
f_m_s8: mu111 port map(ctrl_adr_m_ctrl(2), vga_adr_m_vga(0), conf(32), f_m(8));
f_m_s9: mu111 port map(ctrl_adr_m_ctrl(3), vga_adr_m_vga(1), conf(32), f_m(9));
f_m_s10: mu111 port map(ctrl_adr_m_ctrl(4), vga_adr_m_vga(2), conf(32), f_m(10));
f_m_s11: mu111 port map(ctrl_adr_m_ctrl(5), vga_adr_m_vga(3), conf(32), f_m(11));
f_m(12) <= vga_adr_m_vga(4);
f_m(13) <= vga_adr_m_vga(5);

--f_lm
f_lm_s0: mu111 port map(f_l(0), f_m(0), conf(25), f_lm(0));
f_lm_s1: mu111 port map(f_l(1), f_m(1), conf(25), f_lm(1));
f_lm_s2: mu111 port map(f_l(2), f_m(2), conf(25), f_lm(2));
f_lm_s3: mu111 port map(f_l(3), f_m(3), conf(25), f_lm(3));
f_lm_s4: mu111 port map(f_l(4), f_m(4), conf(25), f_lm(4));
f_lm_s5: mu111 port map(f_l(5), f_m(5), conf(25), f_lm(5));
f_lm_s6: mu111 port map(f_l(6), f_m(6), conf(25), f_lm(6));
f_lm_s7: mu111 port map(f_l(7), f_m(7), conf(25), f_lm(7));
f_lm_s8: mu111 port map(f_l(8), f_m(8), conf(25), f_lm(8));
f_lm_s9: mu111 port map(f_l(9), f_m(9), conf(25), f_lm(9));
f_lm_s10: mu111 port map(f_l(10), f_m(10), conf(25), f_lm(10));
f_lm_s11: mu111 port map(f_l(11), f_m(11), conf(25), f_lm(11));
f_lm_s12: mu111 port map(f_l(12), f_m(12), conf(25), f_lm(12));
f_lm_s13: mu111 port map(f_l(13), f_m(13), conf(25), f_lm(13));

--shift register
sh_o_reg_l_int(0) <= '0';
sh_out_gen_l:
for i in 0 to 13 generate
	sh_o_reg_l: sh_out_cell port map(testo_clk, testo_e, f_lm(i) , sh_o_reg_l_int(i), sh_o_reg_l_int(i+1));
end generate;
testo_d <= sh_o_reg_l_int(14);





--from shiftregister to components
sh_i_reg_l_0: dfn10 port map(testi_d , testi_clk, t_l(0));

sh_i_gen_l:
for k in 1 to 10 generate
	sh_i_reg_l: dfn10 port map(t_l(k-1), testi_clk, t_l(k));
end generate;






--config shiftregisters
cf_reg_0: dfn10 port map(config_d, config_clk, conf(0));

cf_gen:
for p in 1 to 38 generate
	cf_reg: dfn10 port map(conf(p-1), config_clk, conf(p));
end generate;

end structural;
