-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_fsm4_oh is
port ( X,CLK,RESET : in std_logic;
       Y : out std_logic_vector(3 downto 0);
       Z1,Z2 : out std_logic);
end my_fsm4_oh;

-- architeture
architecture fsm4_oh of my_fsm4_oh is
    type state_type is (ST0,ST1,ST2,ST3);
    attribute ENUM_ENCODING: STRING;
    attribute ENUM_ENCODING of state_type: type is "1000 0100 0010 0001";
    signal PS,NS : state_type;
begin
    sync_proc: process(CLK,NS,RESET)
        begin
        if (RESET = '1') then PS <= ST0;
        elsif (rising_edge(CLK)) then PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS,X)
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
    
    -- one-hot encoded approach
    with PS select
    Y <= "1000" when ST0,
          "0100" when ST1,
          "0010" when ST2,
          "0001" when ST3,
          "1000" when others;
end fsm4_oh;