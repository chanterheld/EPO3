library ieee;
use ieee.std_logic_1164.all;
entity storage_top_lvl_tb is
end entity;

architecture behav of storage_top_lvl_tb is


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
end component storage_top_lvl;

type color_type is (white, red, yellow, green, cyan, blue, magenta, black);
signal clk, reset, vga_s_fl, ctrl_s_fl, r_w_in, vga_flag, ctrl_flag : std_logic;
signal live_clr, vga_data : std_logic_vector(1 downto 0);
signal ctrl_data,  vga_adr_x, vga_adr_y, ctlr_adr_x, ctlr_adr_y : std_logic_vector(2 downto 0);
signal vga_adr, ctlr_adr : std_logic_vector(5 downto 0);
signal colour_out, colour_live : color_type;

begin
l1: storage_top_lvl port map(clk, reset, reset, vga_s_fl, ctrl_s_fl, r_w_in, live_clr, vga_adr, ctlr_adr, vga_flag, ctrl_flag, vga_data, ctrl_data);

clk 	<= 	'1' after 0 ns,
         	'0' after 5 ns when clk /= '0' else '1' after 5 ns;
reset <= 	'1' after 0 ns,
		'0' after 30 ns;

vga_s_fl <= 	'1' after 0 ns;
vga_adr <=	"001001" after 0 ns,
		"001100" after 100 ns,
		"011010" after 180 ns,
		"100110" after 300 ns,
		"111011" after 380 ns,
		"010101" after 500 ns;
vga_adr_x	<= vga_adr(5 downto 3);
vga_adr_y	<= vga_adr(2 downto 0);


ctrl_s_fl<= 	'1' after 0 ns;
r_w_in<= 	'1' after 0 ns;
ctlr_adr <=	"001001" after 0 ns,
		"001100" after 140 ns,
		"011010" after 220 ns,
		"100110" after 340 ns,
		"111011" after 420 ns,
		"010101" after 540 ns;
ctlr_adr_x<=	ctlr_adr(5 downto 3);
ctlr_adr_y<=	ctlr_adr(2 downto 0);




live_clr<= 	"00" after 0 ns,
		"01" after 50 ns,
		"11" after 170 ns,
		"00" after 260 ns,
		"10" after 460 ns,
		"00" after 580 ns;

clr_conv1: process(vga_data)
begin
	case vga_data is
		when "00" => colour_out <= blue;
		when "01" => colour_out <= green;
		when "10" => colour_out <= red;
		when "11" => colour_out <= yellow;
		when others => colour_out <= black;
	end case;
end process;	

clr_conv2: process(live_clr)
begin
	case live_clr is
		when "00" => colour_live <= blue;
		when "01" => colour_live <= green;
		when "10" => colour_live <= red;
		when "11" => colour_live <= yellow;
		when others => colour_live <= black;
	end case;
end process;		

end behav;