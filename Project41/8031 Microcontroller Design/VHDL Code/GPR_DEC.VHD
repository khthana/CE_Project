library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity GPR_DECODER is
	port(F_IR_3DT0	:in std_logic_vector(2 downto 0);
		FLAG_RS1	:in std_logic;
        FLAG_RS0    :in std_logic;
		ADDRESS_OUT :out std_logic_vector(7 downto 0)
		);
end GPR_DECODER;	

architecture STRUCTURE of GPR_DECODER is
begin
	ADDRESS_OUT(7 downto 5) <= "000";
	ADDRESS_OUT(4)          <= FLAG_RS0;
	ADDRESS_OUT(3)          <= FLAG_RS1;
	ADDRESS_OUT(2 downto 0) <= F_IR_3DT0; 
end STRUCTURE;		   
