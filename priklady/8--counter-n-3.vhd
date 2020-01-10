


entity counter_n_3 is
    port(
        clk, reset: in std_logic;
        n: in std_logic_vector(1 downto 0);
        value: out std_logic_vector(1 downto 0)
    );
end counter_n_3;

architecture arch of counter_n_3 is
    signal cnt: unsigned(1 downto 0);
begin
    sync: process(clk)
    begin
        if reset = '1' then
            cnt <= unsigned(n);
        elsif rising_edge(clk) then
            if cnt = "11" then
                cnt <= unsigned(n);
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process sync;

    value <= std_logic_vector(cnt);

end arch ; -- arch