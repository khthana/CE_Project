------------------------------------------------------------------------
-- Central Processing Unit block
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity PIC_CPU is
    port (      MCLRb           : in    std_logic;
                OSC1            : in    std_logic;
                MBR_IN          : in    std_logic_vector(13 downto 0);
                OSC2            : out   std_logic;
                PSENb           : out   std_logic;
                MAR_OUT         : out   std_logic_vector(12 downto 0);
                RA              : inout std_logic_vector( 4 downto 0);
                RB              : inout std_logic_vector( 7 downto 0) );
end PIC_CPU;

architecture rtl of PIC_CPU is

    component PIC_ALU
       port (   clk                     : in    std_logic;
                reset                   : in    std_logic;
                Data_in_ALU             : in    std_logic_vector(7 downto 0);
                IR_operand_in_ALU       : in    std_logic_vector(7 downto 0);
                IR_b_in_ALU             : in    std_logic_vector(2 downto 0);
                Sel_first_operand_ALU   : in    std_logic_vector(1 downto 0);
                Sel_second_operand_ALU  : in    std_logic_vector(1 downto 0);
                Execute_ALU             : in    std_logic_vector(4 downto 0);
                Check_STATUS_ALU        : in    std_logic_vector(2 downto 0);
                Write_to_W_ALU          : in    std_logic;
                Write_to_STATUS_ALU     : in    std_logic;
                Write_to_FSR_ALU        : in    std_logic;
                Data_out_ALU            : out   std_logic_vector(7 downto 0);
                FSR_out_ALU             : out   std_logic_vector(7 downto 0);
                STATUS_out_ALU          : out   std_logic_vector(7 downto 0);
                ALU_Zero_flag           : out   std_logic     );
    end component;

    component PIC_RF
       port (   reset                   : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q3                  : in    std_logic;
                Data_in_RF              : in    std_logic_vector(7 downto 0);
                Direct_adr_in_RF        : in    std_logic_vector(5 downto 0);
                Indirect_adr_in_RF      : in    std_logic_vector(5 downto 0);
                Addr_mode_RF            : in    std_logic;
                Write_to_RF             : in    std_logic;
                Data_out_RF             : out   std_logic_vector(7 downto 0) );
    end component;

    component PIC_PC
       port (   clk                     : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q3                  : in    std_logic;
                clk_q4                  : in    std_logic;
                reset                   : in    std_logic;
                Call_int                : in    std_logic;
                Data_in_PC              : in    std_logic_vector( 7 downto 0);
                IR_jmp_in_PC            : in    std_logic_vector(10 downto 0);
                Sel_part_PC             : in    std_logic_vector( 1 downto 0);
                Increase_PC             : in    std_logic;
                Write_to_PC             : in    std_logic;
                Write_to_PCLATH_PC      : in    std_logic;
                Sel_SADR_PC             : in    std_logic;
                Update_SP_PC            : in    std_logic_vector( 1 downto 0);
                Write_to_STACK_PC       : in    std_logic;
                PCLATH_out_PC           : out   std_logic_vector( 7 downto 0);
                PC_out_PC               : out   std_logic_vector(12 downto 0) );
    end component;

    component PIC_IO
       port (   clk_q1                  : in    std_logic;
                clk_q2                  : in    std_logic;
                clk_q4                  : in    std_logic;
                reset                   : in    std_logic;
                Data_in_IO              : in    std_logic_vector(7 downto 0);
                Write_to_TMR0_IO        : in    std_logic;
                Write_to_OPTION_IO      : in    std_logic;
                Write_to_INTCON_IO      : in    std_logic;
                Write_to_TRISA_IO       : in    std_logic;
                Write_to_TRISB_IO       : in    std_logic;
                Clr_GIE_IO              : in    std_logic;
                Set_GIE_IO              : in    std_logic;
                T0CK1			: in    std_logic;
                SET_RBIF		: in    std_logic;
                INT0			: in    std_logic;
                TMR0_out_IO             : out   std_logic_vector(7 downto 0);
                OPTION_out_IO           : out   std_logic_vector(7 downto 0);
                INTCON_out_IO           : out   std_logic_vector(7 downto 0);
                TRISA_out_IO            : out   std_logic_vector(4 downto 0);
                TRISB_out_IO            : out   std_logic_vector(7 downto 0) );
    end component;

    component PIC_CU
       port (   OSC1                    : in  std_logic;
                reset                   : in  std_logic;
                MBR                     : in  std_logic_vector(13 downto 0);
                Zero_flag               : in  std_logic;
                TMR0                    : in  std_logic_vector( 7 downto 0);
                OPTION                  : in  std_logic_vector( 7 downto 0);
                PCL                     : in  std_logic_vector( 7 downto 0);
                STATUS                  : in  std_logic_vector( 7 downto 0);
                FSR                     : in  std_logic_vector( 7 downto 0);
                PORTA                   : in  std_logic_vector( 4 downto 0);
                TRISA                   : in  std_logic_vector( 4 downto 0);
                PORTB                   : in  std_logic_vector( 7 downto 0);
                TRISB                   : in  std_logic_vector( 7 downto 0);
                PCLATH                  : in  std_logic_vector( 7 downto 0);
                INTCON                  : in  std_logic_vector( 7 downto 0);
                RF                      : in  std_logic_vector( 7 downto 0);
                Sel_first_operand_ALU   : out std_logic_vector( 1 downto 0);
                Sel_second_operand_ALU  : out std_logic_vector( 1 downto 0);
                Execute_ALU             : out std_logic_vector( 4 downto 0);
                Check_STATUS_ALU        : out std_logic_vector( 2 downto 0);
                Write_to_W_ALU          : out std_logic;
                Write_to_STATUS_ALU     : out std_logic;
                Write_to_FSR_ALU        : out std_logic;
                Sel_part_PC             : out std_logic_vector( 1 downto 0);
                Increase_PC             : out std_logic;
                Write_to_PC             : out std_logic;
                Write_to_PCLATH_PC      : out std_logic;
                Sel_SADR_PC             : out std_logic;
                Update_SP_PC            : out std_logic_vector( 1 downto 0);
                Write_to_STACK_PC       : out std_logic;
                Addr_mode_RF            : out std_logic;
                Write_to_RF             : out std_logic;
                Write_to_TMR0_IO        : out std_logic;
                Write_to_OPTION_IO      : out std_logic;
                Write_to_INTCON_IO      : out std_logic;
                Write_to_TRISA_IO       : out std_logic;
                Write_to_PORTA_IO       : out std_logic;
                Write_to_TRISB_IO       : out std_logic;
                Write_to_PORTB_IO       : out std_logic;
                Clr_GIE_IO              : out std_logic;
                Set_GIE_IO              : out std_logic;
                IR_out_CU               : out std_logic_vector( 13 downto 0);
                Data_in_ALU             : out std_logic_vector(  7 downto 0);
                Int_occur               : out std_logic;
                clk_q1                  : out std_logic;
                clk_q2                  : out std_logic;
                clk_q3                  : out std_logic;
                clk_q4                  : out std_logic;
                CLR_MBR_CU              : out std_logic );
    end component;

        -- PIC_ALU --
        signal  Sel_first_operand_ALU   : std_logic_vector(1 downto 0);
        signal  Sel_second_operand_ALU  : std_logic_vector(1 downto 0);
        signal  Execute_ALU             : std_logic_vector(4 downto 0);
        signal  Check_STATUS_ALU        : std_logic_vector(2 downto 0);
        signal  Write_to_W_ALU          : std_logic;
        signal  Write_to_STATUS_ALU     : std_logic;
        signal  Write_to_FSR_ALU        : std_logic;
        signal  Data_out_ALU            : std_logic_vector(7 downto 0);
        signal  ALU_Zero_flag           : std_logic;

        -- PIC_RF --
        signal  Addr_mode_RF            : std_logic;
        signal  Write_to_RF             : std_logic;

        -- PIC_PC --
        signal  Sel_part_PC             : std_logic_vector( 1 downto 0);
        signal  Increase_PC             : std_logic;
        signal  Write_to_PC             : std_logic;
        signal  Write_to_PCLATH_PC      : std_logic;
        signal  Sel_SADR_PC             : std_logic;
        signal  Update_SP_PC            : std_logic_vector( 1 downto 0);
        signal  Write_to_STACK_PC       : std_logic;

        -- PIC_IO --
        signal  Write_to_TMR0_IO        : std_logic;
        signal  Write_to_OPTION_IO      : std_logic;
        signal  Write_to_INTCON_IO      : std_logic;
        signal  Write_to_TRISA_IO       : std_logic;
        signal  Write_to_PORTA_IO       : std_logic;
        signal  Write_to_TRISB_IO       : std_logic;
        signal  Write_to_PORTB_IO       : std_logic;
        signal  Clr_GIE_IO              : std_logic;
        signal  Set_GIE_IO              : std_logic;

        -- PIC_CU --
        signal  clk_q1                  : std_logic;
        signal  clk_q2                  : std_logic;
        signal  clk_q3                  : std_logic;
        signal  clk_q4                  : std_logic;
        signal  CLR_MBR_CU              : std_logic;

        -- PIC_CPU --
        signal  MBR                     : std_logic_vector(13 downto 0);
        signal  PC                      : std_logic_vector(12 downto 0);
        signal  IR                      : std_logic_vector(13 downto 0);
        signal  Data_in_ALU             : std_logic_vector( 7 downto 0);
        signal  TMR0                    : std_logic_vector( 7 downto 0);
        signal  OPTION                  : std_logic_vector( 7 downto 0);
        alias   PCL     : std_logic_vector( 7 downto 0) is PC(7 downto 0);
        signal  STATUS                  : std_logic_vector( 7 downto 0);
        signal  FSR                     : std_logic_vector( 7 downto 0);
        signal  PORTA                   : std_logic_vector( 4 downto 0);
        signal  TRISA                   : std_logic_vector( 4 downto 0);
        signal  PORTB                   : std_logic_vector( 7 downto 0);
        signal  TRISB                   : std_logic_vector( 7 downto 0);
        signal  PCLATH                  : std_logic_vector( 7 downto 0);
        signal  INTCON                  : std_logic_vector( 7 downto 0);
        signal  RF                      : std_logic_vector( 7 downto 0);
        signal  T0CK1,SET_RBIF,INT0,ISR,
                reset                  	: std_logic;
        signal  latch_a,data_latch_a    : std_logic_vector( 4 downto 0);
        signal  rlatch_b,data_latch_b  	: std_logic_vector( 7 downto 0);
        signal  flatch_b		: std_logic_vector( 7 downto 4);
begin
        OSC2    <= OSC1;
        PSENb   <= clk_q4;
        reset   <= MCLRb;

        MAR_REG:
        process(clk_q1,reset)
        begin
                if    reset = '1' then
                        MAR_OUT <= (others => '0');
                elsif rising_edge(clk_q1) then
                        MAR_OUT <= "000" & PC(9 downto 0);
                end if;
        end process;

        MBR_REG:
        process(CLR_MBR_CU,OSC1,reset)
        begin
                if    (CLR_MBR_CU = '1') OR (reset = '1') then
                        MBR <= "00000000000000";
                elsif falling_edge(OSC1) then
                        if    clk_q4 = '1' then
                                MBR <= MBR_IN;
                        end if;
                end if;
        end process;

	LATCH_PORTA:
        process(clk_q2,ra,reset)
	begin
                if    reset = '1' then
                        latch_a <= (others => '0');
                elsif rising_edge(clk_q2) then
			latch_a <= ra;
		end if;
	end process;

	PORTA <= latch_a;

	DATA_LATCH_PORTA:
        process(clk_q4,write_to_PORTA_IO,Data_out_ALU,reset)
	begin
                if    reset = '1' then
                        data_latch_a <= (others => '0');
                elsif rising_edge(clk_q4) then
			if write_to_PORTA_IO = '1' then
				data_latch_a <= Data_out_ALU(4 downto 0);
			end if;
		end if;
	end process;

	TRIS_LATCH_PORTA:
	process(TRISA,data_latch_a)
	begin
		for i in TRISA'range loop
			if TRISA(i) = '1' then
				ra(i) <= 'Z';
			else
				ra(i) <= data_latch_a(i);
			end if;
		end loop;
	end process;

	T0CK1 <= ra(4);


	LATCH_PORTB_RISE:
        process(clk_q2,rb,reset)
	begin
                if    reset = '1' then
                        rlatch_b <= (others => '0');
                elsif rising_edge(clk_q2) then
			rlatch_b <= rb;
		end if;
	end process;

	PORTB <= rlatch_b;

	INT0  <= rb(0);

	LATCH_PORTB_FALL:
        process(clk_q2,rb(7 downto 4),reset)
	begin
                if    reset = '1' then
                        flatch_b <= (others => '0');
                elsif falling_edge(clk_q2) then
			flatch_b <= rb(7 downto 4);
		end if;
	end process;

	RB_INT_ON_CHANGE:
	process(rlatch_b(7 downto 4),flatch_b,TRISB(7 downto 4))
	variable each_int : std_logic_vector(7 downto 4);
	variable rbif     : std_logic; 
	begin
		rbif := '0';
		for i in flatch_b'range loop
			each_int(i) :=  TRISB(i) AND 
					(rlatch_b(i) XOR flatch_b(i));
			rbif := rbif OR each_int(i);
		end loop;
		SET_RBIF <= rbif;
	end process;

	DATA_LATCH_PORTB:
        process(clk_q4,write_to_PORTB_IO,Data_out_ALU,reset)
	begin
                if    reset = '1' then
                        data_latch_b <= (others => '0');
                elsif rising_edge(clk_q4) then
			if write_to_PORTB_IO = '1' then
				data_latch_b <= Data_out_ALU;
			end if;
		end if;
	end process;


	TRIS_LATCH_PORTB:
	process(TRISB,data_latch_b)
	begin
		for i in TRISB'range loop
			if TRISB(i) = '1' then
				rb(i) <= 'Z';
			else
				rb(i) <= data_latch_b(i);
			end if;
		end loop;
	end process;

        ALU_BLOCK:      PIC_ALU
              port map (clk_q4,MCLRb,Data_in_ALU,IR(7 downto 0),IR(9 downto 7),
                        Sel_first_operand_ALU,Sel_second_operand_ALU,
                        Execute_ALU,Check_STATUS_ALU,
                        Write_to_W_ALU,Write_to_STATUS_ALU,Write_to_FSR_ALU,
                        Data_out_ALU,FSR,STATUS,ALU_Zero_flag );

        RF_BLOCK:       PIC_RF
              port map (reset,clk_q2,clk_q3,Data_out_ALU,
                        IR(5 downto 0),FSR(5 downto 0),
                        Addr_mode_RF,Write_to_RF,RF );

        PC_BLOCK:       PIC_PC
              port map (OSC1,clk_q2,clk_q3,clk_q4,MCLRb,ISR,
                        Data_out_ALU,IR(10 downto 0),Sel_part_PC,
                        Increase_PC,Write_to_PC,Write_to_PCLATH_PC,
                        Sel_SADR_PC,Update_SP_PC,Write_to_STACK_PC,
                        PCLATH,PC );

        IO_BLOCK:       PIC_IO
              port map (clk_q1,clk_q2,clk_q4,MCLRb,
                        Data_out_ALU,Write_to_TMR0_IO,Write_to_OPTION_IO,
                        Write_to_INTCON_IO,Write_to_TRISA_IO,
                        Write_to_TRISB_IO,
                        Clr_GIE_IO,Set_GIE_IO,T0CK1,SET_RBIF,INT0,
                        TMR0,OPTION,INTCON,TRISA,TRISB );

        CU_BLOCK:       PIC_CU
              port map (OSC1,MCLRb,MBR,ALU_Zero_flag,
                        TMR0,OPTION,PCL,STATUS,FSR,PORTA,TRISA,PORTB,TRISB,
                        PCLATH,INTCON,RF,
                        Sel_first_operand_ALU,Sel_second_operand_ALU,
                        Execute_ALU,Check_STATUS_ALU,Write_to_W_ALU,
                        Write_to_STATUS_ALU,Write_to_FSR_ALU,
                        Sel_part_PC,Increase_PC,
                        Write_to_PC,Write_to_PCLATH_PC,Sel_SADR_PC,
                        Update_SP_PC,Write_to_STACK_PC,Addr_mode_RF,
                        Write_to_RF,Write_to_TMR0_IO,Write_to_OPTION_IO,
                        Write_to_INTCON_IO,Write_to_TRISA_IO,
                        Write_to_PORTA_IO,Write_to_TRISB_IO,
                        Write_to_PORTB_IO,Clr_GIE_IO,Set_GIE_IO,IR,
                        Data_in_ALU,ISR,clk_q1,clk_q2,clk_q3,clk_q4,
                        CLR_MBR_CU );

end rtl;

configuration cpu_block of PIC_CPU is
    for rtl
        for ALU_BLOCK:  PIC_ALU
            use entity work.PIC_ALU(rtl);
        end for;
        for RF_BLOCK:   PIC_RF
            use entity work.PIC_RF(rtl);
	end for;
        for PC_BLOCK:   PIC_PC
            use entity work.PIC_PC(rtl);
	end for;
        for IO_BLOCK:   PIC_IO
            use entity work.PIC_IO(rtl);
	end for;
        for CU_BLOCK:   PIC_CU
            use entity work.PIC_CU(rtl);
	end for;
    end for;
end cpu_block;
