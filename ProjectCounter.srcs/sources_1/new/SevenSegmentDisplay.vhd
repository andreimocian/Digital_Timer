library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity SevenSegmentDisplay is
    Port(CLK: in STD_LOGIC;
         displayed_minutes10_ssd: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_minutes01_ssd: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds10_ssd: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds01_ssd: in STD_LOGIC_VECTOR (3 downto 0);
         Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
         LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end SevenSegmentDisplay;

architecture Behavioral of SevenSegmentDisplay is
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
    signal refresh_counter: STD_LOGIC_VECTOR (16 downto 0);
signal LED_activating_counter: std_logic_vector(1 downto 0);
begin
    process(LED_BCD)
    begin
        case LED_BCD is
            when "0000" => LED_out <= "0000001"; -- "0"     
            when "0001" => LED_out <= "1001111"; -- "1" 
            when "0010" => LED_out <= "0010010"; -- "2" 
            when "0011" => LED_out <= "0000110"; -- "3" 
            when "0100" => LED_out <= "1001100"; -- "4" 
            when "0101" => LED_out <= "0100100"; -- "5" 
            when "0110" => LED_out <= "0100000"; -- "6" 
            when "0111" => LED_out <= "0001111"; -- "7" 
            when "1000" => LED_out <= "0000000"; -- "8"     
            when "1001" => LED_out <= "0000100"; -- "9" 
            when others =>
        end case;
    end process;
    
    process(CLK)
    begin 
        if CLK = '1' and CLK'EVENT then
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;
    LED_activating_counter <= refresh_counter(16 downto 15);

    process(LED_activating_counter)
    begin
        case LED_activating_counter is
            when "00" =>
                Anode_Activate <= "0111"; 
                LED_BCD <= displayed_minutes10_ssd(3 downto 0);
            when "01" =>
                Anode_Activate <= "1011"; 
                LED_BCD <= displayed_minutes01_ssd(3 downto 0);
            when "10" =>
                Anode_Activate <= "1101"; 
                LED_BCD <= displayed_seconds10_ssd(3 downto 0);
            when "11" =>
                Anode_Activate <= "1110"; 
                LED_BCD <= displayed_seconds01_ssd(3 downto 0);  
            when others => 
            end case;
    end process;
end Behavioral;
