library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of side_input_sel is
begin
output <= 		test_reg when (sel(1) = '1') else
		mid when (sel(0) = '1') else above;
end behaviour;
