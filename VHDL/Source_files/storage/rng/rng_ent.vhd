library ieee;
use ieee.std_logic_1164.all;

entity randomblock is
port (	address : in std_logic_vector(5 downto 0);
	restart : in std_logic;
	reset : in std_logic;
	clk : in std_logic;
	color: out std_logic_vector(1 downto 0)
);
end randomblock;
