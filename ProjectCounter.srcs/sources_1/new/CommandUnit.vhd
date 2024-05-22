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
         UDIN: in STD_LOGIC;
         ZERO: in STD_LOGIC;
         UD: out STD_LOGIC;
         IMIN: out STD_LOGIC;
         ISEC: out STD_LOGIC;
         RST: out STD_LOGIC;
         EN: out STD_LOGIC;
         ZEROLED: out STD_LOGIC);
end CommandUnit;

architecture Behavioral of CommandUnit is
    signal MINSECXOR: STD_LOGIC;
    signal MINAND: STD_LOGIC;
    signal SECAND: STD_LOGIC;
    
    signal TMPBEN: STD_LOGIC;
    signal TMPMIN: STD_LOGIC;
    signal TMPSEC: STD_LOGIC;
    
    signal TMPRST: STD_LOGIC;
    signal TMPIMIN: STD_LOGIC;
    signal TMPISEC: STD_LOGIC;
    signal TMPEN: STD_LOGIC;
    signal TMPUD: STD_LOGIC;
    signal TMPZERO: STD_LOGIC;
    signal TMPZEROEN: STD_LOGIC;
    --signal NEXTUD: STD_LOGIC;
    
    signal RSTUD: STD_LOGIC;
    signal NOTUD: STD_LOGIC;
    signal IMINSEC: STD_LOGIC;
    signal IMINSECUD: STD_LOGIC;
    signal TFFUDIN: STD_LOGIC;
    signal AUXZERO: STD_LOGIC;
    signal ZEROEX: STD_LOGIC;
    
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
    DBEN: Debouncer port map(CLK => CLK, button => BEN, EN => TMPBEN);
    DBMIN: Debouncer port map(CLK => CLK, button => BMIN, EN => TMPMIN);
    DBSEC: Debouncer port map(CLK => CLK, button => BSEC, EN => TMPSEC);
    DBSTOP: Debouncer port map(CLK => CLK, button => AUXZERO, EN => ZEROEX);
    TFFEN: TFlipFlop port map(CLK => TMPZEROEN, T => TMPZEROEN, Q => TMPEN);
    --TFFUD: TFlipFlop port map(CLK => RSTUD, T => RSTUD, Q => TMPUD);
    
---------------------FOR SIMULATION------------------------
    --TMPBEN <= BEN;
    --TMPMIN <= BMIN;
    --TMPSEC <= BSEC;
-----------------------------------------------------------
      
    MINSECXOR <= TMPMIN xor TMPSEC;
    MINAND <= MINSECXOR and TMPMIN;
    SECAND <= MINSECXOR and TMPSEC;
    
    TMPRST <= BMIN and BSEC;
    TMPUD <= UDIN;
    
    AUXZERO <= ZERO and TMPUD;
    
    TMPZEROEN <= ZEROEX or TMPBEN;
    
    --RSTUD <= TMPRST and TMPUD;
    
--    process(TMPRST, MINAND, SECAND, TMPBEN)
--        variable NEXTUD: STD_LOGIC;
--    begin
--        if TMPRST = '1' then
--            TMPUD <= '0';
--        end if;
--        if MINAND = '1' or SECAND = '1' then
--            NEXTUD := '1';
--        end if;
--        if TMPEN = '1' and NEXTUD = '1' then
--            NEXTUD := '0';
--            TMPUD <= '1';
--        end if;
--    end process;
    
--    process(TMPRST, TMPBEN)
--    begin
--        if TMPRST = '1' then
--            TMPUD <= '0';
--        end if;
--        if TMPBEN = '1' and NEXTUD = '1' then
--            NEXTUD <= '0';
--            TMPUD <= '1';
--        end if;
--    end process;
    
--    process(MINAND, SECAND)
--    begin
--        if rising_edge(MINAND) or rising_edge(SECAND) then
--            NEXTUD <= '1';
--        end if;
--    end process;
        
    --NOTUD <= not TMPUD;
    --IMINSEC <= MINAND or SECAND;
    --IMINSECUD <= NOTUD and IMINSEC;
    --TFFUDIN <= IMINSECUD or RSTUD;
    
    
    EN <= TMPEN;
    IMIN <= MINAND;
    ISEC <= SECAND;
    RST <= TMPRST;
    UD <= TMPUD;
    ZEROLED <= AUXZERO;
        
end Behavioral;