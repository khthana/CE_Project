---  February 10th, 1999
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity CONTROL_UNIT is
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
        INTERRUPT0,INTERRUPT1,
        TIMER_COUNTER0, TIMER_COUNTER1,
		CHECKED_BIT_STATUS         : in std_logic;		
		W_BIT_OPERATOR_LATCH,
		PREPARE_FOR_ROTATE,
        CLR_BIT, CPL_BIT, 
        SET_BIT, WRITE_BIT_F_CARRY,
        CHK_BIT, SET_ALL_BIT_ZERO ,		
		INC16, DEC16, ADD16_TO_ABUS,
		B_OP_OUT2BUS, RI_DEC_TO_BUS,
		GPR_DEC_2_BUS, IR_TO_INTBUS,        
		TMP1_TO_INTBUS, TMP2_TO_INTBUS,
		ALU_TO_INTBUS, ACC_TO_INTBUS,        
        RAM_TO_INTBUS, SP_TO_INTBUS ,        
        PCH_TO_INTBUS,
        WRITE_PCL_F_INTBUS,
        PC_TO_A_BUS,
       	INTBUS_TO_DPH	  ,
        INTBUS_TO_DPL	  ,        
		WRITE_IR, WRITE_ACC,       
        WRITE_RAM, WRITE_DPH,
        WRITE_DPL, WRITE_INT_MAR,
        WRITE_TMP2_F_ACC,
        WRITE_TMP2_F_BUS,       
        WRITE_TMP1, WRITE_SP,
        WRITE_EXT_MAR, INC_PC,		          
        READ_EXT_MEM, ACCESS_EXT_MEM,
		PSW_TO_INTBUS 		: out std_logic;
		CLOCK				: in  std_logic	);
end CONTROL_UNIT;	


architecture DATA_PATH of CONTROL_UNIT is
	constant ADD_INS :std_logic_vector(3 downto 0)	:="0000";
	constant ADDC_INS :std_logic_vector(3 downto 0)	:="0001";		
	constant SUBB_INS :std_logic_vector(3 downto 0)	:="0010";
	constant MUL_INS :std_logic_vector(3 downto 0)	:="0011";
	constant DIV_INS :std_logic_vector(3 downto 0)	:="0100";	
	constant AND_INS :std_logic_vector(3 downto 0)	:="0101";
	constant OR_INS	 :std_logic_vector(3 downto 0)	:="0110";
	constant XOR_INS :std_logic_vector(3 downto 0)	:="0111";

	constant NOT_INS :std_logic_vector(3 downto 0)	:="1000";
	constant RR_INS  :std_logic_vector(3 downto 0)	:="1001";
	constant RL_INS  :std_logic_vector(3 downto 0)	:="1010";

	constant RRC_INS :std_logic_vector(3 downto 0)	:="1011";
	constant RLC_INS :std_logic_vector(3 downto 0)	:="1100";		
	constant INC_INS :std_logic_vector(3 downto 0)	:="1101";
	constant DEC_INS :std_logic_vector(3 downto 0)	:="1110";
	constant NO_OP_INS :std_logic_vector(3 downto 0):="1111";
        
--- ############################################################################
--- The statement part of this architecture
--- ############################################################################        
begin
	SEND_CONTROL : process (CLOCK)
		variable NOW_STAGE, OVERLAPED_STAGE : integer;
		variable S52 : boolean;
	begin
		if (CLOCK'EVENT and CLOCK='1') then
			if RESET = '0' then
				NOW_STAGE := 0;
				S52 := false;
				--- clear the value of the signal into the inactive stage
				P0_NOT_TO_PIN   	<=  '0';
				PSEN    			<=  '1'; 
				ALE   				<=  '0';
				ALU_ENABLE   		<=  '0';
				W_BIT_OPERATOR_LATCH <=  '0';
				PREPARE_FOR_ROTATE  <=  '0';
		        CLR_BIT   			<=  '0'; 
		        CPL_BIT   			<=  '0'; 
        		SET_BIT   			<=  '0'; 
			    WRITE_BIT_F_CARRY   <=  '0';
		        CHK_BIT   			<=  '0';
		        SET_ALL_BIT_ZERO    <=  '0';			
				INC16   			<=  '0'; 
				DEC16   			<=  '0'; 
				--ADD_WITH_RELATIVE   <=  '0';				
				ADD16_TO_ABUS   	<=  '0';
				B_OP_OUT2BUS   		<=  '0';
				RI_DEC_TO_BUS   	<=  '0';
				GPR_DEC_2_BUS   	<=  '0';
				IR_TO_INTBUS   		<=  '0';        
				TMP1_TO_INTBUS   	<=  '0';
		        TMP2_TO_INTBUS   	<=  '0';
				ALU_TO_INTBUS   	<=  '0';		        
		        ACC_TO_INTBUS   	<=  '0';
		        RAM_TO_INTBUS   	<=  '0';
		        SP_TO_INTBUS    	<=  '0';        
		        PCH_TO_INTBUS   	<=  '0';
		        PC_TO_A_BUS   		<=  '0';        
				INTBUS_TO_DPH	    <=  '0';
		        INTBUS_TO_DPL	    <=  '0';
		        WRITE_IR   			<=  '0';
		        WRITE_ACC   		<=  '0';
		        WRITE_RAM   		<=  '0';
		        WRITE_DPH   		<=  '0';
		        WRITE_DPL   		<=  '0';
		        WRITE_INT_MAR   	<=  '0';
		        WRITE_TMP2_F_ACC    <=  '0';
		        WRITE_TMP2_F_BUS    <=  '0';
				WRITE_TMP1   		<=  '0';
		        WRITE_SP   			<=  '0';
		        WRITE_EXT_MAR   	<=  '0';
		        WRITE_PCL_F_INTBUS  <=  '0';
		        INC_PC   			<=  '0';
		        READ_EXT_MEM   		<=  '0';
		        ACCESS_EXT_MEM   	<=  '0';
				PSW_TO_INTBUS		<= 	'0';
			else --RESET = '0'
				case NOW_STAGE is
					when 0 			=> 	
					
					when 1			=> 	ALU_ENABLE		 <= '0';
										--P0_NOT_TO_PIN  <= '1';
								  		--PSEN 			 <= '0';--clear old value of stage 51(no need to clear)
										TMP2_TO_INTBUS 	 <= '0';
								        WRITE_RAM        <= '0';--clear old value of stage 25
										ALU_TO_INTBUS 	 <= '0';
								       	--WRITE_RAM      <= '0';--clear old value of stage 31
										--ALU_TO_INTBUS  <= '0';
								        WRITE_ACC        <= '0';--clear old value of stage 33
										ALE 			 <= '0';
										P0_NOT_TO_PIN 	 <= '1';
								  		PC_TO_A_BUS      <= '1';        
								  		PSEN             <= '0';--PSEN has been change to active low
								        READ_EXT_MEM     <= '1';
								        WRITE_EXT_MAR 	 <= '1';--DLY1;								        
								        if S52 then
											WRITE_TMP2_F_BUS <= '1';--DLY1;										
										--else
										--	WRITE_IR     <= '1';--DLY1;
										end if;										
										
					when 2			=> 	P0_NOT_TO_PIN 	 <= '0';
								  		PC_TO_A_BUS      <= '0';        
								  		PSEN             <= '1';
								        READ_EXT_MEM     <= '0';
								        WRITE_EXT_MAR 	 <= '0';
								        WRITE_TMP2_F_BUS <= '0';
										WRITE_IR     	 <= '0';--clear old value
										INC_PC 			 <= '1';
								  		ALE 			 <= '1';
										
										if S52 then
											if OVERLAPED_STAGE = 2 then
											    case IR(7 downto 0) is
													when "00100110" |	-- 1byte-1cycle instruction
												 	  	 "00100111" |	-- instruction ADD  A,@Ri
												 		 "00110110" |
														 "00110111" |	-- instruction	ADDC A,@Ri
														 "01000110" |
														 "01000111" |	-- instruction	OR  A,@Ri
														 "01010110" |
														 "01010111" |	-- instruction	ANL  A,@Ri
														 "01100110" |
														 "01100111" |	-- instruction	XRL  A,@Ri
														 "10010110" |
														 "10010111" 	-- instruction SUBB A,@Ri       	
												 			 		=> 	ALU_TO_INTBUS  	 <= '1';--DLY1;
								        								WRITE_ACC        <= '1';--DLY2;

																	
												
													when "00000110" |   -- 1byte-1cycle instruction
												 	     "00000111" |	-- instruction INC @Ri
														 "00010110" |
														 "00010111"     -- instruction DEC @Ri
												 					=> 	ALU_TO_INTBUS 	 <= '1';--DLY1;
																		WRITE_RAM     	 <= '1';--DLY2;
																		
																														
													when "10110010"|	-- instruction CPL  bit
												 		 "11000010"|	-- instruction CLR  bit
												 		 "11010010"|	-- instruction SETB bit
														 "10100010" =>	-- instruction MOV  C,bit
																		TMP2_TO_INTBUS		 <= '1';
																		W_BIT_OPERATOR_LATCH <= '1';
													
													when "01110110"|		
												 		 "01110111" => 	-- instruction MOV @Ri,#data	
														 				RI_DEC_TO_BUS		<= '1';
																		WRITE_INT_MAR		<= '1';
												
													when "11000101"|	-- instruction XCH A,direct
														 "11100101"|	-- instruction MOV A,direct
														 "11110101"| 	-- instruction MOV direct,A
														 "00000101"|	-- instruction INC direct 
												 	     "00010101"|	-- instruction DEC direct
														 "00100101"|	-- instruction ADD 	A,direct		
														 "00110101"|	-- instruction ADDC	A,direct	
														 "01000101"|	-- instruction ORL 	A,direct		
														 "01010101"|	-- instruction ANL 	A,direct		
														 "01100101"|	-- instruction XRL 	A,direct		
														 "10010101"|	-- instruction SUBB A,direct	
														 "01000010"|	-- instruction ORL direct,A    	
												 		 "01010010"|	-- instruction ANL direct,A		
												 		 "01100010" =>	-- instruction XRL direct,A		
														 				TMP2_TO_INTBUS		<= '1';
																		WRITE_INT_MAR		<= '1';				
													
													
													when "00100100"|	-- instruction ADD  A,#data		
												 		 "00110100"|	-- instruction ADDC A,#data		
														 "01000100"|	-- instruction ORL  A,#data		
														 "01010100"|	-- instruction ANL  A,#data		
														 "01100100"|	-- instruction XRL  A,#data		
														 "10010100" =>	-- instruction SUBB A,#data		
														 				TMP2_TO_INTBUS 		<= '1';
																		WRITE_TMP1			<= '1';
														 
														 
													when "01110100" => -- instruction MOV A,#data 
												     				   --replace the stage 54
														  			   TMP2_TO_INTBUS 		<= '1';
														        	   WRITE_ACC      		<= '1';--DLY1;																
															   
												
													when "01111000"|
														 "01111001"|
														 "01111010"|
														 "01111011"|														 
														 "01111100"|
														 "01111101"|
														 "01111110"|
														 "01111111"	=> -- instruction MOV Rn,#data
																	   --replace the stage 53 
																	   GPR_DEC_2_BUS 		<= '1';
																	   WRITE_INT_MAR 		<= '1';--DLY1;
												
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 2
										end if; -- S52										        										
										
					when 3			=>  TMP2_TO_INTBUS 	 <= '0';
								        WRITE_ACC      	 <= '0';--clear old value of stage s52 case 4
										INC_PC			 <= '0';--clear old value
										ACCESS_EXT_MEM   <= '1';
										-- ALE		     <= '1';
										
										if S52 then
											if OVERLAPED_STAGE = 3 then
												case IR(7 downto 0) is
													when "01000000" => 	-- instruction JC   rel
																		   TMP2_TO_INTBUS     <= '1';	
																		   WRITE_PCL_F_INTBUS  <= '1';
																									
																									
													when "00100110" |	-- 1byte-1cycle instruction
												 	  	 "00100111" |	-- instruction ADD  A,@Ri
												 		 "00110110" |
														 "00110111" |	-- instruction	ADDC A,@Ri
														 "01000110" |
														 "01000111" |	-- instruction	OR  A,@Ri
														 "01010110" |
														 "01010111" |	-- instruction	ANL  A,@Ri
														 "01100110" |
														 "01100111" |	-- instruction	XRL  A,@Ri
														 "10010110" |
														 "10010111" 	-- instruction SUBB A,@Ri       	
												 			 		=> 	ALU_TO_INTBUS  	 <= '0';--DLY1;
								        								WRITE_ACC        <= '0';--DLY2;--clear old value
																		S52 := false;
												
													when "00000110" |   -- 1byte-1cycle instruction
												 	     "00000111" |	-- instruction INC @Ri
														 "00010110" |
														 "00010111"     -- instruction DEC @Ri
												 					=> 	ALU_TO_INTBUS 	 <= '0';--DLY1;
																		WRITE_RAM     	 <= '0';--DLY2;--clear old value
																		S52 := false;

												
												
													when "10110010"|	-- instruction CPL  bit
														 "11000010"|	-- instruction CLR  bit
														 "11010010"|	-- instruction SETB bit
														 "10100010" =>	-- instruction MOV  C,bit
																		TMP2_TO_INTBUS		    <= '0'; ---wait for a stability of signal
																		W_BIT_OPERATOR_LATCH 	<= '0'; --chamonank
																		B_OP_OUT2BUS			<= '1';
																		WRITE_INT_MAR			<= '1';
												
													when "01111000"|
														 "01111001"|
														 "01111010"|
														 "01111011"|														 
														 "01111100"|
														 "01111101"|
														 "01111110"|
														 "01111111"	=> -- instruction MOV Rn,#data
																		GPR_DEC_2_BUS		<= '0';
																		WRITE_INT_MAR		<= '0';--clear old value
																		TMP2_TO_INTBUS		<= '1';
																		WRITE_RAM			<= '1';
													
													when "01110110"|		
												 		 "01110111" => 	-- instruction MOV @Ri,#data	
														 				RI_DEC_TO_BUS		<= '0';
																		WRITE_INT_MAR		<= '0';--clear old value
																		RAM_TO_INTBUS		<= '1';
																		WRITE_TMP1			<= '1';
													
													when "00100101"|	-- instruction ADD 	A,direct		
														 "00110101"|	-- instruction ADDC	A,direct	
														 "01000101"|	-- instruction ORL 	A,direct		
														 "01010101"|	-- instruction ANL 	A,direct		
														 "01100101"|	-- instruction XRL 	A,direct		
														 "10010101" =>	-- instruction SUBB A,direct	
														 				TMP2_TO_INTBUS		<= '0';
																		WRITE_INT_MAR		<= '0';--clear old value
																		RAM_TO_INTBUS		<= '1';
																		WRITE_TMP1			<= '1';
																		WRITE_TMP2_F_ACC	<= '1';
												
												
													
													when "11000101"|	-- instruction XCH A,direct
														 "11100101"|	-- instruction MOV A,direct
														 "11110101"| 	-- instruction MOV direct,A
														 "00000101"|	-- instruction INC direct 
												 	     "00010101"|	-- instruction DEC direct
														 "01000010"|	-- instruction ORL direct,A    	
												 		 "01010010"|	-- instruction ANL direct,A		
												 		 "01100010" =>	-- instruction XRL direct,A	
														 				TMP2_TO_INTBUS		<= '0';
																		WRITE_INT_MAR		<= '0';--clear old value
																		RAM_TO_INTBUS		<= '1';
																		WRITE_TMP2_F_BUS	<= '1';
												
													when "00100100"|	-- instruction ADD A,#data		
												 		 "00110100"|	-- instruction ADDC A,#data		
														 "01000100"|	-- instruction ORL A,#data		
														 "01010100"|	-- instruction ANL A,#data		
														 "01100100"|	-- instruction XRL A,#data		
														 "10010100" =>	-- instruction SUBB A,#data		
														 				TMP2_TO_INTBUS 		<= '0';
																		WRITE_TMP1			<= '0';--clear old value																		
																		WRITE_TMP2_F_ACC	<= '1';
														 														 
												
													when "01110100" => 	TMP2_TO_INTBUS 		<= '0';
																        WRITE_ACC      		<= '0';--clear old value
																		S52 := false;	--don't care the next value of INC_VALUE     
																		--instruction has been finished														   
																									
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 3
										end if; -- S52 
																				
					when 4			=>  TMP2_TO_INTBUS 	 <= '0';
 								        WRITE_RAM      	 <= '0';--clear old value of stage s52 case 3
										ALE 			 <= '0';--clear old value
										--ACCESS_EXT_MEM <= '1';
										
										if S52 then
											if OVERLAPED_STAGE = 4 then
												case IR(7 downto 0) is
													when "01000000" => 	-- instruction JC   rel
																		   TMP2_TO_INTBUS     <= '0';	
																		   WRITE_PCL_F_INTBUS  <= '0';--clear old value
												
													when "10110010"	=>  -- instruction CPL bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_INT_MAR			<= '0';--clear old value
																		RAM_TO_INTBUS			<= '1';
																		CPL_BIT					<= '1';
																		
												    when "11000010"	=>	-- instruction CLR bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_INT_MAR			<= '0';--clear old value
																		RAM_TO_INTBUS			<= '1';
																		CLR_BIT					<= '1';
													
												    when "11010010"	=>	-- instruction SETB bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_INT_MAR			<= '0';--clear old value
																		RAM_TO_INTBUS			<= '1';
																		SET_BIT					<= '1';
													
												
												 	when "10100010" =>	-- instruction MOV C,bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_INT_MAR			<= '0';--clear old value
																		RAM_TO_INTBUS			<= '1';
																		PREPARE_FOR_ROTATE		<= '1';
												
													when "01110110"|		
												 		 "01110111" => 	-- instruction MOV @Ri,#data	
														 				RAM_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		TMP1_TO_INTBUS		<= '1';
																		WRITE_INT_MAR		<= '1';
													
													when "11000101" =>	-- instruction XCH A,direct
																		RAM_TO_INTBUS		<= '0';
																		WRITE_TMP2_F_BUS	<= '0';--clear old value
																		ACC_TO_INTBUS		<= '1';
																		WRITE_TMP1			<= '1';
																		
																		
													when "11100101" =>	-- instruction MOV A,direct
														 				RAM_TO_INTBUS		<= '0';
																		WRITE_TMP2_F_BUS	<= '0';--clear old value
																		TMP2_TO_INTBUS		<= '1';
																		WRITE_ACC			<= '1';
																		
																		
													when "11110101" => 	-- instruction MOV direct,A
														 				RAM_TO_INTBUS		<= '0';
																		WRITE_TMP2_F_BUS	<= '0';--clear old value
																		ACC_TO_INTBUS		<= '1';
																		WRITE_RAM			<= '1';
																		
																		
																																 
													when "00100101"|	-- instruction ADD 	A,direct		
														 "00110101"|	-- instruction ADDC	A,direct	
														 "01000101"|	-- instruction ORL 	A,direct		
														 "01010101"|	-- instruction ANL 	A,direct		
														 "01100101"|	-- instruction XRL 	A,direct		
														 "10010101" =>	-- instruction SUBB A,direct	
														 				RAM_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';
																		WRITE_TMP2_F_ACC	<= '0';--clear old value but not finished
																		
												
												
													when "00100100" =>	-- instruction ADD A,#data		
																		WRITE_TMP2_F_ACC	<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= ADD_INS;
																		
												 	when "00110100" =>	-- instruction ADDC A,#data		
														 				WRITE_TMP2_F_ACC	<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= ADDC_INS;
																		
													when "01000100" =>	-- instruction ORL A,#data		
														 				WRITE_TMP2_F_ACC	<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= OR_INS;
																		
													when "01010100" =>	-- instruction ANL A,#data		
														 				WRITE_TMP2_F_ACC	<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= AND_INS;
																		
													when "01100100" =>	-- instruction XRL A,#data		
														 				WRITE_TMP2_F_ACC	<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= XOR_INS;
																		
													when "10010100" =>	-- instruction SUBB A,#data		
														 				WRITE_TMP2_F_ACC	<= '0';--clear old value																		
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= SUBB_INS;
												
												
													when "00000101"|	-- instruction INC direct 
												 	     "00010101"|	-- instruction DEC direct
														 "01000010"|	-- instruction ORL direct,A    	
												 		 "01010010"|	-- instruction ANL direct,A		
												 		 "01100010" =>	-- instruction XRL direct,A
														 				RAM_TO_INTBUS		<= '0';
																		WRITE_TMP2_F_BUS	<= '0';--clear old value
																		ACC_TO_INTBUS		<= '1';
																		WRITE_TMP1			<= '1';
												
													when "01111000"|
														 "01111001"|
														 "01111010"|
														 "01111011"|														 
														 "01111100"|
														 "01111101"|
														 "01111110"|
														 "01111111" =>	-- instruction MOV Rn,#data
																		TMP2_TO_INTBUS 		<= '0';
								 								        WRITE_RAM      		<= '0';--clear old value
																		S52 := false;	--don't care the next value of INC_VALUE
																
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 4
										end if; -- S52											

					when 5			=>  P0_NOT_TO_PIN 	 <= '1';
										ACCESS_EXT_MEM	 <= '0';--clear old value
										PSEN 			 <= '0';								
												
										if S52 then
											if OVERLAPED_STAGE = 5 then
												case IR(7 downto 0) is
													when "10110010"	=>  -- instruction CPL bit
																		RAM_TO_INTBUS			<= '0';
																		CPL_BIT					<= '0';--clear old value
																		B_OP_OUT2BUS			<= '1';
																		WRITE_RAM				<= '1';
																		
																		
												    when "11000010"	=>	-- instruction CLR bit
																		RAM_TO_INTBUS			<= '0';
																		CLR_BIT					<= '0';--clear old value
																		B_OP_OUT2BUS			<= '1';
																		WRITE_RAM				<= '1';
													
												    when "11010010"	=>	-- instruction SETB bit
																		RAM_TO_INTBUS			<= '0';
																		SET_BIT					<= '0';--clear old value
																		B_OP_OUT2BUS			<= '1';
																		WRITE_RAM				<= '1';
												
												
													when "10100010" =>	-- instruction MOV C,bit
																		RAM_TO_INTBUS			<= '0';
																		PREPARE_FOR_ROTATE		<= '0';--for a stable signal
																																				
												
													when "01110110"|		
												 		 "01110111" => 	-- instruction MOV @Ri,#data	
														 				TMP1_TO_INTBUS		<= '0';
																		WRITE_INT_MAR		<= '0';--clear old value
																		TMP2_TO_INTBUS		<= '1';
																		WRITE_RAM			<= '1';
													
												
													when "11000101" =>	-- instruction XCH A,direct
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		TMP2_TO_INTBUS		<= '1';
																		WRITE_ACC			<= '1';
																		
													when "11100101" =>	-- instruction MOV A,direct
														 				TMP2_TO_INTBUS		<= '0';
																		WRITE_ACC			<= '0';--clear old value
																		S52 := false;
													
													when "11110101" => 	-- instruction MOV direct,A
														 				ACC_TO_INTBUS		<= '0';
																		WRITE_RAM			<= '0';--clear old value
																		S52 := false;
												
													when "00100101" =>	-- instruction ADD 	A,direct		
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= ADD_INS;
																		
													when "00110101" =>	-- instruction ADDC	A,direct	
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= ADDC_INS;
													
													when "01000101" =>	-- instruction ORL 	A,direct		
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= OR_INS;
													
													when "01010101" =>	-- instruction ANL 	A,direct		
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= AND_INS;
													
													when "01100101" =>	-- instruction XRL 	A,direct		
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= XOR_INS;
													
													when "10010101" =>	-- instruction SUBB A,direct	
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= SUBB_INS;
													
													
													when "00100100"|	-- instruction ADD  A,#data		
												 		 "00110100"|	-- instruction ADDC A,#data		
														 "01000100"|	-- instruction ORL  A,#data		
														 "01010100"|	-- instruction ANL  A,#data		
														 "01100100"|	-- instruction XRL  A,#data		
														 "10010100" =>	-- instruction SUBB A,#data		
														 				ALU_ENABLE			<= '0';--clear old value
																		ALU_TO_INTBUS		<= '1';
																		WRITE_ACC			<= '1';
												
													when "00000101"	=>	-- instruction INC direct 
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= INC_INS;
																		
												 	when "00010101" =>	-- instruction DEC direct
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= DEC_INS;
													
													when "01000010" =>	-- instruction ORL direct,A
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= OR_INS;    	
																		
												 	when "01010010" =>	-- instruction ANL direct,A		
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
														 				ALU_ENABLE			<= '1';
																		ALU_MODE			<= AND_INS;
																		
												 	when "01100010" =>	-- instruction XRL direct,A		
																		ACC_TO_INTBUS		<= '0';
																		WRITE_TMP1			<= '0';--clear old value
																		ALU_ENABLE			<= '1';
																		ALU_MODE			<= XOR_INS;
													
																
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 5
										end if; -- S52									
										
					
					when 6 			=>  --P0_NOT_TO_PIN 	 <= '1';
								  		--PSEN 			 <= '0';
										
										if S52 then
											if OVERLAPED_STAGE = 6 then
												case IR(7 downto 0) is
													when "10110010"|	-- instruction CPL  bit
														 "11000010"|	-- instruction CLR  bit
														 "11010010" =>	-- instruction SETB bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_RAM				<= '0';--clear old value
																		S52 := false;
																		
												    
												
													when "10100010" =>	-- instruction MOV C,bit
																		B_OP_OUT2BUS			<= '1';
																		WRITE_TMP2_F_BUS		<= '1';
																		
												
													when "01110110"|		
												 		 "01110111" => 	-- instruction MOV @Ri,#data	
														 				TMP2_TO_INTBUS		<= '0';
																		WRITE_RAM			<= '0';--clear old value
																		S52 := false;
													
													when "11000101" =>	-- instruction XCH A,direct
																		TMP2_TO_INTBUS		<= '0';
																		WRITE_ACC			<= '0';--clear old value
																		TMP1_TO_INTBUS		<= '1';
																		WRITE_RAM			<= '1';
													
													when "00100101"|	-- instruction ADD 	A,direct		
														 "00110101"|	-- instruction ADDC	A,direct	
														 "01000101"|	-- instruction ORL 	A,direct		
														 "01010101"|	-- instruction ANL 	A,direct		
														 "01100101"|	-- instruction XRL 	A,direct		
														 "10010101" =>	-- instruction SUBB A,direct	
														 				ALU_ENABLE			<= '0';--clear old value
																		ALU_TO_INTBUS		<= '1';
																		WRITE_ACC			<= '1';
													
													when "00100100"|	-- instruction ADD  A,#data		
												 		 "00110100"|	-- instruction ADDC A,#data		
														 "01000100"|	-- instruction ORL  A,#data		
														 "01010100"|	-- instruction ANL  A,#data		
														 "01100100"|	-- instruction XRL  A,#data		
														 "10010100" =>	-- instruction SUBB A,#data		
														 				ALU_TO_INTBUS		<= '0';
																		WRITE_ACC			<= '0';--clear old value
																		S52 := false;
													
													when "00000101"|	-- instruction INC direct 
												 	     "00010101"|	-- instruction DEC direct
														 "01000010"|	-- instruction ORL direct,A
												 		 "01010010"|	-- instruction ANL direct,A		
												 		 "01100010" =>	-- instruction XRL direct,A
																		ALU_ENABLE			<= '0';--clear old value
																		ALU_TO_INTBUS		<= '1';
																		WRITE_RAM			<= '1';
																										
																
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 6
										end if; -- S52									
																				
										
					when 7			=>  PC_TO_A_BUS  	 <= '1';
							 	  		--P0_NOT_TO_PIN  <= '1';
								  		--PSEN 			 <= '0';
								        READ_EXT_MEM 	 <= '1';
								        WRITE_IR 		 <= '1';--DLY1;        
								        WRITE_EXT_MAR 	 <= '1';--DLY1;
										
										if S52 then
											if OVERLAPED_STAGE = 7 then
												case IR(7 downto 0) is
													when "10100010" =>	-- instruction MOV C,bit
																		B_OP_OUT2BUS			<= '0';
																		WRITE_TMP2_F_BUS		<= '0';--clear old value
																		ALU_ENABLE				<= '1';
																		ALU_MODE				<= RLC_INS;
																		
																		
												
													when "11000101" =>	-- instruction XCH A,direct
																		TMP1_TO_INTBUS		<= '0';
																		WRITE_RAM			<= '0';--clear old value
																		S52 := false;
													
													when "00100101"|	-- instruction ADD 	A,direct		
														 "00110101"|	-- instruction ADDC	A,direct	
														 "01000101"|	-- instruction ORL 	A,direct		
														 "01010101"|	-- instruction ANL 	A,direct		
														 "01100101"|	-- instruction XRL 	A,direct		
														 "10010101" =>	-- instruction SUBB A,direct	
														 				ALU_TO_INTBUS		<= '0';
																		WRITE_ACC			<= '0';--clear old value
																		S52 := false;
													
													when "00000101"|	-- instruction INC direct 
												 	     "00010101"|	-- instruction DEC direct														 
														 "01000010"|	-- instruction ORL direct,A
												 		 "01010010"|	-- instruction ANL direct,A		
												 		 "01100010" =>	-- instruction XRL direct,A
																		ALU_TO_INTBUS		<= '0';
																		WRITE_RAM			<= '0';--clear old value
																		S52 := false;
																
													when others		=>
												end case;--IR(7 downto 0)
											end if; ---OVERLAPED_STAGE = 7
										end if; -- S52																			
										
										
					when 8			=> 	if S52 then
											ALU_ENABLE	 <= '0';--clear old value of instruction MOV c,bit
											S52 := false;
										end if;
										PC_TO_A_BUS  	 <= '0';
							 	  		P0_NOT_TO_PIN	 <= '0';
								  		PSEN 			 <= '1';
								        READ_EXT_MEM 	 <= '0';
								        WRITE_IR 		 <= '0';
								        WRITE_EXT_MAR 	 <= '0';--clear old value of stage 7
										case IR(7 downto 0) is
											when "00001000" |		
												 "00001001" |
												 "00001010" |
												 "00001011" |													 												 
												 "00001100" |
												 "00001101" |
												 "00001110" |
												 "00001111" |	-- instruction INC Rn												 
												 "00011000" |
												 "00011001" |
												 "00011010" |
												 "00011011" |													 
												 "00011100" |
												 "00011101" |
												 "00011110" |
												 "00011111"    -- instruction DEC Rn
												 			=> GPR_DEC_2_BUS 	 <= '1';
														       WRITE_INT_MAR 	 <= '1';--DLY1;	
												 
											when "00101000" |
												 "00101001" |
												 "00101010" |
												 "00101011" |												 
												 "00101100" |
												 "00101101" |
												 "00101110" |
												 "00101111" |	-- instruction ADD  A,Rn												 
												 "00111000" |
												 "00111001" |
												 "00111010" |
												 "00111011" |												 
												 "00111100" |
												 "00111101" |
												 "00111110" |
												 "00111111" |	-- instruction ADDC A,Rn											 
												 "01001000" |
												 "01001001" |
												 "01001010" |
												 "01001011" |												 
												 "01001100" |
												 "01001101" |
												 "01001110" |
												 "01001111" | 	-- instruction OR   A,Rn
												 "01011000" |
												 "01011001" |
												 "01011010" |
												 "01011011" |												 
												 "01011100" |
												 "01011101" |
												 "01011110" |
												 "01011111" | 	-- instruction ANL  A,Rn
												 "01101000" | 	
												 "01101001" | 	
												 "01101010" | 	
												 "01101011" | 													 
												 "01101100" | 	
												 "01101101" | 	
												 "01101110" | 	
												 "01101111" | 	-- instruction XRL  A,Rn
												 "10011000" |
												 "10011001" |
												 "10011010" |
												 "10011011" |												 
												 "10011100" |
												 "10011101" |
												 "10011110" |
												 "10011111" 	-- instruction SUBB A,Rn
               												 => GPR_DEC_2_BUS 	 <= '1';
														        WRITE_INT_MAR 	 <= '1';--DLY1;
															 
											when "11001000" |	
												 "11001001" |	
												 "11001010" |	
												 "11001011" |													 
												 "11001100" |	
												 "11001101" |	
												 "11001110" |	
												 "11001111" 	-- instruction XCH  A,Rn
															 => GPR_DEC_2_BUS 	 <= '1';
														        WRITE_INT_MAR 	 <= '1';--DLY1;        		  		  		
														        WRITE_TMP2_F_ACC <= '1';															 
			
											when "11101000" |
												 "11101001" |
												 "11101010" |
												 "11101011" |												 
												 "11101100" |
												 "11101101" |
												 "11101110" |
												 "11101111" 	-- instruction MOV  A,Rn
															 => GPR_DEC_2_BUS 	 <= '1';
														        WRITE_INT_MAR    <= '1';--DLY1;															 
															 	
											when "11111000" |
												 "11111001" |
												 "11111010" |
												 "11111011" |												 
												 "11111100" |
												 "11111101" |
												 "11111110" |
												 "11111111"	-- instruction MOV  Rn,A
            												 => GPR_DEC_2_BUS 	 <= '1';
														        WRITE_INT_MAR 	 <= '1';--DLY1;
																
											when "11000110" |
												 "11000111"  	-- instruction XCH  A,@Ri
															 => RI_DEC_TO_BUS 	 <= '1';
														        WRITE_INT_MAR 	 <= '1';--DLY1;
										 
										    when "11100110" |	
												 "11100111" |	-- instruction MOV  A,@Ri	
												 "11110110" |
												 "11110111" |   -- instruction MOV  @Ri,A
												 "00000110" |   
												 "00000111" |	-- instruction INC @Ri
												 "00010110" |
												 "00010111" |   -- instruction DEC @Ri            
												 "00100110" |
												 "00100111" |	-- instruction ADD  A,@Ri
												 "00110110" |
												 "00110111" |	-- instruction	ADDC A,@Ri
												 "01000110" |
												 "01000111" |	-- instruction	OR  A,@Ri
												 "01010110" |
												 "01010111" |	-- instruction	ANL  A,@Ri												 
												 "01100110" |
												 "01100111" |	-- instruction	XRL  A,@Ri												 
												 "10010110" |
												 "10010111" 	-- instruction SUBB A,@Ri       	
															 => RI_DEC_TO_BUS 	 <= '1';
														        WRITE_INT_MAR 	 <= '1';--DLY1;
															 															
											when "11100100"  	-- instruction CLR A
															 => TMP1_TO_INTBUS   <= '0';
														        WRITE_INT_MAR	 <= '0';--clear old value from stage 28
																SET_ALL_BIT_ZERO <= '1';															 	
											
											when "11110100"| 	-- instruction CPL A
												 "00000100"|    -- instruction INC A
												 "00010100"|    -- instruction DEC A
												 "00000011"|	-- instruction RR  A
												 "00010011"|	-- instruction RRC A
												 "00100011"|	-- instruction RL  A
												 "00110011" 	-- instruction RLC A
            												 => WRITE_TMP2_F_ACC <= '1';
																
																
											when "10110011"| 	-- instruction CPL C
												 "11000011"|	-- instruction CLR C
												 "11010011" 	-- instruction SETB C
															 => SET_ALL_BIT_ZERO <= '1';
														        																
											when "01110110"|		
												 "01110111"| 	-- instruction MOV @Ri,#data	*2b-1cycle													 
												 "01111000"|
												 "01111001"|
												 "01111010"|
												 "01111011"|												 
												 "01111100"|
												 "01111101"|
												 "01111110"|
												 "01111111"| 	-- instruction MOV Rn,#data		*2b-1cycle												 
												 "01000010"|	-- instruction ORL direct,A    	*2b-1cycle
												 "01010010"|	-- instruction ANL direct,A		*2b-1cycle
												 "01100010"|	-- instruction XRL direct,A		*2b-1cycle
												 "10100010"|	-- instruction MOV C,bit		*2b-1cycle
												 "10110010"|	-- instruction CPL bit			*2b-1cycle
												 "11000010"|	-- instruction CLR bit			*2b-1cycle
												 "11010010"|	-- instruction SETB bit			*2b-1cycle
												 "00100100"|	-- instruction ADD A,#data		*2b-1cycle
												 "00110100"|	-- instruction ADDC A,#data		*2b-1cycle
												 "01000100"|	-- instruction ORL A,#data		*2b-1cycle
												 "01010100"|	-- instruction ANL A,#data		*2b-1cycle
												 "01100100"|	-- instruction XRL A,#data		*2b-1cycle
												 "01110100"|	-- instruction MOV A,#data		*2b-1cycle
												 "10010100"|	-- instruction SUBB A,#data		*2b-1cycle
												 "00000101"|	-- instruction INC direct		*2b-1cycle
												 "00010101"|	-- instruction DEC direct		*2b-1cycle
												 "00100101"|	-- instruction ADD A,direct		*2b-1cycle
												 "00110101"|	-- instruction ADDC A,direct	*2b-1cycle
												 "01000101"|	-- instruction ORL A,direct		*2b-1cycle
												 "01010101"|	-- instruction ANL A,direct		*2b-1cycle
												 "01100101"|	-- instruction XRL A,direct		*2b-1cycle
												 "10010101"|	-- instruction SUBB A,direct	*2b-1cycle
												 "11000101"|	-- instruction XCH A,direct		*2b-1cycle												 
												 "11100101"|	-- instruction MOV A,direct		*2b-1cycle
												 "11110101"| 	-- instruction MOV direct,A		*2b-1cycle
												 "01000000"|	-- instruction JC   rel
												 "10000000"		-- instruction SJMP rel
												 			 => -- use stage 47
															 	INC_PC 			 <= '1';
								  								ALE			 	 <= '1'; 
																-- next stage = 48
					
											
											when others		 => 
										end case; -- IR(7 downto 0)
--*******************************************************************************************************************************										
					when 9			=>	case IR(7 downto 0) is
											when "00001000" |		
												 "00001001" |
												 "00001010" |
												 "00001011" |													 												 
												 "00001100" |
												 "00001101" |
												 "00001110" |
												 "00001111" |	-- instruction INC Rn												 
												 "00011000" |
												 "00011001" |
												 "00011010" |
												 "00011011" |													 
												 "00011100" |
												 "00011101" |
												 "00011110" |
												 "00011111"    -- instruction DEC Rn
												 			 => GPR_DEC_2_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																RAM_TO_INTBUS    <= '1';
														        WRITE_TMP2_F_BUS <= '1';--DLY1;
														        
																--next state = 10
															 	             					
											when "00101000" |
												 "00101001" |
												 "00101010" |
												 "00101011" |												 
												 "00101100" |
												 "00101101" |
												 "00101110" |
												 "00101111" |	-- instruction ADD  A,Rn												 
												 "00111000" |
												 "00111001" |
												 "00111010" |
												 "00111011" |												 
												 "00111100" |
												 "00111101" |
												 "00111110" |
												 "00111111" |	-- instruction ADDC A,Rn											 
												 "01001000" |
												 "01001001" |
												 "01001010" |
												 "01001011" |												 
												 "01001100" |
												 "01001101" |
												 "01001110" |
												 "01001111" | 	-- instruction OR   A,Rn
												 "01011000" |
												 "01011001" |
												 "01011010" |
												 "01011011" |												 
												 "01011100" |
												 "01011101" |
												 "01011110" |
												 "01011111" | 	-- instruction ANL  A,Rn
												 "01101000" | 	
												 "01101001" | 	
												 "01101010" | 	
												 "01101011" | 													 
												 "01101100" | 	
												 "01101101" | 	
												 "01101110" | 	
												 "01101111" | 	-- instruction XRL  A,Rn
												 "10011000" |
												 "10011001" |
												 "10011010" |
												 "10011011" |												 
												 "10011100" |
												 "10011101" |
												 "10011110" |
												 "10011111" 	-- instruction SUBB A,Rn
               												 => GPR_DEC_2_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																WRITE_TMP2_F_ACC <= '1';
														        RAM_TO_INTBUS	 <= '1';
														        WRITE_TMP1       <= '1';--DLY1;
														        --next state = 13										
															 
											when "11001000" |	
												 "11001001" |	
												 "11001010" |	
												 "11001011" |													 
												 "11001100" |	
												 "11001101" |	
												 "11001110" |	
												 "11001111" 	-- instruction XCH  A,Rn
															 => GPR_DEC_2_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';
																WRITE_TMP2_F_ACC <= '0';--clear old value
																RAM_TO_INTBUS 	 <= '1';
														        WRITE_ACC        <= '1';--DLY1;
																--next state = 16															 
			
											when "11101000" |
												 "11101001" |
												 "11101010" |
												 "11101011" |												 
												 "11101100" |
												 "11101101" |
												 "11101110" |
												 "11101111" 	-- instruction MOV  A,Rn
															 => GPR_DEC_2_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																RAM_TO_INTBUS    <= '1';
														        WRITE_ACC        <= '1';--DLY1;
																--next state = none ++ cleared															 
															 	
											when "11111000" |
												 "11111001" |
												 "11111010" |
												 "11111011" |												 
												 "11111100" |
												 "11111101" |
												 "11111110" |
												 "11111111"	-- instruction MOV  Rn,A
            												 => GPR_DEC_2_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																ACC_TO_INTBUS 	 <= '1';
														        WRITE_RAM     	 <= '1';--DLY1;
																--next state = none	++ cleared
																
											when "11000110" |
												 "11000111"  	-- instruction XCH  A,@Ri
															 => RI_DEC_TO_BUS    <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																RAM_TO_INTBUS    <= '1';
														  		WRITE_TMP1       <= '1';--DLY1;	
																--next state = 23															 
										 
										    when "11100110" |	
												 "11100111" |	-- instruction MOV  A,@Ri	
												 "11110110" |
												 "11110111" |   -- instruction MOV  @Ri,A
												 "00000110" |   
												 "00000111" |	-- instruction INC @Ri
												 "00010110" |
												 "00010111" |   -- instruction DEC @Ri            
												 "00100110" |
												 "00100111" |	-- instruction ADD  A,@Ri
												 "00110110" |
												 "00110111" |	-- instruction	ADDC A,@Ri
												 "01000110" |
												 "01000111" |	-- instruction	OR  A,@Ri
												 "01010110" |
												 "01010111" |	-- instruction	ANL  A,@Ri
												 "01100110" |
												 "01100111" |	-- instruction	XRL  A,@Ri
												 "10010110" |
												 "10010111" 	-- instruction SUBB A,@Ri       	
															 => RI_DEC_TO_BUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																RAM_TO_INTBUS    <= '1';
																WRITE_TMP1       <= '1';--DLY1;
																--next state = 28
															 															
											when "11100100"  	-- instruction CLR A
															 =>	--use stage 35
															    SET_ALL_BIT_ZERO <= '0';
														  		B_OP_OUT2BUS 	 <= '1';
														        WRITE_ACC    	 <= '1';--DLY1;
																--next state = none ++ cleared
													
											when "11110100"| 	-- instruction CPL A
												 "00000100"|    -- instruction INC A
												 "00010100"|    -- instruction DEC A
												 "00000011"|	-- instruction RR  A
												 "00010011"|	-- instruction RRC A
												 "00100011"|	-- instruction RL  A
												 "00110011" 	-- instruction RLC A
            												 => --use stage 37
															 	WRITE_TMP2_F_ACC <= '0';--clear old value
																ALU_ENABLE		 <= '1';
																case IR(7 downto 0) is
																	when "11110100"	=>	ALU_MODE <= NOT_INS; --  CPL A
																	when "00000100" =>	ALU_MODE <= INC_INS; --  INC A
																	when "00010100"	=>	ALU_MODE <= DEC_INS; --  DEC A
																	when "00000011" =>	ALU_MODE <= RR_INS;  --  RR  A
																	when "00010011" =>	ALU_MODE <= RRC_INS; --  RRC A
																	when "00100011" =>	ALU_MODE <= RL_INS;  --  RL  A
																	when "00110011" =>	ALU_MODE <= RLC_INS; --  RLC A        
																	when others	    =>
																end case;--IR(7 downto 0)
																
											when "10110011"| 	-- instruction CPL C
												 "11000011"|	-- instruction CLR C
												 "11010011" 	-- instruction SETB C
															 => SET_ALL_BIT_ZERO <= '0';--clear old value
															 	WRITE_TMP2_F_BUS <= '1';--DLY3
																case IR(6 downto 4) is 
																	when "011" 	=>	PSW_TO_INTBUS    <= '1'; 	-- CPL C
																	when "100" 	=>  B_OP_OUT2BUS     <= '1';    -- CLR C
     												 				when "101" 	=>  B_OP_OUT2BUS     <= '1';  	-- SETB C
																	when others	=>
																end case; --IR(7 downto 0)
											
											when "01110110"|		
												 "01110111"| 	-- instruction MOV @Ri,#data	*2b-1cycle													 
												 "01111000"|
												 "01111001"|
												 "01111010"|
												 "01111011"|												 
												 "01111100"|
												 "01111101"|
												 "01111110"|
												 "01111111"| 	-- instruction MOV Rn,#data		*2b-1cycle												
												 "01000010"|	-- instruction ORL direct,A    	*2b-1cycle
												 "01010010"|	-- instruction ANL direct,A		*2b-1cycle
												 "01100010"|	-- instruction XRL direct,A		*2b-1cycle
												 "10100010"|	-- instruction MOV C,bit		*2b-1cycle
												 "10110010"|	-- instruction CPL bit			*2b-1cycle
												 "11000010"|	-- instruction CLR bit			*2b-1cycle
												 "11010010"|	-- instruction SETB bit			*2b-1cycle
												 "00100100"|	-- instruction ADD A,#data		*2b-1cycle
												 "00110100"|	-- instruction ADDC A,#data		*2b-1cycle
												 "01000100"|	-- instruction ORL A,#data		*2b-1cycle
												 "01010100"|	-- instruction ANL A,#data		*2b-1cycle
												 "01100100"|	-- instruction XRL A,#data		*2b-1cycle
												 "01110100"|	-- instruction MOV A,#data		*2b-1cycle
												 "10010100"|	-- instruction SUBB A,#data		*2b-1cycle
												 "00000101"|	-- instruction INC direct		*2b-1cycle
												 "00010101"|	-- instruction DEC direct		*2b-1cycle
												 "00100101"|	-- instruction ADD A,direct		*2b-1cycle
												 "00110101"|	-- instruction ADDC A,direct	*2b-1cycle
												 "01000101"|	-- instruction ORL A,direct		*2b-1cycle
												 "01010101"|	-- instruction ANL A,direct		*2b-1cycle
												 "01100101"|	-- instruction XRL A,direct		*2b-1cycle
												 "10010101"|	-- instruction SUBB A,direct	*2b-1cycle
												 "11000101"|	-- instruction XCH A,direct		*2b-1cycle												 
												 "11100101"|	-- instruction MOV A,direct		*2b-1cycle
												 "11110101"| 	-- instruction MOV direct,A		*2b-1cycle
												 "01000000"|	-- instruction JC   rel
												 "10000000"		-- instruction SJMP rel
												 			 => -- use stage 48
															 	INC_PC 			 <= '0';--clear old value
														  		--ALE 			 <= '1';
														        ACCESS_EXT_MEM 	 <= '1';																
																-- next stage = 49
											
											when others		 => 
										end case; -- IR(7 downto 0)					  
--*********************************************************************************************************************************************
					when 10			=>	case IR(7 downto 0) is
											when "00001000" |		
												 "00001001" |
												 "00001010" |
												 "00001011" |													 												 
												 "00001100" |
												 "00001101" |
												 "00001110" |
												 "00001111" |	-- instruction INC Rn												 
												 "00011000" |
												 "00011001" |
												 "00011010" |
												 "00011011" |													 
												 "00011100" |
												 "00011101" |
												 "00011110" |
												 "00011111"    -- instruction DEC Rn
												 			 => RAM_TO_INTBUS	 <= '0';
																WRITE_TMP2_F_BUS <= '0';--clear old value																																
															 	ALU_ENABLE       <= '1';
																if IR(4) = '0' then
																	ALU_MODE 	 <= INC_INS;
																elsif IR(4) = '1' then
																	ALU_MODE 	 <= DEC_INS;
																end if;
															 	--next stage = none ++ cleared
															 	             					
											when "00101000" |
												 "00101001" |
												 "00101010" |
												 "00101011" |												 
												 "00101100" |
												 "00101101" |
												 "00101110" |
												 "00101111" |	-- instruction ADD  A,Rn												 
												 "00111000" |
												 "00111001" |
												 "00111010" |
												 "00111011" |												 
												 "00111100" |
												 "00111101" |
												 "00111110" |
												 "00111111" |	-- instruction ADDC A,Rn											 
												 "01001000" |
												 "01001001" |
												 "01001010" |
												 "01001011" |												 
												 "01001100" |
												 "01001101" |
												 "01001110" |
												 "01001111" | 	-- instruction OR   A,Rn
												 "01011000" |
												 "01011001" |
												 "01011010" |
												 "01011011" |												 
												 "01011100" |
												 "01011101" |
												 "01011110" |
												 "01011111" | 	-- instruction ANL  A,Rn
												 "01101000" | 	
												 "01101001" | 	
												 "01101010" | 	
												 "01101011" | 													 
												 "01101100" | 	
												 "01101101" | 	
												 "01101110" | 	
												 "01101111" | 	-- instruction XRL  A,Rn
												 "10011000" |
												 "10011001" |
												 "10011010" |
												 "10011011" |												 
												 "10011100" |
												 "10011101" |
												 "10011110" |
												 "10011111" 	-- instruction SUBB A,Rn
               												 => WRITE_TMP2_F_ACC <= '0';
																RAM_TO_INTBUS	 <= '0';
																WRITE_TMP1	     <= '0';																															 
															 	ALU_ENABLE		 <= '1';
																if    IR(7 downto 4) = "0010" then
																	ALU_MODE 	 <= ADD_INS;
																elsif IR(7 downto 4) = "0011" then
																	ALU_MODE 	 <= ADDC_INS;
																elsif IR(7 downto 4) = "0100" then 
																	ALU_MODE     <= OR_INS;
																elsif IR(7 downto 4) = "0101" then
																	ALU_MODE 	 <= AND_INS;
																elsif IR(7 downto 4) = "0110" then
																	ALU_MODE	 <= XOR_INS;
																elsif IR(7 downto 4) = "1001" then
																	ALU_MODE	 <= SUBB_INS;
																end if;
															 	--next stage = none ++ cleared
															 
											when "11001000" |	
												 "11001001" |	
												 "11001010" |	
												 "11001011" |													 
												 "11001100" |	
												 "11001101" |	
												 "11001110" |	
												 "11001111" 	-- instruction XCH  A,Rn
															 => RAM_TO_INTBUS	 <= '0';
																WRITE_ACC		 <= '0';--clear old value
																TMP2_TO_INTBUS 	 <= '1';
								        						WRITE_RAM        <= '1';--DLY1;
																--next stage = none ++ cleared	
																
											when "11101000" |
												 "11101001" |
												 "11101010" |
												 "11101011" |												 
												 "11101100" |
												 "11101101" |
												 "11101110" |
												 "11101111" 	-- instruction MOV  A,Rn
															 => RAM_TO_INTBUS    <= '0';
								        						WRITE_ACC        <= '0';--clear old value of stage 18																
															 	
											when "11111000" |
												 "11111001" |
												 "11111010" |
												 "11111011" |												 
												 "11111100" |
												 "11111101" |
												 "11111110" |
												 "11111111"	-- instruction MOV  Rn,A
            												 => ACC_TO_INTBUS 	 <= '0';
								        						WRITE_RAM     	 <= '0';--clear old value of stage 20																																

											when "11000110" |
												 "11000111"  	-- instruction XCH  A,@Ri
															 => RAM_TO_INTBUS	 <= '0';
																WRITE_TMP1		 <= '0';--clear old value
																TMP1_TO_INTBUS   <= '1';
								        						WRITE_INT_MAR	 <= '1';--DLY1;
								        						WRITE_TMP2_F_ACC <= '1';
																--next stage = 24
										 
										    when "11100110" |	
												 "11100111" |	-- instruction MOV  A,@Ri	
												 "11110110" |
												 "11110111" |   -- instruction MOV  @Ri,A
												 "00000110" |   
												 "00000111" |	-- instruction INC @Ri
												 "00010110" |
												 "00010111" |   -- instruction DEC @Ri            
												 "00100110" |
												 "00100111" |	-- instruction ADD  A,@Ri
												 "00110110" |
												 "00110111" |	-- instruction	ADDC A,@Ri
												 "01000110" |
												 "01000111" |	-- instruction	OR  A,@Ri
												 "01010110" |
												 "01010111" |	-- instruction	ANL  A,@Ri
												 "01100110" |
												 "01100111" |	-- instruction	XRL  A,@Ri
												 "10010110" |
												 "10010111" 	-- instruction SUBB A,@Ri       	
															 => --use stage 28
															 	RAM_TO_INTBUS	 <= '0';
																WRITE_TMP1		 <= '0';--clear old value
																TMP1_TO_INTBUS   <= '1';
								        						WRITE_INT_MAR	 <= '1';--DLY1;
																-- next stage = 29, 30, 32
															 															
											when "11100100"  	-- instruction CLR A
															 =>	B_OP_OUT2BUS 	 <= '0';
														        WRITE_ACC    	 <= '0';--clear old value of stage 35
													
											
											when "11110100"| 	-- instruction CPL A
												 "00000100"|    -- instruction INC A
												 "00010100"|    -- instruction DEC A
												 "00000011"|	-- instruction RR  A
												 "00010011"|	-- instruction RRC A
												 "00100011"|	-- instruction RL  A
												 "00110011" 	-- instruction RLC A
            												 =>	ALU_ENABLE		 <= '1';
															 	ALU_MODE		 <= NO_OP_INS;
														  		ALU_TO_INTBUS 	 <= '1';--DLY1;
														        WRITE_ACC     	 <= '1';--DLY2;
																--next stage = none ++ cleared
																
											when "10110011" | 	-- CPL C
												 "11010011" 	-- SETB C
												 			 => -- use stage 40 
															    -- next stage = 41
															    WRITE_TMP2_F_BUS <= '0';
															    PSW_TO_INTBUS    <= '0';
															    B_OP_OUT2BUS     <= '0';--clear old value
															    ALU_ENABLE 		 <= '1';
														        ALU_MODE   	     <= NOT_INS; 
															    																																							
											when "11000011" 	-- CLR C																	
															 => -- use stage 39 
															    --next stage = none ++ cleared
															    ALU_TO_INTBUS 	 <= '0';
															    WRITE_TMP2_F_BUS <= '0';
															    B_OP_OUT2BUS     <= '0';--clear old value from stage 38 and 41
															    ALU_ENABLE 		 <= '1';
															    ALU_MODE   		 <= RLC_INS;
															 
											when "01110110"|		
												 "01110111"| 	-- instruction MOV @Ri,#data	*2b-1cycle
												 "01111000"|
												 "01111001"|
												 "01111010"|
												 "01111011"|												 
												 "01111100"|
												 "01111101"|
												 "01111110"|
												 "01111111"| 	-- instruction MOV Rn,#data		*2b-1cycle
												 "01000010"|	-- instruction ORL direct,A    	*2b-1cycle
												 "01010010"|	-- instruction ANL direct,A		*2b-1cycle
												 "01100010"|	-- instruction XRL direct,A		*2b-1cycle
												 "10100010"|	-- instruction MOV C,bit		*2b-1cycle
												 "10110010"|	-- instruction CPL bit			*2b-1cycle
												 "11000010"|	-- instruction CLR bit			*2b-1cycle
												 "11010010"|	-- instruction SETB bit			*2b-1cycle
												 "00100100"|	-- instruction ADD A,#data		*2b-1cycle
												 "00110100"|	-- instruction ADDC A,#data		*2b-1cycle
												 "01000100"|	-- instruction ORL A,#data		*2b-1cycle
												 "01010100"|	-- instruction ANL A,#data		*2b-1cycle
												 "01100100"|	-- instruction XRL A,#data		*2b-1cycle
												 "01110100"|	-- instruction MOV A,#data		*2b-1cycle
												 "10010100"|	-- instruction SUBB A,#data		*2b-1cycle
												 "00000101"|	-- instruction INC direct		*2b-1cycle
												 "00010101"|	-- instruction DEC direct		*2b-1cycle
												 "00100101"|	-- instruction ADD A,direct		*2b-1cycle
												 "00110101"|	-- instruction ADDC A,direct	*2b-1cycle
												 "01000101"|	-- instruction ORL A,direct		*2b-1cycle
												 "01010101"|	-- instruction ANL A,direct		*2b-1cycle
												 "01100101"|	-- instruction XRL A,direct		*2b-1cycle
												 "10010101"|	-- instruction SUBB A,direct	*2b-1cycle
												 "11000101"|	-- instruction XCH A,direct		*2b-1cycle												 
												 "11100101"|	-- instruction MOV A,direct		*2b-1cycle
												 "11110101"| 	-- instruction MOV direct,A		*2b-1cycle
												 "01000000"|	-- instruction JC   rel
												 "10000000"		-- instruction SJMP rel
												 			 => -- use stage 49
															 	ALE 			 <= '0';--clear old value
														  		--ACCESS_EXT_MEM <= '1';
																-- next stage = 50				 

											when others		 => 
										end case; -- IR(7 downto 0)	
--*********************************************************************************************************************************************
					when 11			=>	case IR(7 downto 0) is					
											when "00001000" |		
												 "00001001" |
												 "00001010" |
												 "00001011" |													 												 
												 "00001100" |
												 "00001101" |
												 "00001110" |
												 "00001111" |	-- instruction INC Rn												 
												 "00011000" |
												 "00011001" |
												 "00011010" |
												 "00011011" |													 
												 "00011100" |
												 "00011101" |
												 "00011110" |
												 "00011111"     -- instruction DEC Rn
												 			 => ALU_ENABLE		 <= '0';--clear old value
																ALU_TO_INTBUS 	 <= '1';--DLY1;
							            						WRITE_RAM        <= '1';--DLY2;
															 	
															 	             					
											when "00101000" |
												 "00101001" |
												 "00101010" |
												 "00101011" |												 
												 "00101100" |
												 "00101101" |
												 "00101110" |
												 "00101111" |	-- instruction ADD  A,Rn												 
												 "00111000" |
												 "00111001" |
												 "00111010" |
												 "00111011" |												 
												 "00111100" |
												 "00111101" |
												 "00111110" |
												 "00111111" |	-- instruction ADDC A,Rn											 
												 "01001000" |
												 "01001001" |
												 "01001010" |
												 "01001011" |												 
												 "01001100" |
												 "01001101" |
												 "01001110" |
												 "01001111" | 	-- instruction OR   A,Rn
												 "01011000" |
												 "01011001" |
												 "01011010" |
												 "01011011" |												 
												 "01011100" |
												 "01011101" |
												 "01011110" |
												 "01011111" | 	-- instruction ANL  A,Rn
												 "01101000" | 	
												 "01101001" | 	
												 "01101010" | 	
												 "01101011" | 													 
												 "01101100" | 	
												 "01101101" | 	
												 "01101110" | 	
												 "01101111" | 	-- instruction XRL  A,Rn
												 "10011000" |
												 "10011001" |
												 "10011010" |
												 "10011011" |												 
												 "10011100" |
												 "10011101" |
												 "10011110" |
												 "10011111" 	-- instruction SUBB A,Rn
               												 => ALU_ENABLE		 <= '0';--clear old value					
																ALU_TO_INTBUS 	 <= '1';--DLY1;
								        						WRITE_ACC        <= '1';--DLY2;															 
															 	
															 
											when "11001000" |	
												 "11001001" |	
												 "11001010" |	
												 "11001011" |													 
												 "11001100" |	
												 "11001101" |	
												 "11001110" |	
												 "11001111" 	-- instruction XCH  A,Rn
															 => TMP2_TO_INTBUS 	 <= '0';
														        WRITE_RAM        <= '0';--clear old value of stage 16
																
											when "11000110" |
												 "11000111"  	-- instruction XCH  A,@Ri
															 => --use stage 24
															 	TMP1_TO_INTBUS	 <= '0';
																WRITE_INT_MAR	 <= '0';
																WRITE_TMP2_F_ACC <= '0';--clear old value
																RAM_TO_INTBUS    <= '1';
								        						WRITE_ACC        <= '1';--DLY1;
																--next stage = 25																																
										 
										    when "11100110" |	
												 "11100111" |	-- instruction MOV  A,@Ri	
												 "11110110" |
												 "11110111"     -- instruction MOV  @Ri,A
												 			 =>	--use stage 29
																TMP1_TO_INTBUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value
																if IR(4) = '0' then
																	RAM_TO_INTBUS    <= '1';	-- MOV  A,@Ri	
									        						WRITE_ACC        <= '1';    -- MOV  A,@Ri	
																elsif IR(4) = '1' then
																	ACC_TO_INTBUS    <= '1';    -- MOV  @Ri,A
															        WRITE_RAM        <= '1';    -- MOV  @Ri,A        
																end if;
																--next stage = none
												 
											when "00000110" |   
												 "00000111" |	-- instruction INC @Ri
												 "00010110" |
												 "00010111"     -- instruction DEC @Ri
												 			 => --use stage 30
															 	TMP1_TO_INTBUS	 <= '0';
																WRITE_INT_MAR	 <= '0';--clear old value of stage 28										
																RAM_TO_INTBUS 	 <= '1';
								       							WRITE_TMP2_F_BUS <= '1';--DLY1;
																
												 
											when "00100110" |
												 "00100111" |	-- instruction ADD  A,@Ri
												 "00110110" |
												 "00110111" |	-- instruction	ADDC A,@Ri
												 "01000110" |
												 "01000111" |	-- instruction	OR  A,@Ri
												 "01010110" |
												 "01010111" |	-- instruction	ANL  A,@Ri
												 "01100110" |
												 "01100111" |	-- instruction	XRL  A,@Ri
												 "10010110" |
												 "10010111" 	-- instruction SUBB A,@Ri       	
												 			 => --use stage 32
															 	TMP1_TO_INTBUS   <= '0';
								        						WRITE_INT_MAR	 <= '0';--clear old value
																RAM_TO_INTBUS 	 <= '1';
								        						WRITE_TMP1	  	 <= '1';--DLY1;
								        						WRITE_TMP2_F_ACC <= '1';
								        						
															 															
											when "11110100"| 	-- instruction CPL A
												 "00000100"|    -- instruction INC A
												 "00010100"|    -- instruction DEC A
												 "00000011"|	-- instruction RR  A
												 "00010011"|	-- instruction RRC A
												 "00100011"|	-- instruction RL  A
												 "00110011" 	-- instruction RLC A
            												 =>	ALU_ENABLE	   <= '0';
															 	ALU_TO_INTBUS  <= '0';
														        WRITE_ACC      <= '0';--clear old value of stage 37
											
											when "10110011" | 	-- CPL C
												 "11010011" 	-- SETB C
															 => --use stage 41
															    --next stage 39
															    ALU_ENABLE 		 <= '0';--clear old value
															    ALU_TO_INTBUS 	 <= '1';--DLY1;
								       						    WRITE_TMP2_F_BUS <= '1';--DLY2;
																
											when "11000011" 	-- CLR C																	
															 => ALU_ENABLE 		 <= '0';--clear old value of stage 39
											
											when "01110110"|		
												 "01110111"| 	-- instruction MOV @Ri,#data	*2b-1cycle
												 "01111000"|
												 "01111001"|
												 "01111010"|
												 "01111011"|												 
												 "01111100"|
												 "01111101"|
												 "01111110"|
												 "01111111"| 	-- instruction MOV Rn,#data		*2b-1cycle												
												 "01000010"|	-- instruction ORL direct,A    	*2b-1cycle
												 "01010010"|	-- instruction ANL direct,A		*2b-1cycle
												 "01100010"|	-- instruction XRL direct,A		*2b-1cycle
												 "10100010"|	-- instruction MOV C,bit		*2b-1cycle
												 "10110010"|	-- instruction CPL bit			*2b-1cycle
												 "11000010"|	-- instruction CLR bit			*2b-1cycle
												 "11010010"|	-- instruction SETB bit			*2b-1cycle
												 "00100100"|	-- instruction ADD A,#data		*2b-1cycle
												 "00110100"|	-- instruction ADDC A,#data		*2b-1cycle
												 "01000100"|	-- instruction ORL A,#data		*2b-1cycle
												 "01010100"|	-- instruction ANL A,#data		*2b-1cycle
												 "01100100"|	-- instruction XRL A,#data		*2b-1cycle
												 "01110100"|	-- instruction MOV A,#data		*2b-1cycle
												 "10010100"|	-- instruction SUBB A,#data		*2b-1cycle
												 "00000101"|	-- instruction INC direct		*2b-1cycle
												 "00010101"|	-- instruction DEC direct		*2b-1cycle
												 "00100101"|	-- instruction ADD A,direct		*2b-1cycle
												 "00110101"|	-- instruction ADDC A,direct	*2b-1cycle
												 "01000101"|	-- instruction ORL A,direct		*2b-1cycle
												 "01010101"|	-- instruction ANL A,direct		*2b-1cycle
												 "01100101"|	-- instruction XRL A,direct		*2b-1cycle
												 "10010101"|	-- instruction SUBB A,direct	*2b-1cycle
												 "11000101"|	-- instruction XCH A,direct		*2b-1cycle												 
												 "11100101"|	-- instruction MOV A,direct		*2b-1cycle
												 "11110101"| 	-- instruction MOV direct,A		*2b-1cycle
												 "01000000"|	-- instruction JC   rel
												 "10000000"		-- instruction SJMP rel
												 			 => -- use stage 50
															 	ACCESS_EXT_MEM 	 <= '0';--clear old value
																PSEN 			 <= '0';
																P0_NOT_TO_PIN 	 <= '1';
																-- next stage = 51	
																																							
											when others		 => 
										end case; -- IR(7 downto 0)	
--*********************************************************************************************************************************************
					when 12			=>	NOW_STAGE := 0;
										case IR(7 downto 0) is
											when "00101000" |
												 "00101001" |
												 "00101010" |
												 "00101011" |												 
												 "00101100" |
												 "00101101" |
												 "00101110" |
												 "00101111" |	-- instruction ADD  A,Rn												 
												 "00111000" |
												 "00111001" |
												 "00111010" |
												 "00111011" |												 
												 "00111100" |
												 "00111101" |
												 "00111110" |
												 "00111111" |	-- instruction ADDC A,Rn											 
												 "01001000" |
												 "01001001" |
												 "01001010" |
												 "01001011" |												 
												 "01001100" |
												 "01001101" |
												 "01001110" |
												 "01001111" | 	-- instruction OR   A,Rn
												 "01011000" |
												 "01011001" |
												 "01011010" |
												 "01011011" |												 
												 "01011100" |
												 "01011101" |
												 "01011110" |
												 "01011111" | 	-- instruction ANL  A,Rn
												 "01101000" | 	
												 "01101001" | 	
												 "01101010" | 	
												 "01101011" | 													 
												 "01101100" | 	
												 "01101101" | 	
												 "01101110" | 	
												 "01101111" | 	-- instruction XRL  A,Rn
												 "10011000" |
												 "10011001" |
												 "10011010" |
												 "10011011" |												 
												 "10011100" |
												 "10011101" |
												 "10011110" |
												 "10011111" 	-- instruction SUBB A,Rn
               												 => ALU_TO_INTBUS    <= '0';
														        WRITE_ACC        <= '0';--clear old value of stage 13
																
																										
											when "00001000" |		
												 "00001001" |
												 "00001010" |
												 "00001011" |													 												 
												 "00001100" |
												 "00001101" |
												 "00001110" |
												 "00001111" |	-- instruction INC Rn												 
												 "00011000" |
												 "00011001" |
												 "00011010" |
												 "00011011" |													 
												 "00011100" |
												 "00011101" |
												 "00011110" |
												 "00011111"     -- instruction DEC Rn
												 			 => ALU_TO_INTBUS 	 <= '0';
													            WRITE_RAM        <= '0';--clear old value of stage 10
										
												 										
											when "11100110" |	
												 "11100111" |	-- instruction MOV  A,@Ri	
												 "11110110" |
												 "11110111"     -- instruction MOV  @Ri,A
												 			 =>	RAM_TO_INTBUS    <= '0';	
									    						WRITE_ACC        <= '0';    
																ACC_TO_INTBUS    <= '0';    
									    						WRITE_RAM        <= '0';--clear old value of stage 29
															   					
					
					
											when "11000110" |
												 "11000111"  	-- instruction XCH  A,@Ri
															 => --use stage 25															 	
																RAM_TO_INTBUS	 <= '0';
																WRITE_ACC		 <= '0';--clear old value
																TMP2_TO_INTBUS 	 <= '1';
								        						WRITE_RAM        <= '1';--DLY1;
																--next stage = 1
										   												 
											when "00000110" |   
												 "00000111" |	-- instruction INC @Ri
												 "00010110" |
												 "00010111"     -- instruction DEC @Ri
												 			 => --use stage 31
															 	RAM_TO_INTBUS 	 <= '0';
								       							WRITE_TMP2_F_BUS <= '0';--clear old value
																ALU_ENABLE 		 <= '1';
																if IR(4) = '0' then
																	ALU_MODE  <= INC_INS;	-- INC @Ri
																else -- IR(4) = '1'
																	ALU_MODE  <= DEC_INS;   -- DEC @Ri        
																end if;
																S52 := true;
																OVERLAPED_STAGE := 0;																
																--next stage = 31
															 	
																															 													 
											when "00100110" |
												 "00100111" |	-- instruction ADD  A,@Ri
												 "00110110" |
												 "00110111" |	-- instruction	ADDC A,@Ri
												 "01000110" |
												 "01000111" |	-- instruction	OR  A,@Ri
												 "01010110" |
												 "01010111" |	-- instruction	ANL  A,@Ri
												 "01100110" |
												 "01100111" |	-- instruction	XRL  A,@Ri
												 "10010110" |
												 "10010111" 	-- instruction SUBB A,@Ri       	
												 			 => --use stage 33
																RAM_TO_INTBUS	 <= '0';
																WRITE_TMP1		 <= '0';
																WRITE_TMP2_F_ACC <= '0';--clear old value
																ALU_ENABLE    	 <= '1';
																case IR(7 downto 1) is
																	when "0010011"  => ALU_MODE <= ADD_INS;		-- ADD  A,@Ri
																	when "0011011"  => ALU_MODE <= ADDC_INS;	-- ADDC A,@Ri
																	when "0100011"  => ALU_MODE <= OR_INS;		-- OR  A,@Ri
																	when "0101011"  => ALU_MODE <= AND_INS;		-- ANL  A,@Ri
																	when "0110011"  => ALU_MODE <= XOR_INS;		-- XRL  A,@Ri          
																	when "1001011"  => ALU_MODE <= SUBB_INS;	-- SUBB A,@Ri        
																	when others		=>
																end case; --IR(7 downto 1)
																S52 := true;
																OVERLAPED_STAGE := 0;

																--next stage = 33
																
																
															 															
											when "10110011" | 	-- CPL C
												 "11010011" 	-- SETB C
															 => --use stage 39
															    ALU_TO_INTBUS 	 <= '0';
																SET_ALL_BIT_ZERO <= '0';
								      							WRITE_TMP2_F_BUS <= '0';
																B_OP_OUT2BUS     <= '0';--clear old value from stage 38 and 41
																ALU_ENABLE 		 <= '1';
								        						ALU_MODE   		 <= RLC_INS;
																--next stage = none

											when "01110110"|		
												 "01110111"| 	-- instruction MOV @Ri,#data	*2b-1cycle													 
												 "01111000"|
												 "01111001"|
												 "01111010"|
												 "01111011"|												 
												 "01111100"|
												 "01111101"|
												 "01111110"|
												 "01111111"| 	-- instruction MOV Rn,#data		*2b-1cycle												
												 "01000010"|	-- instruction ORL direct,A    	*2b-1cycle
												 "01010010"|	-- instruction ANL direct,A		*2b-1cycle
												 "01100010"|	-- instruction XRL direct,A		*2b-1cycle
												 "10100010"|	-- instruction MOV C,bit		*2b-1cycle
												 "10110010"|	-- instruction CPL bit			*2b-1cycle
												 "11000010"|	-- instruction CLR bit			*2b-1cycle
												 "11010010"|	-- instruction SETB bit			*2b-1cycle
												 "00100100"|	-- instruction ADD A,#data		*2b-1cycle
												 "00110100"|	-- instruction ADDC A,#data		*2b-1cycle
												 "01000100"|	-- instruction ORL A,#data		*2b-1cycle
												 "01010100"|	-- instruction ANL A,#data		*2b-1cycle
												 "01100100"|	-- instruction XRL A,#data		*2b-1cycle
												 "01110100"|	-- instruction MOV A,#data		*2b-1cycle
												 "10010100"|	-- instruction SUBB A,#data		*2b-1cycle
												 "00000101"|	-- instruction INC direct		*2b-1cycle
												 "00010101"|	-- instruction DEC direct		*2b-1cycle
												 "00100101"|	-- instruction ADD A,direct		*2b-1cycle
												 "00110101"|	-- instruction ADDC A,direct	*2b-1cycle
												 "01000101"|	-- instruction ORL A,direct		*2b-1cycle
												 "01010101"|	-- instruction ANL A,direct		*2b-1cycle
												 "01100101"|	-- instruction XRL A,direct		*2b-1cycle
												 "10010101"|	-- instruction SUBB A,direct	*2b-1cycle
												 "11000101"|	-- instruction XCH A,direct		*2b-1cycle												 
												 "11100101"|	-- instruction MOV A,direct		*2b-1cycle
												 "11110101"| 	-- instruction MOV direct,A		*2b-1cycle
												 "01000000"|	-- instruction JC   rel
												 "10000000"		-- instruction SJMP rel
												 			 => -- use stage 51 ++ cleared
															 	--P0_NOT_TO_PIN 	 <= '1';
								  								--PSEN 			 <= '0';
																S52 := true;
																OVERLAPED_STAGE := 0;
															 	-- next stage = 52
																																											
											when others		 => 
										end case; -- IR(7 downto 0)	


--********************************************************************************************************
				 	when others 	=> 	
				end case; -- NOW_STAGE
				NOW_STAGE := NOW_STAGE + 1;
				OVERLAPED_STAGE := OVERLAPED_STAGE + 1;
				
			end if;	-- RESET = '0'
		end if;	--rising_edge(CLOCK) = '1'	
	end process SEND_CONTROL;
end DATA_PATH;