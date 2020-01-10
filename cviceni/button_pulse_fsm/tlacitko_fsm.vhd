library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tlacitko_fsm is
  Port ( clk: in std_logic;
         enter: in std_logic;
         press: out std_logic;
         y: out std_logic_vector(1 downto 0));
end tlacitko_fsm;

architecture arch of tlacitko_fsm is
    type tlac_state is (ST_W1, ST_W0, ST_P); -- wait 1, wait 0, pressed
    signal PS, NS: tlac_state;
begin
    sync: process(clk, NS)
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process sync;
    
    comb: process(PS)
    begin
        NS <= PS;
        press <= '0';
        case PS is
            when ST_W1 =>
                if enter = '1' then
                    NS <= ST_P;
                end if;
            when ST_P =>
                press <= '1';
                NS <= ST_W0;
            when ST_W0 =>
                if enter = '0' then
                    NS <= ST_W1;
                end if;
            when others =>
                NS <= ST_W1;
        end case;
    end process comb;
    
    with PS select
        y <= "00" when ST_W1, 
             "01" when ST_P,
             "10" when ST_W0,
             "11" when others;
end arch;