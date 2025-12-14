library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;




entity GENERAL_REGISTER is
	port(DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
end GENERAL_REGISTER;	

architecture BEHAVIOR of GENERAL_REGISTER is

begin
	process (DATA_IN, CLOCK, LOAD_IN, RESET)
			variable  INT_REG : std_logic_vector(7  downto 0);	
	begin
		if CLOCK'EVENT and (CLOCK = '0') then
			if RESET = '0' then
				INT_REG := "00000000";				
			elsif(LOAD_IN ='1') then
       	    	INT_REG := DATA_IN;				
			end if;
		end if; 
		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;