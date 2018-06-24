library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of sh_out_cell is
signal ff_in : std_logic;
begin
ff: 	process(clk)
	begin
		if (rising_edge(clk)) then
			data_out <= ff_in;
		end if;
	end process;

ff_in <= chain_in when (sel = '1') else data_in;

end behaviour;
