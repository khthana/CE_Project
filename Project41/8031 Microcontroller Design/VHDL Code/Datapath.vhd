library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------
--------------------------------
--------------------------------
   
entity DATA_PATH is
	port(		
		
		READ_P1_PIN_OUT, READ_P2_PIN_OUT, READ_P3_PIN_OUT: out std_logic;
		
		
		P0_OUTPUT_2_PIN,    P1_OUTPUT_2_PIN,    
		P2_OUTPUT_2_PIN,     P3_OUTPUT_2_PIN  : out std_logic_vector(7 downto 0);

		PSW_TO_INTBUS_F_CU				      :in std_logic;
		
		PORT_0_PIN_BUS ,
		PORT_1_PIN_BUS ,
        PORT_2_PIN_BUS ,
        PORT_3_PIN_BUS : in std_logic_vector(7 downto 0);
        	
        IR_OUT_TO_CU   : out std_logic_vector(7 downto 0);
        ALU_ENABLE : in std_logic;
        ALU_MODE   : in std_logic_vector(3 downto 0);        
		SIG_RESULT_H_READY,
        SIG_RESULT_L_READY,
        CARRY_FLAG_OUT_TO_CU,
        OVERFLOW_FLAG_TO_CU	,
        AUX_C_FLAG_TO_CU	,        
        REG_BANK_SELECT0_TO_CU,
        REG_BANK_SELECT1_TO_CU,
        INTERRUPT0,
        INTERRUPT1,
        TIMER_COUNTER0,
        TIMER_COUNTER1,
		CHECKED_BIT_STATUS         : out std_logic;

		
		W_BIT_OPERATOR_LATCH,
		PREPARE_FOR_ROTATE,
        CLR_BIT, CPL_BIT, SET_BIT, WRITE_BIT_F_CARRY,
        CHK_BIT,SET_ALL_BIT_ZERO ,	   		
		
		INC16, DEC16, ADD_WITH_RELATIVE,		
		
		ADD16_TO_ABUS,
		B_OP_OUT2BUS,
		RI_DEC_TO_BUS,
		GPR_DEC_2_BUS,
		IR_TO_INTBUS,        
		TMP1_TO_INTBUS,
        TMP2_TO_INTBUS,
		ALU_TO_INTBUS,
        ACC_TO_INTBUS_F_CU,
        RAM_TO_INTBUS,
        SP_TO_INTBUS_F_CU ,
        
        PCH_TO_INTBUS,
        PCL_TO_INTBUS,
        PC_TO_A_BUS,
        
        DPTR_TO_ADDRESS_BUS,
       	INTBUS_TO_DPH	  ,
        INTBUS_TO_DPL	  ,
        ADDRESS_BUS_TO_DPH,
        ADDRESS_BUS_TO_DPL,
        
		WRITE_IR,
        WRITE_ACC_F_CU,
        WRITE_RAM,
        WRITE_DPH_F_CU,
        WRITE_DPL_F_CU,		
        WRITE_INT_MAR,
        WRITE_TMP2_F_ACC,
        WRITE_TMP2_F_BUS,
        WRITE_TMP1,
        WRITE_SP_F_CU,
        WRITE_EXT_MAR,
        WRITE_PC_16,
        WRITE_PCH_F_INTBUS,
        WRITE_PCL_F_INTBUS,
        INC_PC,                        
        READ_EXT_MEM,
        SEND_MEMORY_READ, SEND_MEMORY_WRITE,        
        CHECK_INTERRUPT,
        ACCESS_EXT_MEM : in std_logic;
		CLOCK		:in std_logic;
		RESET		:in std_logic;
        
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
--- FOR TEST ONLY
        ACC_FT,
        PSW_FT,
        IR_FT 	     :out std_logic_vector(7 downto 0)
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
		);
end DATA_PATH;	


----------------------------------------
----- begin of ARCHITECTURE of DATA_PATH
----------------------------------------
architecture STRUCTURAL of DATA_PATH is

	component PORT2
	  port(ADDRESS_OR_DATA		:in std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		ACCESS_EXTERNAL_MEM		:in std_logic;
		PORT02_OUT_PIN			:out std_logic_vector(7 downto 0)	); 											  
	end component;


	component REDIRECT 
	  port(F_IR,
		ADDRESS_IN			:in std_logic_vector(7 downto 0);		
		RAM_TO_INTBUS,		
		WRITE_RAM			:in std_logic;		
		REAL_WRITE_RAM,
		REAL_RAM_TO_INTBUS	:out std_logic;		
		W_P0_LATCH,
		W_P1_LATCH,
		W_P2_LATCH,
		W_P3_LATCH,		
		R_P0_LATCH,
		R_P1_LATCH,
		R_P2_LATCH,
		R_P3_LATCH,		
		R_P0_PIN,
		R_P1_PIN,
		R_P2_PIN,
		R_P3_PIN,
		WRITE_PSW,		
		WRITE_B,
		WRITE_ACC,
		WRITE_SP,
		WRITE_DPH,
		WRITE_DPL,
		PSW_TO_INTBUS,
		B_TO_INTBUS,
		ACC_TO_INTBUS,
		SP_TO_INTBUS,
		DPH_TO_INTBUS,
		DPL_TO_INTBUS		:out std_logic
		);
	end component;	

    component BIT_OPERATOR
	  port(CLOCK,LOAD_IN  		:in std_logic;
	  	BIT_NUMBER 	    	:in std_logic_vector(2 downto 0);
		ORIGINAL_VALUE		:in std_logic_vector(7 downto 0);
        CARRY_FLAG			:in std_logic;
		PREPARE_FOR_ROTATE,
		CLR_BIT,
		CPL_BIT,
		SET_BIT,
		WRITE_BIT_F_CARRY,
		CHK_BIT,SET_ALL_BIT_ZERO :in std_logic;
        BIT_OPERATED 		:out std_logic_vector(7 downto 0);
        CHECKED_BIT_STATUS  :out std_logic
		);
    end component;

    component RI_DECODER 
      port(F_IR_0	:in std_logic;
		FLAG_RS1	:in std_logic;
        FLAG_RS0    :in std_logic;
		ADDRESS_OUT :out std_logic_vector(7 downto 0)
		);
    end component;

    component GPR_DECODER 
	 port(F_IR_3DT0	:in std_logic_vector(2 downto 0);
		FLAG_RS1	:in std_logic;
        FLAG_RS0    :in std_logic;
		ADDRESS_OUT :out std_logic_vector(7 downto 0)
		);
    end component;	

   component ACC 
	port(DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
   end component;

   component GENERAL_REGISTER 
	port(DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
   end component;

   component INSTRUCTION_REGISTER 
	port(DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
   end component;


   component RAM_ADDR_REG 
	port(F_IR, DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
   end component;

   component PSW 
	port(DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
        ACC_IN		:in std_logic_vector(7 downto 0);
        
		CLOCK		:in std_logic;
		LOAD_IN		:in std_logic;
		RESET		:in std_logic;
        
        CARRY_IN	:in std_logic;
		OVERFLOW_IN	:in std_logic;
        AUX_C_IN	:in std_logic;        
        
        CARRY_CHANGE 	: in std_logic;
        OVERFLOW_CHANGE : in std_logic;
        AUX_C_CHANGE 	: in std_logic);
   end component;
	
   component RAM_128_BYTE 
	generic(DATA_WIDTH	: integer:=8;
			CAPACITY	: integer:=128;
			ADDR_WIDTH 	: integer:=7);
	port(DATA_IN	:in std_logic_vector(DATA_WIDTH-1 downto 0);
		DATA_OUT	:out std_logic_vector(DATA_WIDTH-1 downto 0);
		CLOCK		:in std_logic;
		WE 		    :in std_logic;
		ADDRESS 	:in std_logic_vector(ADDR_WIDTH-1 downto 0));
   end component;

   component TMP2_REG 
	port(DATA_F_ACC	:in std_logic_vector(7 downto 0);
    	DATA_F_BUS	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;
		W_F_ACC 	:in std_logic;
		W_F_BUS		:in std_logic);
   end component;

   component PROG_ADDR_REG 
	port(DATA_IN	:in std_logic_vector(15 downto 0);
		DATA_OUT	:out std_logic_vector(15 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
   end component;

   component ALU 
	port(DATA_IN1	:in std_logic_vector(7 downto 0);
    	DATA_IN2	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;
        CARRY_IN	:in std_logic;
        CARRY_OUT 	:out std_logic;
        OVERFLOW_OUT:out std_logic;
        AUX_C_OUT   :out std_logic;
        CARRY_CHANGE : out std_logic;
        OVERFLOW_CHANGE : out std_logic;
        AUX_C_CHANGE : out std_logic;
		INSTRUCTION	:in std_logic_vector(3 downto 0);
        ALU_SELECTED :in std_logic;
        RESET			:in std_logic );					    
   end component;

   component PC 
	port(
		DATA_IN8	:in  std_logic_vector(7  downto 0);
		DATA_IN16	:in  std_logic_vector(15 downto 0);
		DATA_OUT	:out std_logic_vector(15 downto 0);
		CLOCK		:in  std_logic;
		LOAD_IN16   :in  std_logic;
        LOAD_IN8H	:in  std_logic;
        LOAD_IN8L	:in  std_logic;
        RESET		:in  std_logic;
		INC_PC		:in  std_logic
		);
   end component;

   component PORT_0_OR_2 
	port(ADDRESS_OR_DATA		:in std_logic_vector(7 downto 0);
		PORT02_IN_INTERNAL		:in std_logic_vector(7 downto 0);
		PORT02_OUT_INTERNAL		:out std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		READ_LATCH				:in std_logic;
   		READ_PIN				:in std_logic;
		WRITE_TO_LATCH	 		:in std_logic;
		ACCESS_EXTERNAL_MEM		:in std_logic;
		PORT02_OUT_PIN			:out std_logic_vector(7 downto 0);
		PORT02_IN_PIN			:in std_logic_vector(7 downto 0);
        READ_EXT_MEM			:in std_logic
		); 											  
   end component;

   component PORT1 
	port(PORT1_IN_INTERNAL		:in std_logic_vector(7 downto 0);
		PORT1_OUT_INTERNAL		:out std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		READ_LATCH				:in std_logic;
   		READ_PIN				:in std_logic;
		WRITE_TO_LATCH	 		:in std_logic;
		PORT1_OUT_PIN			:out std_logic_vector(7 downto 0);
		PORT1_IN_PIN			:in std_logic_vector(7 downto 0)
		); 											  
   end component;
	
   component PORT3 
	port(PORT3_IN_INTERNAL		:in std_logic_vector(7 downto 0);
		PORT3_OUT_INTERNAL		:out std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		READ_LATCH				:in std_logic;
   		READ_PIN				:in std_logic;
		WRITE_TO_LATCH	 		:in std_logic;
		PORT3_OUT_PIN			:out std_logic_vector(7 downto 0);
		PORT3_IN_PIN			:in std_logic_vector(7 downto 0);
        
        MEM_WR_ACTIVE_L			:in std_logic;
        MEM_RD_ACTIVE_L			:in std_logic
		); 											  
   end component;

signal
	RI_DEC_OUT,
	GPR_DEC_OUT,
	B_OUTPUT,
	ACC_OUTPUT,
	RAM_OUTPUT,
	PSW_OUT,
	ALU_OUT,
    IR_OUT,
	P0_OUTPUT_2_BUS,	P1_OUTPUT_2_BUS,	P2_OUTPUT_2_BUS	,    P3_OUTPUT_2_BUS,
    
    SP_OUTPUT,
    DPH_OUTPUT,
    DPL_OUTPUT : std_logic_vector(7 downto 0);  
    
signal  ADDRESS_BUS : std_logic_vector(15 downto 0);
signal  EXT_MAR_OUTPUT, PC_OUTPUT : std_logic_vector(15 downto 0);   
signal  INTERNAL_BUS : std_logic_vector(7 downto 0);
signal	INTRAM_ADDR : std_logic_vector(7 downto 0); 

signal
	BIT_OPERATED_TO_BUS,
    TMP2_2_ALU ,
    TMP1_2_ALU ,
    DPH_INPUT ,
    DPL_INPUT : std_logic_vector(7 downto 0);        
    
signal
	PSW_TO_INTBUS,
	PSW_TO_INTBUS_F_REDIRECT,
	ACC_TO_INTBUS,
	ACC_TO_INTBUS_F_REDIRECT,
	SP_TO_INTBUS,
	SP_TO_INTBUS_F_REDIRECT,
    DPH_TO_INTBUS,
    DPL_TO_INTBUS,
    B_TO_INTBUS,
    WRITE_DPH,
	WRITE_DPH_F_REDIRECT,
    WRITE_DPL,
	WRITE_DPL_F_REDIRECT,
    WRITE_SP,
	WRITE_SP_F_REDIRECT,
    WRITE_B,
    WRITE_PSW,
	REAL_WRITE_RAM,
	WRITE_ACC,
	WRITE_ACC_F_REDIRECT,
	READ_P0_LATCH, READ_P1_LATCH,
    READ_P2_LATCH, READ_P3_LATCH,
	READ_P1_PIN  , READ_P0_PIN  ,      
	READ_P2_PIN  , READ_P3_PIN  ,      
    W_P0_LATCH,	W_P1_LATCH,
    W_P2_LATCH,	W_P3_LATCH,
	REAL_RAM_TO_INTBUS,
    C_STATUS_F_ALU, 
    OV_STATUS_F_ALU,
    AUX_C_STATUS_F_ALU,
    C_CHANGE,
    OV_CHANGE,
    AUX_C_CHANGE : std_logic;
    
signal PULL_LOW : std_logic := '0';
signal ADD_16_OUT : std_logic_vector(15 downto 0);
----------------------------------------------
----- begin of the statement part of DATA_PATH
----------------------------------------------
begin
	REDIRECT_PORT_REG : REDIRECT port map (IR_OUT,
		INTRAM_ADDR,
		RAM_TO_INTBUS,		
		WRITE_RAM,
		
		
		REAL_WRITE_RAM,
		REAL_RAM_TO_INTBUS,
		
		W_P0_LATCH,
		W_P1_LATCH,
		W_P2_LATCH,
		W_P3_LATCH,
				
		READ_P0_LATCH,
		READ_P1_LATCH,
		READ_P2_LATCH,
		READ_P3_LATCH,
				
		READ_P0_PIN,
		READ_P1_PIN,
		READ_P2_PIN,
		READ_P3_PIN,
		
		WRITE_PSW,		
		WRITE_B,
		WRITE_ACC_F_REDIRECT,
		WRITE_SP_F_REDIRECT,
		WRITE_DPH_F_REDIRECT,
		WRITE_DPL_F_REDIRECT,
		PSW_TO_INTBUS_F_REDIRECT,
		B_TO_INTBUS,
		ACC_TO_INTBUS_F_REDIRECT,
		SP_TO_INTBUS_F_REDIRECT,
		DPH_TO_INTBUS,
		DPL_TO_INTBUS);
		
    
    DO_BIT_OPERATION : BIT_OPERATOR port map(CLOCK, W_BIT_OPERATOR_LATCH, TMP2_2_ALU(2 downto 0), 
											INTERNAL_BUS,PSW_OUT(7), PREPARE_FOR_ROTATE,
											CLR_BIT, CPL_BIT, SET_BIT, WRITE_BIT_F_CARRY,
											CHK_BIT,SET_ALL_BIT_ZERO ,BIT_OPERATED_TO_BUS,
 											CHECKED_BIT_STATUS );    
	REG_INDRCT_DEC : RI_DECODER port map (IR_OUT(0), PSW_OUT(4), PSW_OUT(3), RI_DEC_OUT);    
	GEN_P_REG_DEC : GPR_DECODER port map(IR_OUT(2 downto 0), PSW_OUT(4), PSW_OUT(3), GPR_DEC_OUT);            
	IR			  : GENERAL_REGISTER port map(INTERNAL_BUS, IR_OUT, CLOCK, WRITE_IR , RESET);
	ACCUMULATOR   : GENERAL_REGISTER port map(INTERNAL_BUS, ACC_OUTPUT, CLOCK, WRITE_ACC, RESET); 
    B_REGISTER    : GENERAL_REGISTER port map(INTERNAL_BUS, B_OUTPUT, CLOCK, WRITE_B, RESET);
	STACK_POINTER : GENERAL_REGISTER port map(INTERNAL_BUS, SP_OUTPUT, CLOCK, WRITE_SP, RESET);
    DPH			  :	GENERAL_REGISTER port map(DPH_INPUT, DPH_OUTPUT, CLOCK, WRITE_DPH, RESET);
    DPL	 		  :	GENERAL_REGISTER port map(DPL_INPUT, DPL_OUTPUT, CLOCK, WRITE_DPL, RESET);
	TEMP1   	  :	GENERAL_REGISTER port map(INTERNAL_BUS, TMP1_2_ALU, CLOCK, WRITE_TMP1, RESET);		
    INTRAM_MAR    : RAM_ADDR_REG port map(IR_OUT, INTERNAL_BUS, INTRAM_ADDR, CLOCK, WRITE_INT_MAR, RESET);
    INT_RAM		: RAM_128_BYTE port map(INTERNAL_BUS, RAM_OUTPUT, CLOCK, REAL_WRITE_RAM, INTRAM_ADDR(6 downto 0));
    TEMP2		: TMP2_REG port map(ACC_OUTPUT, INTERNAL_BUS, TMP2_2_ALU, CLOCK, WRITE_TMP2_F_ACC, WRITE_TMP2_F_BUS);
    PROG_ADDR_REG : PROG_ADDR_REG port map(ADDRESS_BUS, EXT_MAR_OUTPUT, CLOCK, WRITE_EXT_MAR, RESET);
    PROGRAM_COUNTER : PC port map (INTERNAL_BUS, ADDRESS_BUS, PC_OUTPUT, CLOCK, 
    							   WRITE_PC_16, WRITE_PCH_F_INTBUS, WRITE_PCL_F_INTBUS, RESET, INC_PC);
    PROGRAM_STATUS_WORD : PSW  port map (INTERNAL_BUS, PSW_OUT, ACC_OUTPUT, CLOCK, WRITE_PSW,
    									 RESET, C_STATUS_F_ALU, OV_STATUS_F_ALU, AUX_C_STATUS_F_ALU,
    									 C_CHANGE, OV_CHANGE, AUX_C_CHANGE);
    ALU_AND_SHIFTER : ALU port map( TMP2_2_ALU, TMP1_2_ALU, ALU_OUT, CLOCK, PSW_OUT(7), C_STATUS_F_ALU, 
    								OV_STATUS_F_ALU, AUX_C_STATUS_F_ALU , C_CHANGE, OV_CHANGE, AUX_C_CHANGE,
                                    ALU_MODE, ALU_ENABLE, RESET);
    PORT0_REG : PORT_0_OR_2 port map(EXT_MAR_OUTPUT(7 downto 0), INTERNAL_BUS, P0_OUTPUT_2_BUS,
    								 CLOCK, RESET, READ_P0_LATCH, READ_P0_PIN, W_P0_LATCH, ACCESS_EXT_MEM, 
                                     P0_OUTPUT_2_PIN, PORT_0_PIN_BUS, READ_EXT_MEM );

	PORT2_REG : PORT_0_OR_2 port map(EXT_MAR_OUTPUT(15 downto 8), INTERNAL_BUS, P2_OUTPUT_2_BUS,
    								 CLOCK, RESET, READ_P2_LATCH, READ_P2_PIN, W_P2_LATCH, ACCESS_EXT_MEM, 
                                     P2_OUTPUT_2_PIN, PORT_2_PIN_BUS, PULL_LOW ); 
	
	
	
    PORT1_REG : PORT1 port map  (INTERNAL_BUS, P1_OUTPUT_2_BUS, CLOCK, RESET, READ_P1_LATCH,
    							 READ_P1_PIN, W_P1_LATCH, P1_OUTPUT_2_PIN, PORT_1_PIN_BUS);

	PORT3_REG : PORT3 port map ( INTERNAL_BUS, P3_OUTPUT_2_BUS, CLOCK, RESET, READ_P3_LATCH,
    							 READ_P3_PIN, W_P3_LATCH, P3_OUTPUT_2_PIN, PORT_3_PIN_BUS,
                                 SEND_MEMORY_READ, SEND_MEMORY_WRITE);    						


   	INTERNAL_BUS <= RAM_OUTPUT when REAL_RAM_TO_INTBUS = '1' else "ZZZZZZZZ"; 
   	INTERNAL_BUS <= B_OUTPUT when B_TO_INTBUS = '1' else "ZZZZZZZZ";     	
   	INTERNAL_BUS <= ACC_OUTPUT when ACC_TO_INTBUS = '1' else "ZZZZZZZZ";    	
	INTERNAL_BUS <= PSW_OUT when PSW_TO_INTBUS = '1' else "ZZZZZZZZ";    	
    INTERNAL_BUS <= ALU_OUT when ALU_TO_INTBUS = '1' else "ZZZZZZZZ";    	
    ADDRESS_BUS <= ADD_16_OUT when ADD16_TO_ABUS = '1' else "ZZZZZZZZZZZZZZZZ";
    INTERNAL_BUS <= BIT_OPERATED_TO_BUS when B_OP_OUT2BUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= GPR_DEC_OUT when GPR_DEC_2_BUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= RI_DEC_OUT when RI_DEC_TO_BUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= IR_OUT when IR_TO_INTBUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= TMP1_2_ALU when TMP1_TO_INTBUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= TMP2_2_ALU when TMP2_TO_INTBUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= SP_OUTPUT when SP_TO_INTBUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= DPH_OUTPUT when DPH_TO_INTBUS = '1' else "ZZZZZZZZ";    	
    INTERNAL_BUS <= DPL_OUTPUT when DPL_TO_INTBUS = '1' else "ZZZZZZZZ";    	
    ADDRESS_BUS(15 downto 8) <= DPH_OUTPUT when DPTR_TO_ADDRESS_BUS = '1' else "ZZZZZZZZ";     	
    ADDRESS_BUS(7 downto 0)  <= DPL_OUTPUT when DPTR_TO_ADDRESS_BUS = '1' else "ZZZZZZZZ";
    DPH_INPUT <=  INTERNAL_BUS when WRITE_DPH = '1' else "ZZZZZZZZ";--INTBUS_TO_DPH            
    DPL_INPUT <= INTERNAL_BUS when WRITE_DPL = '1'  else "ZZZZZZZZ";--INTBUS_TO_DPL
    DPH_INPUT <= ADDRESS_BUS(15 downto 8) when ADDRESS_BUS_TO_DPH = '1' else "ZZZZZZZZ";
    DPL_INPUT <= ADDRESS_BUS(7 downto 0) when ADDRESS_BUS_TO_DPL = '1' else "ZZZZZZZZ";    	
    INTERNAL_BUS <= PC_OUTPUT(15 downto 8) when PCH_TO_INTBUS = '1' else "ZZZZZZZZ";
    INTERNAL_BUS <= PC_OUTPUT(7 downto 0) when PCL_TO_INTBUS = '1' else "ZZZZZZZZ";    	
    ADDRESS_BUS <= PC_OUTPUT when PC_TO_A_BUS = '1' else "ZZZZZZZZZZZZZZZZ";



--	DRV_P0_TO_INTBUS_OUT : block (READ_P0_PIN = '1' or READ_P0_LATCH = '1' or READ_EXT_MEM = '1')
    INTERNAL_BUS <= P0_OUTPUT_2_BUS when READ_P0_PIN = '1' else "ZZZZZZZZ";     
    INTERNAL_BUS <= P0_OUTPUT_2_BUS when READ_P0_LATCH = '1' else "ZZZZZZZZ";     
    INTERNAL_BUS <= P0_OUTPUT_2_BUS when READ_EXT_MEM = '1' else "ZZZZZZZZ";     		
    	

    
--	DRV_P1_TO_INTBUS_OUT : block (READ_P1_PIN = '1' or READ_P1_LATCH = '1')
    INTERNAL_BUS <= P1_OUTPUT_2_BUS when READ_P1_PIN = '1' else "ZZZZZZZZ";
	INTERNAL_BUS <= P1_OUTPUT_2_BUS when READ_P1_LATCH = '1' else "ZZZZZZZZ";

       	

--	DRV_P2_TO_INTBUS_OUT : block (READ_P2_PIN = '1' or READ_P2_LATCH = '1')
    INTERNAL_BUS <= P2_OUTPUT_2_BUS when READ_P2_PIN = '1' else "ZZZZZZZZ";  
	INTERNAL_BUS <= P2_OUTPUT_2_BUS when READ_P2_LATCH = '1' else "ZZZZZZZZ";
    	


--	DRV_P3_TO_INTBUS_OUT : block (READ_P3_PIN = '1' or READ_P3_LATCH = '1')
    INTERNAL_BUS <= P3_OUTPUT_2_BUS when READ_P3_PIN = '1' else "ZZZZZZZZ";
	INTERNAL_BUS <= P3_OUTPUT_2_BUS when READ_P3_LATCH = '1' else "ZZZZZZZZ";

-----------------------------------------
    
    CARRY_FLAG_OUT_TO_CU   <= PSW_OUT(7);
    OVERFLOW_FLAG_TO_CU	   <= PSW_OUT(2);
    AUX_C_FLAG_TO_CU	   <= PSW_OUT(6);
    REG_BANK_SELECT0_TO_CU <= PSW_OUT(3);
    REG_BANK_SELECT1_TO_CU <= PSW_OUT(4);
    
    INTERRUPT0		<= PORT_3_PIN_BUS(2);
    INTERRUPT1		<= PORT_3_PIN_BUS(3); 
    TIMER_COUNTER0	<= PORT_3_PIN_BUS(4);
    TIMER_COUNTER1  <= PORT_3_PIN_BUS(5);
	
	READ_P1_PIN_OUT <= READ_P1_PIN;
	READ_P2_PIN_OUT	<= READ_P2_PIN;
	READ_P3_PIN_OUT <= READ_P3_PIN;
	
    
    PULL_LOW 		<= '0';
    IR_OUT_TO_CU   	<= IR_OUT;
	WRITE_ACC 		<= WRITE_ACC_F_REDIRECT or WRITE_ACC_F_CU;
	WRITE_DPH		<= WRITE_DPH_F_REDIRECT or WRITE_DPH_F_CU;
	WRITE_DPL		<= WRITE_DPL_F_REDIRECT or WRITE_DPL_F_CU;
	SP_TO_INTBUS    <= SP_TO_INTBUS_F_REDIRECT or SP_TO_INTBUS_F_CU;
	ACC_TO_INTBUS	<= ACC_TO_INTBUS_F_REDIRECT or ACC_TO_INTBUS_F_CU;	
	PSW_TO_INTBUS	<= PSW_TO_INTBUS_F_REDIRECT or PSW_TO_INTBUS_F_CU;
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
--- FOR  TEST ONLY
        ACC_FT 		   <= ACC_OUTPUT;
        PSW_FT 		   <= PSW_OUT;
        IR_FT 		   <= IR_OUT;
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4        
	
    
end STRUCTURAL;	