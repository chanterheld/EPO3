library ieee;
use ieee.std_logic_1164.all;

entity vga_top_lvl_tb is
end entity;

architecture behav of vga_top_lvl_tb is

component vga_top_lvl is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		flag	: in	std_logic;
		score_up: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		data_in	: in	std_logic_vector(1 downto 0);

		set_flag: out	std_logic;
		h_sync	: out	std_logic;
		v_sync	: out	std_logic;
		rgb	: out	std_logic_vector(2 downto 0);
		address	: out	std_logic_vector(5 downto 0)
	);
end component;

type color_type is (white, red, yellow, green, cyan, blue, magenta, black);
signal clk, reset, flag, flag_next, score_up, set_flag, clr_flag, h_sync, v_sync : std_logic;
signal dip_sw, data_in : std_logic_vector(1 downto 0);
signal rgb : std_logic_vector(2 downto 0);
signal address: std_logic_vector(5 downto 0);
signal color, color_send : color_type;

begin
L1: vga_top_lvl port map(clk, reset, reset, flag, score_up, dip_sw, data_in, set_flag, h_sync, v_sync, rgb, address);

clk 	<= 	'1' after 0 ns,
         	'0' after 81380 ps when clk /= '0' else '1' after 81380 ps;

reset <= 	'1' after 0 ns,
		'0' after 200 ns;

dip_sw <= 	"11" after 0 ns,
		"10" after 16748204 ns,
		"01" after 33496408 ns,
		"00" after 50244612 ns;

data_in <=	address(3)&address(0);

process(clk, v_sync)
begin
	if rising_edge(v_sync) then
		score_up <= '1';
	else
		if rising_edge(clk) then
			score_up <= '0';
		end if;
	end if;	
end process;

process (clk, set_flag, clr_flag, flag)
begin
	if flag = '1' then
		flag_next <= '1';
	else
		flag_next <= '0';
	end if;
	if set_flag = '1' then
		flag_next <= '1';
	elsif clr_flag = '1' then
		flag_next <= '0';
	end if;
	if (rising_edge(clk)) then
		flag <= flag_next;
	end if;
end process; 

clr_flag <= '1' after 300 ns when (flag = '1') else '0' after 20 ns;

clr_conv: process(rgb)
begin
	case rgb is
		when "000" => color <= black;
		when "001" => color <= blue;
		when "010" => color <= green;
		when "011" => color <= cyan;
		when "100" => color <= red;
		when "101" => color <= magenta;
		when "110" => color <= yellow;
		when "111" => color <= white;
		when others => color <= black;
	end case;
end process;

clr_conv2: process(data_in)
begin
	case data_in is
		when "00" => color_send <= blue;
		when "01" => color_send <= green;
		when "10" => color_send <= red;
		when "11" => color_send <= yellow;
		when others => color_send <= black;
	end case;
end process;
end behav;
