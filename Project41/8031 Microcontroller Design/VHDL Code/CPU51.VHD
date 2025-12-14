library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CPU_MCS_51 is
   port(
		P0_PIN ,
		P1_PIN ,
        P2_PIN ,
        P3_PIN      : inout std_logic_vector(7 downto 0) ;
        PSEN,
        ALE			: out std_logic;
        CLOCK,
        RESET 		: in std_logic;
        
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
--- FOR TEST ONLY
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        ACC,
        PSW,
        IRs         : out std_logic_vector(7 downto 0)
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
        
		);        
        
end CPU_MCS_51;	

architecture STRUCTURE of CPU_MCS_51 is
	component DATA_PATH
		port(		
		
		READ_P1_PIN_OUT, READ_P2_PIN_OUT, READ_P3_PIN_OUT: out std_logic;
		
		
		P0_OUTPUT_2_PIN,    P1_OUTPUT_2_PIN,    
		P2_OUTPUT_2_PIN,    P3_OUTPUT_2_PIN  : out std_logic_vector(7 downto 0);

		PSW_TO_INTBUS_F_CU				      :in std_logic;
		
		PORT_0_PIN_BUS ,
		PORT_1_PIN_BUS ,
        PORT_2_PIN_BUS ,
        PORT_3_PIN_BUS : in std_logic_vector(7 downto 0);
		
		------------------------------------------
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
    end component;

    component CONTROL_UNIT 
	port(P0_NOT_TO_PIN 					: out std_logic;
		RESET   					  	: in std_logic;
		PSEN , ALE 						: out std_logic;  
        IR			  					: in std_logic_vector(7 downto 0);
        ALU_ENABLE 						: out std_logic;
        ALU_MODE   						: out std_logic_vector(3 downto 0);        
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
		CHECKED_BIT_STATUS         : in std_logic;
		
		W_BIT_OPERATOR_LATCH,
		PREPARE_FOR_ROTATE,
        CLR_BIT, 
        CPL_BIT, 
        SET_BIT, 
        WRITE_BIT_F_CARRY,
        CHK_BIT,
        SET_ALL_BIT_ZERO ,		
		INC16, 
		DEC16, 		
		ADD16_TO_ABUS,
		B_OP_OUT2BUS,
		RI_DEC_TO_BUS,
		GPR_DEC_2_BUS,
		IR_TO_INTBUS,        
		TMP1_TO_INTBUS,
        TMP2_TO_INTBUS,
		ALU_TO_INTBUS,        
        ACC_TO_INTBUS,        
        RAM_TO_INTBUS,
        SP_TO_INTBUS ,        
        PCH_TO_INTBUS,
        WRITE_PCL_F_INTBUS,
        PC_TO_A_BUS,
       	INTBUS_TO_DPH	  ,
        INTBUS_TO_DPL	  ,        
		WRITE_IR,
        WRITE_ACC,        
        WRITE_RAM,
        WRITE_DPH,
        WRITE_DPL,
        WRITE_INT_MAR,
        WRITE_TMP2_F_ACC,
        WRITE_TMP2_F_BUS,        
        WRITE_TMP1,
        WRITE_SP,
        WRITE_EXT_MAR,
        INC_PC,        
        READ_EXT_MEM,
        ACCESS_EXT_MEM,
		PSW_TO_INTBUS 		: out std_logic;
		CLOCK				: in  std_logic	);
	  end component;
    	
---- ***************************************************************
---- signal declaration
---- ***************************************************************        	
	signal P0_OUTPUT_2_PIN,    
		   P1_OUTPUT_2_PIN,    
		   P2_OUTPUT_2_PIN,     
		   P3_OUTPUT_2_PIN  : std_logic_vector(7 downto 0);  
	signal READ_P3_PIN, READ_P2_PIN, READ_P1_PIN : std_logic;
    signal IR  :  std_logic_vector(7 downto 0);	
    signal ALU_ENABLE :  std_logic;
    signal ALU_MODE   :  std_logic_vector(3 downto 0);
	signal SIG_RESULT_H_READY,
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
		CHECKED_BIT_STATUS         :  std_logic;		
   signal P0_NOT_TO_PIN,
        W_BIT_OPERATOR_LATCH,
		PREPARE_FOR_ROTATE,
        CLR_BIT, CPL_BIT, SET_BIT, 
		WRITE_BIT_F_CARRY,
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
        ACC_TO_INTBUS,        
        RAM_TO_INTBUS,
        SP_TO_INTBUS ,        
        PCH_TO_INTBUS,
        PCL_TO_INTBUS,
        PC_TO_A_BUS,        
        DPTR_TO_ADDRESS_BUS,
       	INTBUS_TO_DPH	  ,
        INTBUS_TO_DPL	  ,
        ADDRESS_BUS_TO_DPH,
        ADDRESS_BUS_TO_DPL,        
		WRITE_IR,
        WRITE_ACC,        
        WRITE_RAM,
        WRITE_DPH,
        WRITE_DPL,
        WRITE_INT_MAR,
        WRITE_TMP2_F_ACC,
        WRITE_TMP2_F_BUS,        
        WRITE_TMP1,
        WRITE_SP,
        WRITE_EXT_MAR,
        WRITE_PC_16,
        WRITE_PCH_F_INTBUS,
        WRITE_PCL_F_INTBUS,
        INC_PC,      
		READ_EXT_MEM,
        SEND_MEMORY_READ, SEND_MEMORY_WRITE,        
        CHECK_INTERRUPT,
        ACCESS_EXT_MEM,
		PSW_TO_INTBUS :  std_logic;
---- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
---- THE STATEMENT part of this architecture
---- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
begin
	DATA_PATH_OF51 : DATA_PATH port map(
										READ_P1_PIN, 
										READ_P2_PIN, 
										READ_P3_PIN,---: out std_logic;
		
										P0_OUTPUT_2_PIN,    
										P1_OUTPUT_2_PIN,    
										P2_OUTPUT_2_PIN,     
										P3_OUTPUT_2_PIN,---  : out std_logic_vector(7 downto 0);

										PSW_TO_INTBUS,--- ///:in std_logic;
		
										P0_PIN,P1_PIN,
										P2_PIN,P3_PIN,										
										-------------------------------------------
										IR,
								        ALU_ENABLE ,
								        ALU_MODE ,
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
										CHECKED_BIT_STATUS  ,		
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
								        ACC_TO_INTBUS,									    
								        RAM_TO_INTBUS,
								        SP_TO_INTBUS ,        
								        PCH_TO_INTBUS,
								        PCL_TO_INTBUS,
								        PC_TO_A_BUS,        
								        DPTR_TO_ADDRESS_BUS,
								       	INTBUS_TO_DPH	  ,
								        INTBUS_TO_DPL	  ,
								        ADDRESS_BUS_TO_DPH,
								        ADDRESS_BUS_TO_DPL,        
										WRITE_IR,
								        WRITE_ACC,								        
								        WRITE_RAM,
								        WRITE_DPH,
								        WRITE_DPL,
								        WRITE_INT_MAR,
								        WRITE_TMP2_F_ACC,
								        WRITE_TMP2_F_BUS,								        
								        WRITE_TMP1,
								        WRITE_SP,
								        WRITE_EXT_MAR,
								        WRITE_PC_16,
								        WRITE_PCH_F_INTBUS,
								        WRITE_PCL_F_INTBUS,
								        INC_PC,								        
								        READ_EXT_MEM,
								        SEND_MEMORY_READ, SEND_MEMORY_WRITE,        
								        CHECK_INTERRUPT,
								        ACCESS_EXT_MEM ,
										CLOCK	  ,
										RESET	  ,        
									    ACC,
								        PSW,
								        IR    );
	
    
	CU_OF_MCS51 : CONTROL_UNIT port map (P0_NOT_TO_PIN,
									    RESET,
                                	    PSEN , ALE ,        
								        IR,
								        ALU_ENABLE ,
								        ALU_MODE ,
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
										CHECKED_BIT_STATUS ,		
										W_BIT_OPERATOR_LATCH,
										PREPARE_FOR_ROTATE,
								        CLR_BIT, CPL_BIT, SET_BIT, WRITE_BIT_F_CARRY,
								        CHK_BIT,SET_ALL_BIT_ZERO ,	   				
										INC16, DEC16,
										ADD16_TO_ABUS,
										B_OP_OUT2BUS,
										RI_DEC_TO_BUS,
										GPR_DEC_2_BUS,
										IR_TO_INTBUS,        
										TMP1_TO_INTBUS,
								        TMP2_TO_INTBUS,
										ALU_TO_INTBUS,								        
								        ACC_TO_INTBUS,								        
								        RAM_TO_INTBUS,
									    SP_TO_INTBUS ,	        
								        PCH_TO_INTBUS,
								        WRITE_PCL_F_INTBUS,
								        PC_TO_A_BUS,								        
								       	INTBUS_TO_DPH	  ,
								        INTBUS_TO_DPL	  ,
								        WRITE_IR,
								        WRITE_ACC,								        
								        WRITE_RAM,
								        WRITE_DPH,
								        WRITE_DPL,
								        WRITE_INT_MAR,
								        WRITE_TMP2_F_ACC,
								        WRITE_TMP2_F_BUS,							        
								        WRITE_TMP1,
									    WRITE_SP,
								        WRITE_EXT_MAR,								        
								        INC_PC,								        
									    READ_EXT_MEM,								        
								        ACCESS_EXT_MEM ,
										PSW_TO_INTBUS,
										CLOCK );
    

	FOR_MONITOR_IR : IRs <= IR;  
	P0_PIN <= P0_OUTPUT_2_PIN when P0_NOT_TO_PIN /= '1' else "ZZZZZZZZ";
	P1_PIN <= P1_OUTPUT_2_PIN when READ_P1_PIN /= '1' else "ZZZZZZZZ";
	DRV_P3_TO_PIN_OUT : block (READ_P3_PIN /= '1' and CHECK_INTERRUPT /= '1' )
    P3_PIN <= P3_OUTPUT_2_PIN when READ_P3_PIN /= '1' else "ZZZZZZZZ";
	P2_PIN <= P2_OUTPUT_2_PIN when READ_P2_PIN /= '1' else "ZZZZZZZZ";	
	
	
	

end STRUCTURE;		   
