library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LATCH_373 is
    port(DATA_IN	:in std_logic_vector(7 downto 0);
		LOAD_IN		:in std_logic;
		DATA_OUT	:out std_logic_vector(7 downto 0)
		);
end LATCH_373;	

architecture BEHAVIOR of LATCH_373 is
	signal INT_REG : std_logic_vector(7 downto 0);
begin
	process ( LOAD_IN )
	begin
		if falling_edge(LOAD_IN) then
			INT_REG <= DATA_IN;	
		end if;
	end process;
	DATA_OUT <= INT_REG;	
end BEHAVIOR;		   





