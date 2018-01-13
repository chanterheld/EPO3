library ieee;
use ieee.std_logic_1164.all;


architecture structural of adr_to_color_sc is
component seg_1 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		d	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_3 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		d	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_4 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_6 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		d	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_8 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_9 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		d	: in	std_logic;
		state 	: out	std_logic
	);
end component;

component seg_10 is
	port(	a	: in	std_logic;
		b	: in	std_logic;
		c	: in	std_logic;
		d	: in	std_logic;
		state 	: out	std_logic
	);
end component;


signal bcd: std_logic_vector(3 downto 0);
signal mux_in : std_logic_vector(4 downto 0);
signal seg: std_logic_vector(8 downto 0);
begin

seg(0) <= seg(1) and seg(2);
l_seg_1 : seg_1 port map(bcd(0), bcd(1), bcd(2), bcd(3), seg(1));
l_seg_3 : seg_3 port map(bcd(0), bcd(1), bcd(2), bcd(3), seg(2));
l_seg_4 : seg_4 port map(bcd(0), bcd(1), bcd(2), seg(3));
seg(4) <= seg(2) and seg(5) and seg(6);
l_seg_6 : seg_6 port map(bcd(0), bcd(1), bcd(2), bcd(3), seg(5));
l_seg_8 : seg_8 port map(bcd(0), bcd(1), bcd(2), seg(6));
l_seg_9 : seg_9 port map(bcd(0), bcd(1), bcd(2), bcd(3), seg(7));
l_seg_10 : seg_10 port map(bcd(0), bcd(1), bcd(2), bcd(3), seg(8));

mux_in <= x_adr&y_adr(2 downto 0);
mux: process(mux_in, seg)
begin
	case mux_in is
		when "01001" => e_n <= seg(0);
		when "10001" => e_n <= seg(1);
		when "11001" => e_n <= '0';
		when "01010" => e_n <= seg(2);
		when "11010" => e_n <= seg(3);
		when "01011" => e_n <= seg(4);
		when "10011" => e_n <= seg(5);
		when "11011" => e_n <= '0';
		when "01100" => e_n <= seg(6);
		when "11100" => e_n <= seg(7);
		when "01101" => e_n <= seg(8);
		when "10101" => e_n <= seg(8);
		when "11101" => e_n <= '0';
		when others => e_n <= '1';
	end case;
end process;

--mux
bcd <= ones when (y_adr(3) = '1') else "00"&tens;
end structural;
