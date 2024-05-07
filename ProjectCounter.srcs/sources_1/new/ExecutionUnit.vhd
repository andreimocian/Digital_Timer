----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2024 11:38:35 PM
-- Design Name: 
-- Module Name: ExecutionUnit - Behavioral
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

entity ExecutionUnit is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         IMIN: in STD_LOGIC;
         ISEC: in STD_LOGIC;
         Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
         LED_out : out STD_LOGIC_VECTOR (6 downto 0));
         ------------------------------------------------------
         --displayed_minutes10: out STD_LOGIC_VECTOR (3 downto 0);
         --displayed_minutes01: out STD_LOGIC_VECTOR (3 downto 0);
         --displayed_seconds10: out STD_LOGIC_VECTOR (3 downto 0);
         --displayed_seconds01: out STD_LOGIC_VECTOR (3 downto 0));
end ExecutionUnit;

architecture Behavioral of ExecutionUnit is
signal CLK_1hz: STD_LOGIC;
signal CLK_EN: STD_LOGIC;
signal AUX_EN: STD_LOGIC;
signal displayed_minutes_temp10: STD_LOGIC_VECTOR (3 downto 0);
signal displayed_minutes_temp01: STD_LOGIC_VECTOR (3 downto 0);
signal displayed_seconds_temp10: STD_LOGIC_VECTOR (3 downto 0);
signal displayed_seconds_temp01: STD_LOGIC_VECTOR (3 downto 0);

    component Debouncer is
    Port ( CLK : in STD_LOGIC;
           button : in STD_LOGIC;
           en : out STD_LOGIC);
    end component;
    
    component FreqDiv is
        port(CLK: in STD_LOGIC;
             EN: out STD_LOGIC);
    end component;
    
    component CountingUnit is
        Port(CLK: in STD_LOGIC;
             UD: in STD_LOGIC;
             RST: in STD_LOGIC;
             EN: in STD_LOGIC;
             IMIN: in STD_LOGIC;
             ISEC: in STD_LOGIC;
             displayed_minutes10: out STD_LOGIC_VECTOR (3 downto 0);
             displayed_minutes01: out STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds10: out STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds01: out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component SevenSegmentDisplay is
        Port(CLK: in STD_LOGIC;
             displayed_minutes10_ssd: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_minutes01_ssd: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds10_ssd: in STD_LOGIC_VECTOR (3 downto 0);
             displayed_seconds01_ssd: in STD_LOGIC_VECTOR (3 downto 0);
             Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
             LED_out : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
begin
    CLK_EN <= CLK_1hz and EN;
    --AUX_EN <= EN or IMIN or ISEC;
    FD1: FreqDiv port map(CLK => CLK, EN => CLK_1hz);
    CU: CountingUnit port map(CLK => CLK_EN, UD => UD, RST => RST, EN => EN, IMIN => IMIN, ISEC => ISEC, displayed_minutes10 => displayed_minutes_temp10, displayed_minutes01 => displayed_minutes_temp01, displayed_seconds10 => displayed_seconds_temp10, displayed_seconds01 => displayed_seconds_temp01);
    SSD: SevenSegmentDisplay port map(CLK => CLK, displayed_minutes10_ssd => displayed_minutes_temp10, displayed_minutes01_ssd => displayed_minutes_temp01, displayed_seconds10_ssd => displayed_seconds_temp10, displayed_seconds01_ssd => displayed_seconds_temp01, Anode_Activate => Anode_Activate, LED_out => LED_out);
    --displayed_minutes10 <= displayed_minutes_temp10;
    --displayed_minutes01 <= displayed_minutes_temp01;
    --displayed_seconds10 <= displayed_seconds_temp10;
    --displayed_seconds01 <= displayed_seconds_temp01;
    
end Behavioral;
