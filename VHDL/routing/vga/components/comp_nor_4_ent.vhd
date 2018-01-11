library IEEE;
use IEEE.std_logic_1164.ALL;

entity comp_nor_8 is
   port(a       :in    std_logic_vector(7 downto 0);
        comp_s  :in    std_logic_vector(7 downto 0);
        comp_out:out   std_logic;
        nor_out :out   std_logic);
end comp_nor_8;
