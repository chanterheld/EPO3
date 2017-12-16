library IEEE;
use IEEE.std_logic_1164.all;

entity random is
port (	clk : in std_logic;
	restart : in std_logic;
	reset : in std_logic;
	seed : buffer std_logic_vector(9 downto 0)
);
end entity;
