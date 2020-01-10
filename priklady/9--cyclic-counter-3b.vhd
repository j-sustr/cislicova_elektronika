

entity cyclic_counter is
    port(
        clk, reset: in std_logic;
        down: in std_logic;
        value: out std_logic_vector(2 downto 0)
    );
end cyclic_counter;

architecture arch of cyclic_counter is
    signal int_value: unsigned(2 downto 0) := (others => '0');
begin

    sync: process(clk)
    begin
        if reset = '1' then
            int_value <= (others => '0');
        elsif rising_edge(clk) then
            if down = '1' then
                if int_value = "000" then
                    int_value <= "111";
                else
                    int_value <= int_value - 1;
                end if;
            else
                if int_value = "111" then
                    int_value <= "000";
                else
                    int_value <= int_value + 1;
                end if;
            end if;
        end if;
    end process sync;

    value <= std_logic_vector(int_value);

end arch ; -- arch



AND

A   B  OUT
0   0   0
0   1   0
1   0   0
1   1   1


NAND
A   B   OUT
0   0    1
0   1    1
1   0    1
1   1    0



NOT - NEGACE

IN  OUT
0   1
1   0