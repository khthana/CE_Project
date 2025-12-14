library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TMP2_REG is
	port(DATA_F_ACC	:in std_logic_vector(7 downto 0);
    	DATA_F_BUS	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;
		W_F_ACC 	:in std_logic;
		W_F_BUS		:in std_logic);
end TMP2_REG;	
	
architecture BEHAVIOR of TMP2_REG is

begin
	process (DATA_F_ACC, DATA_F_BUS, CLOCK, W_F_ACC, W_F_BUS )
			variable  INT_REG : std_logic_vector(7  downto 0);
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if (W_F_ACC ='1') then
				INT_REG := DATA_F_ACC;
            else
               	if (W_F_BUS = '1') then   
                	INT_REG := DATA_F_BUS;
                end if;				
			end if;
		end if;
		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;