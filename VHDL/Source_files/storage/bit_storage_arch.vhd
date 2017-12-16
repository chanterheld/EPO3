library ieee;
use ieee.std_logic_1164.all;

architecture structural of bit_storage is
component dnl_gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load_1	: in	std_logic;
		load_2	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

component mplex7t1_1 is
	port(	input	: in	std_logic_vector(6 downto 0);
		sel	: in	std_logic_vector(2 downto 0);
		output	: out	std_logic
	);
end component;

component inv_decoder_3to7 is
  port(
    x  :  in  std_logic_vector(2 downto 0);
    y  :  out  std_logic_vector(6 downto 0)
	);
end component;

signal we_x, we_y, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, x_plex_out : std_logic_vector(6 downto 0);
signal x_adr_wr, y_adr_wr, x_adr_r, y_adr_r: std_logic_vector(2 downto 0);
begin
x_adr_wr <= wr_adr(5 downto 3);
y_adr_wr <= wr_adr(2 downto 0);
x_adr_r <= r_adr(5 downto 3);
y_adr_r <= r_adr(2 downto 0);

gen_row1:
for t in 0 to 5 generate
	lt_r: dnl_gated_reg_1 port map(clk, reset, we_y(0), we_x(t+1), '1', data_r1(t+1));
end generate;
data_r1(0) <= '1';
lt_m: mplex7t1_1 port map(data_r1, x_adr_r, x_plex_out(0));

gen_row2:
for u in 0 to 6 generate
	lu_r: dnl_gated_reg_1 port map(clk, reset, we_y(1), we_x(u), '1', data_r2(u));
end generate;
lu_m: mplex7t1_1 port map(data_r2, x_adr_r, x_plex_out(1));

gen_row3:
for v in 0 to 6 generate
	lv_r: dnl_gated_reg_1 port map(clk, reset, we_y(2), we_x(v), '1', data_r3(v));
end generate;
lv_m: mplex7t1_1 port map(data_r3, x_adr_r, x_plex_out(2));

gen_row4:
for w in 0 to 6 generate
	lw_r: dnl_gated_reg_1 port map(clk, reset, we_y(3), we_x(w), '1', data_r4(w));
end generate;
lu_w: mplex7t1_1 port map(data_r4, x_adr_r, x_plex_out(3));

gen_row5:
for x in 0 to 6 generate
	lx_r: dnl_gated_reg_1 port map(clk, reset, we_y(4), we_x(x), '1', data_r5(x));
end generate;
lx_m: mplex7t1_1 port map(data_r5, x_adr_r, x_plex_out(4));

gen_row6:
for y in 0 to 6 generate
	ly_r: dnl_gated_reg_1 port map(clk, reset, we_y(5), we_x(y), '1', data_r6(y));
end generate;
ly_m: mplex7t1_1 port map(data_r6, x_adr_r, x_plex_out(5));

gen_row7:
for z in 0 to 6 generate
	lz_r: dnl_gated_reg_1 port map(clk, reset, we_y(6), we_x(z), '1', data_r7(z));
end generate;
lz_m: mplex7t1_1 port map(data_r7, x_adr_r, x_plex_out(6));

ldeco_x: inv_decoder_3to7 port map(x_adr_wr, we_x);
ldeco_y: inv_decoder_3to7 port map(y_adr_wr, we_y);
lc_m: mplex7t1_1 port map(x_plex_out, y_adr_r, bit_out);
end structural;
