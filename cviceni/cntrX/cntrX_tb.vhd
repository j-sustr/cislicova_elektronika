----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2019 13:10:21
-- Design Name: 
-- Module Name: cntrX_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cntrX_tb is
end cntrX_tb;

architecture Behavioral of cntrX_tb is
	
	constant C_WIDTH : integer := 10;
	constant clk_p : time := 10 ns;
	
	signal clk         : std_logic := '0';
	signal reset       : std_logic := '0';
	signal ce          : std_logic := '0';
	signal inc_not_dec : std_logic := '0';
	signal cnt         : std_logic_vector(C_WIDTH - 1 downto 0);

begin

	clock : process
	begin
		wait for clk_p / 2;
		clk <= not clk;
	end process;

	dut : entity work.cntrX
		generic map(
			C_WIDTH => C_WIDTH
		)
		port map(
			clk         => clk,
			reset       => reset,
			ce          => ce,
			inc_not_dec => inc_not_dec,
			cnt         => cnt
		);
		
		tb : process
		begin
			reset <= '1';
			wait for clk_p*2;
			reset <= '0';
			wait for clk_p*2;
			
			ce <= '1';
			inc_not_dec <= '1';
			wait for clk_p*20;
			inc_not_dec <= '0';
		wait;
		end process;

end Behavioral;
