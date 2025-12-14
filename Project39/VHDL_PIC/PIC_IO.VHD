library IEEE;
use IEEE.std_logic_1164.all;
entity PIC_IO is
        port (  reset                   : in    std_logic;
                clk_q1                  : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q4                  : in    std_logic;
                Data_in_IO              : in    std_logic_vector(7 downto 0);
                Write_to_TMR0_IO        : in    std_logic;
                Write_to_OPTION_IO      : in    std_logic;
                Write_to_INTCON_IO      : in    std_logic;
                Write_to_TRISA_IO       : in    std_logic;
                Write_to_TRISB_IO       : in    std_logic;
                Clr_GIE_IO              : in    std_logic;
                Set_GIE_IO              : in    std_logic;
                T0CK1						: in    std_logic;
                SET_RBIF					: in    std_logic;
                INT0						: in    std_logic;
                TMR0_out_IO             : out   std_logic_vector(7 downto 0);
                OPTION_out_IO           : out   std_logic_vector(7 downto 0);
                INTCON_out_IO           : out   std_logic_vector(7 downto 0);
                TRISA_out_IO            : out   std_logic_vector(4 downto 0);
                TRISB_out_IO            : out   std_logic_vector(7 downto 0) );
end;

architecture rtl of PIC_IO is

   component SYN_CYC
        port (  reset   : in  std_logic;
                clkq2   : in  std_logic;
                clkq4   : in  std_logic;
                pscale  : in  std_logic;
                trigged : in  std_logic;
                inctmr0 : out std_logic  );
   end component;

   component P_SCALER
        port (  reset   : in  std_logic;
                inc     : in  std_logic;
                dout    : out std_logic_vector(7 downto 0) );
   end component;

   component TIMER
        port (  reset   : in  std_logic;
                clk     : in  std_logic;
                inc     : in  std_logic;
                wr      : in  std_logic;
                din     : in  std_logic_vector(7 downto 0);
                ov      : out std_logic;
                dout    : out std_logic_vector(7 downto 0) );
   end component;

        signal  SET_T0IF,SET_INTF,EXT_ip0,EXT_ip1,
		INC_TIMER,MUX_EXT_OUT,DEC8TO1_OUT,
		MUX_TRIG_OUT,
                INTF_SBIT	: std_logic;
        signal  prescaler,
                trisb           : std_logic_vector(7 downto 0);
        signal  trisa           : std_logic_vector(4 downto 0);
        signal  INTCON,
		OPTION  : std_logic_vector(6 downto 0);
        alias   INTEDG  : std_logic is OPTION(6);
        alias   T0CS    : std_logic is OPTION(5);
        alias   T0SE    : std_logic is OPTION(4);
        alias   PSA     : std_logic is OPTION(3);
        alias   PS2TO0  : std_logic_vector(2 downto 0) is OPTION(2 downto 0);
	alias	D2trisa : std_logic_vector(4 downto 0) is Data_in_IO(4 downto 0);
	alias	D2option: std_logic_vector(6 downto 0) is Data_in_IO(6 downto 0);
begin
	-- BIT 7 is RBPU\ use to pullup signal can not implement by FPGA
	-- Therefore RBPU\ must always be "1"
        OPTION_out_IO   <= "1" & OPTION;
	-- Unimplement bit ,read as "0"
        INTCON_out_IO   <= INTCON(6) & "0" & INTCON(5 downto 0);
        TRISA_out_IO    <= trisa;
        TRISB_out_IO    <= trisb;
        EXT_ip0         <= clk_q1 or  clk_q2;
        EXT_ip1         <= T0CK1  xor T0SE;
        SET_INTF        <= INT0   xor INTEDG;

        MUX_EXT:
        process(T0CS,EXT_ip0,EXT_ip1)
        begin
                if T0CS = '1' then
                        MUX_EXT_OUT <= EXT_ip1;
                else
                        MUX_EXT_OUT <= EXT_ip0;
                end if;
        end process;

        DEC8TO1:
        process(PS2TO0,prescaler)
        begin
                case PS2TO0 is
                        when "000"  => DEC8TO1_OUT <= prescaler(0);
                        when "001"  => DEC8TO1_OUT <= prescaler(1);
                        when "010"  => DEC8TO1_OUT <= prescaler(2);
                        when "011"  => DEC8TO1_OUT <= prescaler(3);
                        when "100"  => DEC8TO1_OUT <= prescaler(4);
                        when "101"  => DEC8TO1_OUT <= prescaler(5);
                        when "110"  => DEC8TO1_OUT <= prescaler(6);
                        when others => DEC8TO1_OUT <= prescaler(7);
                end case;
        end process;

        MUX_TRIG:
        process(PSA,MUX_EXT_OUT,DEC8TO1_OUT)
        begin
                if PSA = '1' then
                        MUX_TRIG_OUT <= MUX_EXT_OUT;
                else
                        MUX_TRIG_OUT <= DEC8TO1_OUT;
                end if;
        end process;

        TRISA_RES:
        process(clk_q4,reset,D2trisa)
        begin
                if   (reset = '1') then
                        trisa <= "11111";
                elsif rising_edge(clk_q4) then
                        if WRITE_to_TRISA_IO = '1' then
                                trisa <= D2trisa;
                        end if;
                end if;
        end process;

        TRISB_RES:
        process(clk_q4,reset,Data_in_IO)
        begin
                if   (reset = '1') then
                        trisb <= "11111111";
                elsif rising_edge(clk_q4) then
                        if WRITE_to_TRISB_IO = '1' then
                                trisb <= Data_in_IO;
                        end if;
                end if;
        end process;

        OPTION_RES:
        process(clk_q4,reset,D2option)
        begin
                if   (reset = '1') then
                        option <= "1111111";
                elsif rising_edge(clk_q4) then
                        if    WRITE_to_OPTION_IO = '1' then
                                option <= D2option;
                        end if;
                end if;
        end process;

        INTF_SETFF:
        process(SET_INTF,clk_q4,INTCON(1))
        variable CLR_INTF : std_logic;
        begin
                CLR_INTF := clk_q4 and INTCON(1);
                if    (CLR_INTF = '1') then
                        INTF_SBIT <= '0';
                elsif (rising_edge(SET_INTF)) then
                        INTF_SBIT <= '1';
                end if;
        end process;

        INTCON_RES_RBIF:
        process(clk_q4,reset,SET_RBIF,Write_to_INTCON_IO,Data_in_IO(0))
        begin

                if (reset = '1') then
                        INTCON(0) <= '0';
                else
                        -- RBIF is sampled at Q2
                        if rising_edge(clk_q4) then
                                if    SET_RBIF = '1' then
                                        INTCON(0) <= '1';
                                elsif Write_to_INTCON_IO = '1' then
                                        INTCON(0) <= Data_in_IO(0);
                                end if;
                        end if;
                end if;
        end process;

        INTCON_RES_INTF:
        process(clk_q4,reset,INTF_SBIT,Write_to_INTCON_IO,Data_in_IO(1))
        begin
                if (reset = '1') then
                        INTCON(1) <= '0';
                else
                        -- INF is setted when rising.
                        if rising_edge(clk_q4)   then
                                if    (INTF_SBIT = '1') then
                                        INTCON(1) <= '1';
                                elsif Write_to_INTCON_IO = '1' then
                                        INTCON(1) <= Data_in_IO(1);
                                end if;
                        end if;
                end if;
        end process;

        INTCON_RES_T0IF:
        process(clk_q4,reset,SET_T0IF,Write_to_INTCON_IO,Data_in_IO(2))
        begin

                if (reset = '1') then
                        INTCON(2) <= '0';
                else
                        -- T0IF is occured at Q3^
                        if rising_edge(clk_q4) then
                                if    SET_T0IF = '1' then
                                        INTCON(2) <= '1';
                                elsif Write_to_INTCON_IO = '1' then
                                        INTCON(2) <= Data_in_IO(2);
                                end if;
                        end if;
                end if;
        end process;

        INTCON_RES_ENABLE:
        process(clk_q4,reset,Write_to_INTCON_IO,Data_in_IO(5 downto 3))
        begin
                if    (reset = '1') then
                        INTCON(5 downto 3) <= "000";
                elsif rising_edge(clk_q4) then
                        if Write_to_INTCON_IO = '1' then
                                INTCON(5 downto 3) <= Data_in_IO(5 downto 3);
                        end if;
                end if;
        end process;

        INTCON_RES_GIE:
        process(clk_q4,reset,Set_GIE_IO,Clr_GIE_IO,Write_to_INTCON_IO,Data_in_IO(7))
        begin
                if (reset = '1') OR (Clr_GIE_IO = '1') then
                        INTCON(6) <= '0';
                else
                        -- SET_GIE_IO and CLR_GIE_IO are occured at Q2^
                        if rising_edge(clk_q4) then
                                if    Set_GIE_IO = '1' then
                                        INTCON(6) <= '1';
                                elsif Write_to_INTCON_IO = '1' then
                                        INTCON(6) <= Data_in_IO(7);
                                end if;
                        end if;
                end if;
        end process;

        TIMER_REG:
        TIMER port map
        -- Updating value of TIMER at Q3^ due to setting overflow bit T0IF at Q4
               (reset,clk_q4,INC_TIMER,Write_to_TMR0_IO,
                Data_in_IO,SET_T0IF,TMR0_out_IO);

        PRESCALER_REG:
        P_SCALER port map
               (Write_to_TMR0_IO,MUX_EXT_OUT,prescaler);

        SYNC_2CYCLES:
        SYN_CYC port map
                (reset,clk_q2,clk_q4,PSA,MUX_TRIG_OUT,INC_TIMER);

end rtl;

configuration io_block of PIC_IO is
    for rtl
        for TIMER_REG: TIMER
            use entity work.TIMER(rtl);
	end for;
        for PRESCALER_REG: P_SCALER
            use entity work.P_SCALER(rtl);
	end for;
        for SYNC_2CYCLES: SYN_CYC
            use entity work.SYN_CYC(rtl);
	end for;
    end for;
end io_block;
