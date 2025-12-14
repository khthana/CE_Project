------------------------------------------------------------------------
-------------------------------------------------------------------------
--                                                                     --
--                     -----   NOTICE   -----                          --
--                                                                     --
-- (C) Copyright 1991 - 1996 Exemplar Logic, Inc. All Rights Reserved. --
--                                                                     --
--     This library source belongs to Exemplar Logic, Inc.             --
--     It is considered trade secret and is not to be divulged         --
--     or used by parties who have not received written                --
--     authorization from the owner, Exemplar Logic, Inc.              --
--                                                                     --
--     This restriction applies to any libraries derived from          --
--     this information and also to the compiled form of this          --
--     and derivative libraries.                                       --
--                                                                     --
--     This notice must be maintained in all copies of this            --
--     file and in all source copies of derivative libraries.          --
--                                                                     --
--                                                                     --
-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------
--      **** DISCLAIMER ****                                           --
--                                                                     --
--  This VITAL library source file is intended for use with Model      --
--  Technology's V-System VHDL simulator.                              --
--  Exemplar Logic cannot  be responsible for any changes the          --
--  customer makes to this source file.                                --
--                                                                     --
-------------------------------------------------------------------------
-------------------------------------------------------------------------


--
-- CELL VERSION
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity VERSION is
begin
	assert FALSE report "Vital 95 library Version is sccs_id = 1.3" severity NOTE;
end VERSION;

architecture EXEMPLAR of VERSION is
begin
end EXEMPLAR;


--
-- CELL VDD
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity VDD is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( O : out std_logic);
    attribute VITAL_LEVEL0 of VDD : entity is TRUE;
end VDD ;

architecture Behavior of VDD is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O <= '1';
end Behavior;

--
-- CELL GND
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity GND is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( O : out std_logic);
    attribute VITAL_LEVEL0 of GND : entity is TRUE;
end GND ;
 
architecture Behavior of GND is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O <= '0';
end Behavior;

 
--
-- CELL PULLUP
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity PULLUP is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( O : out std_logic);
    attribute VITAL_LEVEL0 of PULLUP : entity is TRUE;
end PULLUP ;
 
architecture Behavior of PULLUP is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O <= 'H';
end Behavior;
 
--
-- CELL PULLDN
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity PULLDN is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( O : out std_logic);
    attribute VITAL_LEVEL0 of PULLDN : entity is TRUE;
end PULLDN ;
 
architecture Behavior of PULLDN is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O <= 'L';
end Behavior;
 
--
-- CELL BUF
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity BUF is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of BUF : entity is TRUE;
end BUF ;

architecture Behavior of BUF is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;

    VitalBehavior : process ( I_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
                  PathDelay => tpd_I_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL INV
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity INV is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of INV : entity is TRUE;
end INV ;

architecture Behavior of INV is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;

    VitalBehavior : process ( I_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalINV(I_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
                  PathDelay => tpd_I_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NAND5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NAND5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NAND5 : entity is TRUE;
end NAND5 ;

architecture Behavior of NAND5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NAND5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '-', '1'),
            ('-', '-', '0', '-', '-', '1'),
            ('-', '-', '-', '0', '-', '1'),
            ('-', '-', '-', '-', '0', '1'),
            ('1', '1', '1', '1', '1', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NAND5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NAND4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NAND4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NAND4 : entity is TRUE;
end NAND4 ;

architecture Behavior of NAND4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NAND4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '1'),
            ('-', '-', '0', '-', '1'),
            ('-', '-', '-', '0', '1'),
            ('1', '1', '1', '1', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NAND4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NAND3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NAND3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NAND3 : entity is TRUE;
end NAND3 ;

architecture Behavior of NAND3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NAND3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '-', '-', '1'),
            ('-', '0', '-', '1'),
            ('-', '-', '0', '1'),
            ('1', '1', '1', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NAND3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NAND2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NAND2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NAND2 : entity is TRUE;
end NAND2 ;

architecture Behavior of NAND2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NAND2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '-', '1'),
            ('-', '0', '1'),
            ('1', '1', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NAND2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5 : entity is TRUE;
end AND5 ;

architecture Behavior of AND5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('1', '1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND4 : entity is TRUE;
end AND4 ;

architecture Behavior of AND4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '0'),
            ('-', '-', '0', '-', '0'),
            ('-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND3 : entity is TRUE;
end AND3 ;

architecture Behavior of AND3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('1', '1', '1', '1'),
            ('0', '-', '-', '0'),
            ('-', '0', '-', '0'),
            ('-', '-', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND2 : entity is TRUE;
end AND2 ;

architecture Behavior of AND2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('1', '1', '1'),
            ('0', '-', '0'),
            ('-', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5B5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5B5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5B5 : entity is TRUE;
end AND5B5 ;

architecture Behavior of AND5B5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5B5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '0', '0', '0', '0', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '-', '0'),
            ('-', '-', '1', '-', '-', '0'),
            ('-', '-', '-', '1', '-', '0'),
            ('-', '-', '-', '-', '1', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5B5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5B4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5B4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5B4 : entity is TRUE;
end AND5B4 ;

architecture Behavior of AND5B4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5B4_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '0', '0', '0', '1', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '-', '0'),
            ('-', '-', '1', '-', '-', '0'),
            ('-', '-', '-', '1', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5B4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5B3 : entity is TRUE;
end AND5B3 ;

architecture Behavior of AND5B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5B3_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '0', '0', '1', '1', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '-', '0'),
            ('-', '-', '1', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5B2 : entity is TRUE;
end AND5B2 ;

architecture Behavior of AND5B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5B2_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '0', '1', '1', '1', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND5B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND5B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND5B1 : entity is TRUE;
end AND5B1 ;

architecture Behavior of AND5B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND5B1_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '1', '1', '1', '1', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND5B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND4B4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND4B4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND4B4 : entity is TRUE;
end AND4B4 ;

architecture Behavior of AND4B4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND4B4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '0', '0', '0', '1'),
            ('1', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '0'),
            ('-', '-', '1', '-', '0'),
            ('-', '-', '-', '1', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND4B4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND4B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND4B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND4B3 : entity is TRUE;
end AND4B3 ;

architecture Behavior of AND4B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND4B3_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '0', '0', '1', '1'),
            ('1', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '0'),
            ('-', '-', '1', '-', '0'),
            ('-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND4B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND4B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND4B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND4B2 : entity is TRUE;
end AND4B2 ;

architecture Behavior of AND4B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND4B2_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '0', '1', '1', '1'),
            ('1', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '0'),
            ('-', '-', '0', '-', '0'),
            ('-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND4B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND4B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND4B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND4B1 : entity is TRUE;
end AND4B1 ;

architecture Behavior of AND4B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND4B1_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '1', '1', '1', '1'),
            ('1', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '0'),
            ('-', '-', '0', '-', '0'),
            ('-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND4B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND3B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND3B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND3B3 : entity is TRUE;
end AND3B3 ;

architecture Behavior of AND3B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND3B3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '0', '0', '1'),
            ('1', '-', '-', '0'),
            ('-', '1', '-', '0'),
            ('-', '-', '1', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND3B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND3B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND3B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND3B2 : entity is TRUE;
end AND3B2 ;

architecture Behavior of AND3B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND3B2_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '0', '1', '1'),
            ('1', '-', '-', '0'),
            ('-', '1', '-', '0'),
            ('-', '-', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND3B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND3B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND3B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND3B1 : entity is TRUE;
end AND3B1 ;

architecture Behavior of AND3B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND3B1_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '1', '1', '1'),
            ('1', '-', '-', '0'),
            ('-', '0', '-', '0'),
            ('-', '-', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND3B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND2B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND2B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND2B2 : entity is TRUE;
end AND2B2 ;

architecture Behavior of AND2B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND2B2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '0', '1'),
            ('1', '-', '0'),
            ('-', '1', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND2B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL AND2B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity AND2B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of AND2B1 : entity is TRUE;
end AND2B1 ;

architecture Behavior of AND2B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT AND2B1_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '1', '1'),
            ('1', '-', '0'),
            ('-', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => AND2B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NOR5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NOR5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NOR5 : entity is TRUE;
end NOR5 ;

architecture Behavior of NOR5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NOR5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '0', '0', '0', '0', '1'),
            ('1', '-', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '-', '0'),
            ('-', '-', '1', '-', '-', '0'),
            ('-', '-', '-', '1', '-', '0'),
            ('-', '-', '-', '-', '1', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NOR5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NOR4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NOR4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NOR4 : entity is TRUE;
end NOR4 ;

architecture Behavior of NOR4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NOR4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '0', '0', '0', '1'),
            ('1', '-', '-', '-', '0'),
            ('-', '1', '-', '-', '0'),
            ('-', '-', '1', '-', '0'),
            ('-', '-', '-', '1', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NOR4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NOR3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NOR3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NOR3 : entity is TRUE;
end NOR3 ;

architecture Behavior of NOR3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NOR3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '0', '0', '1'),
            ('1', '-', '-', '0'),
            ('-', '1', '-', '0'),
            ('-', '-', '1', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NOR3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL NOR2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity NOR2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of NOR2 : entity is TRUE;
end NOR2 ;

architecture Behavior of NOR2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT NOR2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '0', '1'),
            ('1', '-', '0'),
            ('-', '1', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => NOR2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5 : entity is TRUE;
end OR5 ;

architecture Behavior of OR5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('1', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR4 : entity is TRUE;
end OR4 ;

architecture Behavior of OR4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('1', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '1'),
            ('-', '-', '1', '-', '1'),
            ('-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR3 : entity is TRUE;
end OR3 ;

architecture Behavior of OR3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('1', '-', '-', '1'),
            ('-', '1', '-', '1'),
            ('-', '-', '1', '1'),
            ('0', '0', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR2 : entity is TRUE;
end OR2 ;

architecture Behavior of OR2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('1', '-', '1'),
            ('-', '1', '1'),
            ('0', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5B5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5B5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5B5 : entity is TRUE;
end OR5B5 ;

architecture Behavior of OR5B5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5B5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '-', '1'),
            ('-', '-', '0', '-', '-', '1'),
            ('-', '-', '-', '0', '-', '1'),
            ('-', '-', '-', '-', '0', '1'),
            ('1', '1', '1', '1', '1', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5B5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5B4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5B4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5B4 : entity is TRUE;
end OR5B4 ;

architecture Behavior of OR5B4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5B4_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '-', '1'),
            ('-', '-', '0', '-', '-', '1'),
            ('-', '-', '-', '0', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('1', '1', '1', '1', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5B4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5B3 : entity is TRUE;
end OR5B3 ;

architecture Behavior of OR5B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5B3_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '-', '1'),
            ('-', '-', '0', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('1', '1', '1', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5B2 : entity is TRUE;
end OR5B2 ;

architecture Behavior of OR5B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5B2_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('1', '1', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR5B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR5B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR5B1 : entity is TRUE;
end OR5B1 ;

architecture Behavior of OR5B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR5B1_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('0', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('1', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR5B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR4B4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR4B4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR4B4 : entity is TRUE;
end OR4B4 ;

architecture Behavior of OR4B4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR4B4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '1'),
            ('-', '-', '0', '-', '1'),
            ('-', '-', '-', '0', '1'),
            ('1', '1', '1', '1', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR4B4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR4B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR4B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR4B3 : entity is TRUE;
end OR4B3 ;

architecture Behavior of OR4B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR4B3_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '1'),
            ('-', '-', '0', '-', '1'),
            ('-', '-', '-', '1', '1'),
            ('1', '1', '1', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR4B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR4B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR4B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR4B2 : entity is TRUE;
end OR4B2 ;

architecture Behavior of OR4B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR4B2_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '-', '-', '-', '1'),
            ('-', '0', '-', '-', '1'),
            ('-', '-', '1', '-', '1'),
            ('-', '-', '-', '1', '1'),
            ('1', '1', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR4B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR4B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR4B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR4B1 : entity is TRUE;
end OR4B1 ;

architecture Behavior of OR4B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR4B1_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('0', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '1'),
            ('-', '-', '1', '-', '1'),
            ('-', '-', '-', '1', '1'),
            ('1', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR4B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR3B3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR3B3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR3B3 : entity is TRUE;
end OR3B3 ;

architecture Behavior of OR3B3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR3B3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '-', '-', '1'),
            ('-', '0', '-', '1'),
            ('-', '-', '0', '1'),
            ('1', '1', '1', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR3B3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR3B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR3B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR3B2 : entity is TRUE;
end OR3B2 ;

architecture Behavior of OR3B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR3B2_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '-', '-', '1'),
            ('-', '0', '-', '1'),
            ('-', '-', '1', '1'),
            ('1', '1', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR3B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR3B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR3B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR3B1 : entity is TRUE;
end OR3B1 ;

architecture Behavior of OR3B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR3B1_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('0', '-', '-', '1'),
            ('-', '1', '-', '1'),
            ('-', '-', '1', '1'),
            ('1', '0', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR3B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR2B2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR2B2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR2B2 : entity is TRUE;
end OR2B2 ;

architecture Behavior of OR2B2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR2B2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '-', '1'),
            ('-', '0', '1'),
            ('1', '1', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR2B2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL OR2B1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OR2B1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OR2B1 : entity is TRUE;
end OR2B1 ;

architecture Behavior of OR2B1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT OR2B1_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('0', '-', '1'),
            ('-', '1', '1'),
            ('1', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => OR2B1_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XNOR5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XNOR5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XNOR5 : entity is TRUE;
end XNOR5 ;

architecture Behavior of XNOR5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XNOR5_0_tab : VitalTruthTableType (0 to 32, 0 to 5) := (
            ('0', '1', '1', '1', '1', '1'),
            ('1', '0', '1', '1', '1', '1'),
            ('1', '1', '0', '1', '1', '1'),
            ('0', '0', '0', '1', '1', '1'),
            ('1', '1', '1', '0', '1', '1'),
            ('0', '0', '1', '0', '1', '1'),
            ('0', '1', '0', '0', '1', '1'),
            ('1', '0', '0', '0', '1', '1'),
            ('1', '1', '1', '1', '0', '1'),
            ('0', '0', '1', '1', '0', '1'),
            ('0', '1', '0', '1', '0', '1'),
            ('1', '0', '0', '1', '0', '1'),
            ('0', '1', '1', '0', '0', '1'),
            ('1', '0', '1', '0', '0', '1'),
            ('1', '1', '0', '0', '0', '1'),
            ('0', '0', '0', '0', '0', '1'),
            ('1', '1', '1', '1', '1', '0'),
            ('0', '0', '1', '1', '1', '0'),
            ('0', '1', '0', '1', '1', '0'),
            ('1', '0', '0', '1', '1', '0'),
            ('0', '1', '1', '0', '1', '0'),
            ('1', '0', '1', '0', '1', '0'),
            ('1', '1', '0', '0', '1', '0'),
            ('0', '0', '0', '0', '1', '0'),
            ('0', '1', '1', '1', '0', '0'),
            ('1', '0', '1', '1', '0', '0'),
            ('1', '1', '0', '1', '0', '0'),
            ('0', '0', '0', '1', '0', '0'),
            ('1', '1', '1', '0', '0', '0'),
            ('0', '0', '1', '0', '0', '0'),
            ('0', '1', '0', '0', '0', '0'),
            ('1', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XNOR5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XNOR4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XNOR4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XNOR4 : entity is TRUE;
end XNOR4 ;

architecture Behavior of XNOR4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XNOR4_0_tab : VitalTruthTableType (0 to 16, 0 to 4) := (
            ('1', '1', '1', '1', '1'),
            ('0', '0', '1', '1', '1'),
            ('0', '1', '0', '1', '1'),
            ('1', '0', '0', '1', '1'),
            ('0', '1', '1', '0', '1'),
            ('1', '0', '1', '0', '1'),
            ('1', '1', '0', '0', '1'),
            ('0', '0', '0', '0', '1'),
            ('0', '1', '1', '1', '0'),
            ('1', '0', '1', '1', '0'),
            ('1', '1', '0', '1', '0'),
            ('0', '0', '0', '1', '0'),
            ('1', '1', '1', '0', '0'),
            ('0', '0', '1', '0', '0'),
            ('0', '1', '0', '0', '0'),
            ('1', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XNOR4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XNOR3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XNOR3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XNOR3 : entity is TRUE;
end XNOR3 ;

architecture Behavior of XNOR3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XNOR3_0_tab : VitalTruthTableType (0 to 8, 0 to 3) := (
            ('0', '1', '1', '1'),
            ('1', '0', '1', '1'),
            ('1', '1', '0', '1'),
            ('0', '0', '0', '1'),
            ('1', '1', '1', '0'),
            ('0', '0', '1', '0'),
            ('0', '1', '0', '0'),
            ('1', '0', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XNOR3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XNOR2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XNOR2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XNOR2 : entity is TRUE;
end XNOR2 ;

architecture Behavior of XNOR2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XNOR2_0_tab : VitalTruthTableType (0 to 4, 0 to 2) := (
            ('1', '1', '1'),
            ('0', '0', '1'),
            ('0', '1', '0'),
            ('1', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XNOR2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XNOR1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XNOR1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XNOR1 : entity is TRUE;
end XNOR1 ;

architecture Behavior of XNOR1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
    end block;

    VitalBehavior : process ( I0_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I0_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XOR5
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XOR5 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I4_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3, I4 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XOR5 : entity is TRUE;
end XOR5 ;

architecture Behavior of XOR5 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
    signal I4_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
        VitalWireDelay(I4_ipd, I4, tipd_I4);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XOR5_0_tab : VitalTruthTableType (0 to 32, 0 to 5) := (
            ('1', '1', '1', '1', '1', '1'),
            ('0', '0', '1', '1', '1', '1'),
            ('0', '1', '0', '1', '1', '1'),
            ('1', '0', '0', '1', '1', '1'),
            ('0', '1', '1', '0', '1', '1'),
            ('1', '0', '1', '0', '1', '1'),
            ('1', '1', '0', '0', '1', '1'),
            ('0', '0', '0', '0', '1', '1'),
            ('0', '1', '1', '1', '0', '1'),
            ('1', '0', '1', '1', '0', '1'),
            ('1', '1', '0', '1', '0', '1'),
            ('0', '0', '0', '1', '0', '1'),
            ('1', '1', '1', '0', '0', '1'),
            ('0', '0', '1', '0', '0', '1'),
            ('0', '1', '0', '0', '0', '1'),
            ('1', '0', '0', '0', '0', '1'),
            ('0', '1', '1', '1', '1', '0'),
            ('1', '0', '1', '1', '1', '0'),
            ('1', '1', '0', '1', '1', '0'),
            ('0', '0', '0', '1', '1', '0'),
            ('1', '1', '1', '0', '1', '0'),
            ('0', '0', '1', '0', '1', '0'),
            ('0', '1', '0', '0', '1', '0'),
            ('1', '0', '0', '0', '1', '0'),
            ('1', '1', '1', '1', '0', '0'),
            ('0', '0', '1', '1', '0', '0'),
            ('0', '1', '0', '1', '0', '0'),
            ('1', '0', '0', '1', '0', '0'),
            ('0', '1', '1', '0', '0', '0'),
            ('1', '0', '1', '0', '0', '0'),
            ('1', '1', '0', '0', '0', '0'),
            ('0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XOR5_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd, I4_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE),
            4 => (InputChangeTime => I4_ipd'LAST_EVENT,
                  PathDelay => tpd_I4_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XOR4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XOR4 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I3_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2, I3 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XOR4 : entity is TRUE;
end XOR4 ;

architecture Behavior of XOR4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
    signal I3_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
        VitalWireDelay(I3_ipd, I3, tipd_I3);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd, I3_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XOR4_0_tab : VitalTruthTableType (0 to 16, 0 to 4) := (
            ('0', '1', '1', '1', '1'),
            ('1', '0', '1', '1', '1'),
            ('1', '1', '0', '1', '1'),
            ('0', '0', '0', '1', '1'),
            ('1', '1', '1', '0', '1'),
            ('0', '0', '1', '0', '1'),
            ('0', '1', '0', '0', '1'),
            ('1', '0', '0', '0', '1'),
            ('1', '1', '1', '1', '0'),
            ('0', '0', '1', '1', '0'),
            ('0', '1', '0', '1', '0'),
            ('1', '0', '0', '1', '0'),
            ('0', '1', '1', '0', '0'),
            ('1', '0', '1', '0', '0'),
            ('1', '1', '0', '0', '0'),
            ('0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XOR4_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd, I3_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE),
            3 => (InputChangeTime => I3_ipd'LAST_EVENT,
                  PathDelay => tpd_I3_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XOR3
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XOR3 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I2_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1, I2 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XOR3 : entity is TRUE;
end XOR3 ;

architecture Behavior of XOR3 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
    signal I2_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
        VitalWireDelay(I2_ipd, I2, tipd_I2);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd, I2_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XOR3_0_tab : VitalTruthTableType (0 to 8, 0 to 3) := (
            ('1', '1', '1', '1'),
            ('0', '0', '1', '1'),
            ('0', '1', '0', '1'),
            ('1', '0', '0', '1'),
            ('0', '1', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '1', '0', '0'),
            ('0', '0', '0', '0'),
            ('B', 'B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XOR3_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd, I2_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE),
            2 => (InputChangeTime => I2_ipd'LAST_EVENT,
                  PathDelay => tpd_I2_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XOR2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XOR2 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_I1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I1_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0, I1 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XOR2 : entity is TRUE;
end XOR2 ;

architecture Behavior of XOR2 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
    signal I1_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
        VitalWireDelay(I1_ipd, I1, tipd_I1);
    end block;

    VitalBehavior : process ( I0_ipd, I1_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        CONSTANT XOR2_0_tab : VitalTruthTableType (0 to 4, 0 to 2) := (
            ('0', '1', '1'),
            ('1', '0', '1'),
            ('1', '1', '0'),
            ('0', '0', '0'),
            ('B', 'B', '0'));
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalTruthTable(TruthTable => XOR2_0_tab,
        DataIn => std_logic_vector'( I0_ipd, I1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE),
            1 => (InputChangeTime => I1_ipd'LAST_EVENT,
                  PathDelay => tpd_I1_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL XOR1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity XOR1 is
    generic (
        tipd_I0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I0_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        I0 : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of XOR1 : entity is TRUE;
end XOR1 ;

architecture Behavior of XOR1 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal I0_ipd  : std_logic := 'X';
begin

    WireDelay : block
    begin
        VitalWireDelay(I0_ipd, I0, tipd_I0);
    end block;

    VitalBehavior : process ( I0_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
    begin

        IF (TimingChecksOn) THEN
        -----------------------------------
        -- No Timing Checks for a comb gate
        -----------------------------------
        END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I0_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I0_ipd'LAST_EVENT,
                  PathDelay => tpd_I0_O,
                  PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL IBUF
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity IBUF is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of IBUF : entity is TRUE;
end IBUF ;

architecture Behavior of IBUF is
    signal I_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;

    VitalBehavior : process ( I_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => tpd_I_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL OBUF
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OBUF is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I, GTS : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OBUF : entity is TRUE;
end OBUF ;

architecture Behavior of OBUF is
    signal I_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( I_ipd, GTS_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUFIF0(I_ipd, GTS_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_I_O),
              PathCondition => TRUE),
            1 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL OBUFT
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OBUFT is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_T  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_T_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I, T, GTS : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OBUFT : entity is TRUE;
end OBUFT ;

architecture Behavior of OBUFT is
    signal I_ipd  : std_logic := 'X';
    signal T_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
        VitalWireDelay(T_ipd, T, tipd_T);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( I_ipd, T_ipd, GTS_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
        VARIABLE E_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    E_res := VitalNOR2(GTS_ipd, T_ipd);
    O_res := VitalBUFIF1(I_ipd, E_res);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_I_O),
              PathCondition => TRUE),
            1 => (InputChangeTime => T_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_T_O),
              PathCondition => TRUE),
            2 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL OUTFF
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OUTFF is
    generic (
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        C, D, GSR, GTS : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of OUTFF : entity is TRUE;
end OUTFF ;

architecture Behavior of OUTFF is
    signal C_ipd  : std_logic := 'X';
    signal D_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( C_ipd, D_ipd, GSR_ipd, GTS_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE Tviol_GTS : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        VARIABLE Q_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "OUTFF",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
        Q_res := VitalBUFIF0(Results(1), GTS_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_C_Q),
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GSR_Q),
              PathCondition => TRUE),
            2 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_Q),
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL BUFGS
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity BUFGS is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of BUFGS : entity is TRUE;
end BUFGS ;
 
architecture Behavior of BUFGS is
    signal I_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
 
    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;
 
    VitalBehavior : process ( I_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
 
    begin
 
    IF (TimingChecksOn) THEN
    END IF;
 
   -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I_ipd);
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
 
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => tpd_I_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;
 
--
-- CELL BUFGP
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity BUFGP is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of BUFGP : entity is TRUE;
end BUFGP ;
 
architecture Behavior of BUFGP is
    signal I_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
 
    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;
 
    VitalBehavior : process ( I_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
 
    begin
 
    IF (TimingChecksOn) THEN
    END IF;
 
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I_ipd);
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
 
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => tpd_I_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;
 
 
--
-- CELL BUFG
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity BUFG is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of BUFG : entity is TRUE;
end BUFG ;
 
architecture Behavior of BUFG is
    signal I_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
 
    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;
 
    VitalBehavior : process ( I_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
 
    begin
 
    IF (TimingChecksOn) THEN
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUF(I_ipd);
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
 
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => tpd_I_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL OFD
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OFD is
    generic (
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        C, D, GSR, GTS : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of OFD : entity is TRUE;
end OFD ;

architecture Behavior of OFD is
    signal C_ipd  : std_logic := 'X';
    signal D_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( C_ipd, D_ipd, GSR_ipd, GTS_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE Tviol_GTS : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        VARIABLE Q_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "OFD",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
        Q_res := VitalBUFIF0(Results(1), GTS_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_C_Q),
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GSR_Q),
              PathCondition => TRUE),
            2 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_Q),
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL OFDI
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OFDI is
    generic (
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        C, D, GSR, GTS : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of OFDI : entity is TRUE;
end OFDI ;

architecture Behavior of OFDI is
    signal C_ipd  : std_logic := 'X';
    signal D_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( C_ipd, D_ipd, GSR_ipd, GTS_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE Tviol_GTS : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        VARIABLE Q_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "OFDI",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, '0', GSR_ipd, '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
        Q_res := VitalBUFIF0(Results(1), GTS_ipd);
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_C_Q),
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GSR_Q),
              PathCondition => TRUE),
            2 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_Q),
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL OFDT
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OFDT is
    generic (
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_T  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_T_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        C, D, T, GSR, GTS : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OFDT : entity is TRUE;
end OFDT ;

architecture Behavior of OFDT is
    signal C_ipd  : std_logic := 'X';
    signal D_ipd  : std_logic := 'X';
    signal T_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(T_ipd, T, tipd_T);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( C_ipd, D_ipd, T_ipd, GSR_ipd, GTS_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_T : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE Tviol_GTS : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res : std_logic := 'X';
        VARIABLE E_res : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "OFDT",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
        E_res := VitalNOR2(T_ipd, GTS_ipd);
        O_res := VitalBUFIF1(Results(1), E_res);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_C_O),
              PathCondition => TRUE),
            1 => (InputChangeTime => T_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_T_O),
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GSR_O),
              PathCondition => TRUE),
            3 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL OFDTI
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity OFDTI is
    generic (
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_T  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_T_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GTS  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GTS_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        C, D, T, GSR, GTS : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of OFDTI : entity is TRUE;
end OFDTI ;

architecture Behavior of OFDTI is
    signal C_ipd  : std_logic := 'X';
    signal D_ipd  : std_logic := 'X';
    signal T_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    signal GTS_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(T_ipd, T, tipd_T);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
        VitalWireDelay(GTS_ipd, GTS, tipd_GTS);
    end block;

    VitalBehavior : process ( C_ipd, D_ipd, T_ipd, GSR_ipd, GTS_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_T : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE Tviol_GTS : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
        VARIABLE E_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "OFDTI",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, '0', GSR_ipd, '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
        E_res := VitalNOR2(T_ipd, GTS_ipd);
        O_res := VitalBUFIF1(Results(1), E_res);


    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_C_O),
              PathCondition => TRUE),
            1 => (InputChangeTime => T_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_T_O),
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GSR_O),
              PathCondition => TRUE),
            3 => (InputChangeTime => GTS_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_GTS_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL IFD
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity IFD is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, C, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of IFD : entity is TRUE;
end IFD ;

architecture Behavior of IFD is
    signal D_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, C_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "IFD",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL IFDI
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity IFDI is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, C, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of IFDI : entity is TRUE;
end IFDI ;

architecture Behavior of IFDI is
    signal D_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, C_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "IFDI",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, '0', GSR_ipd, '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL INLAT
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity INLAT is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        tsetup_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tpd_D_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_G  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_G_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, G, GSR : in std_logic;
        O, Q : out std_logic);
    attribute VITAL_LEVEL0 of INLAT : entity is TRUE;
end INLAT ;

architecture Behavior of INLAT is
    signal D_ipd  : std_logic := 'X';
    signal G_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(G_ipd, G, tipd_G);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, G_ipd, GSR_ipd)


        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_G : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => G_ipd,
            RefSignalName  => "G",
            SetupHigh      => tsetup_D_G_noedge_POSEDGE,
            SetupLow       => tsetup_D_G_noedge_NEGEDGE,
            HoldHigh       => thold_D_G_noedge_POSEDGE,
            HoldLow        => thold_D_G_noedge_NEGEDGE,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "INLAT",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_G);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

	O_res := VitalBUF(D_ipd);
        VitalStateTable(StateTable => LATCH0_table,
            DataIn => (violation, G_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => D_ipd'LAST_EVENT,
              PathDelay => tpd_D_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => G_ipd'LAST_EVENT,
              PathDelay => tpd_G_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL ILD_1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity ILD_1 is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        tsetup_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_G  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_G_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, G, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of ILD_1 : entity is TRUE;
end ILD_1 ;

architecture Behavior of ILD_1 is
    signal D_ipd  : std_logic := 'X';
    signal G_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(G_ipd, G, tipd_G);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, G_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_G : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => G_ipd,
            RefSignalName  => "G",
            SetupHigh      => tsetup_D_G_noedge_POSEDGE,
            SetupLow       => tsetup_D_G_noedge_NEGEDGE,
            HoldHigh       => thold_D_G_noedge_POSEDGE,
            HoldLow        => thold_D_G_noedge_NEGEDGE,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "ILD_1",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_G);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => LATCH0_table,
            DataIn => (violation, G_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => G_ipd'LAST_EVENT,
              PathDelay => tpd_G_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL ILD
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity ILD is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tsetup_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        tipd_G  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_G_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, G : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of ILD : entity is TRUE;
end ILD ;

architecture Behavior of ILD is
    signal D_ipd  : std_logic := 'X';
    signal G_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(G_ipd, G, tipd_G);
    end block;

    VitalBehavior : process ( D_ipd, G_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_G : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => G_ipd,
            RefSignalName  => "G",
            SetupHigh      => tsetup_D_G_noedge_POSEDGE,
            SetupLow       => tsetup_D_G_noedge_NEGEDGE,
            HoldHigh       => thold_D_G_noedge_POSEDGE,
            HoldLow        => thold_D_G_noedge_NEGEDGE,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '\',
            Violation      => Tviol_D,
            HeaderMsg      => "ILD",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_G);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => LATCH1_table,
            DataIn => (violation, G_ipd, '0', '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => G_ipd'LAST_EVENT,
              PathDelay => tpd_G_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL ILDI
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity ILDI is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tsetup_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        tipd_G  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_G_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, G : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of ILDI : entity is TRUE;
end ILDI ;

architecture Behavior of ILDI is
    signal D_ipd  : std_logic := 'X';
    signal G_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(G_ipd, G, tipd_G);
    end block;

    VitalBehavior : process ( D_ipd, G_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_G : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => G_ipd,
            RefSignalName  => "G",
            SetupHigh      => tsetup_D_G_noedge_POSEDGE,
            SetupLow       => tsetup_D_G_noedge_NEGEDGE,
            HoldHigh       => thold_D_G_noedge_POSEDGE,
            HoldLow        => thold_D_G_noedge_NEGEDGE,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '\',
            Violation      => Tviol_D,
            HeaderMsg      => "ILDI",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_G);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => LATCH1_table,
            DataIn => (violation, G_ipd, '0', '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => G_ipd'LAST_EVENT,
              PathDelay => tpd_G_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL ILDI_1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity ILDI_1 is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_NEGEDGE : VitalDelayType := 0 ns ;
        tsetup_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_G_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_G  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_G_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, G, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of ILDI_1 : entity is TRUE;
end ILDI_1 ;

architecture Behavior of ILDI_1 is
    signal D_ipd  : std_logic := 'X';
    signal G_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(G_ipd, G, tipd_G);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, G_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_G : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => G_ipd,
            RefSignalName  => "G",
            SetupHigh      => tsetup_D_G_noedge_POSEDGE,
            SetupLow       => tsetup_D_G_noedge_NEGEDGE,
            HoldHigh       => thold_D_G_noedge_POSEDGE,
            HoldLow        => thold_D_G_noedge_NEGEDGE,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "ILDI_1",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_G);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => LATCH0_table,
            DataIn => (violation, G_ipd, '0', GSR_ipd, '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => G_ipd'LAST_EVENT,
              PathDelay => tpd_G_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL FD
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity FD is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, C, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FD : entity is TRUE;
end FD ;

architecture Behavior of FD is
    signal D_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, C_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FD",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;

        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;
 
--
-- CELL FDE
--
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;
 
entity FDE is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_CE  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, CE, C, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FDE : entity is TRUE;
end FDE ;

architecture Behavior of FDE is
    signal D_ipd  : std_logic := 'X';
    signal CE_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(CE_ipd, CE, tipd_CE);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, CE_ipd, C_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_CE : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');
 
        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;
 
        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);
 
    begin
 
    IF (TimingChecksOn) THEN
 
        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FDE",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D;
 
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, GSR_ipd, '0', CE_ipd, D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
 
    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;
 

--
-- CELL FDC
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity FDC is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CLR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_CLR_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_CLR_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tpd_CLR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, C, CLR, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FDC : entity is TRUE;
end FDC ;

architecture Behavior of FDC is
    signal D_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal CLR_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(CLR_ipd, CLR, tipd_CLR);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, C_ipd, CLR_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_CLR : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_CLR_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);
        VARIABLE RESET_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FDC",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);

        VitalSetupHoldCheck (
            TestSignal     => CLR_ipd,
            TestSignalName => "CLR",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_CLR_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_CLR_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_CLR,
            HeaderMsg      => "FDC",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_CLR_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D OR Tviol_CLR;
	RESET_res := VitalOR2(CLR_ipd, GSR_ipd);
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, RESET_res, '0', '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => CLR_ipd'LAST_EVENT,
              PathDelay => tpd_CLR_Q,
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL FDCE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity FDCE is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_CE  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CLR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_CLR_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_CLR_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tpd_CLR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, CE, C, CLR, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FDCE : entity is TRUE;
end FDCE ;

architecture Behavior of FDCE is
    signal D_ipd  : std_logic := 'X';
    signal CE_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal CLR_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(CE_ipd, CE, tipd_CE);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(CLR_ipd, CLR, tipd_CLR);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, CE_ipd, C_ipd, CLR_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_CE : X01 := '0';
        VARIABLE Tviol_CLR : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_CLR_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);
        VARIABLE RESET_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FDCE",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);

        VitalSetupHoldCheck (
            TestSignal     => CLR_ipd,
            TestSignalName => "CLR",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_CLR_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_CLR_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_CLR,
            HeaderMsg      => "FDCE",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_CLR_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D OR Tviol_CLR;
	RESET_res := VitalOR2(CLR_ipd, GSR_ipd);
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, RESET_res, '0', CE_ipd, D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => CLR_ipd'LAST_EVENT,
              PathDelay => tpd_CLR_Q,
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL FDP
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity FDP is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_PRE  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_PRE_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_PRE_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tpd_PRE_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, C, PRE, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FDP : entity is TRUE;
end FDP ;

architecture Behavior of FDP is
    signal D_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal PRE_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(PRE_ipd, PRE, tipd_PRE);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, C_ipd, PRE_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_PRE : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_PRE_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);
        VARIABLE PRESET_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FDP",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);

        VitalSetupHoldCheck (
            TestSignal     => PRE_ipd,
            TestSignalName => "PRE",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_PRE_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_PRE_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_PRE,
            HeaderMsg      => "FDP",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_PRE_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D OR Tviol_PRE;
	PRESET_res := VitalOR2(PRE_ipd, GSR_ipd);
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, '0', PRESET_res, '1', D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => PRE_ipd'LAST_EVENT,
              PathDelay => tpd_PRE_Q,
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL FDPE
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity FDPE is
    generic (
        tipd_D  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_D_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tipd_CE  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_PRE  : VitalDelayType01 := (0 ns, 0 ns) ;
        tsetup_PRE_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        thold_PRE_C_noedge_POSEDGE : VitalDelayType := 0 ns ;
        tpd_PRE_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_GSR  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_GSR_Q : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        D, CE, C, PRE, GSR : in std_logic;
        Q : out std_logic);
    attribute VITAL_LEVEL0 of FDPE : entity is TRUE;
end FDPE ;

architecture Behavior of FDPE is
    signal D_ipd  : std_logic := 'X';
    signal CE_ipd  : std_logic := 'X';
    signal C_ipd  : std_logic := 'X';
    signal PRE_ipd  : std_logic := 'X';
    signal GSR_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(D_ipd, D, tipd_D);
        VitalWireDelay(CE_ipd, CE, tipd_CE);
        VitalWireDelay(C_ipd, C, tipd_C);
        VitalWireDelay(PRE_ipd, PRE, tipd_PRE);
        VitalWireDelay(GSR_ipd, GSR, tipd_GSR);
    end block;

    VitalBehavior : process ( D_ipd, CE_ipd, C_ipd, PRE_ipd, GSR_ipd)

        -- Timing Check Results :
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_CE : X01 := '0';
        VARIABLE Tviol_PRE : X01 := '0';
        VARIABLE Tviol_GSR : X01 := '0';
        VARIABLE PrevData : std_logic_vector (1 to 7) := (others=>'X');
        VARIABLE results  : std_logic_vector (1 to 1) := (others=>'X');

        -- Functionality Results :
        VARIABLE violation : X01 := '0';
        VARIABLE TimingData_D_C : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_PRE_C : VitalTimingDataType := VitalTimingDataInit;

        -- Output Glitch Results :
        VARIABLE Q_GlitchData : VitalGlitchDataType;
        ALIAS Q_res  : std_logic IS Results(1);
        VARIABLE PRESET_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_D_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "FDPE",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_C);

        VitalSetupHoldCheck (
            TestSignal     => PRE_ipd,
            TestSignalName => "PRE",
            RefSignal      => C_ipd,
            RefSignalName  => "C",
            SetupHigh      => tsetup_PRE_C_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_PRE_C_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_PRE,
            HeaderMsg      => "FDPE",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_PRE_C);
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        violation := Tviol_D OR Tviol_PRE;
	PRESET_res := VitalOR2(PRE_ipd, GSR_ipd);
        VitalStateTable(StateTable => DFF_table,
            DataIn => (violation, C_ipd, '0', PRESET_res, CE_ipd, D_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01(
        OutSignal     => Q,
        OutSignalName => "Q",
        OutTemp       => Q_res,
        Paths => (
            0 => (InputChangeTime => C_ipd'LAST_EVENT,
              PathDelay => tpd_C_Q,
              PathCondition => TRUE),
            1 => (InputChangeTime => PRE_ipd'LAST_EVENT,
              PathDelay => tpd_PRE_Q,
              PathCondition => TRUE),
            2 => (InputChangeTime => GSR_ipd'LAST_EVENT,
              PathDelay => tpd_GSR_Q,
              PathCondition => TRUE)),
        GlitchData => Q_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL BUFT
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity BUFT is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_T  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_T_O : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I, T : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of BUFT : entity is TRUE;
end BUFT ;

architecture Behavior of BUFT is
    signal I_ipd  : std_logic := 'X';
    signal T_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
        VitalWireDelay(T_ipd, T, tipd_T);
    end block;

    VitalBehavior : process ( I_ipd, T_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUFIF0(I_ipd, T_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_I_O),
              PathCondition => TRUE),
            1 => (InputChangeTime => T_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_T_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;


--
-- CELL WAND1
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity WAND1 is
    generic (
        tipd_I  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_I_O  : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := TRUE;
        InstancePath  : STRING  := "*");
    port (
        I : in std_logic;
        O : out std_logic);
    attribute VITAL_LEVEL0 of WAND1 : entity is TRUE;
end WAND1 ;

architecture Behavior of WAND1 is
    signal I_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WireDelay : block
    begin
        VitalWireDelay(I_ipd, I, tipd_I);
    end block;

    VitalBehavior : process ( I_ipd)
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE O_res  : std_logic := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_res := VitalBUFIF0(I_ipd, I_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01Z(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => I_ipd'LAST_EVENT,
              PathDelay => VitalExtendToFillDelay(tpd_I_O),
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL CY4
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4 is
    generic (
        tipd_A0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_B0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_A1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_B1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_ADD  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CIN  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C0  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C1  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C2  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C3  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C4  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C5  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C6  : VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_C7  : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_A0_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_A0_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_B0_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_B0_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_A1_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_A1_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_B1_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_B1_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_ADD_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_ADD_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_CIN_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_CIN_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C0_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C0_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C1_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C1_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C2_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C2_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C3_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C3_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C4_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C4_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C5_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_C5_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C6_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C6_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C7_COUT0 : VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_C7_COUT : VitalDelayType01 := (0 ns, 0 ns) ;
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port (
        A0, B0, A1, B1, ADD, CIN, C0, C1, C2, C3, C4, C5, C6, C7 : in std_logic;
        COUT0, COUT : out std_logic);
    attribute VITAL_LEVEL0 of CY4 : entity is TRUE;
end CY4 ;
 
architecture Behavior of CY4 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
    signal A0_ipd  : std_logic := 'X';
    signal B0_ipd  : std_logic := 'X';
    signal A1_ipd  : std_logic := 'X';
    signal B1_ipd  : std_logic := 'X';
    signal ADD_ipd  : std_logic := 'X';
    signal CIN_ipd  : std_logic := 'X';
    signal C0_ipd  : std_logic := 'X';
    signal C1_ipd  : std_logic := 'X';
    signal C2_ipd  : std_logic := 'X';
    signal C3_ipd  : std_logic := 'X';
    signal C4_ipd  : std_logic := 'X';
    signal C5_ipd  : std_logic := 'X';
    signal C6_ipd  : std_logic := 'X';
    signal C7_ipd  : std_logic := 'X';
begin
 
    WireDelay : block
    begin
        VitalWireDelay(A0_ipd, A0, tipd_A0);
        VitalWireDelay(B0_ipd, B0, tipd_B0);
        VitalWireDelay(A1_ipd, A1, tipd_A1);
        VitalWireDelay(B1_ipd, B1, tipd_B1);
        VitalWireDelay(ADD_ipd, ADD, tipd_ADD);
        VitalWireDelay(CIN_ipd, CIN, tipd_CIN);
        VitalWireDelay(C0_ipd, C0, tipd_C0);
        VitalWireDelay(C1_ipd, C1, tipd_C1);
        VitalWireDelay(C2_ipd, C2, tipd_C2);
        VitalWireDelay(C3_ipd, C3, tipd_C3);
        VitalWireDelay(C4_ipd, C4, tipd_C4);
        VitalWireDelay(C5_ipd, C5, tipd_C5);
        VitalWireDelay(C6_ipd, C6, tipd_C6);
        VitalWireDelay(C7_ipd, C7, tipd_C7);
    end block;
 
    VitalBehavior : process ( A0_ipd, B0_ipd, A1_ipd, B1_ipd, ADD_ipd, CIN_ipd, C0_ipd, C1_ipd, C2_ipd, C3_ipd, C4_ipd, C5_ipd, C6_ipd, C7_ipd)
        VARIABLE COUT0_res : std_logic := 'X';
        VARIABLE COUT0_GlitchData : VitalGlitchDataType;
        VARIABLE COUT_res : std_logic := 'X';
        VARIABLE COUT_GlitchData : VitalGlitchDataType;
        VARIABLE n1 : std_logic := 'X';
        VARIABLE n2 : std_logic := 'X';
        VARIABLE n3 : std_logic := 'X';
        VARIABLE n4 : std_logic := 'X';
        VARIABLE n5 : std_logic := 'X';
    begin
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    n1 := VitalOR2( VitalAND2(C1_ipd, VitalINV(C0_ipd)), VitalAND2(C0_ipd, ADD_ipd));
    n2 := VitalXOR3(n1, VitalOR2( VitalINV(C7_ipd), VitalINV(B0_ipd)), A0_ipd);
    n3 := VitalOR2( VitalAND2(n2, C3_ipd), VitalAND2(C2_ipd, VitalINV(C3_ipd)));
    n4 := VitalOR3( VitalAND3(C7_ipd, VitalINV(C5_ipd), VitalINV(C4_ipd) ), VitalAND3( VitalINV(ADD_ipd), C5_ipd, VitalINV(C4_ipd) ), VitalAND3(C5_ipd, C4_ipd, A0_ipd)); 
    n5 := VitalOR2( VitalINV(C6_ipd), VitalAND2(C6_ipd, VitalXOR3(A1_ipd, n1, VitalOR2( VitalINV(B1_ipd), VitalINV(C7_ipd) ))));

    COUT0_res := VitalOR2( VitalAND2(CIN_ipd, n3), VitalAND2(n4, VitalINV(n3)));
    COUT_res := VitalOR2( VitalAND2(COUT0_res, n5), VItalAND2(A1_ipd, VitalINV(n5)));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
        OutSignal     => COUT0,
        OutSignalName => "COUT0",
        OutTemp       => COUT0_res,
        Paths => (
            0 => (InputChangeTime => A0_ipd'LAST_EVENT,
                  PathDelay => tpd_A0_COUT0,
                  PathCondition => TRUE),
            1 => (InputChangeTime => B0_ipd'LAST_EVENT,
                  PathDelay => tpd_B0_COUT0,
                  PathCondition => TRUE),
            2 => (InputChangeTime => A1_ipd'LAST_EVENT,
                  PathDelay => tpd_A1_COUT0,
                  PathCondition => TRUE),
            3 => (InputChangeTime => B1_ipd'LAST_EVENT,
                  PathDelay => tpd_B1_COUT0,
                  PathCondition => TRUE),
            4 => (InputChangeTime => ADD_ipd'LAST_EVENT,
                  PathDelay => tpd_ADD_COUT0,
                  PathCondition => TRUE),
            5 => (InputChangeTime => CIN_ipd'LAST_EVENT,
                  PathDelay => tpd_CIN_COUT0,
                  PathCondition => TRUE),
            6 => (InputChangeTime => C0_ipd'LAST_EVENT,
                  PathDelay => tpd_C0_COUT0,
                  PathCondition => TRUE),
            7 => (InputChangeTime => C1_ipd'LAST_EVENT,
                  PathDelay => tpd_C1_COUT0,
                  PathCondition => TRUE),
            8 => (InputChangeTime => C2_ipd'LAST_EVENT,
                  PathDelay => tpd_C2_COUT0,
                  PathCondition => TRUE),
            9 => (InputChangeTime => C3_ipd'LAST_EVENT,
                  PathDelay => tpd_C3_COUT0,
                  PathCondition => TRUE),
            10 => (InputChangeTime => C4_ipd'LAST_EVENT,
                  PathDelay => tpd_C4_COUT0,
                  PathCondition => TRUE),
            11 => (InputChangeTime => C5_ipd'LAST_EVENT,
                  PathDelay => tpd_C5_COUT0,
                  PathCondition => TRUE),
            12 => (InputChangeTime => C6_ipd'LAST_EVENT,
                  PathDelay => tpd_C6_COUT0,
                  PathCondition => TRUE),
            13 => (InputChangeTime => C7_ipd'LAST_EVENT,
                  PathDelay => tpd_C7_COUT0,
                  PathCondition => TRUE)),
        GlitchData => COUT0_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    VitalPathDelay01(
        OutSignal     => COUT,
        OutSignalName => "COUT",
        OutTemp       => COUT_res,
        Paths => (
            0 => (InputChangeTime => A0_ipd'LAST_EVENT,
                  PathDelay => tpd_A0_COUT,
                  PathCondition => TRUE),
            1 => (InputChangeTime => B0_ipd'LAST_EVENT,
                  PathDelay => tpd_B0_COUT,
                  PathCondition => TRUE),
            2 => (InputChangeTime => A1_ipd'LAST_EVENT,
                  PathDelay => tpd_A1_COUT,
                  PathCondition => TRUE),
            3 => (InputChangeTime => B1_ipd'LAST_EVENT,
                  PathDelay => tpd_B1_COUT,
                  PathCondition => TRUE),
            4 => (InputChangeTime => ADD_ipd'LAST_EVENT,
                  PathDelay => tpd_ADD_COUT,
                  PathCondition => TRUE),
            5 => (InputChangeTime => CIN_ipd'LAST_EVENT,
                  PathDelay => tpd_CIN_COUT,
                  PathCondition => TRUE),
            6 => (InputChangeTime => C0_ipd'LAST_EVENT,
                  PathDelay => tpd_C0_COUT,
                  PathCondition => TRUE),
            7 => (InputChangeTime => C1_ipd'LAST_EVENT,
                  PathDelay => tpd_C1_COUT,
                  PathCondition => TRUE),
            8 => (InputChangeTime => C2_ipd'LAST_EVENT,
                  PathDelay => tpd_C2_COUT,
                  PathCondition => TRUE),
            9 => (InputChangeTime => C3_ipd'LAST_EVENT,
                  PathDelay => tpd_C3_COUT,
                  PathCondition => TRUE),
            10 => (InputChangeTime => C4_ipd'LAST_EVENT,
                  PathDelay => tpd_C4_COUT,
                  PathCondition => TRUE),
            11 => (InputChangeTime => C5_ipd'LAST_EVENT,
                  PathDelay => tpd_C5_COUT,
                  PathCondition => TRUE),
            12 => (InputChangeTime => C6_ipd'LAST_EVENT,
                  PathDelay => tpd_C6_COUT,
                  PathCondition => TRUE),
            13 => (InputChangeTime => C7_ipd'LAST_EVENT,
                  PathDelay => tpd_C7_COUT,
                  PathCondition => TRUE)),
        GlitchData => COUT_GlitchData,
        MsgOn      => FALSE,
        Mode       => OnEvent,
        XOn        => FALSE
     );
    end process;
end Behavior;


--
-- CELL CY4_01
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_01 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_01 : entity is TRUE;
end CY4_01 ;

architecture Behavior of CY4_01 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '0';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '1';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_02
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_02 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_02 : entity is TRUE;
end CY4_02 ;

architecture Behavior of CY4_02 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '1';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_03
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_03 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_03 : entity is TRUE;
end CY4_03 ;

architecture Behavior of CY4_03 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '0';
	C2 <= '0';
	C1 <= '1';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_04
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_04 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_04 : entity is TRUE;
end CY4_04 ;

architecture Behavior of CY4_04 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '0';
	C4 <= '0';
	C3 <= '0';
	C2 <= '1';
	C1 <= '1';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_05
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_05 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_05 : entity is TRUE;
end CY4_05 ;

architecture Behavior of CY4_05 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '0';
	C3 <= '0';
	C2 <= '0';
	C1 <= '1';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_06
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_06 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_06 : entity is TRUE;
end CY4_06 ;

architecture Behavior of CY4_06 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '0';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_07
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_07 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_07 : entity is TRUE;
end CY4_07 ;

architecture Behavior of CY4_07 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_08
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_08 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_08 : entity is TRUE;
end CY4_08 ;

architecture Behavior of CY4_08 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '0';
	C4 <= '0';
	C3 <= '0';
	C2 <= '0';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_09
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_09 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_09 : entity is TRUE;
end CY4_09 ;

architecture Behavior of CY4_09 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '0';
	C4 <= '0';
	C3 <= '0';
	C2 <= '1';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_10
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_10 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_10 : entity is TRUE;
end CY4_10 ;

architecture Behavior of CY4_10 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '0';
	C2 <= '0';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_11
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_11 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_11 : entity is TRUE;
end CY4_11 ;

architecture Behavior of CY4_11 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '0';
	C3 <= '0';
	C2 <= '0';
	C1 <= '0';
	C0 <= '0';
end Behavior;

--
-- CELL CY4_12
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_12 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_12 : entity is TRUE;
end CY4_12 ;

architecture Behavior of CY4_12 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '0';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '0';
	C0 <= '1';
end Behavior;

--
-- CELL CY4_13
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_13 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_13 : entity is TRUE;
end CY4_13 ;

architecture Behavior of CY4_13 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '1';
	C2 <= '0';
	C1 <= '0';
	C0 <= '1';
end Behavior;

--
-- CELL CY4_14
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_14 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_14 : entity is TRUE;
end CY4_14 ;

architecture Behavior of CY4_14 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '1';
	C3 <= '0';
	C2 <= '0';
	C1 <= '0';
	C0 <= '1';
end Behavior;

--
-- CELL CY4_15
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_15 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_15 : entity is TRUE;
end CY4_15 ;

architecture Behavior of CY4_15 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '0';
	C4 <= '0';
	C3 <= '0';
	C2 <= '1';
	C1 <= '0';
	C0 <= '1';
end Behavior;

--
-- CELL CY4_16
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_16 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_16 : entity is TRUE;
end CY4_16 ;

architecture Behavior of CY4_16 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
	C7 <= '1';
	C6 <= '1';
	C5 <= '1';
	C4 <= '0';
	C3 <= '0';
	C2 <= '0';
	C1 <= '0';
	C0 <= '1';
end Behavior;

--
-- CELL CY4_17
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_17 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_17 : entity is TRUE;
end CY4_17 ;

architecture Behavior of CY4_17 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_18
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_18 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_18 : entity is TRUE;
end CY4_18 ;

architecture Behavior of CY4_18 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_19
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_19 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_19 : entity is TRUE;
end CY4_19 ;

architecture Behavior of CY4_19 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_20
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_20 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_20 : entity is TRUE;
end CY4_20 ;

architecture Behavior of CY4_20 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_21
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_21 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_21 : entity is TRUE;
end CY4_21 ;

architecture Behavior of CY4_21 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_22
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_22 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_22 : entity is TRUE;
end CY4_22 ;

architecture Behavior of CY4_22 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '1';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_23
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_23 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_23 : entity is TRUE;
end CY4_23 ;

architecture Behavior of CY4_23 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '1';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_24
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_24 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_24 : entity is TRUE;
end CY4_24 ;

architecture Behavior of CY4_24 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_25
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_25 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_25 : entity is TRUE;
end CY4_25 ;

architecture Behavior of CY4_25 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_26
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_26 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_26 : entity is TRUE;
end CY4_26 ;

architecture Behavior of CY4_26 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_27
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_27 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_27 : entity is TRUE;
end CY4_27 ;

architecture Behavior of CY4_27 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_28
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_28 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_28 : entity is TRUE;
end CY4_28 ;

architecture Behavior of CY4_28 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_29
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_29 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_29 : entity is TRUE;
end CY4_29 ;

architecture Behavior of CY4_29 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '1';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_30
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_30 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_30 : entity is TRUE;
end CY4_30 ;

architecture Behavior of CY4_30 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_31
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_31 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_31 : entity is TRUE;
end CY4_31 ;

architecture Behavior of CY4_31 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '0';
        C0 <= '1';
end Behavior;

--
-- CELL CY4_32
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_32 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_32 : entity is TRUE;
end CY4_32 ;

architecture Behavior of CY4_32 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '1';
        C2 <= '0';
        C1 <= '0';
        C0 <= '1';
end Behavior;

--
-- CELL CY4_33
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_33 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_33 : entity is TRUE;
end CY4_33 ;

architecture Behavior of CY4_33 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '1';
end Behavior;

--
-- CELL CY4_34
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_34 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_34 : entity is TRUE;
end CY4_34 ;

architecture Behavior of CY4_34 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_35
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_35 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_35 : entity is TRUE;
end CY4_35 ;

architecture Behavior of CY4_35 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '1';
end Behavior;

--
-- CELL CY4_36
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_36 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_36 : entity is TRUE;
end CY4_36 ;

architecture Behavior of CY4_36 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '1';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '1';
        C1 <= '0';
        C0 <= '1';
end Behavior;

--
-- CELL CY4_37
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_37 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_37 : entity is TRUE;
end CY4_37 ;

architecture Behavior of CY4_37 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_38
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_38 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_38 : entity is TRUE;
end CY4_38 ;

architecture Behavior of CY4_38 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '1';
        C6 <= '0';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_39
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_39 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_39 : entity is TRUE;
end CY4_39 ;

architecture Behavior of CY4_39 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '1';
        C4 <= '1';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_40
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_40 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_40 : entity is TRUE;
end CY4_40 ;

architecture Behavior of CY4_40 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '1';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_41
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_41 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_41 : entity is TRUE;
end CY4_41 ;

architecture Behavior of CY4_41 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '1';
        C4 <= '0';
        C3 <= '0';
        C2 <= '0';
        C1 <= '0';
        C0 <= '0';
end Behavior;

--
-- CELL CY4_42
--

library ieee;
use ieee.std_logic_1164.all;

use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.exemplar_vital_prims.all;

entity CY4_42 is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( C0, C1, C2, C3, C4, C5, C6, C7 : out std_logic);
    attribute VITAL_LEVEL0 of CY4_42 : entity is TRUE;
end CY4_42 ;

architecture Behavior of CY4_42 is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
        C7 <= '0';
        C6 <= '0';
        C5 <= '0';
        C4 <= '0';
        C3 <= '0';
        C2 <= '1';
        C1 <= '0';
        C0 <= '0';
end Behavior;


--
-- CELL RAM
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
library exemplar;
use exemplar.exemplar_1164.all;
use work.exemplar_vital_prims.all;

entity RAM is
	generic(
	    tipd_A0 : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_A1 : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_A2 : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_A3 : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_A4 : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_D  : VitalDelayType01 := (0 ns, 0 ns);
	    tipd_WE : VitalDelayType01 := (0 ns, 0 ns);
	    tpd_WE_O : VitalDelayType01 := (0 ns, 0 ns);
            tsetup_D_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            thold_D_WE_noedge_POSEDGE   : VitalDelayType := 0 ns ;
            tsetup_A0_WE_noedge_POSEDGE : VitalDelayType := 0 ns ;
            thold_A0_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            tsetup_A1_WE_noedge_POSEDGE : VitalDelayType := 0 ns ;
            thold_A1_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            tsetup_A2_WE_noedge_POSEDGE : VitalDelayType := 0 ns ;
            thold_A2_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            tsetup_A3_WE_noedge_POSEDGE : VitalDelayType := 0 ns ;
            thold_A3_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            tsetup_A4_WE_noedge_POSEDGE : VitalDelayType := 0 ns ;
            thold_A4_WE_noedge_POSEDGE  : VitalDelayType := 0 ns ;
            TimingChecksOn : BOOLEAN := FALSE;
            InstancePath  : STRING  := "*");
	port (
	    A0, A1, A2, A3, A4, D, WE : in std_logic;
	    O : out std_logic
	);
        attribute VITAL_LEVEL0 of RAM : entity is TRUE;
end RAM;
		
architecture Behavior of RAM is
    signal D_ipd   : std_logic := 'X';
    signal WE_ipd  : std_logic := 'X';
    signal A0_ipd  : std_logic := 'X';
    signal A1_ipd  : std_logic := 'X';
    signal A2_ipd  : std_logic := 'X';
    signal A3_ipd  : std_logic := 'X';
    signal A4_ipd  : std_logic := 'X';
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin

    WIRE_DELAY : block
    begin
        VitalWireDelay(D_ipd, D, (tipd_D));
        VitalWireDelay(WE_ipd, WE, (tipd_WE));
        VitalWireDelay(A0_ipd, A0, (tipd_A0));
        VitalWireDelay(A1_ipd, A1, (tipd_A1));
        VitalWireDelay(A2_ipd, A2, (tipd_A2));
        VitalWireDelay(A3_ipd, A3, (tipd_A3));
        VitalWireDelay(A4_ipd, A4, (tipd_A4));
    end block;

    VitalBehavior : process ( D_ipd, WE_ipd, A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd)
        VARIABLE O_res : std_logic := 'X';
        VARIABLE O_GlitchData : VitalGlitchDataType;
        VARIABLE Tviol_D : X01 := '0';
        VARIABLE Tviol_A0 : X01 := '0';
        VARIABLE Tviol_A1 : X01 := '0';
        VARIABLE Tviol_A2 : X01 := '0';
        VARIABLE Tviol_A3 : X01 := '0';
        VARIABLE Tviol_A4 : X01 := '0';
        VARIABLE TimingData_A0_WE : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_A1_WE : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_A2_WE : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_A3_WE : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_A4_WE : VitalTimingDataType := VitalTimingDataInit;
        VARIABLE TimingData_D_WE : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE RAM_MEMORY : std_logic_vector (31 downto 0);
	VARIABLE ram_addr : std_logic_vector (4 downto 0);
    begin

    -----------------------------------
    -- Timing Checks Section.
    -----------------------------------

    IF (TimingChecksOn) THEN

        VitalSetupHoldCheck (
            TestSignal     => A0_ipd,
            TestSignalName => "A0",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_A0_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_A0_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_A0,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_A0_WE);

        VitalSetupHoldCheck (
            TestSignal     => A1_ipd,
            TestSignalName => "A1",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_A1_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_A1_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_A1,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_A1_WE);


        VitalSetupHoldCheck (
            TestSignal     => A2_ipd,
            TestSignalName => "A2",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_A2_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_A2_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_A2,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_A2_WE);
 
        VitalSetupHoldCheck (
            TestSignal     => A3_ipd,
            TestSignalName => "A3",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_A3_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_A3_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_A3,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_A3_WE);
 
 
        VitalSetupHoldCheck (
            TestSignal     => A4_ipd,
            TestSignalName => "A4",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_A4_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_A4_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_A4,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_A4_WE);
 
        VitalSetupHoldCheck (
            TestSignal     => D_ipd,
            TestSignalName => "D",
            RefSignal      => WE_ipd,
            RefSignalName  => "WE",
            SetupHigh      => tsetup_D_WE_noedge_POSEDGE,
            SetupLow       => 0 ns,
            HoldHigh       => thold_D_WE_noedge_POSEDGE,
            HoldLow        => 0 ns,
            CheckEnabled   => TRUE, -- check enabled
            RefTransition  => '/',
            Violation      => Tviol_D,
            HeaderMsg      => "RAM",
            Xon            => FALSE,
            MsgOn          => TRUE,
            MsgSeverity    => WARNING,
            TimingData     => TimingData_D_WE);

    END IF;
    -----------------------------------
    -- Functionality Section.
    -----------------------------------

    ram_addr := (A4 & A3 & A2 & A1 & A0);
    if ( WE_ipd = '1') THEN
	O_res := D_ipd;
	RAM_MEMORY(evec2int(ram_addr)) := D_ipd;
    else
	O_res := RAM_MEMORY(evec2int(ram_addr));
    end if;


    -----------------------------------
    -- Path Delay Section.
    -----------------------------------

 
    VitalPathDelay01(
        OutSignal     => O,
        OutSignalName => "O",
        OutTemp       => O_res,
        Paths => (
            0 => (InputChangeTime => WE_ipd'LAST_EVENT,
              PathDelay => tpd_WE_O,
              PathCondition => TRUE)),
        GlitchData => O_GlitchData,
        Mode       => OnEvent,
        XOn        => TRUE,
        MsgOn      => TRUE
    );
    end process;
end Behavior;

--
-- CELL STARTUP
--

--
-- Just a dummy startup block
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;

entity STARTUP is
    generic (
        TimingChecksOn : BOOLEAN := FALSE;
        InstancePath  : STRING  := "*");
    port ( Q2, Q3, Q1Q4, DONEIN : out std_logic;
	   GSR, GTS, CLK : in std_logic);
end STARTUP ;

architecture Behavior of STARTUP is
    attribute VITAL_LEVEL1 of Behavior : architecture is TRUE;
begin
	------------------------------------------
	-- Just a dummy startup block		--
	------------------------------------------
end Behavior;
