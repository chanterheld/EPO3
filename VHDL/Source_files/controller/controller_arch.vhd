library ieee;
use ieee.std_logic_1164.all;

architecture behav of controller is
component plus_minus_one is 
	port(	a	: in 	std_logic_vector(2 downto 0);
		b	: out	std_logic_vector(2 downto 0);
		sel	: in	std_logic
	);
end component;

component gated_reg_1 is
	port(	clk	: in	std_logic; 
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

component gated_reg_3 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		load	: in	std_logic;
		t	: in	std_logic_vector(2 downto 0);
		q	: out	std_logic_vector(2 downto 0)
	);
end component;

component t_ff is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic
	);
end component;

component up_cnt_cell is
	port(	clk	: in 	std_logic;
		reset	: in 	std_logic;
		t	: in 	std_logic;
		q	: out 	std_logic;
		and_out	: out	std_logic
	);	
end component;

type fsm_state is (increment, wait_flag, new_line, look_up, look_down, look_left, look_right, wait_up, wait_down, wait_left, wait_right, write_one, wait_write, map_done, game_done); 
signal state, next_state : fsm_state;
signal adder_sel, reg_sel, x_ins, y_ins, x_l, y_l, d_l, x_r, y_r, d_r, done_t, done, edge, hit, s_type : std_logic;
signal adder_in, adder_out, x_reg, y_reg, x_out, y_out, edge_val : std_logic_vector(2 downto 0);

signal lvl_interconnect, lvl_reset, lvl_up_s : std_logic;
signal dip_sw_s : std_logic_vector(1 downto 0);
begin
pmo: plus_minus_one port map(adder_in, adder_out, adder_sel);
reg_x: gated_reg_3 port map (clk, x_r, x_l, x_out, x_reg);
reg_y: gated_reg_3 port map (clk, y_r, y_l, y_out, y_reg);
reg_d: gated_reg_1 port map(clk, d_r, d_l, done_t, done);
--mux
x_out <=  adder_out when (x_ins = '1') else x_reg;
y_out <=  adder_out when (y_ins = '1') else y_reg;
adder_in <=  y_reg when (reg_sel = '1') else x_reg;
edge_val <= '1'&dip_sw_s when (adder_sel = '1') else "001";
--comp
edge <= '1' when (edge_val = adder_in) else '0';
hit <= '1' when (data_in = s_type&live_clr) else '0';
--level
l1: t_ff port map (clk, lvl_reset, lvl_interconnect, dip_sw_s(1));
l2: up_cnt_cell port map(clk, lvl_reset, lvl_up_s, dip_sw_s(0), lvl_interconnect);
--others 
done_t <= done nor data_in(2);
address <= x_out&y_out;
dip_sw <= dip_sw_s;
lvl_reset <= reset or game_rst;
lvl_up <= lvl_up_s;
--fsm
state_reg: process (clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			state <= game_done;
		else
			state <= next_state;
		end if;
	end if;
end process;

comb: process(state, edge, flag, hit, done, game_rst, max)
begin
	lvl_up_s <= '0';
	game_end <= '0';
	next_state <= state;
	case state is
		when  increment =>				-- set flag, x = x+1, load_x
			adder_sel <= '1';
			reg_sel <= '0';
			x_ins <= '1';
			y_ins <= '0';
			x_l <= '1';
			y_l <= '0';
			d_l <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			r_w <= '0';
			if (edge = '1') then
				set_flag <= '0';
				x_r <= '1';
				next_state <= new_line;		
			else
				set_flag <= '1';
				x_r <= '0';
				next_state <= wait_flag;
			end if;


		when wait_flag =>
			adder_sel <= '-';
			reg_sel <= '-';
			x_ins <= '0';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '0';
			set_flag <= '0';
			r_w <= '0';
			if (flag = '0') then
				d_l <= '1';
				if (hit = '1') then
					next_state <= look_up;
				else
					next_state <= increment;
				end if;
			end if;

		when new_line =>
			adder_sel <= '1';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '1';
			d_l <= '0';
			x_r <= '0';
			d_r <= '0';
			s_type <= '-';
			set_flag <= '0';
			r_w <= '-';
			if (edge = '1') then
				y_r <= '1';
				d_r <= '1';
				if (done = '0') then
					next_state <= map_done;
				elsif (max = '1') then
					next_state <= game_done;
				end if;
			else
				y_r <= '0';
				next_state <= increment;
			end if;

		when look_up =>
			adder_sel <= '0';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			r_w <= '0';
			if (edge = '1') then
				set_flag <= '0';
				next_state <= look_left;
			else
				set_flag <= '1';
				next_state <= wait_up;
			end if;



		when look_left  =>
			adder_sel <= '0';
			reg_sel <= '0';
			x_ins <= '1';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			r_w <= '0';
			if (edge = '1') then
				set_flag <= '0';
				next_state <= look_down;
			else
				set_flag <= '1';
				next_state <= wait_left;
			end if;

		when look_down =>
			adder_sel <= '1';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			r_w <= '0';
			if (edge = '1') then
				set_flag <= '0';
				next_state <= look_right;
			else
				set_flag <= '1';
				next_state <= wait_down;
			end if;

		when look_right =>
			adder_sel <= '1';
			reg_sel <= '0';
			x_ins <= '1';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			r_w <= '0';
			if (edge = '1') then
				set_flag <= '0';
				next_state <= increment;
			else
				set_flag <= '1';
				next_state <= wait_right;
			end if;

		when wait_up =>
			adder_sel <= '0';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '1';
			r_w <= '0';
			set_flag <= '0';
			if (flag = '0') then
				if (hit = '1') then
					next_state <= write_one;
				else
					next_state <= look_left;
				end if;
			end if;

		when wait_left =>
			adder_sel <= '0';
			reg_sel <= '0';
			x_ins <= '1';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '1';
			r_w <= '0';
			if (flag = '0') then
				if (hit = '1') then
					next_state <= write_one;
				else
					next_state <= look_down;
				end if;
			end if;

		when wait_down =>
			adder_sel <= '1';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '1';
			r_w <= '0';
			set_flag <= '0';
			if (flag = '0') then
				if (hit = '1') then
					next_state <= write_one;
				else
					next_state <= look_right;
				end if;
			end if;


		when wait_right =>
			adder_sel <= '1';
			reg_sel <= '0';
			x_ins <= '1';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '1';
			r_w <= '0';
			if (flag = '0') then
				if (hit = '1') then
					next_state <= write_one;
				else
					next_state <= increment;
				end if;
			end if;

		when write_one =>
			adder_sel <= '-';
			reg_sel <= '-';
			x_ins <= '0';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			set_flag <= '1';
			r_w <= '1';
			next_state <= wait_write;
			
		when wait_write =>
			adder_sel <= '-';
			reg_sel <= '-';
			x_ins <= '0';
			y_ins <= '0';
			x_l <= '0';
			y_l <= '0';
			d_l <= '0';
			x_r <= '0';
			y_r <= '0';
			d_r <= '0';
			s_type <= '-';
			set_flag <= '0';
			r_w <= '1';
			if (flag = '0') then
				next_state <= increment;
			end if;

		when map_done =>
			adder_sel <= '1';
			reg_sel <= '1';
			x_ins <= '0';
			y_ins <= '1';
			x_l <= '0';
			y_l <= '1';
			d_l <= '0';
			x_r <= '0';
			d_r <= '0';
			s_type <= '-';
			set_flag <= '0';
			r_w <= '-';
			if (dip_sw_s = "11") then
				next_state <= game_done;
			else
				next_state <= increment;
				lvl_up_s <= '1';
			end if;

		when game_done =>
			adder_sel <= '1';
			reg_sel <= '-';
			x_ins <= '1';
			y_ins <= '1';
			x_l <= '1';
			y_l <= '1';
			d_l <= '1';
			x_r <= '1';
			y_r <= '1';
			d_r <= '1';
			s_type <= '-';
			set_flag <= '0';
			r_w <= '-';
			game_end <= '1';
			if (game_rst = '1') then
				next_state <= increment;
				x_r <= '0';
				y_r <= '0';
			end if;
	end case;
end process;
end behav;

