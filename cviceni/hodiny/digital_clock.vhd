library ieee;
use ieee.std_logic_all.all;
use ieee.numeric_std.all;


entity digital_clock is
    port( 
        clk_10ms: in std_logic;
        enable: in std_logic;
        reset: in std_logic;
        load: in std_logic;

        hr_d1_in: in std_logic_vector(1 downto 0);  -- d1 ... most significant digit
        hr_d0_in: in std_logic_vector(3 downto 0);
        mi_d1_in: in std_logic_vector(3 downto 0);
        mi_d0_in: in std_logic_vector(3 downto 0);
        se_d1_in: in std_logic_vector(3 downto 0);
        se_d0_in: in std_logic_vector(3 downto 0);
        fs_d1_in: in std_logic_vector(3 downto 0);
        fs_d0_in: in std_logic_vector(3 downto 0);

        hr_d1: in std_logic_vector(1 downto 0);
        hr_d0: in std_logic_vector(3 downto 0);
        mi_d1: in std_logic_vector(3 downto 0);
        mi_d0: in std_logic_vector(3 downto 0);
        se_d1: in std_logic_vector(3 downto 0);
        se_d0: in std_logic_vector(3 downto 0);
        fs_d1: in std_logic_vector(3 downto 0);
        fs_d0: in std_logic_vector(3 downto 0);
     );
end digital_clock;


architecture Behavioral of digital_clock is

    signal hr_d1_int: std_logic_vector(1 downto 0);
    signal mi_d1_int, se_d1_int: std_logic_vector(3 downto 0);

    signal clk_10ms: std_logic;
    signal counter_100ms, counter_10ms: integer;
    signal counter_hour, counter_minute, counter_second: integer;

begin

    count_time: process(clk_10ms, load, reset, enable) begin
        if (rising_edge(clk_10ms)) then
            if (load = '1') then
                counter_hour <= to_integer(unsigned(hr_in1)) * 10 + to_integer(unsigned(hr_in0));
                counter_minute <= to_integer(unsigned(mi_in1)) * 10 + to_integer(unsigned(mi_in0));
                counter_second <= 0;
            elsif (enable = '1') then
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

    
    hr_d1_int <= x"2" when counter_hour >= 20 else
                 x"1" when counter_hour >= 10 else
                 x"0";

    hr_d0 <= std_logic_vector(to_unsigned((counter_hour - to_integer(unsigned(hr_d1_int)) * 10), 4));
    
    
    mi_d1_int <= x"5" when counter_minute >= 50 else
                 x"4" when counter_minute >= 40 else
                 x"3" when counter_minute >= 30 else
                 x"2" when counter_minute >= 20 else
                 x"1" when counter_minute >= 10 else
                 x"0";

    mi_d0 <= std_logic_vector(to_unsigned((counter_minute - to_integer(unsigned(mi_d1_int)) * 10), 4));

    se_d1_int <= x"5" when counter_second >= 50 else
                 x"4" when counter_second >= 40 else
                 x"3" when counter_second >= 30 else
                 x"2" when counter_second >= 20 else
                 x"1" when counter_second >= 10 else
                 x"0";

    se_d0 <= std_logic_vector(to_unsigned((counter_second - to_integer(unsigned(se_d1_int)) * 10), 4));


    fs_d1 <= std_logic_vector(to_unsigned(couter_100ms, 4);
    fs_d0 <= std_logic_vector(to_unsigned(couter_10ms, 4); 

end Behavioral;
