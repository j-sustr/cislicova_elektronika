----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 15:10:11
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port(
        clk: in std_logic;
        rst: in std_logic;
        we: in std_logic;
        manual_enable: in std_logic;
        manual_addr: in std_logic_vector(2 downto 0);
        din: in std_logic_vector(7 downto 0);
        leds: out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is
    signal cntr1_max: std_logic;
    signal cntr1_rst: std_logic;
    signal cntr1_out: std_logic_vector(27 downto 0);
    signal cntr2_out: std_logic_vector(2 downto 0);
    signal addr: std_logic(2 downto 0);
begin

    cntr1_max <= '1' when (cntr1_out = "0101111101011110000011111111") else '0';

    cntr1_rst <= rst or cntr1_max;

    addr <= manual_addr when (manual_enable = '1') else cntr2_out; -- mux
    

    cntr1: entity work.cntrX
        generic map(
            C_WIDTH => 28
        );
        port map(
            clk => clk,
            reset => cntr1_rst,
            ce => '1',
            inc_not_dec => '1',
            cnt => cntr1_out  
        );
    
    cntr2: entity work.cntrX 
        generic map(
            C_WIDTH => 8
        );
        port map(
            clk => clk,
            reset => cntr1_rst,
            ce => '1',
            inc_not_dec => '1',
            cnt => cntr1_ena  
        );
        
    mem1: entity work.ram
        generic map(
            d_width := 8,
            size := 8,
        );
        port map(
            clk => clk,
            wr_ena => we,
            addr => addr,
            data_in => din,
            data_out => leds  
        );
    
begin


end Behavioral;
