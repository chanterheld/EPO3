library ieee;
use ieee.std_logic_1164.all;

architecture behavior of decoder_3to8 is
begin
  process(x)
  begin
  y <= (others => '0');    
	case x is
	 when "000" => y(0) <= '1';
	 when "001" => y(1) <= '1';
	 when "010" => y(2) <= '1';
	 when "011" => y(3) <= '1';
	 when "100" => y(4) <= '1';
	 when "101" => y(5) <= '1';
	 when "110" => y(6) <= '1';
	 when "111" => y(7) <= '1';
	 when others => y <= (others => '0');
	end case;
  end process;
end behavior;
