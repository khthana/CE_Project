library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;




entity PROG_ADDR_REG is
	port(DATA_IN	:in std_logic_vector(15 downto 0);
		DATA_OUT	:out std_logic_vector(15 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
end PROG_ADDR_REG;	

architecture BEHAVIOR of PROG_ADDR_REG is

begin
	process (DATA_IN, CLOCK, LOAD_IN, RESET	)
			variable  INT_REG : std_logic_vector(15  downto 0);	
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG := "1111111111111111";
			else
				if(LOAD_IN ='1') then
        	    	INT_REG := DATA_IN;				
				end if;
			end if;
		end if; -- RESET = '0'
		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;