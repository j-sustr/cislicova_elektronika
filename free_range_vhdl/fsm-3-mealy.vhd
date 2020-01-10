-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity my_fsm3 is
    port ( X,CLK,SET : in std_logic;
            Y : out std_logic_vector(1 downto 0);
            Z2 : out std_logic);
end my_fsm3;

-- architecture
architecture fsm3 of my_fsm3 is
    type state_type is (ST0,ST1,ST2);
    signal PS,NS : state_type;
begin

    sync_proc: process(CLK,NS,SET)
    begin
        if (SET = '1') then
            PS <= ST2;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS,X)
    begin
        Z2 <= '0'; -- pre-assign FSM outputs
        case PS is
            when ST0 => -- items regarding state ST0
                Z2 <= '0'; -- Mealy output always 0
                if (X = '0') then NS <= ST0;
                else NS <= ST1;
                end if;
            when ST1 => -- items regarding state ST1
                Z2 <= '0'; -- Mealy output always 0
                if (X = '0') then NS <= ST0;
                else NS <= ST2;
                end if;
            when ST2 => -- items regarding state ST2
                -- Mealy output handled in the if statement
                if (X = '0') then NS <= ST0; Z2 <= '0';
                else NS <= ST2; Z2 <= '1';
                end if;
            when others => -- the catch all condition
                Z2 <= '1'; NS <= ST0;
        end case;
    end process comb_proc;

    -- faking some state variable outputs
    with PS select
        Y <= "00" when ST0,
             "10" when ST1,
             "11" when ST2,
             "00" when others;
end fsm3;