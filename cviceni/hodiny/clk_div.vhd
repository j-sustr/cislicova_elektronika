library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clk_div is
    generic(
        C_COUNTER_WIDTH: integer
    );
    port(
        period: std_logic_vector(C_COUNTER_WIDTH - 1 downto 0);
        pulse_width: std_logic_vector(C_COUNTER_WIDTH - 1 downto 0);
        clk_in: in std_logic;
        clk_out: out std_logic
    );
end clk_div;

architecture Behavioral of clk_div is
    signal counter: unsigned(C_COUNTER_WIDTH - 1 downto 0) := (others =>'0');
begin
    process(clk_in)
    begin
        if(rising_edge(clk_in)) then
            counter <= counter + 1;
            if(counter >= unsigned(period)) then
                counter <= (others => '0');
            end if;
        end if;
    end process;

    clk_out <= '1' when counter < unsigned(pulse_width) else '0';

end Behavioral;