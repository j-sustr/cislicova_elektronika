-- 1. Navrhněte synchronní sekvenční obvod – automat (SSO), který bude indikovat
-- konec posloupnosti jedniček na vstupu. Jedná se tedy o automat s jedním vstupem X a
-- s jedním výstupem Y. Výstup Y bude nulový, pouze zároveň s první nulou následující
-- za jedničkou na vstupu bude na výstupu log. 1. Situace je znázorněna na obrázku níže,
-- pravé bity vstupují resp. vystupují jako první. 



entity end_of_seq is
    port(
        clk: in std_logic;
        x: in std_logic;
        y: out std_logic
    );
end end_of_seq;


architecture arch of end_of_seq is
    type state_type is (ST0, ST1);
    signal ps, ns: state_type := ST0;
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
            when ST0 =>
                if x = '1' then
                    ns <= ST1;
                end if;
            when ST1 =>
                if x = '0' then
                    y <= '1';
                    ns <= ST1;
                end if;
            when others =>
                ns <= ST0;
        end case;
    end process comb;



end arch ; -- arch
