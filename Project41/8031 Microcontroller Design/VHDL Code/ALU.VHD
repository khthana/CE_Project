library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
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
        RESET			:in std_logic
							);					    
end ALU;	

architecture BEHAVIOR of ALU is
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

	signal DATA_OUT_TMP :std_logic_vector(7 downto 0);
   		
		
begin
	OP_INSIDE : process (DATA_IN1, DATA_IN2, CLOCK, CARRY_IN,
    					 INSTRUCTION, ALU_SELECTED, RESET )
		variable INT_REG   : std_logic_vector(8 downto 0);
		variable INT_REG_H : std_logic_vector(8 downto 0) ;
		variable FIRST_TIME : boolean ;
		variable A, A2, M2 : integer;
	begin
	if (CLOCK'EVENT and CLOCK = '0') then
		if RESET = '0' then
			FIRST_TIME := true;
			INT_REG_H  := "000000000";
			INT_REG	   := "000000000";       
	        CARRY_OUT 		<=	'0';
        	OVERFLOW_OUT	<=	'0';
        	AUX_C_OUT   	<=	'0';
        	CARRY_CHANGE 	<=	'0';
        	OVERFLOW_CHANGE <=	'0';
        	AUX_C_CHANGE 	<=	'0';			
		else -- RESET = '0'	
			if ALU_SELECTED = '1' then 
				case INSTRUCTION is
					when ADD_INS | ADDC_INS  =>
								    INT_REG  := ('0' & DATA_IN1)  +  ( '0' & DATA_IN2);
                    				if INSTRUCTION(0) = '1' then
                                    	if CARRY_IN = '1' then
                                    		INT_REG := INT_REG + 1;
                                        end if;
                                    end if;
										
										
										--- maintain carry flag
										CARRY_CHANGE <= '1';
						       			if INT_REG(8) = '1' then
						       				CARRY_OUT <= '1';
						       			else
						                   	CARRY_OUT <= '0';
						                end if;
										
										--- maintain overflow flag
										OVERFLOW_CHANGE <= '1';
										if INSTRUCTION(1) = '0' then -- this means the instruction ADDC, ADD
											if (    (DATA_IN1(7)='1' and DATA_IN2(7)='1' and INT_REG(7)='0')     or
												    (DATA_IN1(7)='0' and DATA_IN2(7)='0' and INT_REG(7)='1')   )    then
                                                    OVERFLOW_OUT <= '1';
	                                        else
    	                                    		OVERFLOW_OUT <= '0';
        	                                end if; 
                                        else  -- this means the instruction SUBB
											if (    (DATA_IN1(7)='1' and DATA_IN2(7)='0' and INT_REG(7)='0')     or
												    (DATA_IN1(7)='0' and DATA_IN2(7)='1' and INT_REG(7)='1')   )    then
                                                    OVERFLOW_OUT <= '1';
	                                        else
    	                                    		OVERFLOW_OUT <= '0';
        	                                end if;
                                        end if; --INSTRUCTION(1) = '0'           
                
					                	--- maintain auxilary carry flag
					                	AUX_C_CHANGE <= '1';
					                	A2 := conv_integer(DATA_IN1(3 downto 0));
						                M2 := conv_integer(DATA_IN2(3 downto 0));					                    
					                    if INSTRUCTION (1) = '0' then -- this means the instruction ADDC, ADD
											A2 := A2 + M2;
                                        	if CARRY_IN = '1' then
                                        		A2 := A2 + 1;
                                            end if;
                                        	if A2 > 15 then
				            	        		AUX_C_OUT <= '1';
					                	    else
					                    		AUX_C_OUT <= '0';
						                    end if;	
                                        else -- this means the instruction SUBB
										    if CARRY_IN = '1' then
										    	A2 := A2 - 1;
										   	end if;
										   	if A2 < M2 then
										   		AUX_C_OUT <= '1';
										   	else
										   		AUX_C_OUT <= '0';
										   	end if;                                    		
                                        end if;
                                    	
                                    
    	            when SUBB_INS => INT_REG  := ('0' & DATA_IN1)  -  ('0' & DATA_IN2);
                    				if CARRY_IN = '1' then
                                    	INT_REG := INT_REG -1;
                                    end if;
										
										
										--- maintain carry flag
										CARRY_CHANGE <= '1';
						       			if INT_REG(8) = '1' then
						       				CARRY_OUT <= '1';
						       			else
						                   	CARRY_OUT <= '0';
						                end if;
										
										--- maintain overflow flag
										OVERFLOW_CHANGE <= '1';
										if INSTRUCTION(1) = '0' then -- this means the instruction ADDC, ADD
											if (    (DATA_IN1(7)='1' and DATA_IN2(7)='1' and INT_REG(7)='0')     or
												    (DATA_IN1(7)='0' and DATA_IN2(7)='0' and INT_REG(7)='1')   )    then
                                                    OVERFLOW_OUT <= '1';
	                                        else
    	                                    		OVERFLOW_OUT <= '0';
        	                                end if; 
                                        else  -- this means the instruction SUBB
											if (    (DATA_IN1(7)='1' and DATA_IN2(7)='0' and INT_REG(7)='0')     or
												    (DATA_IN1(7)='0' and DATA_IN2(7)='1' and INT_REG(7)='1')   )    then
                                                    OVERFLOW_OUT <= '1';
	                                        else
    	                                    		OVERFLOW_OUT <= '0';
        	                                end if;
                                        end if; --INSTRUCTION(1) = '0'           
                
					                	--- maintain auxilary carry flag
					                	AUX_C_CHANGE <= '1';
					                	A2 := conv_integer(DATA_IN1(3 downto 0));
						                M2 := conv_integer(DATA_IN2(3 downto 0));					                    
					                    if INSTRUCTION (1) = '0' then -- this means the instruction ADDC, ADD
											A2 := A2 + M2;
                                        	if CARRY_IN = '1' then
                                        		A2 := A2 + 1;
                                            end if;
                                        	if A2 > 15 then
				            	        		AUX_C_OUT <= '1';
					                	    else
					                    		AUX_C_OUT <= '0';
						                    end if;	
                                        else -- this means the instruction SUBB
										    if CARRY_IN = '1' then
										    	A2 := A2 - 1;
										   	end if;
										   	if A2 < M2 then
										   		AUX_C_OUT <= '1';
										   	else
										   		AUX_C_OUT <= '0';
										   	end if;                                    		
                                        end if;                                    
					
			
					when AND_INS => INT_REG  :=  ('0' & DATA_IN1)  and  ('0' & DATA_IN2);
                                    CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

                    				
					when OR_INS  => INT_REG  :=  ('0' & DATA_IN1)  or   ('0' & DATA_IN2);
                    				CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

					when XOR_INS => INT_REG  :=  ('0' & DATA_IN1)  xor  ('0' & DATA_IN2);
	                   				CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

            	    when NOT_INS => INT_REG  :=  '0' & (not DATA_IN1);
                    				CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

				
					when RR_INS  => INT_REG(6 downto 0)  :=  DATA_IN1(7 downto 1);
                    				INT_REG(8) := '0';
                                    INT_REG(7) := DATA_IN1(0);
                                    CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

                                    
            	    when RL_INS  => INT_REG(8 downto 1)  :=  '0' & DATA_IN1(6 downto 0);
                    				INT_REG(0)	:= DATA_IN1(7);
                                    CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

                                    
                    
					when RRC_INS => INT_REG  :=  '0' & CARRY_IN & DATA_IN1(7 downto 1);
            	    				CARRY_OUT <= DATA_IN1(0);
									CARRY_CHANGE <= '1';
                                    
	                when RLC_INS => INT_REG  :=  '0' & DATA_IN1(6 downto 0) & CARRY_IN;
    	            				CARRY_OUT <= DATA_IN1(7);
                                    CARRY_CHANGE <= '1';
	                                
					when INC_INS | DEC_INS
								 => INT_REG  := '0' & DATA_IN1;
								 	if INSTRUCTION(0) = '1' then --INC
										A	:= 1;
									else 						 --DEC
										A	:= -1;
									end if;
									INT_REG  :=  INT_REG + A;
                                    CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

                                    
	                when others => INT_REG  :=  INT_REG;                
                    				CARRY_CHANGE 	<= '0';
                                    OVERFLOW_CHANGE <= '0';
                                    AUX_C_CHANGE    <= '0';

				end case;
			
                					
	   		else 
				INT_REG := INT_REG;
			end if;	 -- ALU_SELECTED = '1';
        end if;	 --RESET = '0;  
		DATA_OUT <= INT_REG(7 downto 0);
	end if; -- (CLOCK'EVENT and CLOCK = '0')
	
	end process OP_INSIDE;
         
end BEHAVIOR;

