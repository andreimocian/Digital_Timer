----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 11:07:40 PM
-- Design Name: 
-- Module Name: FreqDiv - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FreqDiv is
    port(CLK: in STD_LOGIC;
         EN: out STD_LOGIC);
end FreqDiv;

architecture Behavioral of FreqDiv is
signal COUNT: STD_LOGIC_VECTOR(25 downto 0);
signal TEMP: STD_LOGIC;
begin
    process(CLK)
    begin
        if CLK = '1' and CLK'EVENT then
            COUNT <= COUNT + 1;
            if COUNT >= 49_999_999 then
                COUNT <= (others => '0');
                TEMP <= not TEMP;
            end if;
        end if;
        EN <= TEMP;
    end process;
end Behavioral;
