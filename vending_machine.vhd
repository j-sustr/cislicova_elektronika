----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2018 09:14:30
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

entity vending_machine is
	Port(
		big_coin   : in  std_logic;
		small_coin : in  std_logic;
		req_water  : in  std_logic;
		req_soda   : in  std_logic;
		pour_soda  : out std_logic;
		pour_water : out std_logic;
		ret_coin   : out std_logic
	);
end vending_machine;

architecture Behavioral of vending_machine is

begin
		
	pour_soda <= '1' when req_soda = '1' and big_coin = '1' else '0';
	
--	pour_soda <= req_soda and big_coin;
	

end Behavioral;
