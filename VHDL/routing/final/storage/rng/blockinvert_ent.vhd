library IEEE;
use IEEE.std_logic_1164.ALL;

entity blockinvert is
   port(address:in    std_logic_vector(5 downto 0);
        seed   :in    std_logic_vector(9 downto 0);
        s      :out   std_logic_vector(3 downto 0));
end blockinvert;
