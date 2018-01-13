library ieee;
use ieee.std_logic_1164.all;

architecture behav of fsm_sel is
signal idle : std_logic_vector(2 downto 0);
signal in_1, in_2, in_3, output: std_logic_vector(3 downto 0);
begin

idle <= idle_1&idle_2&idle_3;

process(idle, in_1, in_2, in_3)
begin
	reset <= '0';
 	case idle is
		when "011" => output <= in_1; s_type <= '0';
		when "101" => output <= in_2; s_type <= '1';
		when "110" => output <= in_3; s_type <= '-';
		when others => output <= in_3; s_type <= '-'; reset <= '1';
	end case;
end process;
end behav;
