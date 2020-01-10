library ieee;
use ieee.std_logic_all.all;
use ieee.numeric_std.all;


entity clk_div is
    generic(
        C_COUNTER_WIDTH: integer := 28;
    );
    port(
        period: std_logic_vector(C_COUNTER_WIDTH - 1 downto 0) := x"2FAF080";
        pulse_width: std_logic_vector(C_COUNTER_WIDTH - 1 downto 0) := x"17D7840"; -- 25000000
        clk_in: in std_logic;
        clk_out: out std_logic
    );
end clk_div;

architecture Behavioral of clk_div is
    signal counter: std_logic_vector(C_COUNTER_WIDTH - 1 downto 0) := (others =>'0');
begin
    process(clk_in)
    begin
        if(rising_edge(clk_in)) then
            counter <= counter + 1;
            if(counter >= period) then
                counter <= (others => '0');
            end if;
        end if;
    end process;

    clk_out <= '1' when counter < pulse_width else '0';

end Behavioral;