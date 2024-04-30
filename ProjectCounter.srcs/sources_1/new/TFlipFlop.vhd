----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 05:51:28 PM
-- Design Name: 
-- Module Name: TFlipFlop - Behavioral
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

entity TFlipFlop is
    Port(T: in STD_LOGIC;
         CLK: in STD_LOGIC;
         Q: out STD_LOGIC);
end TFlipFlop;

architecture Behavioral of TFlipFlop is
signal temp: STD_LOGIC;
begin
    process(CLK)
    begin
        if CLK = '1' and CLK'EVENT then
            temp <= not temp;
        end if;
    end process;
    Q <= temp;
end Behavioral;
