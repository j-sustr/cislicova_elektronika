
entity fsm_1 is
    port(CLK: in std_logic;
         X: in std_logic_vector(1 downto 0),
         Z: out std_logic
         Y: out std_logic_vector(1 downto 0));
end fsm_1;

architecture arch of fsm_1 is
    state_type is (ST01, ST10, ST11);
    signal PS, NS: state_type;
begin
    sync_proc: process(CLK, NS)
    begin
        if rising_edge(CLK) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process()
    begin
        Z <= '0';
        case PS is
            when ST01 =>
                if (X(1) = '0') then NS <= ST11; Z <= '0';
                else NS <= ST10; Z <= '1';
                end if;
            when ST10 =>
                if (X(0) = '0') then NS <= ST10; Z <= '0';
                else NS <= ST01; Z <= '0';
                end if;
            when ST11 =>
                if (X(1) = '0') then NS <= ST10; Z <= '1';
                else NS <= ST11; Z <= '0';
                end if;
            when others =>
                NS <= ST01; Z <= '0';
        end case;
    end process comb_proc;

    with PS select
        Y <= "01" when ST01,
             "10" when ST10,
             "11" when ST11,
             "00" when others;

end arch ; -- arch



------------------------------------------------------------------------
-- EXERCISE 4

entity fsm_2 is
    port(CLK, INIT: in std_logic;
         X: in std_logic_vector(1 downto 0),
         Z: out std_logic_vector(1 downto 0),
         Y: out std_logic_vector(1 downto 0));
end fsm_2;


architecture arch of fsm_2 is

    type state_type is (SA, SB, SC);
    signal PS, NS: state_type := SA;

begin
    sync_proc: process(CLK, NS, INIT)
    begin
        if (INIT = '1') then
            NS <= SA;
        elsif rising_edge(CLK) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process()
    begin
        
        case PS is
            when SA =>
                if (X(1) = '0') then NS <= ST11; Z <= '0';
                else NS <= ST10; Z <= '1';
                end if;
            when ST10 =>
                if (X(0) = '0') then NS <= ST10; Z <= '0';
                else NS <= ST01; Z <= '0';
                end if;
            when ST11 =>
                if (X(1) = '0') then NS <= ST10; Z <= '1';
                else NS <= ST11; Z <= '0';
                end if;
            when others =>
                NS <= ST01; Z <= '0';
        end case;
    end process comb_proc;

    with PS select
        Y <= "01" when ST01,
             "10" when ST10,
             "11" when ST11,
             "00" when others;

end arch ; -- arch