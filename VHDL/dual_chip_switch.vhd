library ieee;
use ieee.std_logic_1164.all;

entity dual_chip_switch is
	port(	color_in	: in	std_logic_vector(3 downto 0);
		rgb_l_in	: in 	std_logic_vector(2 downto 0);
		rgb_r_in	: in	std_logic_vector(2 downto 0);
		h_sync_l_in	: in	std_logic;
		v_sync_l_in	: in	std_logic;
		h_sync_r_in	: in	std_logic;
		v_sync_r_in	: in	std_logic;
		sellect		: in	std_logic;
		color_out_l	: out	std_logic_vector(3 downto 0);
		color_out_r	: out	std_logic_vector(3 downto 0);
		rgb_out		: out	std_logic_vector(2 downto 0);
		h_sync_out	: out	std_logic;
		v_sync_out	: out	std_logic
);
end dual_chip_switch;

architecture behav of dual_chip_switch is

begin
process (color_in, rgb_l_in, rgb_r_in, h_sync_l_in, v_sync_l_in, h_sync_r_in, v_sync_r_in, sellect)
begin
	if (sellect = '1') then
		color_out_l <= "1111";
		color_out_r <= color_in;
		rgb_out <= rgb_r_in;
		h_sync_out <= h_sync_r_in;
		v_sync_out <= v_sync_r_in;
	else
		color_out_r <= "1111";
		color_out_l <= color_in;
		rgb_out <= rgb_l_in;
		h_sync_out <= h_sync_l_in;
		v_sync_out <= v_sync_l_in;	
	end if;
end process;

end behav;
