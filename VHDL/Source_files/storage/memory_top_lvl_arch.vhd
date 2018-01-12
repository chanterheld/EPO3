library ieee;
use ieee.std_logic_1164.all;

 architecture structural of storage_top_lvl is
component storage_fsm is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		a_flag	: in	std_logic;
		fsm_out	: out	std_logic
	);
end component;

component bit_storage is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		wr_adr	: in	std_logic_vector(5 downto 0);
		r_adr	: in	std_logic_vector(5 downto 0);

		bit_out	: out	std_logic
	);
end component;

component flag_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		set_flag: in	std_logic;
		clr_flag: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);

		q	: out	std_logic_vector(1 downto 0);
		flag	: out	std_logic
	);
end component;

component flag_reg_3 is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		set_flag: in	std_logic;
		clr_flag: in	std_logic;
		t	: in	std_logic_vector(2 downto 0);
		q	: out	std_logic_vector(2 downto 0);
		flag	: out	std_logic
	);
end component;

component h_latch is
	port(	t	: in	std_logic;
		hold	: in	std_logic;
		q	: out	std_logic
	);
end component;

component randomblock is
port (	clk : in std_logic;
	reset : in std_logic;
	restart : in std_logic;
	address : in std_logic_vector(5 downto 0);
	color: out std_logic_vector(1 downto 0)
);
end component;

signal vga_flag_s, vga_clr_flag, ctrl_flag_s, ctrl_ap_flag, fal_write, ctrl_clr_flag, fsm_out, a_flag, input_sel, storage_out, reset_s, cntr_fl_rst, vga_fl_rst : std_logic;
signal rng_color, return_color: std_logic_vector(1 downto 0);
signal cntrl_data_in : std_logic_vector(2 downto 0);
signal read_adr, write_adr : std_logic_vector(5 downto 0);
signal seed : std_logic_vector(9 downto 0);

begin
fsm: storage_fsm port map(clk, reset, a_flag, fsm_out);
storage: bit_storage port map(clk, reset_s, write_adr , read_adr, storage_out);


--freg_2: flag_reg_2 port map(clk, reset, vga_s_fl, vga_clr_flag, return_color, vga_data, vga_flag_s);

	--data_reg: gated_reg_2 port map(clk, reset, clr_flag, t, q);
	vga_data_reg_0: gated_reg_1 port map(clk, reset, vga_clr_flag, return_color(0), vga_data(0));
	vga_data_reg_1: gated_reg_1 port map(clk, reset, vga_clr_flag, return_color(1), vga_data(1));
		
	--

vga_flag_reg: gated_reg_1 port map(clk, vga_fl_rst, vga_s_fl, '1', vga_flag_s);
vga_fl_rst <= reset or vga_clr_flag;

--

--freg_3: flag_reg_3 port map(clk, reset, ctrl_s_fl, ctrl_clr_flag, cntrl_data_in, ctrl_data, ctrl_flag_s);
cntr_data_reg_0: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(0), ctrl_data(0));
cntr_data_reg_1: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(1), ctrl_data(1));
cntr_data_reg_2: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(2), ctrl_data(2));

cntr_flag_reg: gated_reg_1 port map(clk, cntr_fl_rst, ctrl_s_fl, '1', ctrl_flag_s);
cntr_fl_rst <= reset or ctrl_clr_flag;
--
hlatch: h_latch port map(vga_flag_s, fsm_out, input_sel);
--seed_gen: random port map(clk, reset, game_rst, seed);
--map_gen: mapgenerator port map(read_adr, seed, rng_color);
l_rng: randomblock port map(clk, reset, game_rst, read_adr, rng_color);
--mplex
read_adr <= vga_adr when (input_sel = '1') else ctlr_adr;
write_adr <= ctlr_adr when (fal_write = '1') else "000000";
return_color <= live_clr when (storage_out = '1') else rng_color;

a_flag <= ctrl_ap_flag or vga_flag_s;
ctrl_ap_flag <= (not(ctrl_flag_s) nor r_w_in);
fal_write <= r_w_in and ctrl_flag_s;
ctrl_clr_flag <= ((not(fsm_out) nor input_sel) or fal_write);
vga_clr_flag <= fsm_out and input_sel;
reset_s <= reset or game_rst;
cntrl_data_in <= storage_out&return_color;

vga_flag <= vga_flag_s;
ctrl_flag <= ctrl_flag_s;
end structural;

