library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity digits_display_decoder is
	Port(
		clk      : in  std_logic;
		rstn     : in  std_logic;
		num_0    : in  std_logic_vector(3 downto 0);
		num_1    : in  std_logic_vector(3 downto 0);
		num_2    : in  std_logic_vector(3 downto 0);
		num_3    : in  std_logic_vector(3 downto 0);
		num_4    : in  std_logic_vector(3 downto 0);
		num_5    : in  std_logic_vector(3 downto 0);
		num_6    : in  std_logic_vector(3 downto 0);
		num_7    : in  std_logic_vector(3 downto 0);
		seg_sel  : out std_logic_vector(7 downto 0);
		cathodes : out std_logic_vector(7 downto 0)
	);
end digits_display_decoder;

architecture Behavioral of digits_display_decoder is

	signal selcntr : unsigned(12 + 3 - 1 downto 0);

	signal selected_num : std_logic_vector(3 downto 0);

begin

	process(clk)
	begin
		if rising_edge(clk) then
			if rstn = '0' then
				selcntr <= (others => '0');
			else
				selcntr <= selcntr + 1;
			end if;
		end if;
	end process;

	process(selcntr(14 downto 12), num_0, num_1, num_2, num_3, num_4, num_5, num_6, num_7)
	begin
		case selcntr(14 downto 12) is
			when "001"  => selected_num <= num_1;
			when "010"  => selected_num <= num_2;
			when "011"  => selected_num <= num_3;
			when "100"  => selected_num <= num_4;
			when "101"  => selected_num <= num_5;
			when "110"  => selected_num <= num_6;
			when "111"  => selected_num <= num_7;
			when others => selected_num <= num_0;
		end case;
	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			if rstn = '0' then
				cathodes <= (others => '1');
			else
				case selected_num is --           ABCDEFGP
					when X"0" => cathodes <= not "11111100";
					when X"1" => cathodes <= not "01100000";
					when X"2" => cathodes <= not "11011010";
					when X"3" => cathodes <= not "11110010";
					when X"4" => cathodes <= not "01100110";
					when X"5" => cathodes <= not "10110110";
					when X"6" => cathodes <= not "10111110";
					when X"7" => cathodes <= not "11100100";
					when X"8" => cathodes <= not "11111110";
					when X"9" => cathodes <= not "11110110";
					when X"A" => cathodes <= not "11101110";
					when X"B" => cathodes <= not "00111110";
					when X"C" => cathodes <= not "10011100";
					when X"D" => cathodes <= not "01111010";
					when X"E" => cathodes <= not "10011110";
					when others => cathodes <= not "10001110";
				end case;
			end if;
		end if;
	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			if rstn = '0' then
				seg_sel <= (others => '1');
			else
				seg_sel <= (others => '1');
				case selcntr(14 downto 12) is
					when "000" => seg_sel(0) <= '0';
					when "001" => seg_sel(1) <= '0';
					when "010" => seg_sel(2) <= '0';
					when "011" => seg_sel(3) <= '0';
					when "100" => seg_sel(4) <= '0';
					when "101" => seg_sel(5) <= '0';
					when "110" => seg_sel(6) <= '0';
					when others => seg_sel(7) <= '0';
				end case;
			end if;
		end if;
	end process;

end Behavioral;

