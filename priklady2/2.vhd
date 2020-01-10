-- 2. Navrhněte synchronní sekvenční obvod – automat (SSO), který bude indikovat
-- konec posloupnosti střídajících se nul a jedniček. Jedná se tedy o automat s jedním
-- vstupem X a s jedním výstupem Y. Výstup Y bude jedničkový pouze tehdy, pokud
-- automat zaznamená na vstupu rozdílný následující bit.


entity end_of_seq is
    port(
        clk: in std_logic;
        x: in std_logic;
        y: out std_logic
    );
end end_of_seq;


architecture arch_fsm_moore of end_of_seq is
    type state_type is (ST_0, ST_1, ST_E, ST_S0, ST_S1);
    signal ps, ns: state_type := ST_S0;
    -- signal prev_x: std_logic := '0'; -- previous x
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
                if x = '1' then ns <= ST1;
                else ns <= ST_E;
                end if;
            when ST_1 =>
                if x = '0' then ns <= ST0;
                else ns <= ST_E;
                end if;
            when ST_E =>
                y <= '1';    
                if x = '0' then ns <= ST_S0;
                else ns <= ST_S1;
                end if;
            when ST_S0 =>
                if x = '1' then ns <= ST_0;
                end if;
            when ST_S1 =>
                if x = '0' then ns <= ST_1;
                end if;
            when others =>
                ns <= ST_S0;
        end case;
    end process comb;



end arch_fsm_moore ; -- arch