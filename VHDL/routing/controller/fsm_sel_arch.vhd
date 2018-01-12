library ieee;
use ieee.std_logic_1164.all;

architecture behav of fsm_sel is
signal idle : std_logic_vector(2 downto 0);
signal in_1, in_2, in_3, output: std_logic_vector(3 downto 0);
begin

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

idle <= idle_1&idle_2&idle_3;

in_1 <= ad_sel_1&reg_sel_1&x_ins_1&y_ins_1;
in_2 <= ad_sel_2&reg_sel_2&x_ins_2&y_ins_2;
in_3 <= ad_sel_3&reg_sel_3&x_ins_3&y_ins_3;

ad_sel	<= output(3);
reg_sel	<= output(2);
x_ins	<= output(1);
y_ins	<= output(0);
end behav;
