library ieee;
use ieee.std_logic_1164.all;

architecture behav of mplex7t1_1 is
begin
process(input, sel)
begin
	case sel is
		when "001" => output <= input(0);
		when "010" => output <= input(1);
		when "011" => output <= input(2);
		when "100" => output <= input(3);
		when "101" => output <= input(4);
		when "110" => output <= input(5);
		when "111" => output <= input(6);
		when others => output <= '0';
	end case;
end process;

end behav;
