library ieee;
use ieee.std_logic_1164.all;

architecture behavior of inv_decoder_3to7 is
begin
  process(x)
  begin
  y <= (others => '1');    
	case x is
	 when "001" => y(0) <= '0';
	 when "010" => y(1) <= '0';
	 when "011" => y(2) <= '0';
	 when "100" => y(3) <= '0';
	 when "101" => y(4) <= '0';
	 when "110" => y(5) <= '0';
	 when "111" => y(6) <= '0';
	 when others => y <= (others => '1');
	end case;
  end process;
end behavior;
