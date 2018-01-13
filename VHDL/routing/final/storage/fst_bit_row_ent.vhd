library IEEE;
use IEEE.std_logic_1164.ALL;

entity fst_bit_row is
   port(clk     :in    std_logic;
        reset   :in    std_logic;
        we_y    :in    std_logic;
        we_x    :in    std_logic_vector(6 downto 0);
        x_adr_r :in    std_logic_vector(2 downto 0);
        plex_out:out   std_logic);
end fst_bit_row;

