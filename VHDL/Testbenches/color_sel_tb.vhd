library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity color_sel_tb is
end entity;

architecture behav of color_sel_tb is
component color_sel is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		x_adr	: in	std_logic_vector(2 downto 0);
		y_adr	: in	std_logic_vector(2 downto 0);
		val_l	: in	std_logic_vector(2 downto 0);
		val_r	: in	std_logic_vector(2 downto 0);
		wr_adr	: in	std_logic_vector(3 downto 0);
		wr_bus	: in	std_logic_vector(1 downto 0);
		
		e_n	: out	std_logic;
		reg_sel : out	std_logic;
		clr_out	: out	std_logic_vector(1 downto 0)
	);
end component;

signal clk, reset, e_n, reg_sel, adr_gen : std_logic;
signal x_adr, y_adr, val_l, val_r : std_logic_vector(2 downto 0);
signal wr_adr : std_logic_vector(3 downto 0);
signal wr_bus, clr_out : std_logic_vector(1 downto 0);
begin
L1 : color_sel port map(clk, reset, x_adr, y_adr, val_l, val_r, wr_adr, wr_bus, e_n, reg_sel, clr_out);
clk 	<=	'0' after 0 ns,
         	'1' after 10 ns when clk /= '1' else '0' after 10 ns;

reset <= 	'1' after 0 ns,
		'0' after 50 ns;

adr_gen <= 	'0' after 0 ns,
         	'1' after 20 ns when adr_gen /= '1' else '0' after 20 ns;

val_l	<= "001";
val_r	<= "010";

y_adr	<=	"000" after 0 ns,
		"001" after 1000 ns,
		"010" after 2000 ns;

x_adr	<= wr_adr(3 downto 1);
wr_bus	<= wr_adr(3)&wr_adr(0); 

cnt: process (adr_gen)
variable tmp : integer range 0 to 15 := 0;
begin
	if (rising_edge(adr_gen)) then
		if reset = '1' then
			tmp := 0;
		else
			if tmp = 15 then
				tmp := 0;
			else
				tmp := tmp + 1;
			end if;
		end if;
	end if;

wr_adr <= std_logic_vector(to_unsigned(tmp,4));
end process;


end behav;