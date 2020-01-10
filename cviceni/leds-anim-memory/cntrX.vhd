
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
-- use UNISIM.VComponents.all;

entity cntrX is
    generic(
        C_WIDTH: integer := 4
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        ce: in std_logic;
        inc_not_dec: in std_logic; --ovládá smìr èítání
        cnt: out std_logic_vector(C_WIDTH - 1 downto 0)
    );
end cntrX;

architecture Behavioral of cntrX is
    signal cnt_tmp: unsigned(C_WIDTH - 1  downto 0);
begin

    cnt_proc: process(clk, reset)
    begin
        if reset = '1' then
            cnt_tmp <= (others => '0');
        elsif rising_edge(clk) then
            if ce = '1' then
                if inc_not_dec = '1' then
                    cnt_tmp <= cnt_tmp + 1;
                else
                    cnt_tmp <= cnt_tmp - 1;
                end if;
            end if;
        end if;
    end process cnt_proc;
    
    cnt <= std_logic_vector(cnt_tmp);
    
end Behavioral;