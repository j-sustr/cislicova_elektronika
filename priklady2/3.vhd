entity seq_of_1_of_even_len is
    port(
        clk: in std_logic;
        x: in std_logic;
        y: out std_logic
    );
end seq_of_1_of_even_len;


architecture arch_fsm_moore of seq_of_1_of_even_len is
    type state_type is (ST_ODD_1, ST_EVN_1, ST_EVN_1_END, ST_0);
    signal ps, ns: state_type := ST_0;
begin

    sync: process(clk)
    begin
        if rising_edge(clk) then
            ps <= ns;
        end if;
    end process sync;

    comb: process(ps, x)
    begin
        y <= '0';
        ns <= ps;

        case ps is
            when ST_0 =>
                if x = '1' then ns <= ST_ODD_1;
                end if;
            when ST_ODD_1 =>
                if x = '1' then ns <= ST_EVN_1;
                else ns <= ST_0;
                end if;
            when ST_EVN_1 =>
                if x = '1' then ns <= ST_ODD_1;
                else ns <= ST_EVN_1_END;
                end if;
            when ST_EVN_1_END =>
                y <= '1';
                if x = '1' then ns <= ST_ODD_1;
                else ns <= ST_0;
                end if;
            when others =>
                ns <= ST_0;
        end case;
    end process comb;



end arch_fsm_moore ;