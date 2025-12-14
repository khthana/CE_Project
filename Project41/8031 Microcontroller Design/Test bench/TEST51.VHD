library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TEST_MCS51 is
    generic (CLOCK_DIV2: time := 200 ns);

end TEST_MCS51;	

architecture BEHAVIOR of TEST_MCS51 is
	component CPU_MCS_51 
   port(
		P0_PIN ,
		P1_PIN ,
        P2_PIN ,
        P3_PIN      : inout std_logic_vector(7 downto 0) := "ZZZZZZZZ";    
        PSEN,
        ALE			: out std_logic;
        CLOCK,
        RESET 		: in std_logic;
        
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
--- FOR TEST ONLY
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        ACC,
        PSW,
        IRs          : out std_logic_vector(7 downto 0)
--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
        
		); 	

    end component;     
    
    component LATCH_373 
    port(DATA_IN	:in std_logic_vector(7 downto 0);
		LOAD_IN		:in std_logic;
		DATA_OUT	:out std_logic_vector(7 downto 0)
		);
    end component;        	
--- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--- signal declaration        
--- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
	signal	P0_PIN, P1_PIN, P2_PIN ,P3_PIN : std_logic_vector(7 downto 0) bus := "ZZZZZZZZ";    
    signal  PSEN, ALE	   : std_logic := '0';        
    signal  RESET : std_logic := '1';
    signal CLOCK : std_logic  := '0';
	--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4
	--- FOR TEST ONLY
	--- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	signal 
        ACC,
        PSW,
        IRs,        		        
        ADDRESS_BYTE_LOW :  std_logic_vector(7 downto 0);


    type ARRAY32 is array(0 to 41) of std_logic_vector(7 downto 0);
--- ***********************
--- statement part
--- ***********************
begin
	
    
    
	SEND_CLOCK : process
	begin
		 wait for 1 ns;
		 CLOCK <= not CLOCK ;
         wait for CLOCK_DIV2;
    end process SEND_CLOCK;

	MAP_CPU : CPU_MCS_51 port map (
									P0_PIN ,P1_PIN ,P2_PIN ,P3_PIN ,
							        PSEN, ALE ,CLOCK, RESET ,
					                ACC,
					                PSW,
					                IRs					                 
									--- $$$$$$$$$$$$$$$$
    								);
                                    
	LATCH_MAP : LATCH_373 port map (P0_PIN, ALE, ADDRESS_BYTE_LOW );
                                    
	MEMORY : process  (PSEN)
    	variable I : integer;
    	variable INT_REG : ARRAY32 :=



  --begin below this line end with 132 if 41 line

 (		"01110100",--74 
 		"01010110",--56     MOV    A, #56	=>A=56
		"11110101",--F5 
		"10110000",--B0     MOV    P3, A	=>P3=56--use p3 as output port
		"01110100",--74 
		"01111000",--78     MOV    A, #78	=>A=78
		"11110101",--F5 
		"01100111",--67     MOV    67, A	=>[67]=78
		"11110101",--F5 
		"10000011",--83     MOV    DPH,A	=>DPH=78
		"01110100",--74 
		"10001001",--89     MOV    A, #89	=>A=89
		"11010011",--D3     SETB   C		=>carry set
		"10010101",--95 	
		"10000011",--83     SUBB    A, DPH	=>A= 10  ov set
		"11100101",--E5 
		"10010000",--90		MOV    A, P1	=>A=P1 pin = 1f   --use p1 as input port
		"01110100",--74 
		"11001110",--CE     MOV    A, #0CE	=>A=CE
		"11110101",--F5 
		"11110000",--F0     MOV    B, A		=>B=CE
		"11010011",--D3     SETB   C		=>carry set
		"10010101",--95 
		"11110000",--F0     SUBB   A, B		=>A=FF carry set, AUX-C set
		"11000011",--C3     CLR    C		=carry clear
		"10010101",--95 
		"01100111",--67     SUBB    A, 67 	=>A=87 no flag set
 		"10010101",--95
		"10010000",--90		SUBB    A, P1	=>A=68
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"01000000",--40		
		"00000101",--05		mov pcl,05 use jc rel
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"00000000",--00
		"00000000"--00		
        );
     


	begin --- of process MEMORY
        I:= conv_integer(P2_PIN &  ADDRESS_BYTE_LOW);	
        if (PSEN = '0' and I <60) then   			
        	P0_PIN <= INT_REG(I);
		else
			P0_PIN <= "ZZZZZZZZ";            
        end if;				
	end process MEMORY;    			
end BEHAVIOR;
 