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

component mplex2t1_6 is 
	port(	a	: in 	std_logic_vector(5 downto 0);
		b	: in	std_logic_vector(5 downto 0);
		sel	: in	std_logic;
		q	: out	std_logic_vector(5 downto 0)
	);
end component;

component mplex2t1_2 is 
	port(	a	: in 	std_logic_vector(1 downto 0);
		b	: in	std_logic_vector(1 downto 0);
		sel	: in	std_logic;
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

component h_latch is
	port(	t	: in	std_logic;
		hold	: in	std_logic;
		q	: out	std_logic
	);
end component;

component fake_rng is
	port(	address 	: in	std_logic_vector(5 downto 0);
		colour		: out	std_logic_vector(1 downto 0)
	);
end component;

signal vga_flag_s, vga_clr_flag, ctrl_flag_s, ctrl_ap_flag, fal_write, ctrl_clr_flag, fsm_out, a_flag, input_sel, storage_out, reset_s : std_logic;
signal rng_color, return_color : std_logic_vector(1 downto 0);
signal cntrl_data_in : std_logic_vector(2 downto 0);
signal read_adr, write_adr : std_logic_vector(5 downto 0);
begin

l1: storage_fsm port map(clk, reset, a_flag, fsm_out);
l2: bit_storage port map(clk, reset_s, write_adr , read_adr, storage_out);
l3: flag_reg_2 port map(clk, reset, vga_s_fl, vga_clr_flag, return_color, vga_data, vga_flag_s);
l4: flag_reg_3 port map(clk, reset, ctrl_s_fl, ctrl_clr_flag, cntrl_data_in, ctrl_data, ctrl_flag_s);
l5: mplex2t1_6 port map(ctlr_adr, vga_adr, input_sel, read_adr);
l6: mplex2t1_6 port map("000000", ctlr_adr, fal_write, write_adr);
l7: mplex2t1_2 port map(rng_color, live_clr, storage_out, return_color);
l8: h_latch port map(vga_flag_s, fsm_out, input_sel);
l9: fake_rng port map(read_adr, rng_color);

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

