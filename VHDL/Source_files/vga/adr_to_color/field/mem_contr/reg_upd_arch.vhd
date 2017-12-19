library ieee;
use ieee.std_logic_1164.all;

architecture structural of vga_reg_upd is
component vga_reg_upd_fsm is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		lst_blk : in 	std_logic;
		adr_up	: in	std_logic;

		plex_sel: out	std_logic;
		set_flag: out	std_logic;
		write_en: out	std_logic;
		reg_l	: out	std_logic
	);
end component;

signal reg_x_s, adder_in, adder_out, nxt_row : std_logic_vector(2 downto 0);
signal lb5, lst_blk, reg_r, reg_l: std_logic;

signal add_interconnect : std_logic_vector(2 downto 0); 

signal plex_out : std_logic_vector(2 downto 0);
begin
l_fsm: vga_reg_upd_fsm port map(clk, reset, flag, lst_blk, y_up, lb5, set_flag, write_en, reg_l);

--gated_reg_3
process (clk)
begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			reg_x_s <= (others => '0');
		else
			reg_x_s <= plex_out;
		end if;
	end if;
end process;
plex_out <= nxt_row when (reg_l = '1') else reg_x_s;

--plus one adder_3
h_add_gen:
for i in 0 to 1 generate
 	adder_out(i) <= (adder_in(i) xor add_interconnect(i));
 	add_interconnect(i+1) <= (adder_in(i) and add_interconnect(i));
end generate;
add_interconnect(0) <= '1';
adder_out(2) <= add_interconnect(2) xor adder_in(2);

--mux
adder_in <= reg_x_s when (lb5 = '1') else y_adr;
reg_y <= y_adr when (lb5 = '1') else nxt_row;
nxt_row <= "001" when (lst_blk = '1') else adder_out;

--comp
lst_blk <= '1' when (adder_in = '1'&dip_sw) else '0';

reg_x <= reg_x_s;
end architecture;