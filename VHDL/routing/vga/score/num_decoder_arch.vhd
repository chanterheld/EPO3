library ieee;
use ieee.std_logic_1164.all;

architecture behav of num_decoder is
signal mux_in : std_logic_vector(4 downto 0);
begin
mux: process(mux_in, seg)
begin
	case mux_in is
		when "01001" => e_n <= seg(0);
		when "10001" => e_n <= seg(1);
		when "11001" => e_n <= seg(2);
		when "01010" => e_n <= seg(3);
		when "11010" => e_n <= seg(4);
		when "01011" => e_n <= seg(5);
		when "10011" => e_n <= seg(6);
		when "11011" => e_n <= seg(7);
		when "01100" => e_n <= seg(8);
		when "11100" => e_n <= seg(9);
		when "01101" => e_n <= seg(10);
		when "10101" => e_n <= seg(11);
		when "11101" => e_n <= seg(12);
		when others => e_n <= '1';
	end case;
end process;

mux_in <= x_adr&y_adr;
end behav;
