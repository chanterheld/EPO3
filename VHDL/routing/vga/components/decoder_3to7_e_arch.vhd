library ieee;
use ieee.std_logic_1164.all;

architecture behavior of decoder_3to7_e is
begin
process(x, enable)
begin
	if (enable = '1') then
		y <= (others => '0');    
		case x is
			when "001" => y(0) <= '1';
			when "010" => y(1) <= '1';
			when "011" => y(2) <= '1';
			when "100" => y(3) <= '1';
			when "101" => y(4) <= '1';
			when "110" => y(5) <= '1';
			when "111" => y(6) <= '1';
			when others => y <= (others => '0');
			end case;
	else 
		y <= (others => '0');
	end if;
end process;
end behavior;
