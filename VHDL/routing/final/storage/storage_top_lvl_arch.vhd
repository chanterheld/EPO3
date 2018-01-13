library ieee;
use ieee.std_logic_1164.all;

 architecture structural of storage_top_lvl is
component storage_fsm is
    port(    clk    : in    std_logic;
        reset    : in     std_logic;
        a_flag    : in    std_logic;
        fsm_out    : out    std_logic
    );
end component;

component bit_storage is
    port(    clk    : in    std_logic;
        reset    : in    std_logic;
        wr_adr    : in    std_logic_vector(5 downto 0);
        r_adr    : in    std_logic_vector(5 downto 0);

        bit_out    : out    std_logic
    );
end component;


component gated_reg_1 is
    port(    clk    : in    std_logic;
        reset    : in     std_logic;
        load    : in    std_logic;
        t    : in    std_logic;
        q    : out    std_logic
    );
end component;


component h_latch is
    port(    t    : in    std_logic;
        hold    : in    std_logic;
        q    : out    std_logic
    );
end component;

component randomtop is
port (    clk : in std_logic;
    reset : in std_logic;
    restart : in std_logic;
    address : in std_logic_vector(5 downto 0);
    color: out std_logic_vector(1 downto 0)
);
end component;

component bit_row is
   port(clk     :in    std_logic;
        reset   :in    std_logic;
        we_y    :in    std_logic;
        we_x    :in    std_logic_vector(6 downto 0);
        x_adr_r :in    std_logic_vector(2 downto 0);
        plex_out:out   std_logic);
end component;

component fst_bit_row is
   port(clk     :in    std_logic;
        reset   :in    std_logic;
        we_y    :in    std_logic;
        we_x    :in    std_logic_vector(6 downto 0);
        x_adr_r :in    std_logic_vector(2 downto 0);
        plex_out:out   std_logic);
end component;

component mplex7t1_1 is
    port(    input    : in    std_logic_vector(6 downto 0);
        sel    : in    std_logic_vector(2 downto 0);
        output    : out    std_logic
    );
end component;

component inv_decoder_3to7 is
  port(
    x  :  in  std_logic_vector(2 downto 0);
    y  :  out  std_logic_vector(6 downto 0)
    );
end component;

signal vga_flag_s, vga_clr_flag, ctrl_flag_s, ctrl_ap_flag, fal_write, ctrl_clr_flag, fsm_out, a_flag, input_sel, storage_out, reset_s, cntr_fl_rst, vga_fl_rst : std_logic;
signal rng_color, return_color: std_logic_vector(1 downto 0);
signal cntrl_data_in : std_logic_vector(2 downto 0);
signal read_adr, write_adr : std_logic_vector(5 downto 0);
signal seed : std_logic_vector(9 downto 0);

signal x_adr_wr, y_adr_wr, x_adr_r, y_adr_r: std_logic_vector(2 downto 0);
signal we_x, we_y, x_plex_out : std_logic_vector(6 downto 0);

begin
fsm: storage_fsm port map(clk, reset, a_flag, fsm_out);
--storage: bit_storage port map(clk, reset_s, write_adr , read_adr, storage_out);
x_adr_wr <= write_adr(5 downto 3);
y_adr_wr <= write_adr(2 downto 0);
x_adr_r <= read_adr(5 downto 3);
y_adr_r <= read_adr(2 downto 0);

ldeco_x: inv_decoder_3to7 port map(x_adr_wr, we_x);
ldeco_y: inv_decoder_3to7 port map(y_adr_wr, we_y);
lc_m: mplex7t1_1 port map(x_plex_out, y_adr_r, storage_out);

row_0: fst_bit_row port map(clk, reset_s, we_y(0), we_x, x_adr_r, x_plex_out(0));
row_1: bit_row port map(clk, reset_s, we_y(1), we_x, x_adr_r, x_plex_out(1));
row_2: bit_row port map(clk, reset_s, we_y(2), we_x, x_adr_r, x_plex_out(2));
row_3: bit_row port map(clk, reset_s, we_y(3), we_x, x_adr_r, x_plex_out(3));
row_4: bit_row port map(clk, reset_s, we_y(4), we_x, x_adr_r, x_plex_out(4));
row_5: bit_row port map(clk, reset_s, we_y(5), we_x, x_adr_r, x_plex_out(5));
row_6: bit_row port map(clk, reset_s, we_y(6), we_x, x_adr_r, x_plex_out(6));

--

--freg_2: flag_reg_2 port map(clk, reset, vga_s_fl, vga_clr_flag, return_color, vga_data, vga_flag_s);

    --data_reg: gated_reg_2 port map(clk, reset, clr_flag, t, q);
    vga_data_reg_0: gated_reg_1 port map(clk, reset, vga_clr_flag, return_color(0), vga_data(0));
    vga_data_reg_1: gated_reg_1 port map(clk, reset, vga_clr_flag, return_color(1), vga_data(1));
        
    --

vga_flag_reg: gated_reg_1 port map(clk, vga_fl_rst, vga_s_fl, '1', vga_flag_s);
vga_fl_rst <= reset or vga_clr_flag;

--

--freg_3: flag_reg_3 port map(clk, reset, ctrl_s_fl, ctrl_clr_flag, cntrl_data_in, ctrl_data, ctrl_flag_s);
cntr_data_reg_0: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(0), ctrl_data(0));
cntr_data_reg_1: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(1), ctrl_data(1));
cntr_data_reg_2: gated_reg_1 port map(clk, reset, ctrl_clr_flag, cntrl_data_in(2), ctrl_data(2));

cntr_flag_reg: gated_reg_1 port map(clk, cntr_fl_rst, ctrl_s_fl, '1', ctrl_flag_s);
cntr_fl_rst <= reset or ctrl_clr_flag;
--
hlatch: h_latch port map(vga_flag_s, fsm_out, input_sel);
--seed_gen: random port map(clk, reset, game_rst, seed);
--map_gen: mapgenerator port map(read_adr, seed, rng_color);
l_rng: randomtop port map(clk, reset, game_rst, read_adr, rng_color);


--mplex
read_adr <= vga_adr when (input_sel = '1') else ctlr_adr;
write_adr <= ctlr_adr when (fal_write = '1') else "000000";
return_color <= live_clr when (storage_out = '1') else rng_color;

a_flag <= ctrl_ap_flag or vga_flag_s;
ctrl_ap_flag <= (not(ctrl_flag_s) nor r_w_in);
fal_write <= r_w_in and ctrl_flag_s;
ctrl_clr_flag <= ((not(fsm_out) nor input_sel) or fal_write);
vga_clr_flag <= fsm_out and input_sel;
reset_s <= reset or game_rst;
cntrl_data_in <= storage_out&return_color;

vga_flag <= vga_flag_s;
ctrl_flag <= ctrl_flag_s;
end structural;