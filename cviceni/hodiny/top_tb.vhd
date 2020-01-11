library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top_tb is
end top_tb;

architecture arch OF top_tb is 

    --Inputs
    signal reset: std_logic := '0';
    signal clk: std_logic := '0';
    signal pause: std_logic := '0';
    signal load_digit: std_logic := '0';
    signal digit_select: std_logic_vector(2 downto 0) := (others => '0');
    signal digit_value: std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
    signal seg_sel: std_logic_vector(7 downto 0);
    signal cathodes: std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period: time := 1 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.top
        port map(reset, clk, pause, load_digit, digit_select, digit_value, seg_sel, cathodes);

   -- Clock process definitions
   clk_process: process
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
        reset <= '1';

        wait for 100 ns;

        reset <= '0';

        wait for clk_period * 10;

        

        wait for clk_period * 10;

        -- insert stimulus here 

        wait;
   end process;

end;