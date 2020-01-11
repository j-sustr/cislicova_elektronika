library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(
        reset: in std_logic;
        clk: in std_logic;
        pause: in std_logic;
        load_digit: in std_logic;
        digit_select: in std_logic_vector(2 downto 0);
        digit_value: in std_logic_vector(3 downto 0);
        seg_sel: out std_logic_vector(7 downto 0);
        cathodes: out std_logic_vector(7 downto 0)
    );
end top;

architecture arch of top is
    -- Constants
    constant C_CLK_COUNTER_WIDTH: integer := 12;
    constant count_10ms: std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0) := x"007";
    constant count_5ms: std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0) := x"003";

    type digits_memory is array(0 to 7) of std_logic_vector(3 downto 0);
    signal current_time: digits_memory := (others => (others => '0'));

    signal clk_10ms: std_logic;
    signal rstn: std_logic;
begin

    rstn <= not reset;

    create_10ms_clock: entity work.clk_div
        generic map(C_COUNTER_WIDTH => C_CLK_COUNTER_WIDTH)
        port map(
            period => count_10ms,
            pulse_width => count_5ms,
            clk_in => clk,
            clk_out => clk_10ms
        );

    digital_clock_0: entity work.digital_clock
        port map(
            clk_10ms => clk_10ms,
            reset => reset,
            pause => pause,
            load_digit => load_digit,
            digit_select => digit_select,
            digit_value => digit_value,
            hr_d1 => current_time(0)(1 downto 0),
            hr_d0 => current_time(1),
            mi_d1 => current_time(2),
            mi_d0 => current_time(3),
            se_d1 => current_time(4),
            se_d0 => current_time(5),
            fs_d1 => current_time(6),
            fs_d0 => current_time(7)
        );


        display_0: entity work.digits_display_decoder
            port map(
                clk      => clk,
                rstn     => rstn,
                num_0    => current_time(0),
                num_1    => current_time(1),
                num_2    => current_time(2),
                num_3    => current_time(3),
                num_4    => current_time(4),
                num_5    => current_time(5),
                num_6    => current_time(6),
                num_7    => current_time(7),
                seg_sel  => seg_sel,
                cathodes => cathodes
            );
end arch;



