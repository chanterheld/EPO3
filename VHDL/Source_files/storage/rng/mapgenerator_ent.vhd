library ieee;
use ieee.std_logic_1164.all;

entity mapgenerator is
port ( 	clk : in std_logic;
	address : in std_logic_vector(5 downto 0);
	seed: in std_logic_vector(9 downto 0);
	color: out std_logic_vector(1 downto 0)
);
end entity;
