

entity compare_vectors_3 is
    port(
        clk, reset: std_logic;
        x: std_logic;
        z: std_logic;
    );
end compare_vectors_3;


architecture arch of fsm1 is
    type state_type is (ST0, ST1, ST2, ST3, ST4);
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
        ns <= ST0;
        z <= '0';

        case ps is
            when ST0 =>
                if x = '1' then ns <= ST1; 
                else ns <= ST0; 
                end if
            when ST1 =>
                if x = '0' then ns <= ST2; 
                else ns <= ST0; 
                end if
            when ST2 =>
                ns <= ST3;
                -- if x = '0' or x = '1' then ns <= ST3; 
                -- else ns <= ST0; 
                -- end if
            when ST3 =>
                if x = '1' then ns <= ST4; 
                else ns <= ST0; 
                end if
            when ST4 =>
                z = '1';
                if x = '1' then ns <= ST4;
                else ns <= ST0;
                end if
            when others =>
                ns <= ST0;
        end case;
    end process;


end arch ; -- arch