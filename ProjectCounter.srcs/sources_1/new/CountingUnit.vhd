----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 10:30:47 PM
-- Design Name: 
-- Module Name: CountingUnit - Behavioral
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

entity CountingUnit is
    Port(CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         RST: in STD_LOGIC;
         EN: in STD_LOGIC;
         --IMIN: in STD_LOGIC;
         --ISEC: in STD_LOGIC;
         displayed_minutes10: out STD_LOGIC_VECTOR (3 downto 0);
         displayed_minutes01: out STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds10: out STD_LOGIC_VECTOR (3 downto 0);
         displayed_seconds01: out STD_LOGIC_VECTOR (3 downto 0));
end CountingUnit;

architecture Behavioral of CountingUnit is

signal AUX0: STD_LOGIC;
signal AUX1: STD_LOGIC;
signal AUX2: STD_LOGIC;
signal AUX3: STD_LOGIC;
signal AUXISEC: STD_LOGIC;
signal AUXIMIN: STD_LOGIC;
signal AUXCLKMIN: STD_LOGIC;
signal AUXCLKSEC: STD_LOGIC;

component FreqDiv is
    port(CLK: in STD_LOGIC;
         EN: out STD_LOGIC);
end component;

component CounterDigit is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         TC0: out STD_LOGIC;
         OUTPUT: out STD_LOGIC_VECTOR(3 downto 0));  
end component;

component CounterDigit5 is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         TC0: out STD_LOGIC;
         OUTPUT: out STD_LOGIC_VECTOR(3 downto 0));  
end component;
begin
    
    --AUXISEC <= EN or ISEC;
    --AUXIMIN <= EN or IMIN;
    --AUXCLKMIN <= CLK or AUXISEC;
    --AUXCLKSEC <= AUX1 or AUXIMIN;
    
    CS01: CounterDigit port map(RST => RST, CLK => CLK, UD => UD, EN => EN, TC0 => AUX0, OUTPUT => displayed_seconds01);
    CS10: CounterDigit5 port map(RST => RST, CLK => AUX0, UD => UD, EN => EN, TC0 => AUX1, OUTPUT => displayed_seconds10);
    CM01: CounterDigit port map(RST => RST, CLK => AUX1, UD => UD, EN => EN, TC0 => AUX2, OUTPUT => displayed_minutes01);
    CM10: CounterDigit port map(RST => RST, CLK => AUX2, UD => UD, EN => EN, TC0=> AUX3, OUTPUT => displayed_minutes10);

end Behavioral;
