library ieee;
use ieee.std_logic_1164.all;

architecture behav of fsm_3 is

type fsm_state is (idlle, rst_pos, map_done, game_done);
signal state, next_state : fsm_state;
 
begin
reg: 	process(clk)
	begin
		if(rising_edge(clk)) then
			if (reset = '1') then
				state <= game_done;
			else
				state <= next_state;
			end if;
		end if;
	end process;

comb:	process(state, game_rst, start, max, dip_sw, d_reg, c_reg)
	begin
		next_state <= state;
		idle <= '0';
		start_1 <= '1';
		game_d	<= '0';
		rst_sc	<= '0';
		lvl_up	<= '0';
		case state is
			when idlle =>
				ad_sel	<= '-';
				reg_sel	<= '-';
				x_ins	<= '-';
				y_ins	<= '-';
				x_l	<= '0';
				y_l	<= '0';
				x_r	<= '0';
				y_r	<= '0';
				d_r	<= '0';
				c_r	<= '0';
				idle 	<= '1';
				if (start = '1') then
					next_state <= rst_pos;
				end if;

			when rst_pos =>
				ad_sel	<= '1';
				reg_sel	<= '-';
				x_ins	<= '1';
				y_ins	<= '1';
				x_l	<= '1';
				y_l	<= '1';
				x_r	<= '0';
				y_r	<= '0';
				d_r	<= '1';
				c_r	<= '1';
				if (d_reg = '0') then
					next_state <= map_done;
				elsif ((max = '1') and (c_reg = '0')) then
					next_state <= game_done;
					rst_sc	<= '1';
				else
					next_state <= idlle;
					start_1 <= '1';
				end if;

			when map_done =>
				ad_sel	<= '-';
				reg_sel	<= '-';
				x_ins	<= '0';
				y_ins	<= '0';
				x_l	<= '0';
				y_l	<= '0';
				x_r	<= '0';
				y_r	<= '0';
				d_r	<= '0';
				c_r	<= '0';
				if dip_sw = "11" then
					next_state <= game_done;
				else
					next_state <= idlle;
					start_1 <= '1';
					lvl_up	<= '1';
				end if;

			when game_done =>
				ad_sel	<= '1';
				reg_sel	<= '-';
				x_ins	<= '1';
				y_ins	<= '1';
				x_l	<= '1';
				y_l	<= '1';
				x_r	<= '1';
				y_r	<= '1';
				d_r	<= '1';
				c_r	<= '1';
				game_d	<= '1';
				if (game_rst = '1') then
					next_state <= idlle;
					start_1 <= '1';
					x_r <= '0';
					y_r <= '0';
				end if;
		end case;
	end process;
end behav;
