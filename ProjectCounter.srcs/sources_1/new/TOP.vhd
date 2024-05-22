----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2024 11:38:35 PM
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    Port(CLK: in STD_LOGIC;
         BMIN: in STD_LOGIC;
         BSEC: in STD_LOGIC;
         BEN: in STD_LOGIC;
         UDIN: in STD_LOGIC;
         ZEROLED: out STD_LOGIC;
         Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
         LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

signal AUXUD: STD_LOGIC;
signal AUXIMIN: STD_LOGIC;
signal AUXISEC: STD_LOGIC;
signal AUXRST: STD_LOGIC;
signal AUXEN: STD_LOGIC;
signal AUXZERO: STD_LOGIC;

component CommandUnit is
    Port(CLK: in STD_LOGIC;
         BMIN: in STD_LOGIC;
         BSEC: in STD_LOGIC;
         BEN: in STD_LOGIC;
         UDIN: in STD_LOGIC;
         ZERO: in STD_LOGIC;
         UD: out STD_LOGIC;
         IMIN: out STD_LOGIC;
         ISEC: out STD_LOGIC;
         RST: out STD_LOGIC;
         EN: out STD_LOGIC;
         ZEROLED: out STD_LOGIC);
end component;

component ExecutionUnit is
    port(RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
         UD: in STD_LOGIC;
         EN: in STD_LOGIC;
         IMIN: in STD_LOGIC;
         ISEC: in STD_LOGIC;
         ZERO: out STD_LOGIC;
         Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
         LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end component;

begin

    CU: CommandUnit port map(CLK => CLK, BMIN => BMIN, BSEC => BSEC, BEN => BEN, UDIN => UDIN, ZERO => AUXZERO, UD => AUXUD, IMIN => AUXIMIN, ISEC => AUXISEC, RST => AUXRST, EN => AUXEN, ZEROLED => ZEROLED);
    EU: ExecutionUnit port map(RST => AUXRST, CLK => CLK, UD => AUXUD, EN => AUXEN, IMIN => AUXIMIN, ISEC => AUXISEC, ZERO => AUXZERO, Anode_Activate => Anode_Activate, LED_out => LED_out);
    
end Behavioral;
