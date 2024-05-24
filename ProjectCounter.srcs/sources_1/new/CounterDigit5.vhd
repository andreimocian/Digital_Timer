library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity CounterDigit5 is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         TC0: out STD_LOGIC;
         OUTPUT: out STD_LOGIC_VECTOR(3 downto 0));  
end CounterDigit5;

architecture Behavioral of CounterDigit5 is
signal COUNT: STD_LOGIC_VECTOR(3 downto 0);
begin
    process(CLK, RST)
        begin
            if RST = '1' then
                COUNT <= (others => '0');
            elsif rising_edge(CLK) then
                if EN = '1' then
                    if UD = '0' then
                        COUNT <= COUNT + 1;
                    else
                        COUNT <= COUNT - 1;
                    end if;
                            
                    if COUNT >= x"5" and UD = '0' then
                        COUNT <= (others => '0');
                    end if;
                    if COUNT = x"0" and UD = '1' then
                        COUNT <= x"5";
                    end if;
                end if;
             end if;
        end process;
    process(COUNT, UD)
        begin
            if UD = '0' then
                if COUNT = x"0" then
                    TC0 <= '1';
                 else
                    TC0 <= '0';
                 end if;
             else
                 if COUNT = x"5" then
                    TC0 <= '1';
                 else
                    TC0 <= '0';
                 end if;
              end if;
        end process;
    
    OUTPUT <= COUNT;
end Behavioral;
