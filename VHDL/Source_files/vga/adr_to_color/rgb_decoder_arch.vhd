library ieee;
use ieee.std_logic_1164.all;

architecture behavior of rgb_decoder is
begin

process(e1_n, e2_n, color_1, color_2)
begin
	rgb <= "000";    
	if(e1_n = '0') then   
		rgb(2) <= color_1(1);
		rgb(1) <= color_1(0);
		rgb(0) <= color_1(1) nor color_1(0);
	elsif(e2_n='0') then
		rgb(2) <= color_2(1);
		rgb(1) <= color_2(0);
		rgb(0) <= color_2(1) nor color_2(0);
	end if;
end process;
end behavior;
