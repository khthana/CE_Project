library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RAM_128_BYTE is
	generic(DATA_WIDTH	: integer:=8;
			CAPACITY	: integer:=128;
			ADDR_WIDTH 	: integer:=7);
	port(DATA_IN	:in std_logic_vector(DATA_WIDTH-1 downto 0);
		DATA_OUT	:out std_logic_vector(DATA_WIDTH-1 downto 0);
		CLOCK		:in std_logic;
		WE 		    :in std_logic;
		ADDRESS 	:in std_logic_vector(ADDR_WIDTH-1 downto 0));
end RAM_128_BYTE;	

architecture BEHAVIOR of RAM_128_BYTE is
	type MEMORY is array ( 0 to CAPACITY-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal RAM_CELL : MEMORY;
begin
	process(CLOCK)    
	begin
		if (CLOCK'EVENT and CLOCK= '0') then
			if (WE = '1') then
				RAM_CELL(conv_integer(ADDRESS)) <= DATA_IN;
            end if;
		end if;
	end process;
	DATA_OUT <= RAM_CELL(conv_integer(ADDRESS));
end BEHAVIOR;
 