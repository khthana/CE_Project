library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BIT_OPERATOR is
	port(CLOCK, LOAD_IN			:in std_logic;
		BIT_NUMBER			:in std_logic_vector(2 downto 0);
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
end BIT_OPERATOR;	

architecture BEHAVIOR of BIT_OPERATOR is
begin
	BIT_OPERATION : process (CLOCK, LOAD_IN, BIT_NUMBER, ORIGINAL_VALUE, CARRY_FLAG,
							PREPARE_FOR_ROTATE, CLR_BIT, CPL_BIT, SET_BIT,
							WRITE_BIT_F_CARRY, CHK_BIT,SET_ALL_BIT_ZERO
							)
		variable I : integer;
		variable INT_REG : std_logic_vector(7 downto 0);
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			I := conv_integer(BIT_NUMBER);
			if LOAD_IN = '1' then
				if ORIGINAL_VALUE(7) = '1' then
					INT_REG := ORIGINAL_VALUE;
				else
					INT_REG := "001" & ORIGINAL_VALUE(7 downto 3);
				end if;
			elsif PREPARE_FOR_ROTATE = '1' then
				INT_REG(7) := ORIGINAL_VALUE(I);				
			elsif CLR_BIT = '1' then
				INT_REG := ORIGINAL_VALUE;			
				INT_REG(I) := '0';			
			elsif CPL_BIT = '1' then
				INT_REG := ORIGINAL_VALUE;
			    INT_REG(I) := not INT_REG(I);
	        elsif SET_BIT = '1' then
				INT_REG := ORIGINAL_VALUE;
        		INT_REG(I) := '1';
        	elsif WRITE_BIT_F_CARRY = '1' then
        		INT_REG(I) := CARRY_FLAG;      
        	elsif SET_ALL_BIT_ZERO = '1' then
        		INT_REG := "00000000";      
        	end if;
		end if;--clock'event and clock = '0'
        BIT_OPERATED <= INT_REG;				
	end process BIT_OPERATION;
	
    CHECK_BIT  : process (CHK_BIT, BIT_NUMBER)
    begin
    	if CHK_BIT = '1' then
    		CHECKED_BIT_STATUS <= ORIGINAL_VALUE(conv_integer(BIT_NUMBER));
    	end if;
    end process CHECK_BIT;
    
end BEHAVIOR;		   
