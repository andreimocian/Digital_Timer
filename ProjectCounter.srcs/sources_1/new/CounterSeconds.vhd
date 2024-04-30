----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2024 04:51:18 PM
-- Design Name: 
-- Module Name: CounterSeconds - Behavioral
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

entity CounterSeconds is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         TC0: out STD_LOGIC;
         OUTPUT: out STD_LOGIC_VECTOR(7 downto 0));  
end CounterSeconds;

architecture Behavioral of CounterSeconds is
signal COUNT: STD_LOGIC_VECTOR(7 downto 0);
begin
    process(CLK, RST)
        begin
            if CLK = '1' and CLK'EVENT then
                if RST = '1' then
                        COUNT <= (others => '0');
                elsif EN = '1' then
                    if UD = '0' then
                        COUNT <= COUNT + 1;
                    else
                        COUNT <= COUNT - 1;
                    end if;
                            
                    if COUNT >= x"3B" and UD = '0' then
                        COUNT <= (others => '0');
                    end if;
                    if COUNT = x"0" and UD = '1' then
                        COUNT <= x"3B";
                    end if;
                end if;
            end if;
            if COUNT = x"0" then
                TC0 <= '1';
            else
                TC0 <= '0';
            end if;
    end process;
    OUTPUT <= COUNT;
end Behavioral;
