library ieee;
use ieee.std_logic_1164.all;

architecture structural of score_cnt is
signal ones_r, tens_r, ones_max, uo2_int: std_logic;
signal tens_s :  std_logic_vector(1 downto 0);
signal ones_s, uo4_int: std_logic_vector(3 downto 0);
begin
--l_tens: up_one_cnt_2 port map(clk, tens_r, ones_max, tens);
---tens_1: t_ff port map(clk, tens_r, uo2_int, tens_s(1));
process (clk)
begin
	if rising_edge(clk) then
 		if (tens_r = '1') then
			tens_s(1) <= '0';
		else
			tens_s(1) <= (uo2_int xor tens_s(1));
		end if;
	end if;
end process;
---
---tens_0: up_cnt_cell port map(clk, tens_r, ones_max, tens_s(0), uo2_int);
process (clk)
begin
	if rising_edge(clk) then
 		if (tens_r = '1') then
			tens_s(0) <= '0';
		else
			tens_s(0) <= (ones_max xor tens_s(0));
		end if;
	end if;
end process;
uo2_int <= (tens_s(0) and ones_max);
---

--l_ones: up_one_cnt_4 port map(clk, ones_r, plus_one, ones_s);
---ones_3: t_ff port map(clk, ones_r, uo4_int(3), ones_s(3));
process (clk)
begin
	if rising_edge(clk) then
 		if (ones_r = '1') then
			ones_s(3) <= '0';
		else
			ones_s(3) <= (uo4_int(3) xor ones_s(3));
		end if;
	end if;
end process;
---

---ones_gen:
---for i in 0 to 2 generate
	---ones: up_cnt_cell port map(clk, ones_r, uo4_int(i), ones_s(i), uo4_int(i+1));
---end generate;
process (clk)
begin
	if rising_edge(clk) then
 		if (ones_r = '1') then
			ones_s(2 downto 0) <= (others => '0');
		else
			ones_s(0) <= uo4_int(0) xor ones_s(0);
			ones_s(1) <= uo4_int(1)xor ones_s(1);
			ones_s(2) <= uo4_int(2)xor ones_s(2);
		end if;
	end if;
end process;
uo4_int(1) <= uo4_int(0) and ones_s(0);
uo4_int(2) <= uo4_int(1) and ones_s(1);
uo4_int(3) <= uo4_int(2) and ones_s(2);
---

uo4_int(0) <= plus_one;

ones_max <= ones_s(3) and ones_s(0) and plus_one;
tens_r <= reset or game_rst; 
ones_r <= ones_max or tens_r;
ones <= ones_s;
tens <= tens_s;

end structural;