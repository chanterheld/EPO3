library ieee;
use ieee.std_logic_1164.all;
 
architecture structural of gated_reg_2 is
signal plex_out, q_s: std_logic_vector(1 downto 0);
begin
process (clk)
begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			q_s <= (others => '0');
		else
			q_s <= plex_out;
		end if;
	end if;
end process;
--mux
plex_out <= t when (load = '1') else q_s;
q <= q_s;
end structural;
