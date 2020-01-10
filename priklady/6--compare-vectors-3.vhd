

entity compare_vectors_3 is
    port(
        clk, reset: std_logic;
        x1, x2, x3: std_logic;
        z: std_logic;
    );
end compare_vectors_3;

architecture arch of compare_vetors_3 is
    type state_type is (ST0, ST1, ST3);
    signal ps, ns: state_type := ST0;
    
    signal x_concat: std_logic_vector(2 downto 0);
begin

    x_concat <= x1 & x2 & x3;

    sync: process(clk)
    begin
        if rising_edge(clk) then
            ps <= ns;
        end if;
    end process sync;

    comb: process(ps, x_concat)
    begin
        z <= '0'
        ns <= ST0;

        case ps is
            when ST0 =>
                if x_concat = "101" then
                    ns <= ST1;
                end if;
            when ST1 =>
                if x_concat = "011" then
                    ns <= ST2;
                end if;
            when ST2 =>
                z <= '1';
                ns <= ST0;
            when others =>
                ns <= ST0;
        end case


    end process comb;

end arch;