library ieee;
use ieee.std_logic_1164.all;

entity top_lvl is
	port(	xi	: in	std_logic;
		xo	: inout	std_logic;
		clk_e	: in	std_logic;
		reset	: in	std_logic;
		game_rst_l: in	std_logic;
		game_rst_r: in	std_logic;
		c_input_l	: in	std_logic_vector(3 downto 0);
		c_input_r	: in	std_logic_vector(3 downto 0);

		config_clk: in	std_logic;
		config_d	: in	std_logic;

		testi_clk : in	std_logic;
		testi_d	: in	std_logic;

		testo_clk : in	std_logic;
		testo_e	: in std_logic;
		testo_d	: out std_logic;

		clk_out	: out	std_logic;
		h_sync_l	: out	std_logic;
		v_sync_l	: out	std_logic;
		h_sync_r	: out	std_logic;
		v_sync_r	: out	std_logic;
		rgb_l	: out	std_logic_vector(2 downto 0);
		rgb_r	: out	std_logic_vector(2 downto 0)
	);
end entity;
