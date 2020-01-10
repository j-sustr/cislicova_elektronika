
entity gray_counter_5 is
    port(
        clk, reset: in std_logic;
        value: out std_logic_vector(2 downto 0);
    );
end gray_counter_5;

architecture arch of gray_counter_5 is
    signal cnt: unsigned(2 downto 0) := (others => '0');
begin

    sync: process(reset, clk)
    begin
        if reset = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if cnt = "101" then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process sync;


    with cnt select
        value <= "000" when "000",
                 "001" when "001",
                 "011" when "010",
                 "010" when "011",
                 "110" when "100",
                 "111" when "101",
                 "000" when others;



end arch ; -- arch