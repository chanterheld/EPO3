library IEEE;
use IEEE.std_logic_1164.ALL;

entity side_input_sel is
   port(above   :in    std_logic;
        mid     :in    std_logic;
        test_reg:in    std_logic;
        sel     :in    std_logic_vector(1 downto 0);
        output  :out   std_logic);
end side_input_sel;
