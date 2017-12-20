library ieee;
use ieee.std_logic_1164.all;

architecture structural of color_sel is

component gated_reg_2 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(1 downto 0);
		q	: out	std_logic_vector(1 downto 0)
	);
end component;

signal read_e: std_logic_vector(7 downto 0);
signal write_e: std_logic_vector(6 downto 0);
signal ff_out: std_logic_vector(13 downto 0);

begin
--l_wr_deco: decoder_3to7_e port map(wr_e, wr_adr, write_e);
--decoder with enable
process(wr_adr, wr_e)
begin
	if (wr_e = '1') then
		write_e <= (others => '0');    
		case wr_adr is
			when "001" => write_e(0) <= '1';
			when "010" => write_e(1) <= '1';
			when "011" => write_e(2) <= '1';
			when "100" => write_e(3) <= '1';
			when "101" => write_e(4) <= '1';
			when "110" => write_e(5) <= '1';
			when "111" => write_e(6) <= '1';
			when others => write_e <= (others => '0');
			end case;
	else 
		write_e <= (others => '0');
	end if;
end process;
--

reg_gen:
for i in 0 to 6 generate
	l_reg: gated_reg_2 port map(clk, reset, write_e(i), wr_bus, ff_out(2*i+1 downto 2*i));
end generate ;
--mux
clr_out <=	ff_out(1 downto 0) when (x_adr = "001") else
		ff_out(3 downto 2) when (x_adr = "010") else
		ff_out(5 downto 4) when (x_adr = "011") else
		ff_out(7 downto 6) when (x_adr = "100") else
		ff_out(9 downto 8) when (x_adr = "101") else
		ff_out(11 downto 10) when (x_adr = "110") else
		ff_out(13 downto 12) when (x_adr = "111") else "--";
end structural;