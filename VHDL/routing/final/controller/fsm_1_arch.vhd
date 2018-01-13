library ieee;
use ieee.std_logic_1164.all;

architecture behav of fsm_1 is
type fsm_state is (idlle, increment, wait_flag, new_line);
signal state, next_state : fsm_state;


begin

reg:	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				state <= idlle;
			else
				state <= next_state;
			end if;
		end if;
	end process;

comb:	process(state, hit, edge, flag, start)
	begin
		next_state <= state;
		idle <= '0';
		start_2	<= '0';
		start_3	<= '0';

		case state is
			when idlle =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '0';
				y_ins	<= '0';
				x_l	<= '0';
				y_l	<= '0';
				d_l	<= '0';
				x_r	<= '0';
				y_r	<= '0';
				set_fl	<= '0';	
				idle	<= '1';
				if (start = '1') then
					next_state <= increment;
				end if;

			when increment =>
				ad_sel	<= '1';
				reg_sel	<= '0';
				x_ins	<= '1';
				y_ins	<= '0';
				x_l	<= '1';
				y_l	<= '0';
				d_l	<= '0';
				y_r	<= '0';
				if (edge = '1') then
					set_fl <= '0';
					x_r <= '1';
					next_state <= new_line;		
				else
					set_fl <= '1';
					x_r <= '0';
					next_state <= wait_flag;
				end if;

			when wait_flag =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '0';
				y_ins	<= '0';
				x_l	<= '0';
				y_l	<= '0';
				d_l	<= '0';
				x_r	<= '0';
				y_r	<= '0';
				set_fl	<= '0';
				if (flag = '0') then
					d_l <= '1';
					if (hit = '1') then
						next_state <= idlle;
						start_2	<= '1';
					else
						next_state <= increment;
					end if;
				end if;

			when new_line =>
				ad_sel	<= '1';
				reg_sel	<= '1';
				x_ins	<= '0';
				y_ins	<= '1';
				x_l	<= '0';
				y_l	<= '1';
				d_l	<= '0';
				x_r	<= '0';
				set_fl	<= '0';
				if (edge = '1') then
					y_r <= '1';
					next_state <= idlle;
					start_3	<= '1';
				else
					y_r <= '0';
					next_state <= increment;
				end if;
		end case;
	end process;


end behav;
