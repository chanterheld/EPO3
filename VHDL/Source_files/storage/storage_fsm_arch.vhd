library ieee;
use ieee.std_logic_1164.all;

architecture behav of storage_fsm is

type fsm_state is (idle, latch_clear);
signal state, next_state : fsm_state;
begin

reg: process(clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			state <= idle;
		else
			state <= next_state;
		end if;
	end if;
end process;

comb: process(state, a_flag)
begin
	next_state <= state;
	case state is
		when idle =>
			fsm_out <= '0';
			if a_flag = '1' then 
				next_state <= latch_clear;
			end if;

		when latch_clear =>
			fsm_out <= '1';
			next_state <= idle;
	end case;
end process;
end behav;
