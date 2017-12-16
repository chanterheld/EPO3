architecture structural of gated_reg_1 is
component reg_1 is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		t	: in	std_logic;
		q	: out	std_logic
	);
end component;

component mplex2t1_1 is 
	port(	a	: in 	std_logic;
		b	: in	std_logic;
		sel	: in	std_logic;
		q	: out	std_logic
	);
end component;

signal plex_out, q_s: std_logic;
begin
l1: reg_1		port map(clk, reset, plex_out, q_s);
l2: mplex2t1_1		port map(q_s, t, load, plex_out);
q <= q_s;
end structural;
