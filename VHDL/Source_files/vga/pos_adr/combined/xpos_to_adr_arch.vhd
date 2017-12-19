library ieee;
use ieee.std_logic_1164.all;

 architecture structural of xpos_to_adr is
component h_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		s 	: out 	std_logic;
 		c_out 	: out 	std_logic
	);
end component;

component f_add is
 	port(	a	: in 	std_logic;
 		b	: in 	std_logic;
 		c_in 	: in 	std_logic;
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

--signals field
signal pos_reg_f, pos_next_f, mplex_f_resized : std_logic_vector(7 downto 0);
signal mplex_out_f : std_logic_vector(4 downto 0);
signal comp_out_f, reg_nor_f, reg_load_f, reg_reset_f, cnt_reset_f: std_logic;
--signal nr
signal pos_reg_nr, pos_next_nr, mplex_out_nr, seg_size, margin : std_logic_vector(7 downto 0);
signal address_nr_s: std_logic_vector(1 downto 0);
signal comp_out_nr, reg_nor_nr, reg_load_nr, reg_reset_nr, cnt_reset_nr : std_logic;
--both
signal reset_s: std_logic;
--gated_reg signals
signal reg_plex_out_f, reg_plex_out_nr: std_logic_vector(7 downto 0);
--r_adder signals
signal f_add_interconnect, nr_add_interconnect : std_logic_vector(6 downto 0);
--blk_adr_cnt signals
signal blk_adr_max, reset_f_adr_s : std_logic;
signal uo_f_interconnect, address_field_s : std_logic_vector(2 downto 0);
--nr_adr_cnt signals
signal nr_adr_max, reset_nr_adr_s, uo_nr_interconnect : std_logic;

begin
--gated_reg_8 field
process (clk)
begin
	if (rising_edge(clk)) then
		if (reg_reset_f = '1') then
			pos_reg_f <= (others => '0');
		else
			pos_reg_f <= reg_plex_out_f;
		end if;
	end if;
end process;
reg_plex_out_f <= pos_next_f when (reg_load_f = '1') else pos_reg_f;

--gated_reg_8 nr
process (clk)
begin
	if (rising_edge(clk)) then
		if (reg_reset_nr = '1') then
			pos_reg_nr <= (others => '0');
		else
			pos_reg_nr <= reg_plex_out_nr;
		end if;
	end if;
end process;
reg_plex_out_nr <= pos_next_nr when (reg_load_nr = '1') else pos_reg_nr;

--adder_f: r_add_8	port map(pos_reg_f, mplex_f_resized, pos_next_f);--field
--r_add_8 field
h_add_f: h_add port map(pos_reg_f(0), mplex_f_resized(0), pos_next_f(0), f_add_interconnect(0));
f_add_gen:
for i in 0 to 5 generate
	lx: f_add port map(pos_reg_f(i+1), mplex_f_resized(i+1), f_add_interconnect(i), pos_next_f(i+1), f_add_interconnect(i+1));
end generate;
pos_next_f(7) <= (pos_reg_f(7) xor mplex_f_resized(7) xor f_add_interconnect(6));

--adder_nr: r_add_8	port map(pos_reg_nr, mplex_out_nr, pos_next_nr);--nr
--r_add_8 nr
h_add_nr: h_add port map(pos_reg_nr(0), mplex_out_nr(0), pos_next_nr(0), nr_add_interconnect(0));
nr_add_gen:
for j in 0 to 5 generate
	ly: f_add port map(pos_reg_nr(j+1), mplex_out_nr(j+1), nr_add_interconnect(j), pos_next_nr(j+1), nr_add_interconnect(j+1));
end generate;
pos_next_nr(7) <= (pos_reg_nr(7) xor mplex_out_nr(7) xor nr_add_interconnect(6));

--adr_reg_f: blk_cnt	port map(clk, reset_s, comp_out_f, dip_sw, cnt_reset_f, address_field);--field
--blk_cnt

---blk_reg: up_one_cnt_3	port map(clk, reset_f_adr_s, comp_out_f, address_field);
---entity up_one_cnt_3
l1: t_ff port map(clk, reset_f_adr_s, uo_f_interconnect(2), address_field_s(2));
ff_gen:
for i in 0 to 1 generate
	lx: up_cnt_cell port map(clk, reset_f_adr_s, uo_f_interconnect(i), address_field_s(i), uo_f_interconnect(i+1));
end generate;
uo_f_interconnect(0) <= comp_out_f;
---
blk_adr_max <=	'1' when (address_field_s = '1'&dip_sw) else '0';
cnt_reset_f <= (blk_adr_max and comp_out_f);
reset_f_adr_s <= (cnt_reset_f or reset_s);

address_field <= address_field_s;

--adr_reg_nr: nr_cnt_x	port map(clk, reset_s, comp_out_nr, cnt_reset_nr, address_nr_s);--nr
--nr_cnt_x

---nr_reg: up_one_cnt_2	port map(clk, reset_nr_adr_s, comp_out_nr, address_nr_s);
---entity up_one_cnt_2
l2: t_ff port map(clk, reset_nr_adr_s, uo_nr_interconnect, address_nr_s(1));
l3: up_cnt_cell port map(clk, reset_nr_adr_s, comp_out_nr, address_nr_s(0), uo_nr_interconnect);
---
nr_adr_max <=	'1' when (address_nr_s = "11") else '0';
cnt_reset_nr <= (nr_adr_max and comp_out_nr);
reset_nr_adr_s <= (cnt_reset_nr or reset_s);

 --comp
reg_nor_f <=	'1' when (pos_reg_f = "00000000") else '0';--field
comp_out_f <=	'1' when (pos_reg_f = posi) else '0';--field

comp_out_nr <= 	'1' when (pos_reg_nr = posi) else '0';--nr
reg_nor_nr  <= 	'1' when (pos_reg_nr = "00000000") else '0';--nr

 --mplex
mplex_out_f <=	"00101" when (reg_nor_f = '1') else block_size;--field
mplex_f_resized <= "000"&mplex_out_f;--field only

mplex_out_nr <=	margin when (reg_nor_nr = '1') else seg_size; -- nr
margin <= "00111100" when (game_d = '1') else "01111010"; -- nr only
seg_size <= "000"&address_nr_s(0)&'0'&not(address_nr_s(0))&"11"; -- nr only

reg_load_f <= comp_out_f or reg_nor_f;--field
reg_load_nr <= comp_out_nr or reg_nor_nr;--nr

reg_reset_f <= reset_s or cnt_reset_f;--field
reg_reset_nr <= reset_s or cnt_reset_nr;--nr

reset_s <= reset or r_reset;--both

address_number <= address_nr_s;
end architecture;