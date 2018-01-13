library ieee;
use ieee.std_logic_1164.all;

entity inv_decoder_3to7 is
  port(
    x  :  in  std_logic_vector(2 downto 0);
    y  :  out  std_logic_vector(6 downto 0)
	);
end inv_decoder_3to7;
