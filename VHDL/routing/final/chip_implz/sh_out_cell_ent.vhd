library IEEE;
use IEEE.std_logic_1164.ALL;

entity sh_out_cell is
   port(clk     :in    std_logic;
        sel     :in    std_logic;
        data_in :in    std_logic;
        chain_in:in    std_logic;
        data_out:out   std_logic);
end sh_out_cell;
