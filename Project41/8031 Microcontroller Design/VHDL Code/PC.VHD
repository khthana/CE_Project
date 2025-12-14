library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PC is
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
end PC;	

architecture BEHAVIOR of PC is

begin
	process (CLOCK)
			variable  INT_REG : std_logic_vector(15  downto 0);
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG := "0000000000000000";
			else
				if(LOAD_IN16 ='1') then
    	        	INT_REG := DATA_IN16;				
	            else
	                if (INC_PC = '1') then
    	        	    INT_REG := INT_REG + 1;             	
                    else
                    	if (LOAD_IN8H = '1') then
                    		INT_REG(15 downto 8) := DATA_IN8;                            
                    	else
                        	if (LOAD_IN8L = '1' ) then
                        		INT_REG(7 downto 0) := DATA_IN8;
                            end if; -- LOAD_IN8L = '1'                      	
                        end if;  -- LOAD_IN8H = '1'
                    end if;	-- INC_PC = '1'
				end if;  -- LOAD_IN16 = '1'
			end if; -- RESET = '0'
		end if;
		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;

			    