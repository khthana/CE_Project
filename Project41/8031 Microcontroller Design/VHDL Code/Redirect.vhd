library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity REDIRECT is
	port(F_IR,
		ADDRESS_IN			:in std_logic_vector(7 downto 0);		
		RAM_TO_INTBUS,		
		WRITE_RAM			:in std_logic;		
		REAL_WRITE_RAM,
		REAL_RAM_TO_INTBUS	:out std_logic;		
		W_P0_LATCH,	W_P1_LATCH,
		W_P2_LATCH,	W_P3_LATCH,		
		R_P0_LATCH,	R_P1_LATCH,
		R_P2_LATCH,	R_P3_LATCH,		
		R_P0_PIN, R_P1_PIN,
		R_P2_PIN, R_P3_PIN,
		WRITE_PSW, WRITE_B,
		WRITE_ACC, WRITE_SP,
		WRITE_DPH, WRITE_DPL,
		PSW_TO_INTBUS, B_TO_INTBUS,
		ACC_TO_INTBUS, SP_TO_INTBUS,
		DPH_TO_INTBUS, DPL_TO_INTBUS		:out std_logic
		);
end REDIRECT;	

architecture BEHAVIOR of REDIRECT is
begin    
	process (F_IR, ADDRESS_IN, RAM_TO_INTBUS, WRITE_RAM)
		variable TMP : integer;
	begin
		W_P0_LATCH       <= '0';
  		W_P1_LATCH       <= '0';
  		W_P2_LATCH       <= '0';
  		W_P3_LATCH       <= '0';		
  		R_P0_LATCH       <= '0';
  		R_P1_LATCH       <= '0';
  		R_P2_LATCH       <= '0';
  		R_P3_LATCH       <= '0';		
  		R_P0_PIN         <= '0';
  		R_P1_PIN         <= '0';
  		R_P2_PIN         <= '0';
  		R_P3_PIN         <= '0';
		WRITE_PSW		 <= '0';
  		WRITE_B          <= '0';
  		WRITE_ACC        <= '0';
  		WRITE_SP         <= '0';
  		WRITE_DPH        <= '0';
  		WRITE_DPL        <= '0';
		PSW_TO_INTBUS	 <= '0';
  		B_TO_INTBUS      <= '0';
  		ACC_TO_INTBUS    <= '0';
  		SP_TO_INTBUS     <= '0';
  		DPH_TO_INTBUS    <= '0';
  		DPL_TO_INTBUS    <= '0';
		REAL_WRITE_RAM 	   <= '0';
	    REAL_RAM_TO_INTBUS <= '0';				
		TMP := conv_integer(ADDRESS_IN);
		if TMP <= 128 then			
			if WRITE_RAM = '1' then
				REAL_WRITE_RAM 	 <= '1';
				W_P0_LATCH       <= '0';
  				W_P1_LATCH       <= '0';
  				W_P2_LATCH       <= '0';
  				W_P3_LATCH       <= '0';		
  				R_P0_LATCH       <= '0';
  				R_P1_LATCH       <= '0';
  				R_P2_LATCH       <= '0';
  				R_P3_LATCH       <= '0';		
  				R_P0_PIN         <= '0';
  				R_P1_PIN         <= '0';
  				R_P2_PIN         <= '0';
  				R_P3_PIN         <= '0';
				WRITE_PSW		 <= '0';
  				WRITE_B          <= '0';
  				WRITE_ACC        <= '0';
  				WRITE_SP         <= '0';
  				WRITE_DPH        <= '0';
  				WRITE_DPL        <= '0';
				PSW_TO_INTBUS	 <= '0';
  				B_TO_INTBUS      <= '0';
  				ACC_TO_INTBUS    <= '0';
  				SP_TO_INTBUS     <= '0';
  				DPH_TO_INTBUS    <= '0';
  				DPL_TO_INTBUS    <= '0';
				REAL_RAM_TO_INTBUS <= '0';
			elsif RAM_TO_INTBUS = '1' then	  				
				REAL_RAM_TO_INTBUS <= '1';
				W_P0_LATCH       <= '0';
  				W_P1_LATCH       <= '0';
  				W_P2_LATCH       <= '0';
  				W_P3_LATCH       <= '0';		
  				R_P0_LATCH       <= '0';
  				R_P1_LATCH       <= '0';
  				R_P2_LATCH       <= '0';
  				R_P3_LATCH       <= '0';		
  				R_P0_PIN         <= '0';
  				R_P1_PIN         <= '0';
  				R_P2_PIN         <= '0';
  				R_P3_PIN         <= '0';
				WRITE_PSW		 <= '0';
  				WRITE_B          <= '0';
  				WRITE_ACC        <= '0';
  				WRITE_SP         <= '0';
  				WRITE_DPH        <= '0';
  				WRITE_DPL        <= '0';
				PSW_TO_INTBUS	 <= '0';
  				B_TO_INTBUS      <= '0';
  				ACC_TO_INTBUS    <= '0';
  				SP_TO_INTBUS     <= '0';
  				DPH_TO_INTBUS    <= '0';
  				DPL_TO_INTBUS    <= '0';
				REAL_WRITE_RAM 	 <= '0';
	    	end if;			
		else
		   	case ADDRESS_IN(6 downto 0) is
				when "0000000" => if WRITE_RAM = '1' then   --80=P0
									  W_P0_LATCH       <= '1';
									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		   <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	   <= '0';
  									  B_TO_INTBUS      <= '0';
							     	  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
									  DPH_TO_INTBUS    <= '0';
									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM   <= '0';
									  REAL_RAM_TO_INTBUS <= '0';
								  elsif RAM_TO_INTBUS = '1' then
								  	  case F_IR is
									  	  when "10110010"|	-- instruction CPL  bit
 									 		   "11000010"|	-- instruction CLR  bit
											   "11010010"|	-- instruction SETB bit
										  	   "11000101"|   --XCH A,direct
										  	   "01010010"|   --ANL direct,A
										  	   "01010100"|   --ANL direct,#data
										  	   "01000010"|   --ORL direct,A
										       "01000011"|   --ORL direct,#data
										       "01100010"|   --XRL direct,A
										  	   "01100011"|   --XRL direct,#data
										  	   "00000101"|   --INC direct
										  	   "00010101"|   --DEC direct
										  	   "11010101" => --DJNZ direct,LABEL
															 R_P0_LATCH <= '1';
															 ---
															 W_P0_LATCH       <= '0';
															 W_P1_LATCH       <= '0';
													  		 W_P2_LATCH       <= '0';
													  		 W_P3_LATCH       <= '0';		
  		
  									  						 R_P1_LATCH       <= '0';
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
															 
										  when others     =>
										  					 R_P0_PIN	<= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  									  						 R_P1_LATCH       <= '0';
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  		
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
															 
									  end case;
								  end if;
									  	
				when "0010000" => if WRITE_RAM = '1' then   --90=P1
									  W_P1_LATCH <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
							       	  R_P1_LATCH	   <= '0'; 
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		   <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	   <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  case F_IR is
									  	  when "10110010"|	-- instruction CPL  bit
  									 		   "11000010"|	-- instruction CLR  bit
											   "11010010"|	-- instruction SETB bit
										  	   "11000101"|   --XCH A,direct
										  	   "01010010"|   --ANL direct,A
										  	   "01010100"|   --ANL direct,#data
										  	   "01000010"|   --ORL direct,A
										       "01000011"|   --ORL direct,#data
										       "01100010"|   --XRL direct,A
										  	   "01100011"|   --XRL direct,#data
										  	   "00000101"|   --INC direct
										  	   "00010101"|   --DEC direct
										  	   "11010101" => --DJNZ direct,LABEL
															 R_P1_LATCH <= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  															 
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
										  when others     =>
										  					 R_P1_PIN	<= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  															 R_P1_LATCH		  <= '0';
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
									  end case;
								  end if;

				when "0100000" => if WRITE_RAM = '1' then   --A0=P2
									  W_P2_LATCH <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  		
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
									  
								  elsif RAM_TO_INTBUS = '1' then
								  	  case F_IR is
									  	  when "10110010"|	-- instruction CPL  bit
											   "11000010"|	-- instruction CLR  bit
											   "11010010"|	-- instruction SETB bit
										  	   "11000101"|   --XCH A,direct
										  	   "01010010"|   --ANL direct,A
										  	   "01010100"|   --ANL direct,#data
										  	   "01000010"|   --ORL direct,A
										       "01000011"|   --ORL direct,#data
										       "01100010"|   --XRL direct,A
										  	   "01100011"|   --XRL direct,#data
										  	   "00000101"|   --INC direct
										  	   "00010101"|   --DEC direct
										  	   "11010101" => --DJNZ direct,LABEL
															 R_P2_LATCH <= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  									  						 R_P1_LATCH       <= '0';
  		
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
										  when others     =>
										  					 R_P2_PIN	<= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  									  						 R_P1_LATCH       <= '0';
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  		
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
									  end case;
								  end if;	  
								
				when "0110000" => if WRITE_RAM = '1' then   --B0=P3
									  W_P3_LATCH <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  case F_IR is
									  	  when "10110010"|	-- instruction CPL  bit
											   "11000010"|	-- instruction CLR  bit
											   "11010010"|	-- instruction SETB bit
											   "11000101"|   --XCH A,direct
										  	   "01010010"|   --ANL direct,A
										  	   "01010100"|   --ANL direct,#data
										  	   "01000010"|   --ORL direct,A
										       "01000011"|   --ORL direct,#data
										       "01100010"|   --XRL direct,A
										  	   "01100011"|   --XRL direct,#data
										  	   "00000101"|   --INC direct
										  	   "00010101"|   --DEC direct
										  	   "11010101" => --DJNZ direct,LABEL
															 R_P3_LATCH <= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  									  						 R_P1_LATCH       <= '0';
  									  						 R_P2_LATCH       <= '0';
  		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  									  						 R_P3_PIN         <= '0';
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
										  when others     =>
										  					 R_P3_PIN	<= '1';
															 ---
															 W_P0_LATCH       <= '0';
  									  						 W_P1_LATCH       <= '0';
  									  						 W_P2_LATCH       <= '0';
  									  						 W_P3_LATCH       <= '0';		
  									  						 R_P0_LATCH       <= '0';
  									  						 R_P1_LATCH       <= '0';
  									  						 R_P2_LATCH       <= '0';
  									  						 R_P3_LATCH       <= '0';		
  									  						 R_P0_PIN         <= '0';
  									  						 R_P1_PIN         <= '0';
  									  						 R_P2_PIN         <= '0';
  		
									  						 WRITE_PSW		 <= '0';
  									  						 WRITE_B          <= '0';
  									  						 WRITE_ACC        <= '0';
  									  						 WRITE_SP         <= '0';
  									  						 WRITE_DPH        <= '0';
  									  						 WRITE_DPL        <= '0';
									  						 PSW_TO_INTBUS	 <= '0';
  									  						 B_TO_INTBUS      <= '0';
  									  						 ACC_TO_INTBUS    <= '0';
  									  						 SP_TO_INTBUS     <= '0';
  									  						 DPH_TO_INTBUS    <= '0';
  									  						 DPL_TO_INTBUS    <= '0';
									  						 REAL_WRITE_RAM 	   <= '0';
	    							  						 REAL_RAM_TO_INTBUS <= '0';
															 ---
									  end case;
								  end if;	  
				
				when "0000001" => if WRITE_RAM = '1' then  --81=SP
									  WRITE_SP <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  		
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  SP_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL        <= '0';
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  		
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
								  end if;
								  	  	
				when "0000010" => if WRITE_RAM = '1' then  --82=DPL
								  	  WRITE_DPL <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';
									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  DPL_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  end if;
								  
				when "0000011" => if WRITE_RAM = '1' then  --83=DPH				
									  WRITE_DPH <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  DPH_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  end if;
								  
				when "1010000" => if WRITE_RAM = '1' then  --D0=PSW
									  WRITE_PSW <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  PSW_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  end if;
								  
				when "1100000" => if WRITE_RAM = '1' then  --E0=ACC
									  WRITE_ACC <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  ACC_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  end if;
								  
				when "1110000" => if WRITE_RAM = '1' then  --F0=B
								  	  WRITE_B <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  B_TO_INTBUS      <= '0';
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  elsif RAM_TO_INTBUS = '1' then
								  	  B_TO_INTBUS <= '1';
									  ---
									  W_P0_LATCH       <= '0';
  									  W_P1_LATCH       <= '0';
  									  W_P2_LATCH       <= '0';
  									  W_P3_LATCH       <= '0';		
  									  R_P0_LATCH       <= '0';
  									  R_P1_LATCH       <= '0';
  									  R_P2_LATCH       <= '0';
  									  R_P3_LATCH       <= '0';		
  									  R_P0_PIN         <= '0';
  									  R_P1_PIN         <= '0';
  									  R_P2_PIN         <= '0';
  									  R_P3_PIN         <= '0';
									  WRITE_PSW		 <= '0';
  									  WRITE_B          <= '0';
  									  WRITE_ACC        <= '0';
  									  WRITE_SP         <= '0';
  									  WRITE_DPH        <= '0';
  									  WRITE_DPL		   <= '0';	
									  PSW_TO_INTBUS	 <= '0';
  									  
  									  ACC_TO_INTBUS    <= '0';
  									  SP_TO_INTBUS     <= '0';
  									  DPH_TO_INTBUS    <= '0';
  									  DPL_TO_INTBUS    <= '0';
									  REAL_WRITE_RAM 	   <= '0';
	    							  REAL_RAM_TO_INTBUS <= '0';

									  ---
								  end if;
				when others =>
								  W_P0_LATCH       <= '0';
								  W_P1_LATCH       <= '0';
								  W_P2_LATCH       <= '0';
								  W_P3_LATCH       <= '0';		
								  R_P0_LATCH       <= '0';
								  R_P1_LATCH       <= '0';
								  R_P2_LATCH       <= '0';
								  R_P3_LATCH       <= '0';		
								  R_P0_PIN         <= '0';
								  R_P1_PIN         <= '0';
								  R_P2_PIN         <= '0';
								  R_P3_PIN         <= '0';
  							  	  WRITE_PSW		 <= '0';
  								  WRITE_B          <= '0';
  								  WRITE_ACC        <= '0';
  								  WRITE_SP         <= '0';
  								  WRITE_DPH        <= '0';
  								  WRITE_DPL		   <= '0';	
								  PSW_TO_INTBUS	 <= '0';
  								  B_TO_INTBUS      <= '0';
  								  ACC_TO_INTBUS    <= '0';
  								  SP_TO_INTBUS     <= '0';
  								  DPH_TO_INTBUS    <= '0';
  								  DPL_TO_INTBUS    <= '0';
								  REAL_WRITE_RAM 	   <= '0';
	    						  REAL_RAM_TO_INTBUS <= '0';
	
			end case;			
		end if;--TMP=<128		
	end process;
end BEHAVIOR;		