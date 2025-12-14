library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor16 is
	port (dataina,datainb : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(15 downto 0);
	      clk : in std_logic);
end  xor16;

architecture exclusive_or16 of xor16 is
begin
	process (clk)
		begin
			if clk = '1' and clk'event then
			dataout <= dataina xor datainb;
			end if;
		end process;
end exclusive_or16;
--------------------------------------- xor16 -------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor24 is
	port (dataina,datainb : in std_logic_vector(23 downto 0);
	      dataout : out std_logic_vector(23 downto 0);
	      clk : in std_logic);
end  xor24;

architecture exclusive_or24 of xor24 is
begin
	process (clk)
		begin
			if clk = '1' and clk'event then
			dataout <= dataina xor datainb;
			end if;
		end process;
end exclusive_or24;

--------------------------------------- input buffer -------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inbuffer is
	port (datain : in std_logic_vector(3 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  inbuffer;

architecture inputbuffer of inbuffer is
type s_type is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
   signal s:s_type;
begin
	process(clk,reset)
		begin
			if 	reset='1' then 
				s <= S1;  --   reset stage
			elsif clk'event and clk = '1' then  ----- rising edge ----
				case s is
					when S1 => 						
						dataout(3 downto 0) <= datain;
						s <= S2;
					when S2 =>
						dataout(7 downto 4) <= datain;
						s <= S3;
					when S3 =>
						dataout(11 downto 8) <= datain;
						s <= S4;
					when S4 =>
						dataout(15 downto 12) <= datain;
						s <= S5;
					when S5 => 						
						dataout(19 downto 16) <= datain;
						s <= S6;
					when S6 =>
						dataout(23 downto 20) <= datain;
						s <= S7;
					when S7 =>
						dataout(27 downto 24) <= datain;
						s <= S8;
					when S8 =>
						dataout(31 downto 28) <= datain;
						s <= S9;					
					when others =>
						null;
				end case;				
			end if;
		end process;
		
end inputbuffer;

--------------------------------------- output buffer ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity outbuffer is
	port (datain : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(3 downto 0);
	      clk,reset : in std_logic);
end  outbuffer;

architecture outputbuffer of outbuffer is
type s_type is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
   signal s:s_type;
begin
	process(clk,reset)
		begin
			if 	reset='1' then
				s <= S1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
				case s is
					when S1 =>
						dataout <= datain(3 downto 0);
						s <= S2;
					when S2 =>
						dataout <= datain(7 downto 4);
						s <= S3;
					when S3 =>
						dataout <= datain(11 downto 8);
						s <= S4;
					when S4 =>
						dataout <= datain(15 downto 12);
						s <= S5;					
					when S5 =>
						dataout <= datain(19 downto 16);
						s <= S6;
					when S6 =>
						dataout <= datain(23 downto 20);
						s <= S7;
					when S7 =>
						dataout <= datain(27 downto 24);
						s <= S8;
					when S8 =>
						dataout <= datain(31 downto 28);
						s <= S9;					
					when others =>
						null;
				end case;
			end if;
		end process;
		
end outputbuffer;

--------------------------------------- key buffer ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keybuffer is
	port (datain : in std_logic_vector(3 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  keybuffer;

architecture keybuff of keybuffer is

type s_type is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
   signal s:s_type;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= S1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is
				when S1 =>
					dataout(3 downto 0) <= datain;
					s <= S2;
				when S2 =>				
					dataout(7 downto 4) <= datain;
					s <= S3;
				when S3 =>
					dataout(11 downto 8) <= datain;
					s <= S4;
				when S4 =>
					dataout(15 downto 12) <= datain;
					s <= S5;
				when S5 =>
					dataout(19 downto 16) <= datain;
					s <= S6;
				when S6 =>				
					dataout(23 downto 20) <= datain;
					s <= S7;
				when S7 =>
					dataout(27 downto 24) <= datain;
					s <= S8;
				when S8 =>
					dataout(31 downto 28) <= datain;
					s <= S9;
				when others =>
					null;
			  end case;
			end if;
		end process;
		
end keybuff;
---------------------------- multiplexor input ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity muxin is
	port (datain,dataloop : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  muxin;

architecture multiplexinput of muxin is
type s_type is (S1,S2);
   signal s:s_type;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= S1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is
				when S1 =>
					dataout <= datain;
					s <= S2;
				when others =>
					dataout <= dataloop;
			  end case;
			end if;
		end process;
		
end multiplexinput;

---------------------------- multiplexor output ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity muxout is
	port (datain : in std_logic_vector(31 downto 0);
	      dataout,dataloop : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  muxout;

architecture multiplexoutput of muxout is
type s_type is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
   signal s:s_type;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= S1;  --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is	
			  	when S1 =>
					dataloop <= datain;
					s <= S2;
				when S2 =>
					dataloop <= datain;
					s <= S3;
				when S3 =>
					dataloop <= datain;
					s <= S4;
				when S4 =>
					dataloop <= datain;
					s <= S5;
				when S5 =>
					dataloop <= datain;
					s <= S6;
				when S6 =>
					dataloop <= datain;
					s <= S7;
				when S7 =>
					dataloop <= datain;
					s <= S8;					
				when S8 =>				
					dataout <= datain(15 downto 0)&datain(31 downto 16);
					s <= S9;
				when others =>
					null;
			  end case;
			end if;
		end process;
		
end multiplexoutput;

------------------------ permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity permute is
	port (i : in std_logic_vector(32 downto 1);
	      o : out std_logic_vector(32 downto 1));
      
end  permute;

architecture permutation of permute is
begin
	o(32)<=i(26); o(31)<=i(18); o(30)<=i(10); o(29)<=i(2); o(28)<=i(28); o(27)<=i(20);  o(26)<=i(12); o(25)<=i(4);
	o(24)<=i(30); o(23)<=i(22); o(22)<=i(14); o(21)<=i(6); o(20)<=i(32); o(19)<=i(24); o(18)<=i(16); o(17)<=i(8);
	o(16)<=i(25); o(15)<=i(17); o(14)<=i(9); o(13)<=i(1); o(12)<=i(27); o(11)<=i(19); o(10)<=i(11);  o(9)<=i(3);
	 o(8)<=i(29);  o(7)<=i(21);  o(6)<=i(13);  o(5)<=i(5);  o(4)<=i(31);  o(3)<=i(23);  o(2)<=i(15);  o(1)<=i(7);
end permutation;

------------------------ de-permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity depermute is
	port (i : in std_logic_vector(32 downto 1);
	      o : out std_logic_vector(32 downto 1));
      
end  depermute;

architecture depermutation of depermute is
begin
	o(32)<=i(20); o(31)<=i(4); o(30)<=i(24); o(29)<=i(8); o(28)<=i(28); o(27)<=i(12); o(26)<=i(32); o(25)<=i(16);
	o(24)<=i(19); o(23)<=i(3); o(22)<=i(23); o(21)<=i(7); o(20)<=i(27); o(19)<=i(11); o(18)<=i(31); o(17)<=i(15);
	o(16)<=i(18); o(15)<=i(2); o(14)<=i(22); o(13)<=i(6); o(12)<=i(26); o(11)<=i(10); o(10)<=i(30);  o(9)<=i(14);
	 o(8)<=i(17);  o(7)<=i(1);  o(6)<=i(21);   o(5)<=i(5);  o(4)<=i(25);  o(3)<=i(9);  o(2)<=i(29);  o(1)<=i(13);
end depermutation;

------------------------ E-box ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity exp is
	port (i : in std_logic_vector(1 to 16);
	      o : out std_logic_vector(1 to 24));
      
end  exp;

architecture expand of exp is
begin
	 o(1)<=i(16);  o(2)<=i( 1);  o(3)<=i( 2);  o(4)<=i( 3);  o(5)<=i( 4);  o(6)<=i( 5);
	 o(7)<=i( 4);  o(8)<=i( 5);  o(9)<=i( 6); o(10)<=i( 7); o(11)<=i( 8); o(12)<=i( 9);
	o(13)<=i( 8); o(14)<=i( 9); o(15)<=i(10); o(16)<=i(11); o(17)<=i(12); o(18)<=i(13);
	o(19)<=i(12); o(20)<=i(13); o(21)<=i(14); o(22)<=i(15); o(23)<=i(16); o(24)<=i(1);

end expand;

------------------------ s-box ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sbox is
	port (i : in std_logic_vector(1 to 24);
	      o : out std_logic_vector(1 to 16));
      
end sbox;

architecture sboxar of sbox is
begin
    process(i)
	begin
	  ----------------- s box table 1 ---------------------

	   if i(2 to 5)="0000" then o(1 to 4)<="1110"; end if;
	   if i(2 to 5)="0001" then o(1 to 4)<="0100"; end if;
	   if i(2 to 5)="0010" then o(1 to 4)<="1101"; end if;
	   if i(2 to 5)="0011" then o(1 to 4)<="0001"; end if;
	   if i(2 to 5)="0100" then o(1 to 4)<="0010"; end if;
	   if i(2 to 5)="0101" then o(1 to 4)<="1111"; end if;
	   if i(2 to 5)="0110" then o(1 to 4)<="1011"; end if;
	   if i(2 to 5)="0111" then o(1 to 4)<="1000"; end if;
	   if i(2 to 5)="1000" then o(1 to 4)<="0011"; end if;
	   if i(2 to 5)="1001" then o(1 to 4)<="1010"; end if;
	   if i(2 to 5)="1010" then o(1 to 4)<="0110"; end if;
	   if i(2 to 5)="1011" then o(1 to 4)<="1100"; end if;
	   if i(2 to 5)="1100" then o(1 to 4)<="0101"; end if;
	   if i(2 to 5)="1101" then o(1 to 4)<="1001"; end if;
	   if i(2 to 5)="1110" then o(1 to 4)<="0000"; end if;
	   if i(2 to 5)="1111" then o(1 to 4)<="0111"; end if;
	 

	  ----------------- s box table 2 ---------------------

	
	   if i(8 to 11)="0000" then o(5 to 8)<="1111"; end if;
	   if i(8 to 11)="0001" then o(5 to 8)<="0001"; end if;
	   if i(8 to 11)="0010" then o(5 to 8)<="1000"; end if;
	   if i(8 to 11)="0011" then o(5 to 8)<="1110"; end if;
	   if i(8 to 11)="0100" then o(5 to 8)<="0110"; end if;
	   if i(8 to 11)="0101" then o(5 to 8)<="1011"; end if;
	   if i(8 to 11)="0110" then o(5 to 8)<="0011"; end if;
	   if i(8 to 11)="0111" then o(5 to 8)<="0100"; end if;
	   if i(8 to 11)="1000" then o(5 to 8)<="1001"; end if;
	   if i(8 to 11)="1001" then o(5 to 8)<="0111"; end if;
	   if i(8 to 11)="1010" then o(5 to 8)<="0010"; end if;
	   if i(8 to 11)="1011" then o(5 to 8)<="1101"; end if;
	   if i(8 to 11)="1100" then o(5 to 8)<="1100"; end if;
	   if i(8 to 11)="1101" then o(5 to 8)<="0000"; end if;
	   if i(8 to 11)="1110" then o(5 to 8)<="0101"; end if;
	   if i(8 to 11)="1111" then o(5 to 8)<="1010"; end if;
	

	  ----------------- s box table 3 ---------------------

	
	   if i(14 to 17)="0000" then o(9 to 12)<="1010"; end if;
	   if i(14 to 17)="0001" then o(9 to 12)<="0000"; end if;
	   if i(14 to 17)="0010" then o(9 to 12)<="1001"; end if;
	   if i(14 to 17)="0011" then o(9 to 12)<="1110"; end if;
	   if i(14 to 17)="0100" then o(9 to 12)<="0110"; end if;
	   if i(14 to 17)="0101" then o(9 to 12)<="0011"; end if;
	   if i(14 to 17)="0110" then o(9 to 12)<="1111"; end if;
	   if i(14 to 17)="0111" then o(9 to 12)<="0101"; end if;
	   if i(14 to 17)="1000" then o(9 to 12)<="0001"; end if;
	   if i(14 to 17)="1001" then o(9 to 12)<="1101"; end if;
	   if i(14 to 17)="1010" then o(9 to 12)<="1100"; end if;
	   if i(14 to 17)="1011" then o(9 to 12)<="0111"; end if;
	   if i(14 to 17)="1100" then o(9 to 12)<="1011"; end if;
	   if i(14 to 17)="1101" then o(9 to 12)<="0100"; end if;
	   if i(14 to 17)="1110" then o(9 to 12)<="0010"; end if;
	   if i(14 to 17)="1111" then o(9 to 12)<="1000"; end if;
	

	  ----------------- s box table 4 ---------------------

	
	   if i(20 to 23)="0000" then o(13 to 16)<="0111"; end if;
	   if i(20 to 23)="0001" then o(13 to 16)<="1101"; end if;
	   if i(20 to 23)="0010" then o(13 to 16)<="1110"; end if;
	   if i(20 to 23)="0011" then o(13 to 16)<="0011"; end if;
	   if i(20 to 23)="0100" then o(13 to 16)<="0000"; end if;
	   if i(20 to 23)="0101" then o(13 to 16)<="0110"; end if;
	   if i(20 to 23)="0110" then o(13 to 16)<="1001"; end if;
	   if i(20 to 23)="0111" then o(13 to 16)<="1010"; end if;
	   if i(20 to 23)="1000" then o(13 to 16)<="0001"; end if;
	   if i(20 to 23)="1001" then o(13 to 16)<="0010"; end if;
	   if i(20 to 23)="1010" then o(13 to 16)<="1000"; end if;
	   if i(20 to 23)="1011" then o(13 to 16)<="0101"; end if;
	   if i(20 to 23)="1100" then o(13 to 16)<="1011"; end if;
	   if i(20 to 23)="1101" then o(13 to 16)<="1100"; end if;
	   if i(20 to 23)="1110" then o(13 to 16)<="0100"; end if;
	   if i(20 to 23)="1111" then o(13 to 16)<="1111"; end if;
	
      end process;
end sboxar;

------------------------ P-permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pp is
	port (i : in std_logic_vector(1 to 16);
	      o : out std_logic_vector(1 to 16));
      
end  pp;

architecture pper of pp is
begin
	 o(1)<=i(16);  o(2)<=i( 7);  o(3)<=i(13);  o(4)<=i(10);  
	 o(5)<=i( 1);  o(6)<=i(12);  o(7)<=i(11);  o(8)<=i(14); 
	o( 9)<=i( 5); o(10)<=i(15); o(11)<=i( 3); o(12)<=i( 9); 
	o(13)<=i( 2); o(14)<=i( 8); o(15)<=i( 4); o(16)<=i( 6); 

end pper;

------------------------ PC-2 for key generate ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pc2 is
	port (i : in std_logic_vector(1 to 28);
	      o : out std_logic_vector(1 to 24));
      
end  pc2;

architecture keypc2 of pc2 is
begin
	 o(1)<=i(14);  o(2)<=i(17);  o(3)<=i(11);  o(4)<=i(24);  o(5)<=i( 1);  o(6)<=i( 5);
	 o(7)<=i( 3);  o(8)<=i(28);  o(9)<=i(15); o(10)<=i( 6); o(11)<=i(21); o(12)<=i(10);
	o(13)<=i(23); o(14)<=i(19); o(15)<=i(12); o(16)<=i( 4); o(17)<=i(26); o(18)<=i( 8);
	o(19)<=i(16); o(20)<=i( 7); o(21)<=i(27); o(22)<=i(20); o(23)<=i(13); o(24)<=i( 2);

end keypc2;


------------------------ key generate ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keygen is
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 28);
	      clk,reset,deen : in std_logic);
end  keygen;

architecture keygenerate of keygen is
type s_type is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
   signal s:s_type;
   signal c0,c1,c2,c3,c4,c5,c6,c7,c8:std_logic_vector(1 to 14);
   signal d0,d1,d2,d3,d4,d5,d6,d7,d8:std_logic_vector(1 to 14);
begin
----- c0 ------ PC-1
	 c0(1)<=i(27);  c0(2)<=i( 1);  c0(3)<=i(26);  c0(4)<=i(18);  c0(5)<=i(25);  c0(6)<=i(17);  c0(7)<=i( 9);
	 c0(8)<=i(23);  c0(9)<=i(15); c0(10)<=i(19); c0(11)<=i(11); c0(12)<=i( 3); c0(13)<=i(10); c0(14)<=i( 2);
----- do ------- PC-1
	 d0(1)<=i(14);  d0(2)<=i( 6);  d0(3)<=i(29);  d0(4)<=i( 7);  d0(5)<=i(30);  d0(6)<=i(22);  d0(7)<=i(31);
	 d0(8)<=i(21);  d0(9)<=i(13); d0(10)<=i( 5); d0(11)<=i(28); d0(12)<=i(20); d0(13)<=i(12); d0(14)<=i( 4);
----- c1 to c16 & d1 to d16 -----

   c1(1 to 14) <=  c0(2 to 14)&c0(1);        d1(1 to 14) <=  d0(2 to 14)&d0(1);
   c2(1 to 14) <=  c1(2 to 14)&c1(1);        d2(1 to 14) <=  d1(2 to 14)&d1(1);
   c3(1 to 14) <=  c2(3 to 14)&c2(1 to 2);   d3(1 to 14) <=  d2(3 to 14)&d2(1 to 2);
   c4(1 to 14) <=  c3(3 to 14)&c3(1 to 2);   d4(1 to 14) <=  d3(3 to 14)&d3(1 to 2);
   c5(1 to 14) <=  c4(3 to 14)&c4(1 to 2);   d5(1 to 14) <=  d4(3 to 14)&d4(1 to 2);
   c6(1 to 14) <=  c5(3 to 14)&c5(1 to 2);   d6(1 to 14) <=  d5(3 to 14)&d5(1 to 2);
   c7(1 to 14) <=  c6(3 to 14)&c6(1 to 2);   d7(1 to 14) <=  d6(3 to 14)&d6(1 to 2);
   c8(1 to 14) <=  c7(3 to 14)&c7(1 to 2);   d8(1 to 14) <=  d7(3 to 14)&d7(1 to 2);
   
	process(clk,reset)
	    begin
	       if reset='1' then s <= S1;  -----   reset stage

		    elsif clk = '1' and clk'event then  ----- rising edge ----

			 if deen = '0' then  --- encode ---  
			    case s is
					when S1 => 
						o <= c1&d1;
				  		s <= S2;
					when S2 =>	
			     		o <= c2&d2;
				  		s <= S3;
			    	when S3 =>
						o <= c3&d3;
				  		s <= S4;
					when S4 =>
			    		o <= c4&d4;
				  		s <= S5;
					when S5 =>
			    		o <= c5&d5;
				  		s <= S6;
					when S6 =>
			    		o <= c6&d6;
				  		s <= S7;
					when S7 =>
			    		o <= c7&d7;
				  		s <= S8;
					when S8 =>
			    		o <= c8&d8;
				  		s <= S9;					
					when others =>
						null;

			    end case;

			 end if; --- encode ---

			 if deen = '1' then  --- decode ---  
				case s is
					when S1 => 
						o <= c8&d8;
				  		s <= S2;
					when S2 =>	
			     		o <= c7&d7;
				  		s <= S3;
			    	when S3 =>
						o <= c6&d6;
				  		s <= S4;
					when S4 =>
			    		o <= c5&d5;
				  		s <= S5;
					when S5 =>
			    		o <= c4&d4;
				  		s <= S6;
					when S6 =>
			    		o <= c3&d3;
				  		s <= S7;
					when S7 =>
			    		o <= c2&d2;
				  		s <= S8;
					when S8 =>
			    		o <= c1&d1;
				  		s <= S9;					
					when others =>
						null;

			    end case;

			 end if; --- decode ---

		   end if; ---- clock ------
	    end process;
		
end keygenerate;


------------------------  key generate complete----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keycom is
	port (i : in std_logic_vector(1 to 32);
	      k : out std_logic_vector(1 to 24);
	      clk,reset,deen : in std_logic);
      
end  keycom;

architecture keycomplete of keycom is

component keygen
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 28);
	      clk,reset,deen : in std_logic);
end component;

component pc2
	port (i : in std_logic_vector(1 to 28);
	      o : out std_logic_vector(1 to 24));
end component;

signal ktmp:std_logic_vector(1 to 28);

begin
     k1:keygen port map (i,ktmp,clk,reset,deen);
     k2:pc2 port map (ktmp,k);

end keycomplete;

------------------------  DES control ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity des is
	port    (clk,reset : in std_logic;
		 ares      : out std_logic;
		 inbuffer  : out std_logic;
		 outbuffer : out std_logic;
		 keybuffer : out std_logic;
		 xor32     : out std_logic;
		 xor48     : out std_logic;            
		 muxin     : out std_logic;
		 muxout    : out std_logic;
		 keycom    : out std_logic);
      
end  des;

architecture descontrol of des is

signal s:integer;

begin
  process(clk,reset)
	    begin
	       if reset='1' then s <= 1;  -----   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----

		   
--=========================== initial ============================ 
			case s is
				when 1 =>			      
					ares <= '1';       ----- all reset -----
				  	s <= 2;
				when 2 =>
			   		inbuffer <= '1';
					outbuffer <= '1';
					keybuffer <= '1';
					xor32 <= '1';
					xor48 <= '1';
					muxin <= '1';
					muxout <= '1';					
					keycom <= '1';
 				  	s <= 3;
				when 3 =>
			    	inbuffer <= '0';
					outbuffer <= '0';
					keybuffer <= '0';
					xor32 <= '0';
					xor48 <= '0';
					muxin <= '0';
					muxout <= '0';			
					keycom <= '0';
				  	s <= 4;
				when 4 =>
			 		ares <= '0';
				  	s <= 5;			    

--=========================== receive input data ============================ 
			    when 5 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 6;
			    when 6 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 7;
			    when 7 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 8;
			    when 8 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 9;
			    when 9 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 10;
			    when 10 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 11;
			    when 11 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 12;
			    when 12 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 13;
			    when 13 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 14;
			    when 14 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 15;
			    when 15 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 16;
			    when 16 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 17;
			    when 17 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 18;
			    when 18 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 19;
			    when 19 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 20;
			    when 20 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 21;
			    when 21 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 22;  

--=========================== move data to muxin and build key 1 ============================ 
							
  			    when 22 => muxin <= '1'; keycom <= '1';
				  s <= 23;
			    when 23 => muxin <= '0'; keycom <= '0';
				  s <= 24;
			    when 24 => xor48 <= '1'; 
				  s <= 25;
			    when 25 => xor48 <= '0'; 
				  s <= 26;			    
			    when 26 => xor32 <= '1';
				  s <= 27;
			    when 27 => xor32 <= '0';
				  s <= 28;
			    when 28 => muxout <= '1';
				  s <= 29;
			    when 29 => muxout <= '0';
				  s <= 30;

--============================ End Round I ==========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 30 => muxin <= '1'; keycom <= '1';
				  s <= 31;
			    when 31 => muxin <= '0'; keycom <= '0';
				  s <= 32;
			    when 32 => xor48 <= '1'; 
				  s <= 33;
			    when 33 => xor48 <= '0'; 
				  s <= 34;			    
			    when 34 => xor32 <= '1';
				  s <= 35;
			    when 35 => xor32 <= '0';
				  s <= 36;
			    when 36 => muxout <= '1';
				  s <= 37;
			    when 37 => muxout <= '0';
				  s <= 38;

--============================ End Round II ==========================

--=========================== move data to muxin and build key 3 ============================ 

			    when 38 => muxin <= '1'; keycom <= '1';
				  s <= 39;
			    when 39 => muxin <= '0'; keycom <= '0';
				  s <= 40;
			    when 40 => xor48 <= '1'; 
				  s <= 41;
			    when 41 => xor48 <= '0'; 
				  s <= 42;			    
			    when 42 => xor32 <= '1';
				  s <= 43;
			    when 43 => xor32 <= '0';
				  s <= 44;
			    when 44 => muxout <= '1';
				  s <= 45;
			    when 45 => muxout <= '0';
				  s <= 46;

--============================ End Round III==========================

--=========================== move data to muxin and build key 4 ============================ 

			    when 46 => muxin <= '1'; keycom <= '1';
				  s <= 47;
			    when 47 => muxin <= '0'; keycom <= '0';
				  s <= 48;
			    when 48 => xor48 <= '1'; 
				  s <= 49;
			    when 49 => xor48 <= '0'; 
				  s <= 50;			    
			    when 50 => xor32 <= '1';
				  s <= 51;
			    when 51 => xor32 <= '0';
				  s <= 52;
			    when 52 => muxout <= '1';
				  s <= 53;
			    when 53 => muxout <= '0';
				  s <= 54;

--============================ End Round IV =========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 54 => muxin <= '1'; keycom <= '1';
				  s <= 55;
			    when 55 => muxin <= '0'; keycom <= '0';
				  s <= 56;
			    when 56 => xor48 <= '1'; 
				  s <= 57;
			    when 57 => xor48 <= '0'; 
				  s <= 58;			    
			    when 58 => xor32 <= '1';
				  s <= 59;
			    when 59 => xor32 <= '0';
				  s <= 60;
			    when 60 => muxout <= '1';
				  s <= 61;
			    when 61 => muxout <= '0';
				  s <= 62;

--============================ End Round V =========================
			    
--=========================== move data to muxin and build key 2 ============================ 

			    when 62 => muxin <= '1'; keycom <= '1';
				  s <= 63;
			    when 63 => muxin <= '0'; keycom <= '0';
				  s <= 64;
			    when 64 => xor48 <= '1'; 
				  s <= 65;
			    when 65 => xor48 <= '0'; 
				  s <= 66;			    
			    when 66 => xor32 <= '1';
				  s <= 67;
			    when 67 => xor32 <= '0';
				  s <= 68;
			    when 68 => muxout <= '1';
				  s <= 69;
			    when 69 => muxout <= '0';
				  s <= 70;

--============================ End Round VI ==========================
			    
--=========================== move data to muxin and build key 7 ============================ 

			    when 70 => muxin <= '1'; keycom <= '1';
				  s <= 71;
			    when 71 => muxin <= '0'; keycom <= '0';
				  s <= 72;
			    when 72 => xor48 <= '1'; 
				  s <= 73;
			    when 73 => xor48 <= '0'; 
				  s <= 74;
			    when 74 => xor32 <= '1';
				  s <= 75;
			    when 75 => xor32 <= '0';
				  s <= 76;
			    when 76 => muxout <= '1';
				  s <= 77;
			    when 77 => muxout <= '0';
				  s <= 78;

--============================ End Round VII ==========================
			    
--=========================== move data to muxin and build key 8  ============================ 

			    when 78 => muxin <= '1'; keycom <= '1';
				  s <= 79;
			    when 79 => muxin <= '0'; keycom <= '0';
				  s <= 80;
			    when 80 => xor48 <= '1'; 
				  s <= 81;
			    when 81 => xor48 <= '0'; 
				  s <= 82;			    
			    when 82 => xor32 <= '1';
				  s <= 83;
			    when 83 => xor32 <= '0';
				  s <= 84;
			    when 84 => muxout <= '1';
				  s <= 85;
			    when 85 => muxout <= '0';
				  s <= 86;

--============================ End Round XVI Final ==========================

--============================ Output Buffer ==========================--

			    when 86 => outbuffer <= '0';
				  s <= 87;
			    when 87 => outbuffer <= '1';
				  s <= 88;
			    when 88 => outbuffer <= '0';
				  s <= 89;
			    when 89 => outbuffer <= '1';
				  s <= 90;
			    when 90 => outbuffer <= '0';
				  s <= 91;
			    when 91 => outbuffer <= '1';
				  s <= 92;
			    when 92 => outbuffer <= '0';
				  s <= 93;
			    when 93 => outbuffer <= '1';
				  s <= 94;
			    when 94 => outbuffer <= '0';
				  s <= 95;
			    when 95 => outbuffer <= '1';
				  s <= 96;
			    when 96 => outbuffer <= '0';
				  s <= 97;
			    when 97 => outbuffer <= '1';
				  s <= 98;
			    when 98 => outbuffer <= '0';
				  s <= 99;
			    when 99 => outbuffer <= '1';
				  s <= 100;
			    when 100 => outbuffer <= '0';
				  s <= 101;
			    when 101 => outbuffer <= '1';
				  s <= 102;
			    when 102 => outbuffer <= '0';
				  s <= 103;
			    when others => null;
		     end case;  ----- state
		  end if;   ---- rising edge
	
    end process;
end descontrol;

--===================================  maindes =====================
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity maindes is
	port (datain,keyin : in std_logic_vector(3 downto 0);
	      dataout : out std_logic_vector(3 downto 0);
	      mclk,mreset,deen : in std_logic);
end maindes;

architecture chipdes of maindes is

component des
	port    (clk,reset : in std_logic;
		 ares      : out std_logic;
		 inbuffer  : out std_logic;
		 outbuffer : out std_logic;
		 keybuffer : out std_logic;
		 xor32     : out std_logic;
		 xor48     : out std_logic;            
		 muxin     : out std_logic;
		 muxout    : out std_logic;
		 keycom    : out std_logic);
      
end component;

component xor16
	port (dataina,datainb : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(15 downto 0);
	      clk : in std_logic);
end  component;

component xor24
	port (dataina,datainb : in std_logic_vector(23 downto 0);
	      dataout : out std_logic_vector(23 downto 0);
	      clk : in std_logic);
end  component;

component inbuffer
	port (datain : in std_logic_vector(3 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  component;

component outbuffer
	port (datain : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(3 downto 0);
	      clk,reset : in std_logic);
end  component;

component keybuffer
	port (datain : in std_logic_vector(3 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  component;

component muxin
	port (datain,dataloop : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  component;

component muxout
	port (datain : in std_logic_vector(31 downto 0);
	      dataout,dataloop : out std_logic_vector(31 downto 0);
	      clk,reset : in std_logic);
end  component;

component permute
	port (i : in std_logic_vector(32 downto 1);
	      o : out std_logic_vector(32 downto 1));
      
end  component;

component depermute
	port (i : in std_logic_vector(32 downto 1);
	      o : out std_logic_vector(32 downto 1));
      
end  component;

component sbox
	port (i : in std_logic_vector(1 to 24);	      
	      o : out std_logic_vector(1 to 16));
      
end component;

component exp
	port (i : in std_logic_vector(1 to 16);
	      o : out std_logic_vector(1 to 24));
      
end  component;

component pp
	port (i : in std_logic_vector(1 to 16);
	      o : out std_logic_vector(1 to 16));
      
end  component;

component keycom
	port (i : in std_logic_vector(1 to 32);
	      k : out std_logic_vector(1 to 24);
	      clk,reset,deen : in std_logic);
      
end  component;


signal  in64,key64,out64,pin64,depout64,indes64,turndes:std_logic_vector(1 to 32);
signal  tmptomuxout:std_logic_vector(1 to 32);
signal  outexp48,tosbox48,turnkey:std_logic_vector(1 to 24);
signal  toppbox32,toxor32,tomuxout32,tmptoexp:std_logic_vector(1 to 16);
signal  allreset,inbufck,outbufck,keybufck,xor32ck,xor48ck:std_logic;
signal  muxinck,muxoutck,keycomck:std_logic;


begin
	tmptomuxout <= indes64(17 to 32)&tomuxout32;
	tmptoexp <= indes64(17 to 32);

	sm1:des port map (mclk,mreset,allreset,inbufck,outbufck,keybufck,xor32ck,xor48ck,muxinck,muxoutck,keycomck);
	sm2:inbuffer port map (datain,in64,inbufck,allreset);
	sm3:permute port map (in64,pin64);
	sm4:depermute port map (out64,depout64);
	sm5:outbuffer port map (depout64,dataout,outbufck,allreset);
	sm6:keybuffer port map (keyin,key64,keybufck,allreset);
	sm7:muxin port map (pin64,turndes,indes64,muxinck,allreset);
	sm8:muxout port map (tmptomuxout,out64,turndes,muxoutck,allreset);
	sm9:exp port map (tmptoexp,outexp48);
	sm10:xor24 port map (outexp48,turnkey,tosbox48,xor48ck);
	sm11:keycom port map (key64,turnkey,keycomck,allreset,deen);
	sm12:sbox port map (tosbox48,toppbox32);
	sm13:pp port map (toppbox32,toxor32);
	sm14:xor16 port map (indes64(1 to 16),toxor32,tomuxout32,xor32ck);
	   
end chipdes;
