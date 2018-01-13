library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of fst_bit_row is
component dnl_gated_reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load_1	: in	std_logic;
		load_2	: in	std_logic;
		q	: out	std_logic
	);
end component;


signal data_r: std_logic_vector(6 downto 0);
begin
data_r(0) <= '1';
l1: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(1), data_r(1));
l2: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(2), data_r(2));
l3: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(3), data_r(3));
l4: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(4), data_r(4));
l5: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(5), data_r(5));
l6: dnl_gated_reg_1 port map(clk, reset, we_y, we_x(6), data_r(6));

process(data_r, x_adr_r)
begin
	case x_adr_r is
		when "001" => plex_out <= data_r(0);
		when "010" => plex_out <= data_r(1);
		when "011" => plex_out <= data_r(2);
		when "100" => plex_out <= data_r(3);
		when "101" => plex_out <= data_r(4);
		when "110" => plex_out <= data_r(5);
		when "111" => plex_out <= data_r(6);
		when others => plex_out <= '0';
	end case;
end process;
end behaviour;
