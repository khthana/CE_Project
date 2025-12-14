Library ieee;
use ieee.std_logic_1164.all;
entity TB_CPU is
end TB_CPU;

architecture Test of TB_CPU is
    component PIC_CPU
        port (  MCLRb           : in    std_logic;
                OSC1            : in    std_logic;
                MBR_IN          : in    std_logic_vector(13 downto 0);
                OSC2            : out   std_logic;
                PSENb           : out   std_logic;
                MAR_OUT         : out   std_logic_vector(12 downto 0);
                RA              : inout std_logic_vector( 4 downto 0);
                RB              : inout std_logic_vector( 7 downto 0) );
    end component;

    component ROM_1kx14
        port (  address : in  std_logic_vector(12 downto 0);
                oe      : in  std_logic;
                dout    : out std_logic_vector(13 downto 0) );
    end component;

    component SEGMENT
        port (  din  : in  std_logic_vector(7 downto 0));
    end component;

    component BUFFER4
        port (  din  : in  std_logic_vector(3 downto 0));
    end component;

        constant tph : time := 50 ns;

        signal  MAR     : std_logic_vector(12 downto 0);
        signal  MBR     : std_logic_vector(13 downto 0);
        signal  PORTA   : std_logic_vector( 4 downto 0);
        signal  PORTB   : std_logic_vector( 7 downto 0);
        signal  reset,PSEN_B,
                osc,oscout,
                finish  : std_logic := '0';
        signal  seg_sig : std_logic_vector(7 downto 0);
        signal  complete : std_logic := 'U';

begin
        CPU_UNIT: PIC_CPU
              port map (reset,osc,MBR,oscout,
                        PSEN_B,MAR,PORTA,PORTB);

        PMEM: ROM_1kx14
                port map (MAR,PSEN_B,MBR);

        seg_sig <= PORTA(4) & PORTB(3 downto 1) & PORTA(3 downto 0);

        DSP_SEG:        SEGMENT port map (seg_sig);

        DSP_NIBBLE:     BUFFER4 port map (PORTB(7 downto 4));

        osc    <= not osc after tph;

     GEN_RESET:
     process
     begin
        -- time 0 ns
        reset <= '1';
        wait for 5*tph;
        PORTA <= "WWWWW";
        PORTB <= "WWWWWWWW";
        reset <= '0';
        wait;
     end process;

     CHECK_PORT:
     process
     begin
        wait until (PORTA = "11111");
        wait for 9*tph;
        if (PORTB = "11111111") then
                assert false report "This program run correctly."
                severity note;
        else
                assert false report "An error occured somewhere."
                severity error;
        end if;
        wait;
     end process;

end Test;


configuration test_cpu_block of TB_CPU is
    for Test
        ------ for testbench architecture
        for CPU_UNIT: PIC_CPU
            use entity work.PIC_CPU(rtl);
        end for;
        for DSP_SEG: SEGMENT
            use entity work.SEGMENT(environment);
        end for;
        for DSP_NIBBLE: BUFFER4
            use entity work.BUFFER4(environment);
        end for;
    end for;
end test_cpu_block;
