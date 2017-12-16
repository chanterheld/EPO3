library ieee;
use ieee.std_logic_1164.all;

entity vga_reg_upd_fsm is
	port(	clk	: in	std_logic;
		reset	: in 	std_logic;
		flag	: in	std_logic;
		lst_blk : in 	std_logic;
		adr_up	: in	std_logic;

		plex_sel: out	std_logic;
		set_flag: out	std_logic;
		write_en: out	std_logic;
		reg_l	: out	std_logic
	);
end entity vga_reg_upd_fsm;