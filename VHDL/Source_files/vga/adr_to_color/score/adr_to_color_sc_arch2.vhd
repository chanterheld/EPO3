library ieee;
use ieee.std_logic_1164.all;

entity adr_to_color_sc is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		game_rst: in	std_logic;
		plus_one: in	std_logic;
		x_adr	: in	std_logic_vector(1 downto 0);
		y_adr	: in	std_logic_vector(3 downto 0);

		max	: out	std_logic;
		e_n	: out	std_logic;
		color	: out	std_logic_vector(1 downto 0)
		
	);
end entity adr_to_color_sc;

library ieee;
use ieee.std_logic_1164.all;


architecture low_lvl of adr_to_color_sc is
--component score_cnt is
--	port(	clk	: in	std_logic;
--		reset	: in	std_logic;
--		game_rst: in	std_logic;
--		plus_one: in	std_logic;
--		tens	: out	std_logic_vector(1 downto 0);
--		ones	: out	std_logic_vector(3 downto 0)
--	);
--end component;
--
--component bcd_to_seg is
--	port(	bcd	: in	std_logic_vector(3 downto 0);
--		seg	: out	std_logic_vector(12 downto 0)
--	);
--end component;
--
--component num_decoder is
--	port(	x_adr	: in	std_logic_vector(1 downto 0);
--		y_adr	: in	std_logic_vector(2 downto 0);
--		seg	: in	std_logic_vector(12 downto 0);
--		e_n	: out	std_logic
--	);
--end component;

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

signal tens: std_logic_vector(1 downto 0);
signal tens_resized, ones, bcd: std_logic_vector(3 downto 0);
signal seg: std_logic_vector(12 downto 0);

--bcd counter signals
signal ones_r, tens_r, ones_max, connect_2bit_up: std_logic;
signal connect_4bit_up : std_logic_vector(3 downto 0);
--num decoder signals
signal mux_in : std_logic_vector(4 downto 0);

begin
--l_cnt: score_cnt port map(clk, reset, game_rst, plus_one, tens, ones);
-- 2 digit bcd counter

---l_tens: up_one_cnt_2 port map(clk, tens_r, ones_max, tens);
---2 bit up counter
l1: t_ff port map(clk, tens_r, connect_2bit_up, tens(1));
l2: up_cnt_cell port map(clk, tens_r, ones_max, tens(0), connect_2bit_up);
---

---l_ones: up_one_cnt_4 port map(clk, ones_r, plus_one, ones);
---4 bit up counter
l3: t_ff port map(clk, ones_r, connect_4bit_up(3), ones(3));
ff_gen:
for i in 0 to 2 generate
	lx: up_cnt_cell port map(clk, ones_r, connect_4bit_up(i), ones(i), connect_4bit_up(i+1));
end generate;
connect_4bit_up(0) <= plus_one;
---

ones_max <= ones(3) and ones(0) and plus_one;
tens_r <= reset or game_rst; 
ones_r <= ones_max or tens_r;
--

--mux
bcd <= ones when (y_adr(3) = '1') else tens_resized;

--l_t_seg: bcd_to_seg port map(bcd, seg);
-- logic conversion
seg(0) <= seg(1) and seg(3);
seg(1) <= not((bcd(2) xnor bcd(0)) or bcd(3) or bcd(1));
seg(2) <= '0';
seg(3) <= not(((bcd(1) nand bcd(0)) and bcd(2)) or bcd(3) or (bcd(1) nor bcd(0)));
seg(4) <= (bcd(1) xor bcd(0)) and bcd(2);
seg(5) <= seg(3) and seg(6) and seg(8); --seg(3) or seg(6) or seg(8)
seg(6) <= not((bcd(2) xor bcd(1)) or bcd(3) or (not(bcd(1)) nor bcd(0)));
seg(7) <= '0';
seg(8) <= not((bcd(2) nor bcd(0)) or (not(bcd(1)) nor bcd(0)));
seg(9) <= not(bcd(2) or not(bcd(1)) or bcd(0));
seg(10) <= not(bcd(3) or (not(bcd(1)) nor bcd(0)) or (bcd(2) xor (bcd(0) nand not(bcd(1)))));
seg(11) <= seg(10);
seg(12) <= '0';
--

--l_deco: num_decoder port map(x_adr, y_adr(2 downto 0), seg, e_n);
-- speciallised mux
mux_in <= x_adr&y_adr(2 downto 0);
mux: process(mux_in, seg)
begin
	case mux_in is
		when "01001" => e_n <= seg(0);
		when "10001" => e_n <= seg(1);
		when "11001" => e_n <= seg(2);
		when "01010" => e_n <= seg(3);
		when "11010" => e_n <= seg(4);
		when "01011" => e_n <= seg(5);
		when "10011" => e_n <= seg(6);
		when "11011" => e_n <= seg(7);
		when "01100" => e_n <= seg(8);
		when "11100" => e_n <= seg(9);
		when "01101" => e_n <= seg(10);
		when "10101" => e_n <= seg(11);
		when "11101" => e_n <= seg(12);
		when others => e_n <= '1';
	end case;
end process;
--

tens_resized <= "00"&tens;
color <= ones(2 downto 1);
max <= '1' when (tens = "11") else '0';
end low_lvl;
