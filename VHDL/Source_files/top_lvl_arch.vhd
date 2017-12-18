library ieee;
use ieee.std_logic_1164.all;

architecture structural of top_lvl is
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
		live_clr: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(2 downto 0);		

		lvl_up	: out	std_logic;
		dip_sw	: out	std_logic_vector(1 downto 0);
		game_end: out	std_logic;
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

signal press, score_up, max, ctrl_s_flag, vga_s_flag, ctrl_flag, vga_flag, lvl_up, game_end, r_w, storage_rst : std_logic;
signal enc_in, vga_data, dip_sw	: std_logic_vector(1 downto 0);
signal ctrl_data : std_logic_vector(2 downto 0);
signal ctrl_adr, vga_adr : std_logic_vector(5 downto 0);
begin
l_input_bf:	input_bf port map (clk, c_input, press, enc_in);
l_controller:	controller port map(clk, reset, game_rst, max, ctrl_flag, enc_in, ctrl_data, lvl_up, dip_sw, game_end, ctrl_s_flag, r_w, ctrl_adr);
l_storage:	storage_top_lvl port map(clk, reset, storage_rst, vga_s_flag, ctrl_s_flag, r_w, enc_in, vga_adr, ctrl_adr, vga_flag, ctrl_flag, vga_data, ctrl_data);
l_vga:		vga_top_lvl port map(clk, reset, game_rst, vga_flag, score_up, game_end, dip_sw, vga_data, max, vga_s_flag, h_sync, v_sync, rgb, vga_adr);
storage_rst <= game_rst or lvl_up; 
score_up <= not(press) nor game_end;
end structural;