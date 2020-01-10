library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity digital_clock is
    port( 
        clk_10ms: in std_logic;
        reset: in std_logic;
        
        -- settings interface
        pause: in std_logic;
        load_digit: in std_logic;
        digit_select: in: std_logic_vector(2 downto 0);
        digit_value: in: std_logic_vector(3 downto 0);

        -- output digits
        hr_d1: out std_logic_vector(1 downto 0); -- d1 ... most significant digit
        hr_d0: out std_logic_vector(3 downto 0); -- d0 ... least significant digit
        mi_d1: out std_logic_vector(3 downto 0);
        mi_d0: out std_logic_vector(3 downto 0);
        se_d1: out std_logic_vector(3 downto 0);
        se_d0: out std_logic_vector(3 downto 0);
        fs_d1: out std_logic_vector(3 downto 0);
        fs_d0: out std_logic_vector(3 downto 0)
    );
end digital_clock;


architecture Behavioral of digital_clock is
    signal hr_d1_int, mi_d1_int, se_d1_int: std_logic_vector(3 downto 0);
    signal hr_d0_int, mi_d0_int, se_d0_int: std_logic_vector(3 downto 0);

    signal counter_100ms: integer := 0; 
    signal counter_10ms: integer := 0;
    signal counter_hour: integer := 0;
    signal counter_minute: integer := 0;
    signal counter_second: integer := 0;

begin

    count_time: process(clk_10ms, load, reset, enable) begin
        if (rising_edge(clk_10ms)) then
            if (reset = '1') then
                counter_100ms <= 0;
                counter_10ms <= 0;
                counter_hour <= 0;
                counter_minute <= 0;
                counter_second <= 0;
            elsif (pause = '1') then
                if (load = '1') then
                    case digit_select is
                        when "000" =>
                            counter_10ms <= to_integer(unsigned(digit_value));
                        when "001" =>
                            counter_100ms <= to_integer(unsigned(digit_value));
                        when "010" =>
                            counter_second <= 10 * to_integer(unsigned(se_d1_int)) + to_integer(unsigned(digit_value));
                        when "011" =>
                            counter_second <= 10 * to_integer(unsigned(digit_value)) + to_integer(unsigned(se_d0_int));
                        when "100" =>
                            counter_minute <= 10 * to_integer(unsigned(mi_d1_int)) + to_integer(unsigned(digit_value));
                        when "101" =>
                            counter_minute <= 10 * to_integer(unsigned(digit_value)) + to_integer(unsigned(mi_d0_int));
                        when "110" =>
                            counter_hour <= 10 * to_integer(unsigned(hr_d1_int)) + to_integer(unsigned(digit_value));
                        when "111" =>
                            counter_hour <= 10 * to_integer(unsigned(digit_value)) + to_integer(unsigned(hr_d0_int));
                    end case;
    
                    counter_minute <= 10 * to_integer(unsigned(mi_d1_in)) + to_integer(unsigned(mi_d0_in));
                    counter_second <= 10 * to_integer(unsigned(se_d1_in)) + to_integer(unsigned(se_d0_in));
                    counter_100ms <= to_integer(unsigned(fs_d1_in)); 
                    counter_10ms <= to_integer(unsigned(fs_d0_in));
                end if;
            else
                counter_10ms <= counter_10ms + 1;
                if (counter_10ms >= 9) then
                    counter_10ms <= 0;
                    counter_100ms <= counter_100ms + 1;
                    if (counter_100ms >= 9) then
                        counter_100ms <= 0;
                        counter_second <= counter_second + 1;
                        if (counter_second >= 59) then
                            counter_second <= 0;
                            counter_minute <= counter_minute + 1;
                            if (counter_minute >= 59) then
                                counter_minute <= 0;
                                counter_hour <= counter_hour + 1;
                                if (counter_hour >= 24) then
                                    counter_hour <= 0;
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process count_time;

    
    hr_d1 <= hr_d1_int(1 downto 0);
    hr_d1_int <= x"2" when counter_hour >= 20 else
                 x"1" when counter_hour >= 10 else
                 x"0";

    hr_d0 <= hr_d0_int;
    hr_d0_int <= std_logic_vector(to_unsigned((counter_hour - to_integer(unsigned(hr_d1_int)) * 10), 4));
    
    mi_d1 <= mi_d1_int;
    mi_d1_int <= x"5" when counter_minute >= 50 else
                 x"4" when counter_minute >= 40 else
                 x"3" when counter_minute >= 30 else
                 x"2" when counter_minute >= 20 else
                 x"1" when counter_minute >= 10 else
                 x"0";

    mi_d0 <= mi_d0_int;
    mi_d0_int <= std_logic_vector(to_unsigned((counter_minute - to_integer(unsigned(mi_d1_int)) * 10), 4));

    se_d1 <= se_d1_int;
    se_d1_int <= x"5" when counter_second >= 50 else
                 x"4" when counter_second >= 40 else
                 x"3" when counter_second >= 30 else
                 x"2" when counter_second >= 20 else
                 x"1" when counter_second >= 10 else
                 x"0";

    se_d0 <= se_d0_int; 
    se_d0_int <= std_logic_vector(to_unsigned((counter_second - to_integer(unsigned(se_d1_int)) * 10), 4));

    fs_d1 <= std_logic_vector(to_unsigned(counter_100ms, 4));
    fs_d0 <= std_logic_vector(to_unsigned(counter_10ms, 4)); 

end Behavioral;
