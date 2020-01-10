library IEEE
use IEEE.std_logic_1164.all

entity fsm4 is
    port(CLK, RESET: in std_logic;
        X: in std_logic;
        Z1, Z2: out std_logic;
        Y: out std_logic_vector(1 downto 0));
end fsm4;

architecture fsm4_arch of fsm4 is
    type state_type is (ST0, ST1, ST2, ST3);
    signal PS, NS: state_type;
begin
    sync_proc: process(CLK, NS, RESET)
    begin
        if RESET = '1' then
            PS <= ST0;
        elsif rising_edge(CLK) then
            PS <= NS;
        end if;
    end process;

    comb_proc: process(PS, X):
    begin
        -- Z1: the Moore output; Z2: the Mealy output
        Z1 <= '0'; Z2 <= '0'; -- pre-assign the outputs

        case PS is
            when ST0 => -- items regarding state ST0
                Z1 <= '1'; -- Moore output
                if (X = '0') then NS <= ST1; Z2 <= '0';
                else NS <= ST0; Z2 <= '1';
                end if;
            when ST1 => -- items regarding state ST1
                Z1 <= '1'; -- Moore output
                if (X = '0') then NS <= ST2; Z2 <= '0';
                else NS <= ST1; Z2 <= '1';
                end if;
            when ST2 => -- items regarding state ST2
                Z1 <= '0'; -- Moore output
                if (X = '0') then NS <= ST3; Z2 <= '0';
                else NS <= ST2; Z2 <= '1';
                end if;
            when ST3 => -- items regarding state ST3
                Z1 <= '1'; -- Moore output
                if (X = '0') then NS <= ST0; Z2 <= '0';
                else NS <= ST3; Z2 <= '1';
                end if;
            when others => -- the catch all condition
                Z1 <= '1'; Z2 <= '0'; NS <= ST0;
        end case;
    end process comb_proc;

    with PS select
        Y <= "00" when ST0,
             "01" when ST1,
             "10" when ST2,
             "11" when ST3,
             "00" when others;
end fsm4_arch;



