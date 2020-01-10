entity fsm2 to
    port(
        clk, reset: in std_logic;
        x: in std_logic_vector(2 downto 0);
        z: out std_logic;
        y: out std_logic_vector(1 downto 0)
    );
end fsm2;


architecture arch of fsm2 is
    type state_type is (ST0, ST1, ST2, ST3);
    signal ps, ns: state_type;
    signal more_than_1: std_logic;
begin

    with x select
        more_than_1 <= '1' when "111"|"110"|"101"|"011",
                       '0' when others;

    sync_proc: process(clk, reset)
    begin
        if reset = '1' then
            ps <= ST0;   
        elsif rising_edge(clk) then 
            ps <= ns; 
        end if;
    end process sync_proc;


    comb_proc: process(ps)
    begin
        z <= '0';
        ns <= ST0;

        case ps is
            when ST0 =>
                if more_than_1 = '1' then
                    ns <= ST1;
                end if;
            when ST1 =>
                if more_than_1 = '1' then
                    ns <= ST2;
                end if;
            when ST2 =>
                if more_than_1 = '1' then
                    ns <= ST3;
                end if;
            when ST3 =>
                z <= '1';
                if more_than_1 = '1' then
                    ns <= ST3;
                end if;
            others =>
        end case;
    end process comb_proc;


end arch;