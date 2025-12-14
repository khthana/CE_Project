library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PSW is
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

end PSW;	

architecture BEHAVIOR of PSW is
begin
	process (DATA_IN, ACC_IN, CLOCK, LOAD_IN, RESET, CARRY_IN, OVERFLOW_IN,
 	       AUX_C_IN, CARRY_CHANGE, OVERFLOW_CHANGE, AUX_C_CHANGE
			)
		variable  INT_REG : std_logic_vector(7  downto 0);
		alias CARRY_BIT        : std_logic is	INT_REG(7);		 
		alias AUX_C_BIT        : std_logic is	INT_REG(6);		  
		alias FLAG0_BIT	       : std_logic is	INT_REG(5);		 
		alias REG_BANK_SELECT1 : std_logic is	INT_REG(4);		 
		alias REG_BANK_SELECT2 : std_logic is	INT_REG(3);		 
		alias OVERFLOW_BIT	   : std_logic is	INT_REG(2); -- PSW.1 is reserved
		alias PARITY_BIT	   : std_logic is	INT_REG(0);		 	                
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG := "00000000";
			else			
				if(LOAD_IN ='1') then
	            	INT_REG := DATA_IN;				
    	        else    	            
			        if CARRY_CHANGE = '1' then
                		CARRY_BIT := CARRY_IN;
			        end if;                
            		if AUX_C_CHANGE = '1' then
			           	AUX_C_BIT := AUX_C_IN;
			        end if;                
            		if OVERFLOW_CHANGE = '1' then
			           	OVERFLOW_BIT := OVERFLOW_IN;	
			        end if; 
				
                    PARITY_BIT :=  ACC_IN(7) xor ACC_IN(6) xor ACC_IN(5) xor ACC_IN(4) xor 
			                       ACC_IN(3) xor ACC_IN(2) xor ACC_IN(1) xor ACC_IN(0); 
                    
				end if; -- LOAD_IN
					
			end if;
		end if;
		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;		   