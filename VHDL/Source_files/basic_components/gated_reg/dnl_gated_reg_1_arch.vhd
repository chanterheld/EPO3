architecture structural of dnl_gated_reg_1 is
signal plex_out, q_s, load: std_logic;
begin
process (clk)
begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			q_s <= '0';
		else
			q_s <= plex_out;
		end if;
	end if;
end process;
--mux
plex_out <= t when (load = '1') else q_s;

load <= (load_1 nor load_2);
q <= q_s;
end structural;
