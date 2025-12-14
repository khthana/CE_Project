library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity RAM_ADDR_REG is
	port(F_IR, DATA_IN	:in std_logic_vector(7 downto 0);
		DATA_OUT	:out std_logic_vector(7 downto 0);
		CLOCK		:in std_logic;        
		LOAD_IN		:in std_logic;
		RESET		:in std_logic);
end RAM_ADDR_REG;	

architecture BEHAVIOR of RAM_ADDR_REG is

begin
	process (DATA_IN, CLOCK, LOAD_IN, RESET, F_IR )
			variable  INT_REG : std_logic_vector(7 downto 0);	
	begin
		if (CLOCK'EVENT and CLOCK = '0') then
			if RESET = '0' then
				INT_REG := "00000000";
			elsif(LOAD_IN ='1') then
				if DATA_IN(7) = '1' then
					case F_IR is
						when "10100010"|	-- instruction MOV  C,bit
							 "10110010"|	-- instruction CPL  bit
					 		 "11000010"|	-- instruction CLR  bit
					 		 "11010010"=>	-- instruction SETB bit
							 				INT_REG := DATA_IN(7 downto 3) & "000";

						when others    =>   INT_REG := DATA_IN;
					end case;
				else
	       	    	INT_REG := DATA_IN;
				end if;
			end if;
		end if;

		DATA_OUT <= INT_REG;
	end process;
end BEHAVIOR;