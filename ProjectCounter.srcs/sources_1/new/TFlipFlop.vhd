library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
