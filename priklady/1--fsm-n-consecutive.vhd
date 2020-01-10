
-- Navrhněte synchronní sekvenční obvod se dvěma vstupy x1 a x2 a s výstupem z. Obvod porovnává dvě
-- sériově vstupující slova. Když se na vstupech zároveň objeví shodné posloupnosti o délce alespoň 3 bitů,
-- výstup z se nastaví do log. 1. Výstup se navrátí do nuly zároveň s první rozdílnou dvojicí bitů na vstupech. 

entity fsm1 is
    port(
        reset: in std_logic;
        clk: in std_logic;
        x1, x2: in std_logic;
        z: out std_logic;
        y: out std_logic_vector()
    );
end fsm1;

architecture arch of fsm1 is
    type state_type is (ST1, ST2, ST3, ST);
    signal ps, ns: state_type;
begin

    sync_proc: process(clk, reset)
    begin
        if reset = '1' then
            ps <= ST1;
        elsif rising_edge(clk) then
            ps <= ns;
        end if;
    end process;

    comb_proc: process(ps, x1, x2)
    begin
        ns <= ps;
        z <= '0';

        case ps is
            when ST1 =>
                if x1 = x2 then ns <= ST2; 
                else ns <= ST1; 
                end if
            when ST2 =>
                if x1 = x2 then ns <= ST3; 
                else ns <= ST1; 
                end if
            when ST3 =>
                if x1 = x2 then ns <= ST4; 
                else ns <= ST1; 
                end if
            when ST4 =>
                if x1 = x2 then ns <= ST4; z <= '1';
                else ns <= ST1;
                end if
            when others =>
                ns <= ST1;
        end case;
    end process;


end arch ; -- arch