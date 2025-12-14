library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PORT_0_OR_2 is
	port(ADDRESS_OR_DATA		:in std_logic_vector(7 downto 0);
		PORT02_IN_INTERNAL		:in std_logic_vector(7 downto 0);
		PORT02_OUT_INTERNAL		:out std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		READ_LATCH				:in std_logic;
   		READ_PIN				:in std_logic;
		WRITE_TO_LATCH	 		:in std_logic;
		ACCESS_EXTERNAL_MEM		:in std_logic;
		PORT02_OUT_PIN			:out std_logic_vector(7 downto 0);
		PORT02_IN_PIN			:in std_logic_vector(7 downto 0);
        READ_EXT_MEM			:in std_logic
		); 											  
end PORT_0_OR_2;	

architecture BEHAVIOR of PORT_0_OR_2 is
	signal INT_REG : std_logic_vector(7 downto 0) := "11111111";
begin
	process(CLOCK, READ_LATCH, READ_PIN, WRITE_TO_LATCH, ACCESS_EXTERNAL_MEM, 
			READ_EXT_MEM, RESET, INT_REG,PORT02_IN_PIN, PORT02_IN_INTERNAL,
			ADDRESS_OR_DATA)
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG <= "00000000";
			elsif READ_PIN = '1' then
				INT_REG <= PORT02_IN_PIN;
			elsif WRITE_TO_LATCH = '1' then
				INT_REG <= PORT02_IN_INTERNAL;
			end if;
		end if; 
		
		if READ_LATCH = '1' then
			PORT02_OUT_INTERNAL <= INT_REG;
		elsif READ_PIN = '1' then
			PORT02_OUT_INTERNAL <= PORT02_IN_PIN;
		elsif ACCESS_EXTERNAL_MEM = '1' then
			PORT02_OUT_PIN 	    <= ADDRESS_OR_DATA;
		elsif READ_EXT_MEM = '1' then
            PORT02_OUT_INTERNAL <= PORT02_IN_PIN;
        else
    	    PORT02_OUT_PIN 	    <= INT_REG;
        end if;
	end process;		
end BEHAVIOR;
