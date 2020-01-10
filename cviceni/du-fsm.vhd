-- Navrhněte elektronický obvod, který vyhodnocuje směr otáčení. Ze snímače otáček vstupují do obvodu dva
-- vzájemně posunuté signály se střídou 1:1 o stejné frekvenci. Podle jejich vzájemného posunutí (předbíhání
-- či zpožďování) elektronický obvod na svém výstupu vyhodnocuje směr otáčení vpravo nebo vlevo (log. 0
-- nebo 1). Vyhodnocování stavu signálů (vzorkování) provádějte v časových intervalech nezávislých na
-- vstupních signálech.

entity rotation_dir is
    port(
        clk: in std_logic;
        sig: in std_logic_vector(1 downto 0);
        dir: out std_logic
    );
end rotation_dir;


architecture fsm of rotation_dir is
    type state_type is (S00, S01, S10, S11);
    signal ps, ns: state_type;
begin
    sync_proc: process(clk, ns)
    begin
        if rising_edge(clk) then
            ps <= ns;
        end if;
    end process sync_proc;

    comb_proc: process(ps)
        ns <= ps;
        -- dir <= '1';
        case ps is
            when S00 =>
                if (sig = "01") then ns <= S01; dir <= '0';
                elsif (sig = "10") then ns <= S10; dir <= '1';
                end if;
            when S01 =>
                if (sig = "11") then ns <= S11; dir <= '0';
                elsif (sig = "00") then ns <= S00; dir = '1';
                end if;
            when S11 =>
                if (sig = "10") then ns <= S10; dir <= '0';
                elsif (sig = "01") then ns <= S01; dir <= '1';
                end if;
            when S10 =>
                if (sig = "00") then ns <= S00; dir <= '0';
                elsif (sig = "11") then ns <= S11; dir <= '1';
                end if;
            when others =>
                ns <= S0;
        end case;
    end process comb_proc;
end fsm;