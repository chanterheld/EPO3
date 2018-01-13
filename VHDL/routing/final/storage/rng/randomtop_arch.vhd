library IEEE;
use IEEE.std_logic_1164.ALL;

architecture structural of randomtop is
component random is
port (	clk : in std_logic;
	restart : in std_logic;
	reset : in std_logic;
	seed : buffer std_logic_vector(9 downto 0)
);
end component;

component addresscomb is
port ( 	address : in std_logic_vector(5 downto 0);
	seed : in std_logic_vector (9 downto 0);
	a : out std_logic_vector ( 5 downto 0)
);
end component;

component blockinvert is
port ( 	address : in std_logic_vector(5 downto 0);
	seed : in std_logic_vector (9 downto 0);
	s : out std_logic_vector (3 downto 0)
);
end component;

component rowselect1 is
port ( 	a : in std_logic_vector(5 downto 0);
	c1 : out std_logic
);
end component;

component rowselect0 is
port ( 	a : in std_logic_vector(5 downto 0);
	c0 : out std_logic
);
end component;
signal sseed: std_logic_vector(9 downto 0) ;
signal sa : std_logic_vector(5 downto 0);
signal ss : std_logic_vector(3 downto 0);
signal sc0, sc1 : std_logic;
begin
lbl1: random port map (clk=>clk,restart=>restart,reset=>reset,seed=>sseed);
lbl2: addresscomb port map (address=>address,seed=>sseed,a=>sa);
lbl3: blockinvert port map (address=>address,seed=>sseed,s=>ss);
lbl4: rowselect1 port map (a=>sa,c1=>sc1);
lbl5: rowselect0 port map (a=>sa,c0=>sc0);

color(0) <= (((sc0 xor ss(0)) xor ss(1)) xor ss(2)) xor ss(3);
color(1) <= (((sc1 xor ss(0)) xor ss(1)) xor ss(2)) xor ss(3);

end structural;