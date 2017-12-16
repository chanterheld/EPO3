--60 us
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pos_to_adr_tb is
end entity;

architecture behav of pos_to_adr_tb is
component xpos_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(1 downto 0)
	);
end component;

component xpos_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		block_size	: in	std_logic_vector(4 downto 0);
		address	: out	std_logic_vector(2 downto 0)
	);
end component;

component ypos_to_blk_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		dip_sw	: in	std_logic_vector(1 downto 0);
		posi	: in	std_logic_vector(7 downto 0);
		block_size	: in	std_logic_vector(4 downto 0); 
		address	: out	std_logic_vector(2 downto 0);
		up	: out	std_logic
	);
end component;

component ypos_to_nr_adr is
	port(	clk	: in	std_logic;
		reset	: in	std_logic;
		r_reset	: in	std_logic;
		posi	: in	std_logic_vector(7 downto 0);
		address	: out	std_logic_vector(3 downto 0)
	);
end component;

component dim_conv is
	port(	dip_sw		: in	std_logic_vector(1 downto 0);
		block_size	: out	std_logic_vector(4 downto 0)
	);
end component;

signal posi  : std_logic_vector(7 downto 0);
signal pos_gen, clk,reset, y_up : std_logic;
signal dip_sw, xnr_adr: std_logic_vector(1 downto 0);
signal xblk_adr, yblk_adr: std_logic_vector(2 downto 0);
signal ynr_adr: std_logic_vector(3 downto 0);
signal block_size: std_logic_vector(4 downto 0);
begin

clk 	<=	'0' after 0 ns,
         	'1' after 10 ns when clk /= '1' else '0' after 10 ns;

pos_gen <= 	'0' after 0 ns,
         	'1' after 40 ns when pos_gen /= '1' else '0' after 40 ns;

reset	<= 	'1' after 0 ns,
		'0' after 50 ns;

dip_sw <= 	"00" after 0 ns,
		"01" after 15000 ns,
		"10" after 30000 ns,
		"11" after 45000 ns;

L1: xpos_to_blk_adr port map(clk, reset, reset, dip_sw, posi, block_size, xblk_adr);
L2: ypos_to_blk_adr port map(clk, reset, reset, dip_sw, posi, block_size, yblk_adr, y_up);
L3: xpos_to_nr_adr port map(clk, reset, reset, posi, xnr_adr);
L4: ypos_to_nr_adr port map(clk, reset, reset, posi, ynr_adr);
L5: dim_conv port map(dip_sw, block_size);


cnt: process (pos_gen)
variable tmp : integer range 0 to 200 := 0;
begin
	if (rising_edge(pos_gen)) then
		if tmp = 200 then
			tmp := 0;
		else
			tmp := tmp + 1;
		end if;
	end if;

posi <= std_logic_vector(to_unsigned(tmp,8));
end process;

end behav;