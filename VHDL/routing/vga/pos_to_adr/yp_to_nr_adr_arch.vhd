library ieee;
use ieee.std_logic_1164.all;

architecture structural of yp_to_nr_adr is
component gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

component comp_nor_4 is
   	port(	a       :in    std_logic_vector(3 downto 0);
   		comp_s  :in    std_logic_vector(3 downto 0);
        	comp_out:out   std_logic;
        	nor_out :out   std_logic);
end component;

component h_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
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

component stk_f_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		c_in 	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

signal pos_reg, pos_next : std_logic_vector(7 downto 0);
signal mplex_out, block_size: std_logic_vector (3 downto 0);
signal address_s: std_logic_vector(3 downto 0);
signal reg_load, reg_reset, cnt_reset, reset_s, intrm: std_logic;
signal r_add_int: std_logic_vector(6 downto 0);
signal comp_out, reg_nor, comp_out_l, reg_nor_l, comp_out_r, reg_nor_r: std_logic;

signal r_reg_inv, posi_inv : std_logic_vector(3 downto 0);
--adr_register signals
signal adr_comp_out, adr_reset_s, nr_select, intrm_1 : std_logic;
signal adr_cnt_s, uo3_int : std_logic_vector(2 downto 0);

begin
--8 bit gated register
reg_0: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(0), pos_reg(0));
reg_1: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(1), pos_reg(1));
reg_2: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(2), pos_reg(2));
reg_3: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(3), pos_reg(3));
reg_4: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(4), pos_reg(4));
reg_5: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(5), pos_reg(5));
reg_6: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(6), pos_reg(6));
reg_7: gated_reg_1 port map(clk, reg_reset, reg_load, pos_next(7), pos_reg(7));

--comp+nor
l_comp: comp_nor_4 port map(pos_reg(3 downto 0), posi(3 downto 0), comp_out_l, reg_nor_l);

r_reg_inv(0) <= pos_reg(7);
r_reg_inv(1) <= pos_reg(6);
r_reg_inv(2) <= pos_reg(5);
r_reg_inv(3) <= pos_reg(4);

posi_inv(0) <= posi(7);
posi_inv(1) <= posi(6);
posi_inv(2) <= posi(5);
posi_inv(3) <= posi(4);

r_comp: comp_nor_4 port map(r_reg_inv(3 downto 0), posi_inv(3 downto 0), comp_out_r, reg_nor_r);

comp_out <= comp_out_l and comp_out_r;
reg_nor <= reg_nor_l and reg_nor_r;

--8 + 4 = 8 bit adder
--adder: r_add_8port map(pos_reg, mplex_resized, pos_next);

ha_o: h_add port map(pos_reg(0),mplex_out(0), pos_next(0), r_add_int(0));
f_add_1: stk_f_add port map(pos_reg(1),mplex_out(1), r_add_int(0), pos_next(1), r_add_int(1));
f_add_2: stk_f_add port map(pos_reg(2),mplex_out(2), r_add_int(1), pos_next(2), r_add_int(2));
f_add_3: stk_f_add port map(pos_reg(3),mplex_out(3), r_add_int(2), pos_next(3), r_add_int(3));
ha_4: h_add port map(pos_reg(4), r_add_int(3), pos_next(4), r_add_int(4));
ha_5: h_add port map(pos_reg(5), r_add_int(4), pos_next(5), r_add_int(5));
ha_6: h_add port map(pos_reg(6), r_add_int(5), pos_next(6), r_add_int(6));
pos_next(7) <= r_add_int(6) xor pos_reg(7);

--1+3 bit counter/register
--adr_reg: nr_cnt_y	port map(clk, reset_s, comp_out, cnt_reset, address_s);

---reg: up_one_cnt_3	port map(clk, adr_reset_s, comp_out, adr_cnt_s);
reg_seg_2: t_ff port map(clk, adr_reset_s, uo3_int(2), adr_cnt_s(2));
reg_seg:
for i in 0 to 1 generate
	lx: up_cnt_cell port map(clk, adr_reset_s, uo3_int(i), adr_cnt_s(i), uo3_int(i+1));
end generate;
uo3_int(0) <= comp_out;
---
nr_sel: t_ff		port map(clk, reset_s, intrm_1, nr_select);

adr_comp_out <=	'1' when (adr_cnt_s = "101") else '0';
intrm_1 <= (adr_comp_out and comp_out);
adr_reset_s <= (intrm_1 or reset_s);
address_s <= (nr_select&adr_cnt_s);
cnt_reset <= (intrm_1 and nr_select);
--




--mplex
mplex_out <=	"1110" when (reg_nor = '1') else block_size;

reg_load <= comp_out or reg_nor;
reg_reset <= reset_s or cnt_reset;
reset_s <= reset or r_reset;
address <= address_s;

--seg size logic
intrm <= (address_s(0) nand address_s(2));
block_size <= address_s(0)&intrm&intrm&intrm;
end architecture;
