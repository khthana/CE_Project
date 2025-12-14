library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity PORT3 is
	port(PORT3_IN_INTERNAL		:in std_logic_vector(7 downto 0);
		PORT3_OUT_INTERNAL		:out std_logic_vector(7 downto 0);
		CLOCK					:in std_logic;
		RESET					:in std_logic;
		READ_LATCH				:in std_logic;
   		READ_PIN				:in std_logic;
		WRITE_TO_LATCH	 		:in std_logic;
		PORT3_OUT_PIN			:out std_logic_vector(7 downto 0);
		PORT3_IN_PIN			:in std_logic_vector(7 downto 0);
        
        MEM_WR_ACTIVE_L			:in std_logic;
        MEM_RD_ACTIVE_L			:in std_logic
		); 											  
end PORT3;	


architecture BEHAVIOR of PORT3 is
	signal INT_REG : std_logic_vector(7 downto 0) := "11111111";
	alias INT0 : std_logic is INT_REG(2);
	alias INT1 : std_logic is INT_REG(3);
	alias T0   : std_logic is INT_REG(4);	
	alias T1   : std_logic is INT_REG(5);	
	alias WR   : std_logic is INT_REG(6);	
	alias RD   : std_logic is INT_REG(7);			
begin
	process(PORT3_IN_INTERNAL, CLOCK, RESET,READ_LATCH,
	   		READ_PIN, WRITE_TO_LATCH, PORT3_IN_PIN,
			MEM_WR_ACTIVE_L, MEM_RD_ACTIVE_L, INT_REG    
			)
	begin
		if CLOCK'EVENT and CLOCK = '0' then
			if RESET = '0' then
				INT_REG <= "11111111";
			elsif READ_PIN = '1' then
				PORT3_OUT_INTERNAL <= PORT3_IN_PIN;
			elsif WRITE_TO_LATCH = '1' then
				INT_REG <= PORT3_IN_INTERNAL;
			end if;
		end if;
			
		if READ_LATCH = '1' then
			PORT3_OUT_INTERNAL <= INT_REG;
		elsif READ_PIN = '1' then
			PORT3_OUT_INTERNAL <= PORT3_IN_PIN;
		elsif MEM_RD_ACTIVE_L = '1' then
            PORT3_OUT_PIN(7) <= '0';		-- active low
		elsif MEM_WR_ACTIVE_L = '1' then
    	    PORT3_OUT_PIN(6) <= '0';	-- active low
        else
           	PORT3_OUT_PIN <= INT_REG;
        end if;                      
 
	end process;		
end BEHAVIOR;
