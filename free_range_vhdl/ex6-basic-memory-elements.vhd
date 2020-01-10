-- EXERCISE 1. Provide a VHDL behavioral
-- model of the D flip-flop shown on the right.
-- The S and R inputs are an active low asynchronous preset and clear. Assume both the
-- S and R inputs will never be asserted simultaneously.

entity d_ff_1 is
    port(
        s: in std_logic;
        r: in std_logic;
        clk: in std_logic;
        d: in: std_logic;
        q: out std_logic
    );
end d_ff_1;

architecture behav of d_ff_1 is
begin
    dff: process(s, r, clk)
    begin
        if R = '0' then
            q <= '0';
        elsif S = '0' then
            q <= '1';
        elsif rising_edge(clk) then
            q <= d;
        end if;
    end process dff;
end behav;

-----------------------------------------------------------------------------------------------
-- EXERCISE 4. Provide a VHDL behavioral
-- model of the D flip-flop shown on the right.
-- The S and R inputs are an active low asynchronous preset and clear. If both the S and
-- R inputs are asserted simultaneously, the output of the flip-flop will toggle.


architecture behav of d_ff_4 is
    signal t_tmp : std_logic;
    begin
        dff: process(s, r, clk)
        begin
            if R = '0' and S = '0' then 
                q <= '0';
            elsif R = '0' then
                q <= '0';
            elsif S = '0' then
                q <= '1';
            elsif rising_edge(clk) then
                q <= d;
            end if;
        end process dff;
    end behav;




