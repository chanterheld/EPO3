library IEEE;
use IEEE.std_logic_1164.ALL;

entity randomtop is
   port(clk    :in    std_logic;
        reset  :in    std_logic;
        restart:in    std_logic;
        address:in    std_logic_vector(5 downto 0);
        color  :out   std_logic_vector(1 downto 0));
end randomtop;