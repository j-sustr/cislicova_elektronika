
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter_x_load is
    generic(
        C_WIDTH: integer:= 4
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        load: in std_logic;
        decrement: in std_logic; --ovládá směr čítání
        load_value: in std_logic_vector(C_WIDTH - 1 downto 0);
        value: out std_logic_vector(C_WIDTH - 1 downto 0)
    );
end cntrX;

architecture behavioral of counter_x_load is
    signal value_tmp: unsigned(C_WIDTH - 1  downto 0);
begin

    cnt_proc: process(clk, reset)
    begin
        if reset = '1' then
            value_tmp <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                value_tmp <= load_value;
            elsif enable = '1' then
                if decrement = '0' then
                    value_tmp <= value_tmp + 1;
                else
                    value_tmp <= value_tmp - 1;
                end if;
            end if;
        end if;
    end process cnt_proc;
    
    value <= std_logic_vector(value_tmp);
    
end behavioral;