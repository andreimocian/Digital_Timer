library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

    signal TMPEN: STD_LOGIC;
    signal TMPUD: STD_LOGIC;
    signal TMPZEROEN: STD_LOGIC;
    
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

    
    MINSECXOR <= TMPMIN xor TMPSEC;
    MINAND <= MINSECXOR and TMPMIN;
    SECAND <= MINSECXOR and TMPSEC;
    
    TMPRST <= BMIN and BSEC;
    
    TMPUD <= UDIN;
    AUXZERO <= ZERO and TMPUD;
    TMPZEROEN <= ZEROEX or TMPBEN;
        
    EN <= TMPEN;
    IMIN <= MINAND;
    ISEC <= SECAND;
    RST <= TMPRST;
    UD <= TMPUD;
    ZEROLED <= AUXZERO;
end Behavioral;