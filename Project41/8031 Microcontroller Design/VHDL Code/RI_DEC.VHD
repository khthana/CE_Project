library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RI_DECODER is
    port(F_IR_0		:in std_logic;
		FLAG_RS1	:in std_logic;
        FLAG_RS0    :in std_logic;
		ADDRESS_OUT :out std_logic_vector(7 downto 0)
		);
end RI_DECODER;	

architecture STRUCTURE of RI_DECODER is
begin
	ADDRESS_OUT(7 downto 5) <= "000";
	ADDRESS_OUT(4)          <= FLAG_RS0;
	ADDRESS_OUT(3)          <= FLAG_RS1;
    ADDRESS_OUT(2 downto 1) <= "00";
	ADDRESS_OUT(0)			<= F_IR_0; 
end STRUCTURE;		   
