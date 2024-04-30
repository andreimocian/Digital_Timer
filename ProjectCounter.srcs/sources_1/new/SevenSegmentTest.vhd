----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2024 07:57:13 PM
-- Design Name: 
-- Module Name: SevenSegmentTest - Behavioral
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

entity SevenSegmentTest is
    Port(CLK: in STD_LOGIC;
         displayed_minutes10: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_minutes01: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds10: in STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds01: in STD_LOGIC_VECTOR (3 downto 0);
         Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
         LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end SevenSegmentTest;

architecture Behavioral of SevenSegmentTest is

component SevenSegmentDisplay is
        Port(CLK: in STD_LOGIC;
             displayed_minutes10: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_minutes01: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds10: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds01: in STD_LOGIC_VECTOR (3 downto 0);
             Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
             LED_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

begin

    SSD: SevenSegmentDisplay port map(CLK => CLK, displayed_minutes10 => displayed_minutes10, displayed_minutes01 => displayed_minutes01, displayed_seconds10 => displayed_seconds10, displayed_seconds01 => displayed_seconds01, Anode_Activate => Anode_Activate, LED_out => LED_out);

end Behavioral;
