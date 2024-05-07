----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 05:31:16 PM
-- Design Name: 
-- Module Name: CommandUnit - Behavioral
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

entity CommandUnit is
    Port(CLK: in STD_LOGIC;
         BMIN: in STD_LOGIC;
         BSEC: in STD_LOGIC;
         BEN: in STD_LOGIC;
         UD: out STD_LOGIC;
         IMIN: out STD_LOGIC;
         ISEC: out STD_LOGIC;
         RST: out STD_LOGIC;
         EN: out STD_LOGIC);
end CommandUnit;

architecture Behavioral of CommandUnit is
    signal TMPEN: STD_LOGIC;
    signal TMPMIN: STD_LOGIC;
    signal TMPSEC: STD_LOGIC;
    signal TMPRST: STD_LOGIC;
    
    component Debouncer is
    Port ( CLK : in STD_LOGIC;
           button : in STD_LOGIC;
           en : out STD_LOGIC);
    end component;
    
    component TFlipFlop is
        Port(T: in STD_LOGIC;
             CLK: in STD_LOGIC;
             Q: out STD_LOGIC);
    end component;
begin
    DBEN: Debouncer port map(CLK => CLK, button => BEN, EN => TMPEN);
    DBMIN: Debouncer port map(CLK => CLK, button => BMIN, EN => TMPMIN);
    DBSEC: Debouncer port map(CLK => CLK, button => BSEC, EN => TMPSEC);
    TFFUD: TFlipFlop port map(CLK => TMPEN, T => TMPEN, Q => EN);
    process(BMIN, BSEC)
    begin
        if BMIN = '1' and BSEC = '1' then
            TMPRST <= '1';
         else
            TMPRST <= '0';
         end if;
    end process;
    
    RST <= TMPRST;
    
    
    
--    process(TMPMIN)
--    begin
--        if TMPMIN = '1' then
--            UD <= '1';
--            EN <= '0';
--            IMIN <= '1';
--        else
--            IMIN <= '0';
--        end if;
--    end process;
    
--    process(TMPSEC)
--        begin
--            if TMPSEC = '1' then
--                UD <= '1';
--                EN <= '0';
--                ISEC <= '1';
--            else
--                ISEC <= '0';
--            end if;
--        end process;
    
end Behavioral;
