library ieee;
use ieee.std_logic_1164.all;

architecture behav of fsm_2 is
type fsm_state is (idlle, look_up, look_left, look_down, look_right, wait_up, wait_left, wait_down, wait_right, write_one, wait_write);
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
		start_1	<= '0';
		c_l <= '0';
		r_w	<= '0';
		case state is
			when idlle =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '0';
				y_ins	<= '0';
				set_fl	<= '0';
				idle <= '1';
				if (start = '1') then
					next_state <=  look_up;
				end if;


			when look_up =>
				ad_sel	<= '0';
				reg_sel	<= '1';
				x_ins	<= '0';
				y_ins	<= '1';
				if (edge = '1') then
					set_fl <= '0';
					next_state <= look_left;
				else
					set_fl <= '1';
					next_state <= wait_up;
				end if;

			when look_left =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '1';
				y_ins	<= '0';
				if (edge = '1') then
					set_fl <= '0';
					next_state <= look_down;
				else
					set_fl <= '1';
					next_state <= wait_left;
				end if;

			when look_down =>
				ad_sel	<= '1';
				reg_sel	<= '1';
				x_ins	<= '0';
				y_ins	<= '1';
				if (edge = '1') then
					set_fl <= '0';
					next_state <= look_right;
				else
					set_fl <= '1';
					next_state <= wait_down;
				end if;

			when look_right =>
				ad_sel	<= '1';
				reg_sel	<= '0';
				x_ins	<= '1';
				y_ins	<= '0';
				if (edge = '1') then
					set_fl <= '0';
					next_state <= idlle;
					start_1 <= '1';
				else
					set_fl <= '1';
					next_state <= wait_right;
				end if;

			when wait_up =>
				ad_sel	<= '0';
				reg_sel	<= '1';
				x_ins	<= '0';
				y_ins	<= '1';
				set_fl	<= '0';
				if (flag = '0') then
					if (hit = '1') then
						next_state <= write_one;
					else
						next_state <= look_left;
					end if;
				end if;

			when wait_left =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '1';
				y_ins	<= '0';
				set_fl	<= '0';
				if (flag = '0') then
					if (hit = '1') then
						next_state <= write_one;
					else
						next_state <= look_down;
					end if;
				end if;

			when wait_down =>
				ad_sel	<= '1';
				reg_sel	<= '1';
				x_ins	<= '0';
				y_ins	<= '1';
				set_fl	<= '0';
				if (flag = '0') then
					if (hit = '1') then
						next_state <= write_one;
					else
						next_state <= look_right;
					end if;
				end if;

			when wait_right =>
				ad_sel	<= '1';
				reg_sel	<= '0';
				x_ins	<= '1';
				y_ins	<= '0';
				set_fl	<= '0';
				r_w	<= '0';
				if (flag = '0') then
					if (hit = '1') then
						next_state <= write_one;
					else
						next_state <= idlle;
						start_1 <= '1';
					end if;
				end if;

			when write_one =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '0';
				y_ins	<= '0';
				set_fl	<= '1';
				r_w	<= '1';
				c_l	<= '1';
				next_state <= wait_write;

			when wait_write =>
				ad_sel	<= '0';
				reg_sel	<= '0';
				x_ins	<= '0';
				y_ins	<= '0';
				set_fl	<= '0';
				r_w	<= '1';
				if (flag = '0') then
					next_state <= idlle;
					start_1 <= '1';
				end if;
		end case;
	end process;


end behav;