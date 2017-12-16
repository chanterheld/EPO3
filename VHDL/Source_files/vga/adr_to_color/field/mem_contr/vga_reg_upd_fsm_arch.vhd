library ieee;
use ieee.std_logic_1164.all;

architecture behav of vga_reg_upd_fsm is
type fsm_state is (idle, load_set, flag_wait);
signal state, next_state : fsm_state;
begin
reg: process (clk) 
begin
	if (rising_edge(clk)) then
		if (reset ='1') then
			state <= idle;
		else
			state <= next_state;
		end if;
	end if;
end process;

comb: process(state, flag, lst_blk, adr_up)
begin
next_state <= state;
case state is
	when idle =>
		plex_sel <= '0';
		set_flag <= '0';
		reg_l <= '0';
		write_en <= '0';
		if ((adr_up = '1') and (lst_blk = '0')) then
			next_state <= load_set;
			write_en <= '1';
		end if;

	when load_set =>
		plex_sel <= '1';
		set_flag <= '1';
		reg_l <= '1';
		write_en <= '0';
		if (lst_blk = '1') then
			next_state <= idle;
		else
			next_state <= flag_wait;
		end if;

	when flag_wait =>
		plex_sel <= '1';
		set_flag <= '0';
		reg_l <= '0';
		write_en <= '1';
		if (flag = '0') then
			next_state <= load_set;
		end if;

end case;
end process;
end behav;