library ieee;
use ieee.std_logic_1164.all;

 architecture structural of xp_to_nr_adr is
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
signal address_s: std_logic_vector(1 downto 0);
signal reg_load, reg_reset, cnt_reset, reset_s: std_logic;
signal mplex_out, block_size, margin : std_logic_vector(6 downto 0);

signal comp_out, reg_nor, comp_out_l, reg_nor_l, comp_out_r, reg_nor_r : std_logic;
signal r_add_int: std_logic_vector(6 downto 0);

--adr_reg_signals
signal adr_comp_out, adr_reset_s, uo_int : std_logic;

begin
--p_reg: gated_reg_8	port map(clk, reg_reset, reg_load, pos_next, pos_reg);
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
r_comp: comp_nor_4 port map(pos_reg(7 downto 4), posi(7 downto 4), comp_out_r, reg_nor_r);
comp_out <= comp_out_l and comp_out_r;
reg_nor <= reg_nor_l and reg_nor_r;

--adder: r_add_8		port map(pos_reg, mplex_out, pos_next);
ha_o: h_add port map(pos_reg(0),mplex_out(0), pos_next(0), r_add_int(0));
f_add_1: stk_f_add port map(pos_reg(1),mplex_out(1), r_add_int(0), pos_next(1), r_add_int(1));
f_add_2: stk_f_add port map(pos_reg(2),mplex_out(2), r_add_int(1), pos_next(2), r_add_int(2));
f_add_3: stk_f_add port map(pos_reg(3),mplex_out(3), r_add_int(2), pos_next(3), r_add_int(3));
f_add_4: stk_f_add port map(pos_reg(4),mplex_out(4), r_add_int(3), pos_next(4), r_add_int(4));
f_add_5: stk_f_add port map(pos_reg(5),mplex_out(5), r_add_int(4), pos_next(5), r_add_int(5));
f_add_6: stk_f_add port map(pos_reg(6),mplex_out(6), r_add_int(5), pos_next(6), r_add_int(6));
pos_next(7) <= r_add_int(6) xor pos_reg(7);

--2 bit counter/register
--adr_reg: nr_cnt_x	port map(clk, reset_s, comp_out, cnt_reset, address_s);
---reg: up_one_cnt_2	port map(clk, adr_reset_s, comp_out, address_s);
l2: t_ff port map(clk, adr_reset_s, uo_int, address_s(1));
l3: up_cnt_cell port map(clk, adr_reset_s, comp_out, address_s(0), uo_int);

---
adr_comp_out <=	'1' when (address_s = "11") else '0';
cnt_reset <= (adr_comp_out and comp_out);
adr_reset_s <= (cnt_reset or reset_s);
--

margin <= 	"0111100" when (game_d = '1') else "1111010";
mplex_out <=	margin when (reg_nor = '1') else block_size;

reg_load <= comp_out or reg_nor;
reg_reset <= reset_s or cnt_reset;
reset_s <= reset or r_reset;
address <= address_s;

block_size <= "00"&address_s(0)&'0'&not(address_s(0))&"11";
end architecture;

