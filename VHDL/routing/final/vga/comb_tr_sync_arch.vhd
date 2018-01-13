library ieee;
use ieee.std_logic_1164.all;

 architecture structural of tr_sync is
component fst_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		q	: out 	std_logic
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

signal reset_s_x, intrm_1 : std_logic;
signal cnt_s_x : std_logic_vector(7 downto 0);
signal h_interconnect : std_logic_vector(6 downto 0);

signal reset_s_y, intrm_2 : std_logic;
signal cnt_s_y, v_interconnect : std_logic_vector(9 downto 0);

signal h_reg, h_next, intrm_h1, intrm_h2, intrm_h3, intrm_h4, intrm_h5 : std_logic;
signal v_reg, v_next, intrm_v1, intrm_v2, intrm_v3, intrm_v4: std_logic;

begin
--x_gen
l1: fst_cnt_cell port map(clk, reset_s_x, h_interconnect(0));
l2: t_ff port map(clk, reset_s_x, h_interconnect(6), cnt_s_x(7));
ffx_gen:
for i in 0 to (5) generate
	lx: up_cnt_cell port map(clk, reset_s_x, h_interconnect(i), cnt_s_x(i+1), h_interconnect(i+1));
end generate;
cnt_s_x(0) <= h_interconnect(0);

r_reset_x <= '1' when (cnt_s_x = "10100000") else '0';
intrm_1 <= (cnt_s_x(7) and cnt_s_x(6) and cnt_s_x(2));
reset_s_x <= (intrm_1 or reset);
cnt_x <= cnt_s_x;

--y_gen
l3: t_ff port map(clk, reset_s_y, v_interconnect(9), cnt_s_y(9));
ffy_gen:
for i in 0 to (8) generate
	ly: up_cnt_cell port map(clk, reset_s_y, v_interconnect(i), cnt_s_y(i), v_interconnect(i+1));
end generate;
v_interconnect(0) <= intrm_1;

r_reset_y <= '1' when (cnt_s_y(9 downto 2) = "10000000") else '0';
intrm_2 <= (cnt_s_y(9) and cnt_s_y(3) and cnt_s_y(2)and cnt_s_y(0) and intrm_1);
reset_s_y <= (intrm_2 or reset);
cnt_y <= cnt_s_y(9 downto 2);

--sync_gen
intrm_h1 <= (h_reg or reset);
intrm_h2 <= (cnt_s_x(7) nand cnt_s_x(5));
intrm_h3 <= (cnt_s_x(4) nand cnt_s_x(3));
intrm_h4 <= (intrm_h1 nand intrm_h2);
intrm_h5 <= (intrm_h3 or intrm_h2);
h_next <= (intrm_h4 nand intrm_h5);

intrm_v1 <= (v_reg or reset);
intrm_v2 <= (cnt_s_y(9) and cnt_s_y(3));
intrm_v3 <= (intrm_v2 nand cnt_s_y(2));
intrm_v4 <= (intrm_v1 nand intrm_v3);
v_next <= (intrm_v4 nand cnt_s_y(9));

process (clk)
begin
	if (rising_edge(clk)) then
		h_reg <= h_next;
		v_reg <= v_next;
	end if;
end process;
v_sync <= v_reg;
h_sync <= h_reg;
end structural;