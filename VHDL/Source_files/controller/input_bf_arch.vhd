library ieee;
use ieee.std_logic_1164.all;

architecture behav of input_bf is
signal press, change, load: std_logic;
signal enc_out, mplex_out, output_s: std_logic_vector(1 downto 0);
begin
enc_out <=	"10" when (input(3) = '1') else
		"01" when (input(2) = '1') else
		"00" when (input(1) = '1') else "11";

press <= input(3) or input(2) or input(1) or input(0);
change <= '1' when (enc_out /= output_s) else '0';
load <= press and change;
update <= load;
mplex_out <= enc_out when (load = '1') else output_s;

reg: process (clk)
begin
	if (rising_edge(clk)) then
		output_s <= mplex_out;
	end if;
end process;
output <= output_s;
end behav;
