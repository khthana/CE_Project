library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity PORT1 is
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
end PORT1;	


architecture BEHAVIOR of PORT1 is
	signal INT_REG : std_logic_vector(7 downto 0) := "11111111";
begin
	process(PORT1_IN_INTERNAL, CLOCK, RESET, READ_LATCH,
   			READ_PIN, WRITE_TO_LATCH, PORT1_IN_PIN, INT_REG    		
			)
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG <= "11111111";
			elsif WRITE_TO_LATCH = '1' then
				INT_REG <= PORT1_IN_INTERNAL;
			else
				INT_REG <= INT_REG;	
			end if;
		end if;
			
		if READ_LATCH = '1' then
			PORT1_OUT_INTERNAL <= INT_REG;
		elsif READ_PIN = '1' then
			PORT1_OUT_INTERNAL <= PORT1_IN_PIN;
		else
			PORT1_OUT_INTERNAL <= INT_REG;
		end if;
		PORT1_OUT_PIN          <= INT_REG;
		
	end process;		
end BEHAVIOR;

