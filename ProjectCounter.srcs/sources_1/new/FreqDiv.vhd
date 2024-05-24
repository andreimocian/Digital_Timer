library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

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
