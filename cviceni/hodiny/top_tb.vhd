library ieee;
use ieee.std_logic_1164.ALL;


entity tb_top is
end tb_top;

architecture arch OF tb_top is 

    -- Constants
    constant C_CLK_COUNTER_WIDTH: integer := 12;

    --Inputs
    signal reset: std_logic := '0';
    signal enable: std_logic := '0';
    signal clk: std_logic := '0';
    signal clk_10ms: std_logic := '0';
    signal load: std_logic := '0';
    signal wr_segment_ena: std_logic := '0';
    signal wr_segment_sel: std_logic_vector(2 downto 1) := (others => '0');
    signal wr_segment_value: std_logic_vector(3 downto 0) := (others => '0');
    signal count_10ms: std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0) := x"008";
    signal count_5ms: std_logic_vector(C_CLK_COUNTER_WIDTH - 1 downto 0) := x"004";


    --Outputs
    signal seg_sel: out std_logic_vector(7 downto 0);
    signal cathodes: out std_logic_vector(7 downto 0);

    signal hr_d1: std_logic_vector(3 downto 0);
    signal hr_d0: std_logic_vector(3 downto 0);
    signal mi_d1: std_logic_vector(3 downto 0);
    signal mi_d0: std_logic_vector(3 downto 0);
    signal se_d1: std_logic_vector(3 downto 0);
    signal se_d0: std_logic_vector(3 downto 0);
    signal fs_d1: std_logic_vector(3 downto 0);
    signal fs_d0: std_logic_vector(3 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ps;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.top port map (
        clk => clk,
        clk_10ms => clk_10ms,
        reset => reset,
        enable => enable,
        load => load,
        wr_segment_ena => wr_segment_ena,
        wr_segment_sel => wr_segment_sel,
        wr_segment_value => wr_segment_value,
        count_10ms => count_10ms,
        count_5ms => count_5ms,
        hr_d1 => hr_d1,
        hr_d0 => hr_d0,
        mi_d1 => mi_d1,
        mi_d0 => mi_d0,
        se_d1 => se_d1,
        se_d0 => se_d0,
        fs_d1 => fs_d1,
        fs_d0 => fs_d0         
    );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

   -- Stimulus process
    stim_proc: process
    begin 
        -- hold reset state for 100 ns.
        rst_n <= '1';

        wait for 100 ns; 

        rst_n <= '0';

        wait for clk_period*10;

        -- insert stimulus here 

        wait;
   end process;

end;