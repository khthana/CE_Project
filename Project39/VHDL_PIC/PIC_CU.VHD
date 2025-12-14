------------------------------------------------------------------------
-- Control Unit block
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity PIC_CU is
    port (	OSC1			: in  std_logic;
		reset			: in  std_logic;
		MBR			: in  std_logic_vector(13 downto 0);
		Zero_flag		: in  std_logic;
		TMR0			: in  std_logic_vector( 7 downto 0);
		OPTION			: in  std_logic_vector( 7 downto 0);
		PCL			: in  std_logic_vector( 7 downto 0);
		STATUS			: in  std_logic_vector( 7 downto 0);
		FSR			: in  std_logic_vector( 7 downto 0);
		PORTA			: in  std_logic_vector( 4 downto 0);
		TRISA			: in  std_logic_vector( 4 downto 0);
		PORTB			: in  std_logic_vector( 7 downto 0);
		TRISB			: in  std_logic_vector( 7 downto 0);
		PCLATH			: in  std_logic_vector( 7 downto 0);
		INTCON			: in  std_logic_vector( 7 downto 0);
		RF			: in  std_logic_vector( 7 downto 0);
		Sel_first_operand_ALU	: out std_logic_vector( 1 downto 0);
		Sel_second_operand_ALU	: out std_logic_vector( 1 downto 0);
		Execute_ALU		: out std_logic_vector( 4 downto 0);
		Check_STATUS_ALU	: out std_logic_vector( 2 downto 0);
		Write_to_W_ALU		: out std_logic;
		Write_to_STATUS_ALU	: out std_logic;
		Write_to_FSR_ALU	: out std_logic;
		Sel_part_PC		: out std_logic_vector( 1 downto 0);
                Increase_PC             : out std_logic;
                Write_to_PC             : out std_logic;
                Write_to_PCLATH_PC      : out std_logic;
		Sel_SADR_PC		: out std_logic;
		Update_SP_PC		: out std_logic_vector( 1 downto 0);
		Write_to_STACK_PC	: out std_logic;
		Addr_mode_RF		: out std_logic;
		Write_to_RF		: out std_logic;
		Write_to_TMR0_IO	: out std_logic;
		Write_to_OPTION_IO	: out std_logic;
		Write_to_INTCON_IO	: out std_logic;
		Write_to_TRISA_IO	: out std_logic;
		Write_to_PORTA_IO	: out std_logic;
		Write_to_TRISB_IO	: out std_logic;
		Write_to_PORTB_IO	: out std_logic;
		Clr_GIE_IO		: out std_logic;
		Set_GIE_IO		: out std_logic;
		IR_out_CU		: out std_logic_vector( 13 downto 0);
                Data_in_ALU             : out std_logic_vector(  7 downto 0);
                Int_occur               : out std_logic;
                clk_q1                  : out std_logic;
                clk_q2                  : out std_logic;
                clk_q3                  : out std_logic;
                clk_q4                  : out std_logic;
                CLR_MBR_CU              : out std_logic );

end PIC_CU;

architecture rtl of PIC_CU is

    component DEC1_CU
        port (  IR              : in  std_logic_vector(13 downto 0);
                Sel_first_op    : out std_logic_vector( 1 downto 0);
                Sel_second_op   : out std_logic_vector( 1 downto 0);
                Execute         : out std_logic_vector( 4 downto 0);
                Chk_status      : out std_logic_vector( 2 downto 0);
                Sel_SADR        : out std_logic;
                Update_SP       : out std_logic_vector( 1 downto 0);
                Wr_STACK        : out std_logic;
                Sel_part_PC     : out std_logic_vector( 1 downto 0);
                Wr_PC           : out std_logic;
                Set_GIE         : out std_logic;
                Skip_if_clr     : out std_logic;
                Skip_if_set     : out std_logic );
    end component;

    component DEC2_CU
        port (  IR              : in std_logic_vector(13 downto 0);
                BANK            : in std_logic_vector( 1 downto 0);
                FSR             : in std_logic_vector( 6 downto 0);
                Wr_W            : out std_logic;
                Wr_STATUS       : out std_logic;
                Wr_FSR          : out std_logic;
                Wr_PC           : out std_logic;
                Wr_PCLATCH      : out std_logic;
                Adr_RF          : out std_logic;
                Wr_RF           : out std_logic;
                Wr_TMR0         : out std_logic;
                Wr_OPTION       : out std_logic;
                Wr_INTCON       : out std_logic;
                Wr_PORTA        : out std_logic;
                Wr_PORTB        : out std_logic;
                Wr_TRISA        : out std_logic;
                Wr_TRISB        : out std_logic  );
    end component;

    component CLK_CU
        port (  osc1            : in  std_logic;
                reset           : in  std_logic;
                clk_q1          : out std_logic;
                clk_q2          : out std_logic;
                clk_q3          : out std_logic;
                clk_q4          : out std_logic );
    end component;

    component MUX_CU
        port (  Direct  : in  std_logic_vector(6 downto 0);
                Adr_RF  : in  std_logic;
                TMR0    : in  std_logic_vector(7 downto 0);
                OPTION  : in  std_logic_vector(7 downto 0);
                PCL     : in  std_logic_vector(7 downto 0);
                STATUS  : in  std_logic_vector(7 downto 0);
                FSR     : in  std_logic_vector(7 downto 0);
                PORTA   : in  std_logic_vector(7 downto 0);
                TRISA   : in  std_logic_vector(7 downto 0);
                PORTB   : in  std_logic_vector(7 downto 0);
                TRISB   : in  std_logic_vector(7 downto 0);
                PCLATH  : in  std_logic_vector(7 downto 0);
                INTCON  : in  std_logic_vector(7 downto 0);
                RF      : in  std_logic_vector(7 downto 0);
                Dout    : out std_logic_vector(7 downto 0);
                BANK    : out std_logic_vector(1 downto 0) );
    end component;

    component FSM_CU
        port (  clk             : in  std_logic;
                reset           : in  std_logic;
                SKIP            : in  std_logic;
                INT             : in  std_logic;
                Write_to_PC     : in  std_logic;
                Sel_des_IR_CU   : out std_logic;
                Increase_PC     : out std_logic;
                CLR_MBR_CU      : out std_logic;
                Load_INT_CU     : out std_logic;
                WR_PC_CU        : out std_logic;
                CLR_INT_CU      : out std_logic  );
    end component;

	alias	GIE   : std_logic is INTCON(7);
	alias	T0IE  : std_logic is INTCON(5);
	alias	INTIE : std_logic is INTCON(4);
	alias	RBIE  : std_logic is INTCON(3);
	alias	T0IF  : std_logic is INTCON(2);
	alias	INTF  : std_logic is INTCON(1);
	alias	RBIF  : std_logic is INTCON(0);


        -- CLOCK GENERATE
        signal  clkq1,clkq2,
                clkq3,clkq4     : std_logic;

        -- FSM_CU
        signal  Skip_if_clr,Sel_des_IR,Skip_if_set,
                SKIP,INT_TMP,INT,CLR_MBR,
                Load_INT,Clr_INT,
                Wr_PC,Inc_PC,
                Wr_to_PC        : std_logic;

        -- DECCODER 1,2
        signal  Wr_PC1,Wr_PC2   : std_logic;
        signal  Sel_first_op,
                Sel_second_op   : std_logic_vector(1 downto 0);
        signal  Execute         : std_logic_vector(4 downto 0);
        signal  Check_STATUS    : std_logic_vector(2 downto 0);
        signal  Write_to_W,
                Write_to_STATUS,
                Write_to_FSR    : std_logic;
        signal  Sel_pc          : std_logic_vector(1 downto 0);
        signal  Write_to_PCLATH,
                Sel_SADR        : std_logic;
        signal  Update_SP       : std_logic_vector(1 downto 0);
        signal  Write_to_STACK,
                Adr_RF,
                Write_RF,
                Write_to_TMR0,
                Write_to_OPTION,
                Write_to_INTCON,
                Write_to_TRISA,
                Write_to_PORTA,
                Write_to_TRISB,
                Write_to_PORTB,
                Set_GIE         : std_logic;

        -- ADDRESS MULTIPLEXR
        signal  ADR_MUX_OUT     : std_logic_vector( 7 downto 0);
	signal	BANK		: std_logic_vector( 1 downto 0);
	signal  TRISA_X,PORTA_X : std_logic_vector( 7 downto 0);

        -- CONTROL UNIT
        signal  IR,MUX_IR_OUT   : std_logic_vector(13 downto 0);

begin
        -- CLOCK GENERATE ---------------------------
        clk_q1  <= clkq1;
        clk_q2  <= clkq2;
        clk_q3  <= clkq3;
        clk_q4  <= clkq4;
                       
	CLOCK_GEN: CLK_CU
                      port map (OSC1,reset,clkq1,clkq2,clkq3,clkq4 );

        -- FSM_CU         ---------------------------
        Increase_PC <= Inc_PC and (not INT_TMP);
        CLR_MBR_CU  <= CLR_MBR;
        Write_to_PC <= Wr_to_PC;
        SKIP        <= (Skip_if_clr and      Zero_flag) or
                       (Skip_if_set and (not Zero_flag) );
        INT_TMP     <= GIE and ( (T0IF and T0IE)  or
                                 (RBIF and RBIE)  or
                                 (INTF and INTIE) );

        FSM_CTRL:  FSM_CU
                      port map (OSC1,reset,SKIP,INT,WR_PC,Sel_des_IR,
                                Inc_PC,CLR_MBR,Load_INT,
                                Wr_to_PC,Clr_INT);

        -- DECODER 1, 2   ---------------------------

        Sel_first_operand_ALU   <= Sel_first_op;
        Sel_second_operand_ALU  <= Sel_second_op;
        Execute_ALU             <= Execute;
        Check_STATUS_ALU        <= Check_STATUS;
        Write_to_W_ALU          <= Write_to_W;
        Write_to_STATUS_ALU     <= Write_to_STATUS;
        Write_to_FSR_ALU        <= Write_to_FSR;
        Sel_part_PC             <= Sel_pc;
        Write_to_PCLATH_PC      <= Write_to_PCLATH;
        Sel_SADR_PC             <= Sel_SADR;
        Update_SP_PC            <= Update_SP;
        Write_to_STACK_PC       <= Write_to_STACK;
        Addr_mode_RF            <= Adr_RF;
        Write_to_RF             <= Write_RF;
        Write_to_TMR0_IO        <= Write_to_TMR0;
        Write_to_OPTION_IO      <= Write_to_OPTION;
        Write_to_INTCON_IO      <= Write_to_INTCON;
        Write_to_TRISA_IO       <= Write_to_TRISA;
        Write_to_PORTA_IO       <= Write_to_PORTA;
        Write_to_TRISB_IO       <= Write_to_TRISB;
        Write_to_PORTB_IO       <= Write_to_PORTB;
        Set_GIE_IO              <= Set_GIE;
        Clr_GIE_IO              <= Clr_INT;

        Wr_PC                   <= Wr_PC1 or Wr_PC2;

        DECODER1:  DEC1_CU
		      port map (IR,
                                Sel_first_op,Sel_second_op,
                                Execute,Check_STATUS,
                                Sel_SADR,Update_SP,
                                Write_to_STACK,Sel_pc,Wr_PC1,
                                Set_GIE,Skip_if_clr,Skip_if_set );

	DECODER2:  DEC2_CU
		      port map (IR,BANK,FSR(6 downto 0),
                                Write_to_W,Write_to_STATUS,
                                Write_to_FSR,
                                Wr_PC2,Write_to_PCLATH,
                                Adr_RF,Write_RF,
                                Write_to_TMR0,
                                Write_to_OPTION,Write_to_INTCON,
                                Write_to_PORTA,Write_to_PORTB,
                                Write_to_TRISA,Write_to_TRISB );

        -- ADDRESS MULTIPLEXER ----------------------

        Data_in_ALU     <= ADR_MUX_OUT;
	TRISA_X		<= "000" & TRISA;
	PORTA_X		<= "000" & PORTA;
	

        ADR_MUX:   MUX_CU
		      port map (IR(6 downto 0),Adr_RF,TMR0,OPTION,
				PCL,STATUS,FSR,PORTA_X,TRISA_X,PORTB,TRISB,
                                PCLATH,INTCON,RF,ADR_MUX_OUT,BANK );

        -- CONTROL_UNIT -----------------------------

        IR_out_CU <= IR;

        MUX_IR:
        process(Sel_des_IR,MBR)
	begin
                if Sel_des_IR = '1' then
                        -- Instr = CALL #004h
			MUX_IR_OUT <= "10000000000100";
		else
			MUX_IR_OUT <= MBR;
		end if;
	end process;

        IR_REG:
        process(clkq2,reset)
	begin
                if    reset = '1' then
                        IR <= (others => '0');
                elsif rising_edge(clkq2) then
			IR <= MUX_IR_OUT;
		end if;
	end process;

        INT_REG:
        process(Load_INT,reset)
        begin
                if    reset = '1' then
                        INT <= '0';
                elsif rising_edge(Load_INT) then
                        INT <= INT_TMP;
		end if;
	end process;
        Int_occur <= INT;

end rtl;

configuration cu_block of PIC_CU is
    for rtl
        for CLOCK_GEN:  CLK_CU
            use entity work.CLK_CU(rtl);
        end for;

        for FSM_CTRL:   FSM_CU
            use entity work.FSM_CU(rtl);
	end for;

        for DECODER1:   DEC1_CU
            use entity work.DEC1_CU(rtl);
	end for;

        for DECODER2:   DEC2_CU
            use entity work.DEC2_CU(rtl);
	end for;

        for ADR_MUX:    MUX_CU
            use entity work.MUX_CU(rtl);
	end for;
    end for;
end cu_block;
