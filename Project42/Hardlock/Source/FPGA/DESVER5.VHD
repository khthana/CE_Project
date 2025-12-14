library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor32 is
	port (dataina,datainb : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk : in std_logic);
end  xor32;

architecture exclusive_or32 of xor32 is
begin
	process (clk)
		begin
			if clk = '1' and clk'event then
			dataout <= dataina xor datainb;
			end if;
		end process;
end exclusive_or32;
--------------------------------------- xor32 -------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor48 is
	port (dataina,datainb : in std_logic_vector(47 downto 0);
	      dataout : out std_logic_vector(47 downto 0);
	      clk : in std_logic);
end  xor48;

architecture exclusive_or48 of xor48 is
begin
	process (clk)
		begin
			if clk = '1' and clk'event then
			dataout <= dataina xor datainb;
			end if;
		end process;
end exclusive_or48;

--------------------------------------- input buffer -------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inbuffer is
	port (datain : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  inbuffer;

architecture inputbuffer of inbuffer is
   signal s:integer;
begin
	process(clk,reset)
		begin
			if 	reset='1' then 
				s <= 1;  --   reset stage
			elsif clk'event and clk = '1' then  ----- rising edge ----
				case s is
					when 1 => 						
						dataout(15 downto 0) <= datain;
						s <= 2;
					when 2 =>
						dataout(31 downto 16) <= datain;
						s <= 3;
					when 3 =>
						dataout(47 downto 32) <= datain;
						s <= 4;
					when 4 =>
						dataout(63 downto 48) <= datain;
						s <= 5;
					when others =>
						s <= 5;
				end case;				
			end if;
		end process;
		
end inputbuffer;

--------------------------------------- output buffer ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity outbuffer is
	port (datain : in std_logic_vector(63 downto 0);
	      dataout : out std_logic_vector(15 downto 0);
	      clk,reset : in std_logic);
end  outbuffer;

architecture outputbuffer of outbuffer is
   signal s:integer;
begin
	process(clk,reset)
		begin
			if 	reset='1' then
				s <= 1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
				case s is
					when 1 =>
						dataout <= datain(15 downto 0);
						s <= 2;
					when 2 =>
						dataout <= datain(31 downto 16);
						s <= 3;
					when 3 =>
						dataout <= datain(47 downto 32);
						s <= 4;
					when 4 =>
						dataout <= datain(63 downto 48);
						s <= 5;					
					when others =>
						s <= 5;
				end case;
			end if;
		end process;
		
end outputbuffer;

--------------------------------------- key buffer ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keybuffer is
	port (datain : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  keybuffer;

architecture keybuff of keybuffer is
   signal s:integer;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= 1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is
				when 1 =>
					dataout(15 downto 0) <= datain;
					s <= 2;
				when 2 =>				
					dataout(31 downto 16) <= datain;
					s <= 3;
				when 3 =>
					dataout(47 downto 32) <= datain;
					s <= 4;
				when 4 =>
					dataout(63 downto 48) <= datain;
					s <= 5;
				when others =>
					s <= 5;
			  end case;
			end if;
		end process;
		
end keybuff;
---------------------------- multiplexor input ---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity muxin is
	port (datain,dataloop : in std_logic_vector(63 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  muxin;

architecture multiplexinput of muxin is
   signal s:integer;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= 1;   --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is
				when 1 =>
					dataout <= datain;
					s <= 2;
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
	port (datain : in std_logic_vector(63 downto 0);
	      dataout,dataloop : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  muxout;

architecture multiplexoutput of muxout is
   signal s:integer;
begin
	process(clk,reset)
		begin
			if reset='1' then s <= 1;  --   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----
			  case s is	
			  	when 1 =>
					dataloop <= datain;
					s <= 2;
				when 2 =>
					dataloop <= datain;
					s <= 3;
				when 3 =>
					dataloop <= datain;
					s <= 4;
				when 4 =>
					dataloop <= datain;
					s <= 5;
				when 5 =>
					dataloop <= datain;
					s <= 6;
				when 6 =>
					dataloop <= datain;
					s <= 7;
				when 7 =>
					dataloop <= datain;
					s <= 8;					
				when 8 =>
					dataloop <= datain;
					s <= 9;
				when 9 =>
					dataloop <= datain;
					s <= 10;
				when 10 =>
					dataloop <= datain;
					s <= 11;
				when 11 =>
					dataloop <= datain;
					s <= 12;
				when 12 =>
					dataloop <= datain;
					s <= 13;					
				when 13 =>
					dataloop <= datain;
					s <= 14;
				when 14 =>
					dataloop <= datain;
					s <= 15;
				when 15 =>
					dataloop <= datain;
					s <= 16;				
				when 16 =>
					dataout <= datain(31 downto 0)&datain(63 downto 32);
					s <= 17;
				when others =>
						s <= 17;
			  end case;
			end if;
		end process;
		
end multiplexoutput;

------------------------ permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity permute is
	port (i : in std_logic_vector(64 downto 1);
	      o : out std_logic_vector(64 downto 1));
      
end  permute;

architecture permutation of permute is
begin
	o(64)<=i(58); o(63)<=i(50); o(62)<=i(42); o(61)<=i(34); o(60)<=i(26); o(59)<=i(18); o(58)<=i(10); o(57)<=i(2);
	o(56)<=i(60); o(55)<=i(52); o(54)<=i(44); o(53)<=i(36); o(52)<=i(28); o(51)<=i(20); o(50)<=i(12); o(49)<=i(4);
	o(48)<=i(62); o(47)<=i(54); o(46)<=i(46); o(45)<=i(38); o(44)<=i(30); o(43)<=i(22); o(42)<=i(14); o(41)<=i(6);
	o(40)<=i(64); o(39)<=i(56); o(38)<=i(48); o(37)<=i(40); o(36)<=i(32); o(35)<=i(24); o(34)<=i(16); o(33)<=i(8);
	o(32)<=i(57); o(31)<=i(49); o(30)<=i(41); o(29)<=i(33); o(28)<=i(25); o(27)<=i(17);  o(26)<=i(9); o(25)<=i(1);
	o(24)<=i(59); o(23)<=i(51); o(22)<=i(43); o(21)<=i(35); o(20)<=i(27); o(19)<=i(19); o(18)<=i(11); o(17)<=i(3);
	o(16)<=i(61); o(15)<=i(53); o(14)<=i(45); o(13)<=i(37); o(12)<=i(29); o(11)<=i(21); o(10)<=i(13);  o(9)<=i(5);
	 o(8)<=i(63);  o(7)<=i(55);  o(6)<=i(47);  o(5)<=i(39);  o(4)<=i(31);  o(3)<=i(23);  o(2)<=i(15);  o(1)<=i(7);
end permutation;

------------------------ de-permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity depermute is
	port (i : in std_logic_vector(64 downto 1);
	      o : out std_logic_vector(64 downto 1));
      
end  depermute;

architecture depermutation of depermute is
begin
	o(64)<=i(40); o(63)<=i(8); o(62)<=i(48); o(61)<=i(16); o(60)<=i(56); o(59)<=i(24); o(58)<=i(64); o(57)<=i(32);
	o(56)<=i(39); o(55)<=i(7); o(54)<=i(47); o(53)<=i(15); o(52)<=i(55); o(51)<=i(23); o(50)<=i(63); o(49)<=i(31);
	o(48)<=i(38); o(47)<=i(6); o(46)<=i(46); o(45)<=i(14); o(44)<=i(54); o(43)<=i(22); o(42)<=i(62); o(41)<=i(30);
	o(40)<=i(37); o(39)<=i(5); o(38)<=i(45); o(37)<=i(13); o(36)<=i(53); o(35)<=i(21); o(34)<=i(61); o(33)<=i(29);
	o(32)<=i(36); o(31)<=i(4); o(30)<=i(44); o(29)<=i(12); o(28)<=i(52); o(27)<=i(20); o(26)<=i(60); o(25)<=i(28);
	o(24)<=i(35); o(23)<=i(3); o(22)<=i(43); o(21)<=i(11); o(20)<=i(51); o(19)<=i(19); o(18)<=i(59); o(17)<=i(27);
	o(16)<=i(34); o(15)<=i(2); o(14)<=i(42); o(13)<=i(10); o(12)<=i(50); o(11)<=i(18); o(10)<=i(58);  o(9)<=i(26);
	 o(8)<=i(33);  o(7)<=i(1);  o(6)<=i(41);   o(5)<=i(9);  o(4)<=i(49);  o(3)<=i(17);  o(2)<=i(57);  o(1)<=i(25);
end depermutation;

------------------------ E-box ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity exp is
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 48));
      
end  exp;

architecture expand of exp is
begin
	 o(1)<=i(32);  o(2)<=i( 1);  o(3)<=i( 2);  o(4)<=i( 3);  o(5)<=i( 4);  o(6)<=i( 5);
	 o(7)<=i( 4);  o(8)<=i( 5);  o(9)<=i( 6); o(10)<=i( 7); o(11)<=i( 8); o(12)<=i( 9);
	o(13)<=i( 8); o(14)<=i( 9); o(15)<=i(10); o(16)<=i(11); o(17)<=i(12); o(18)<=i(13);
	o(19)<=i(12); o(20)<=i(13); o(21)<=i(14); o(22)<=i(15); o(23)<=i(16); o(24)<=i(17);
	o(25)<=i(16); o(26)<=i(17); o(27)<=i(18); o(28)<=i(19); o(29)<=i(20); o(30)<=i(21);
	o(31)<=i(20); o(32)<=i(21); o(33)<=i(22); o(34)<=i(23); o(35)<=i(24); o(36)<=i(25);
	o(37)<=i(24); o(38)<=i(25); o(39)<=i(26); o(40)<=i(27); o(41)<=i(28); o(42)<=i(29);
	o(43)<=i(28); o(44)<=i(29); o(45)<=i(30); o(46)<=i(31); o(47)<=i(32); o(48)<=i( 1);

end expand;

------------------------ s-box ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sbox is
	port (i : in std_logic_vector(1 to 48);
	      clk : in std_logic;
	      o : out std_logic_vector(1 to 32));
      
end sbox;

architecture sboxar of sbox is
begin
    process(clk)
	begin
	  ----------------- s box table 1 ---------------------

	if i(1) = '0' then   ------ 00 -------

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
	end if;

	if i(1) = '1' then   ------ 10 -------

	   if i(2 to 5)="0000" then o(1 to 4)<="0100"; end if;
	   if i(2 to 5)="0001" then o(1 to 4)<="0001"; end if;
	   if i(2 to 5)="0010" then o(1 to 4)<="1110"; end if;
	   if i(2 to 5)="0011" then o(1 to 4)<="1000"; end if;
	   if i(2 to 5)="0100" then o(1 to 4)<="1101"; end if;
	   if i(2 to 5)="0101" then o(1 to 4)<="0110"; end if;
	   if i(2 to 5)="0110" then o(1 to 4)<="0010"; end if;
	   if i(2 to 5)="0111" then o(1 to 4)<="1011"; end if;
	   if i(2 to 5)="1000" then o(1 to 4)<="1111"; end if;
	   if i(2 to 5)="1001" then o(1 to 4)<="1100"; end if;
	   if i(2 to 5)="1010" then o(1 to 4)<="1001"; end if;
	   if i(2 to 5)="1011" then o(1 to 4)<="0111"; end if;
	   if i(2 to 5)="1100" then o(1 to 4)<="0011"; end if;
	   if i(2 to 5)="1101" then o(1 to 4)<="1010"; end if;
	   if i(2 to 5)="1110" then o(1 to 4)<="0101"; end if;
	   if i(2 to 5)="1111" then o(1 to 4)<="0000"; end if;
	end if;

	  ----------------- s box table 2 ---------------------

	if i(7) = '0' then   ------ 00 -------

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
	end if;


	if i(7) = '1' then   ------ 10 -------

	   if i(8 to 11)="0000" then o(5 to 8)<="0000"; end if;
	   if i(8 to 11)="0001" then o(5 to 8)<="1110"; end if;
	   if i(8 to 11)="0010" then o(5 to 8)<="0111"; end if;
	   if i(8 to 11)="0011" then o(5 to 8)<="1011"; end if;
	   if i(8 to 11)="0100" then o(5 to 8)<="1010"; end if;
	   if i(8 to 11)="0101" then o(5 to 8)<="0100"; end if;
	   if i(8 to 11)="0110" then o(5 to 8)<="1101"; end if;
	   if i(8 to 11)="0111" then o(5 to 8)<="0001"; end if;
	   if i(8 to 11)="1000" then o(5 to 8)<="0101"; end if;
	   if i(8 to 11)="1001" then o(5 to 8)<="1000"; end if;
	   if i(8 to 11)="1010" then o(5 to 8)<="1100"; end if;
	   if i(8 to 11)="1011" then o(5 to 8)<="0110"; end if;
	   if i(8 to 11)="1100" then o(5 to 8)<="1001"; end if;
	   if i(8 to 11)="1101" then o(5 to 8)<="0011"; end if;
	   if i(8 to 11)="1110" then o(5 to 8)<="0010"; end if;
	   if i(8 to 11)="1111" then o(5 to 8)<="1111"; end if;
	end if;

	  ----------------- s box table 3 ---------------------

	if i(13) = '0' then   ------ 00 -------

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
	end if;

	if i(13) = '1' then   ------ 10 -------

	   if i(14 to 17)="0000" then o(9 to 12)<="1101"; end if;
	   if i(14 to 17)="0001" then o(9 to 12)<="0110"; end if;
	   if i(14 to 17)="0010" then o(9 to 12)<="0100"; end if;
	   if i(14 to 17)="0011" then o(9 to 12)<="1001"; end if;
	   if i(14 to 17)="0100" then o(9 to 12)<="1000"; end if;
	   if i(14 to 17)="0101" then o(9 to 12)<="1111"; end if;
	   if i(14 to 17)="0110" then o(9 to 12)<="0011"; end if;
	   if i(14 to 17)="0111" then o(9 to 12)<="0000"; end if;
	   if i(14 to 17)="1000" then o(9 to 12)<="1011"; end if;
	   if i(14 to 17)="1001" then o(9 to 12)<="0001"; end if;
	   if i(14 to 17)="1010" then o(9 to 12)<="0010"; end if;
	   if i(14 to 17)="1011" then o(9 to 12)<="1100"; end if;
	   if i(14 to 17)="1100" then o(9 to 12)<="0101"; end if;
	   if i(14 to 17)="1101" then o(9 to 12)<="1010"; end if;
	   if i(14 to 17)="1110" then o(9 to 12)<="1110"; end if;
	   if i(14 to 17)="1111" then o(9 to 12)<="0111"; end if;
	end if;

	  ----------------- s box table 4 ---------------------

	if i(19) = '0' then   ------ 00 -------

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
	end if;

	if i(19) = '1' then   ------ 10 -------

	   if i(20 to 23)="0000" then o(13 to 16)<="1010"; end if;
	   if i(20 to 23)="0001" then o(13 to 16)<="0110"; end if;
	   if i(20 to 23)="0010" then o(13 to 16)<="1001"; end if;
	   if i(20 to 23)="0011" then o(13 to 16)<="0000"; end if;
	   if i(20 to 23)="0100" then o(13 to 16)<="1100"; end if;
	   if i(20 to 23)="0101" then o(13 to 16)<="1011"; end if;
	   if i(20 to 23)="0110" then o(13 to 16)<="0111"; end if;
	   if i(20 to 23)="0111" then o(13 to 16)<="1101"; end if;
	   if i(20 to 23)="1000" then o(13 to 16)<="1111"; end if;
	   if i(20 to 23)="1001" then o(13 to 16)<="0001"; end if;
	   if i(20 to 23)="1010" then o(13 to 16)<="0011"; end if;
	   if i(20 to 23)="1011" then o(13 to 16)<="1110"; end if;
	   if i(20 to 23)="1100" then o(13 to 16)<="0101"; end if;
	   if i(20 to 23)="1101" then o(13 to 16)<="0010"; end if;
	   if i(20 to 23)="1110" then o(13 to 16)<="1000"; end if;
	   if i(20 to 23)="1111" then o(13 to 16)<="0100"; end if;
	end if;

	  ----------------- s box table 5 ---------------------

	if i(25) = '0' then   ------ 00 -------

	   if i(26 to 29)="0000" then o(17 to 20)<="0010"; end if;
	   if i(26 to 29)="0001" then o(17 to 20)<="1100"; end if;
	   if i(26 to 29)="0010" then o(17 to 20)<="0100"; end if;
	   if i(26 to 29)="0011" then o(17 to 20)<="0001"; end if;
	   if i(26 to 29)="0100" then o(17 to 20)<="0111"; end if;
	   if i(26 to 29)="0101" then o(17 to 20)<="1010"; end if;
	   if i(26 to 29)="0110" then o(17 to 20)<="1011"; end if;
	   if i(26 to 29)="0111" then o(17 to 20)<="0110"; end if;
	   if i(26 to 29)="1000" then o(17 to 20)<="1000"; end if;
	   if i(26 to 29)="1001" then o(17 to 20)<="0101"; end if;
	   if i(26 to 29)="1010" then o(17 to 20)<="0011"; end if;
	   if i(26 to 29)="1011" then o(17 to 20)<="1111"; end if;
	   if i(26 to 29)="1100" then o(17 to 20)<="1101"; end if;
	   if i(26 to 29)="1101" then o(17 to 20)<="0000"; end if;
	   if i(26 to 29)="1110" then o(17 to 20)<="1110"; end if;
	   if i(26 to 29)="1111" then o(17 to 20)<="1001"; end if;
	end if;

	if i(25) = '1' then   ------ 10 -------

	   if i(26 to 29)="0000" then o(17 to 20)<="0100"; end if;
	   if i(26 to 29)="0001" then o(17 to 20)<="0010"; end if;
	   if i(26 to 29)="0010" then o(17 to 20)<="0001"; end if;
	   if i(26 to 29)="0011" then o(17 to 20)<="1011"; end if;
	   if i(26 to 29)="0100" then o(17 to 20)<="1010"; end if;
	   if i(26 to 29)="0101" then o(17 to 20)<="1101"; end if;
	   if i(26 to 29)="0110" then o(17 to 20)<="0111"; end if;
	   if i(26 to 29)="0111" then o(17 to 20)<="1000"; end if;
	   if i(26 to 29)="1000" then o(17 to 20)<="1111"; end if;
	   if i(26 to 29)="1001" then o(17 to 20)<="1001"; end if;
	   if i(26 to 29)="1010" then o(17 to 20)<="1100"; end if;
	   if i(26 to 29)="1011" then o(17 to 20)<="0101"; end if;
	   if i(26 to 29)="1100" then o(17 to 20)<="0110"; end if;
	   if i(26 to 29)="1101" then o(17 to 20)<="0011"; end if;
	   if i(26 to 29)="1110" then o(17 to 20)<="0000"; end if;
	   if i(26 to 29)="1111" then o(17 to 20)<="1110"; end if;
	end if;

	  ----------------- s box table 6 ---------------------

	if i(31) = '0' then   ------ 00 -------

	   if i(32 to 35)="0000" then o(21 to 24)<="1100"; end if;
	   if i(32 to 35)="0001" then o(21 to 24)<="0001"; end if;
	   if i(32 to 35)="0010" then o(21 to 24)<="1010"; end if;
	   if i(32 to 35)="0011" then o(21 to 24)<="1111"; end if;
	   if i(32 to 35)="0100" then o(21 to 24)<="1001"; end if;
	   if i(32 to 35)="0101" then o(21 to 24)<="0010"; end if;
	   if i(32 to 35)="0110" then o(21 to 24)<="0110"; end if;
	   if i(32 to 35)="0111" then o(21 to 24)<="1000"; end if;
	   if i(32 to 35)="1000" then o(21 to 24)<="0000"; end if;
	   if i(32 to 35)="1001" then o(21 to 24)<="1101"; end if;
	   if i(32 to 35)="1010" then o(21 to 24)<="0011"; end if;
	   if i(32 to 35)="1011" then o(21 to 24)<="0100"; end if;
	   if i(32 to 35)="1100" then o(21 to 24)<="1110"; end if;
	   if i(32 to 35)="1101" then o(21 to 24)<="0111"; end if;
	   if i(32 to 35)="1110" then o(21 to 24)<="0101"; end if;
	   if i(32 to 35)="1111" then o(21 to 24)<="1011"; end if;
	end if;


	if i(31) = '1' then   ------ 10 -------

	   if i(32 to 35)="0000" then o(21 to 24)<="1001"; end if;
	   if i(32 to 35)="0001" then o(21 to 24)<="1110"; end if;
	   if i(32 to 35)="0010" then o(21 to 24)<="1111"; end if;
	   if i(32 to 35)="0011" then o(21 to 24)<="0101"; end if;
	   if i(32 to 35)="0100" then o(21 to 24)<="0010"; end if;
	   if i(32 to 35)="0101" then o(21 to 24)<="1000"; end if;
	   if i(32 to 35)="0110" then o(21 to 24)<="1100"; end if;
	   if i(32 to 35)="0111" then o(21 to 24)<="0011"; end if;
	   if i(32 to 35)="1000" then o(21 to 24)<="0111"; end if;
	   if i(32 to 35)="1001" then o(21 to 24)<="0000"; end if;
	   if i(32 to 35)="1010" then o(21 to 24)<="0100"; end if;
	   if i(32 to 35)="1011" then o(21 to 24)<="1010"; end if;
	   if i(32 to 35)="1100" then o(21 to 24)<="0001"; end if;
	   if i(32 to 35)="1101" then o(21 to 24)<="1101"; end if;
	   if i(32 to 35)="1110" then o(21 to 24)<="1011"; end if;
	   if i(32 to 35)="1111" then o(21 to 24)<="0110"; end if;
	end if;


	  ----------------- s box table 7 ---------------------

	if i(37) = '0' then   ------ 00 -------

	   if i(38 to 41)="0000" then o(25 to 28)<="0100"; end if;
	   if i(38 to 41)="0001" then o(25 to 28)<="1011"; end if;
	   if i(38 to 41)="0010" then o(25 to 28)<="0010"; end if;
	   if i(38 to 41)="0011" then o(25 to 28)<="1110"; end if;
	   if i(38 to 41)="0100" then o(25 to 28)<="1111"; end if;
	   if i(38 to 41)="0101" then o(25 to 28)<="0000"; end if;
	   if i(38 to 41)="0110" then o(25 to 28)<="1000"; end if;
	   if i(38 to 41)="0111" then o(25 to 28)<="1101"; end if;
	   if i(38 to 41)="1000" then o(25 to 28)<="0011"; end if;
	   if i(38 to 41)="1001" then o(25 to 28)<="1100"; end if;
	   if i(38 to 41)="1010" then o(25 to 28)<="1001"; end if;
	   if i(38 to 41)="1011" then o(25 to 28)<="0111"; end if;
	   if i(38 to 41)="1100" then o(25 to 28)<="0101"; end if;
	   if i(38 to 41)="1101" then o(25 to 28)<="1010"; end if;
	   if i(38 to 41)="1110" then o(25 to 28)<="0110"; end if;
	   if i(38 to 41)="1111" then o(25 to 28)<="0001"; end if;
	end if;

	if i(37) = '1' then   ------ 10 -------

	   if i(38 to 41)="0000" then o(25 to 28)<="0001"; end if;
	   if i(38 to 41)="0001" then o(25 to 28)<="0100"; end if;
	   if i(38 to 41)="0010" then o(25 to 28)<="1011"; end if;
	   if i(38 to 41)="0011" then o(25 to 28)<="1101"; end if;
	   if i(38 to 41)="0100" then o(25 to 28)<="1100"; end if;
	   if i(38 to 41)="0101" then o(25 to 28)<="0011"; end if;
	   if i(38 to 41)="0110" then o(25 to 28)<="0111"; end if;
	   if i(38 to 41)="0111" then o(25 to 28)<="1110"; end if;
	   if i(38 to 41)="1000" then o(25 to 28)<="1010"; end if;
	   if i(38 to 41)="1001" then o(25 to 28)<="1111"; end if;
	   if i(38 to 41)="1010" then o(25 to 28)<="0110"; end if;
	   if i(38 to 41)="1011" then o(25 to 28)<="1000"; end if;
	   if i(38 to 41)="1100" then o(25 to 28)<="0000"; end if;
	   if i(38 to 41)="1101" then o(25 to 28)<="0101"; end if;
	   if i(38 to 41)="1110" then o(25 to 28)<="1001"; end if;
	   if i(38 to 41)="1111" then o(25 to 28)<="0010"; end if;
	end if;


	  ----------------- s box table 8 ---------------------

       if i(43) = '0' then   ------ 00 -------

	   if i(44 to 47)="0000" then o(29 to 32)<="1101"; end if;
	   if i(44 to 47)="0001" then o(29 to 32)<="0010"; end if;
	   if i(44 to 47)="0010" then o(29 to 32)<="1000"; end if;
	   if i(44 to 47)="0011" then o(29 to 32)<="0100"; end if;
	   if i(44 to 47)="0100" then o(29 to 32)<="0110"; end if;
	   if i(44 to 47)="0101" then o(29 to 32)<="1111"; end if;
	   if i(44 to 47)="0110" then o(29 to 32)<="1011"; end if;
	   if i(44 to 47)="0111" then o(29 to 32)<="0001"; end if;
	   if i(44 to 47)="1000" then o(29 to 32)<="1010"; end if;
	   if i(44 to 47)="1001" then o(29 to 32)<="1001"; end if;
	   if i(44 to 47)="1010" then o(29 to 32)<="0011"; end if;
	   if i(44 to 47)="1011" then o(29 to 32)<="1110"; end if;
	   if i(44 to 47)="1100" then o(29 to 32)<="0101"; end if;
	   if i(44 to 47)="1101" then o(29 to 32)<="0000"; end if;
	   if i(44 to 47)="1110" then o(29 to 32)<="1100"; end if;
	   if i(44 to 47)="1111" then o(29 to 32)<="0111"; end if;
	end if;

	if i(43) = '1' then   ------ 10 -------

	   if i(44 to 47)="0000" then o(29 to 32)<="0111"; end if;
	   if i(44 to 47)="0001" then o(29 to 32)<="1011"; end if;
	   if i(44 to 47)="0010" then o(29 to 32)<="0100"; end if;
	   if i(44 to 47)="0011" then o(29 to 32)<="0001"; end if;
	   if i(44 to 47)="0100" then o(29 to 32)<="1001"; end if;
	   if i(44 to 47)="0101" then o(29 to 32)<="1100"; end if;
	   if i(44 to 47)="0110" then o(29 to 32)<="1110"; end if;
	   if i(44 to 47)="0111" then o(29 to 32)<="0010"; end if;
	   if i(44 to 47)="1000" then o(29 to 32)<="0000"; end if;
	   if i(44 to 47)="1001" then o(29 to 32)<="0110"; end if;
	   if i(44 to 47)="1010" then o(29 to 32)<="1010"; end if;
	   if i(44 to 47)="1011" then o(29 to 32)<="1101"; end if;
	   if i(44 to 47)="1100" then o(29 to 32)<="1111"; end if;
	   if i(44 to 47)="1101" then o(29 to 32)<="0011"; end if;
	   if i(44 to 47)="1110" then o(29 to 32)<="0101"; end if;
	   if i(44 to 47)="1111" then o(29 to 32)<="1000"; end if;
	end if;


      end process;
end sboxar;

------------------------ P-permutation ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pp is
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 32));
      
end  pp;

architecture pper of pp is
begin
	 o(1)<=i(16);  o(2)<=i( 7);  o(3)<=i(20);  o(4)<=i(21);  
	 o(5)<=i(29);  o(6)<=i(12);  o(7)<=i(28);  o(8)<=i(17); 
	o( 9)<=i( 1); o(10)<=i(15); o(11)<=i(23); o(12)<=i(26); 
	o(13)<=i( 5); o(14)<=i(18); o(15)<=i(31); o(16)<=i(10); 
	o(17)<=i( 2); o(18)<=i( 8); o(19)<=i(24); o(20)<=i(14); 
	o(21)<=i(32); o(22)<=i(27); o(23)<=i( 3); o(24)<=i( 9); 
	o(25)<=i(19); o(26)<=i(13); o(27)<=i(30); o(28)<=i( 6); 
	o(29)<=i(22); o(30)<=i(11); o(31)<=i( 4); o(32)<=i(25); 
	

end pper;

------------------------ PC-2 for key generate ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity pc2 is
	port (i : in std_logic_vector(1 to 56);
	      o : out std_logic_vector(1 to 48));
      
end  pc2;

architecture keypc2 of pc2 is
begin
	 o(1)<=i(14);  o(2)<=i(17);  o(3)<=i(11);  o(4)<=i(24);  o(5)<=i( 1);  o(6)<=i( 5);
	 o(7)<=i( 3);  o(8)<=i(28);  o(9)<=i(15); o(10)<=i( 6); o(11)<=i(21); o(12)<=i(10);
	o(13)<=i(23); o(14)<=i(19); o(15)<=i(12); o(16)<=i( 4); o(17)<=i(26); o(18)<=i( 8);
	o(19)<=i(16); o(20)<=i( 7); o(21)<=i(27); o(22)<=i(20); o(23)<=i(13); o(24)<=i( 2);
	o(25)<=i(41); o(26)<=i(52); o(27)<=i(31); o(28)<=i(37); o(29)<=i(47); o(30)<=i(55);
	o(31)<=i(30); o(32)<=i(40); o(33)<=i(51); o(34)<=i(45); o(35)<=i(33); o(36)<=i(48);
	o(37)<=i(44); o(38)<=i(49); o(39)<=i(39); o(40)<=i(56); o(41)<=i(34); o(42)<=i(53);
	o(43)<=i(46); o(44)<=i(42); o(45)<=i(50); o(46)<=i(36); o(47)<=i(29); o(48)<=i(32);

end keypc2;


------------------------ key generate ----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keygen is
	port (i : in std_logic_vector(1 to 64);
	      o : out std_logic_vector(1 to 56);
	      clk,reset,deen : in std_logic);
end  keygen;

architecture keygenerate of keygen is

   signal s:integer;
   signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16:std_logic_vector(1 to 28);
   signal d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16:std_logic_vector(1 to 28);
begin
----- c0 ------ PC-1
	 c0(1)<=i(57);  c0(2)<=i(49);  c0(3)<=i(41);  c0(4)<=i(33);  c0(5)<=i(25);  c0(6)<=i(17);  c0(7)<=i( 9);
	 c0(8)<=i( 1);  c0(9)<=i(58); c0(10)<=i(50); c0(11)<=i(42); c0(12)<=i(34); c0(13)<=i(26); c0(14)<=i(18);
	c0(15)<=i(10); c0(16)<=i( 2); c0(17)<=i(59); c0(18)<=i(51); c0(19)<=i(43); c0(20)<=i(35); c0(21)<=i(27);
	c0(22)<=i(19); c0(23)<=i(11); c0(24)<=i( 3); c0(25)<=i(60); c0(26)<=i(52); c0(27)<=i(44); c0(28)<=i(36);
----- do ------- PC-1
	 d0(1)<=i(63);  d0(2)<=i(55);  d0(3)<=i(47);  d0(4)<=i(39);  d0(5)<=i(31);  d0(6)<=i(23);  d0(7)<=i(15);
	 d0(8)<=i( 7);  d0(9)<=i(62); d0(10)<=i(54); d0(11)<=i(46); d0(12)<=i(38); d0(13)<=i(30); d0(14)<=i(22);
	d0(15)<=i(14); d0(16)<=i( 6); d0(17)<=i(61); d0(18)<=i(53); d0(19)<=i(45); d0(20)<=i(37); d0(21)<=i(29);
	d0(22)<=i(21); d0(23)<=i(13); d0(24)<=i( 5); d0(25)<=i(28); d0(26)<=i(20); d0(27)<=i(12); d0(28)<=i( 4);
----- c1 to c16 & d1 to d16 -----

   c1(1 to 28) <=  c0(2 to 28)&c0(1);        d1(1 to 28) <=  d0(2 to 28)&d0(1);
   c2(1 to 28) <=  c1(2 to 28)&c1(1);        d2(1 to 28) <=  d1(2 to 28)&d1(1);
   c3(1 to 28) <=  c2(3 to 28)&c2(1 to 2);   d3(1 to 28) <=  d2(3 to 28)&d2(1 to 2);
   c4(1 to 28) <=  c3(3 to 28)&c3(1 to 2);   d4(1 to 28) <=  d3(3 to 28)&d3(1 to 2);
   c5(1 to 28) <=  c4(3 to 28)&c4(1 to 2);   d5(1 to 28) <=  d4(3 to 28)&d4(1 to 2);
   c6(1 to 28) <=  c5(3 to 28)&c5(1 to 2);   d6(1 to 28) <=  d5(3 to 28)&d5(1 to 2);
   c7(1 to 28) <=  c6(3 to 28)&c6(1 to 2);   d7(1 to 28) <=  d6(3 to 28)&d6(1 to 2);
   c8(1 to 28) <=  c7(3 to 28)&c7(1 to 2);   d8(1 to 28) <=  d7(3 to 28)&d7(1 to 2);
   c9(1 to 28) <=  c8(2 to 28)&c8(1);        d9(1 to 28) <=  d8(2 to 28)&d8(1);
  c10(1 to 28) <=  c9(3 to 28)&c9(1 to 2);  d10(1 to 28) <=  d9(3 to 28)&d9(1 to 2);
  c11(1 to 28) <= c10(3 to 28)&c10(1 to 2); d11(1 to 28) <= d10(3 to 28)&d10(1 to 2);
  c12(1 to 28) <= c11(3 to 28)&c11(1 to 2); d12(1 to 28) <= d11(3 to 28)&d11(1 to 2);
  c13(1 to 28) <= c12(3 to 28)&c12(1 to 2); d13(1 to 28) <= d12(3 to 28)&d12(1 to 2);
  c14(1 to 28) <= c13(3 to 28)&c13(1 to 2); d14(1 to 28) <= d13(3 to 28)&d13(1 to 2);
  c15(1 to 28) <= c14(3 to 28)&c14(1 to 2); d15(1 to 28) <= d14(3 to 28)&d14(1 to 2);
  c16(1 to 28) <= c15(2 to 28)&c15(1);      d16(1 to 28) <= d15(2 to 28)&d15(1);


	process(clk,reset)
	    begin
	       if reset='1' then s <= 1;  -----   reset stage

		    elsif clk = '1' and clk'event then  ----- rising edge ----

			 if deen = '0' then  --- encode ---  
			    case s is
					when 1 => 
						o <= c1&d1;
				  		s <= 2;
					when 2 =>	
			     		o <= c2&d2;
				  		s <= 3;
			    	when 3 =>
						o <= c3&d3;
				  		s <= 4;
					when 4 =>
			    		o <= c4&d4;
				  		s <= 5;
					when 5 =>
			    		o <= c5&d5;
				  		s <= 6;
					when 6 =>
			    		o <= c6&d6;
				  		s <= 7;
					when 7 =>
			    		o <= c7&d7;
				  		s <= 8;
					when 8 =>
			    		o <= c8&d8;
				  		s <= 9;
					when 9 =>
			    		o <= c9&d9;
				  		s <= 10;
					when 10 =>
			    		o <= c10&d10;
				  		s <= 11;
					when 11 =>
			    		o <= c11&d11;
				  		s <= 12;
					when 12 =>
			    		o <= c12&d12;
				  		s <= 13;
					when 13 =>
			    		o <= c13&d13;
				  		s <= 14;
					when 14 =>
			    		o <= c14&d14;
				  		s <= 15;
					when 15 =>
			    		o <= c15&d15;
				  		s <= 16;
					when 16 =>
			    		o <= c16&d16;
				  		s <= 17;
					when others =>
						s <= 17;

			    end case;

			 end if; --- encode ---

			 if deen = '1' then  --- decode ---  
				case s is
					when 1 => 
						o <= c16&d16;
				  		s <= 2;
					when 2 =>	
			     		o <= c15&d15;
				  		s <= 3;
			    	when 3 =>
						o <= c14&d14;
				  		s <= 4;
					when 4 =>
			    		o <= c13&d13;
				  		s <= 5;
					when 5 =>
			    		o <= c12&d12;
				  		s <= 6;
					when 6 =>
			    		o <= c11&d11;
				  		s <= 7;
					when 7 =>
			    		o <= c10&d10;
				  		s <= 8;
					when 8 =>
			    		o <= c9&d9;
				  		s <= 9;
					when 9 =>
			    		o <= c8&d8;
				  		s <= 10;
					when 10 =>
			    		o <= c7&d7;
				  		s <= 11;
					when 11 =>
			    		o <= c6&d6;
				  		s <= 12;
					when 12 =>
			    		o <= c5&d5;
				  		s <= 13;
					when 13 =>
			    		o <= c4&d4;
				  		s <= 14;
					when 14 =>
			    		o <= c3&d3;
				  		s <= 15;
					when 15 =>
			    		o <= c2&d2;
				  		s <= 16;
					when 16 =>
			    		o <= c1&d1;
				  		s <= 17;
					when others =>
						s <= 17;

			    end case;

			 end if; --- decode ---

		   end if; ---- clock ------
	    end process;
		
end keygenerate;


------------------------  key generate complete----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity keycom is
	port (i : in std_logic_vector(1 to 64);
	      k : out std_logic_vector(1 to 48);
	      clk,reset,deen : in std_logic);
      
end  keycom;

architecture keycomplete of keycom is

component keygen
	port (i : in std_logic_vector(1 to 64);
	      o : out std_logic_vector(1 to 56);
	      clk,reset,deen : in std_logic);
end component;

component pc2
	port (i : in std_logic_vector(1 to 56);
	      o : out std_logic_vector(1 to 48));
end component;

signal ktmp:std_logic_vector(1 to 56);

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
		 sbox      : out std_logic;
		 keycom    : out std_logic);
      
end  des;

architecture descontrol of des is

signal s:integer;

begin
  process(clk,reset)
	    begin
	       if reset='1' then s <= 190;  -----   reset stage
			elsif clk = '1' and clk'event then  ----- rising edge ----

		   
--=========================== initial ============================ 
			case s is
				when 190 =>			      
					ares <= '1';       ----- all reset -----
				  	s <= 191;
				when 191 =>
			   		inbuffer <= '1';
					outbuffer <= '1';
					keybuffer <= '1';
					xor32 <= '1';
					xor48 <= '1';
					muxin <= '1';
					muxout <= '1';
					sbox <= '1';
					keycom <= '1';
 				  	s <= 192;
				when 192 =>
			    	inbuffer <= '0';
					outbuffer <= '0';
					keybuffer <= '0';
					xor32 <= '0';
					xor48 <= '0';
					muxin <= '0';
					muxout <= '0';
					sbox <= '0';
					keycom <= '0';
				  	s <= 193;
				when 193 =>
			 		ares <= '0';
				  	s <= 0;			    

--=========================== receive input data ============================ 
			    when 0 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 1;
			    when 1 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 2;
			    when 2 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 3;
			    when 3 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 4;
			    when 4 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 5;
			    when 5 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 6;
			    when 6 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 7;
			    when 7 => inbuffer <= '1'; keybuffer <= '1';
				  s <= 8;
			    when 8 => inbuffer <= '0'; keybuffer <= '0';
				  s <= 9;

--=========================== move data to muxin and build key 1 ============================ 
							
				when 9 => muxin <= '1'; keycom <= '1';
				  s <= 10;
			    when 10 => muxin <= '0'; keycom <= '0';
				  s <= 11;
			    when 11 => xor48 <= '1'; 
				  s <= 12;
			    when 12 => xor48 <= '0'; 
				  s <= 13;
			    when 13 => sbox <= '1';
				  s <= 14;
			    when 14 => sbox <= '0';
				  s <= 15;
			    when 15 => xor32 <= '1';
				  s <= 16;
			    when 16 => xor32 <= '0';
				  s <= 17;
			    when 17 => muxout <= '1';
				  s <= 18;
			    when 18 => muxout <= '0';
				  s <= 19;

--============================ End Round I ==========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 19 => muxin <= '1'; keycom <= '1';
				  s <= 20;
			    when 20 => muxin <= '0'; keycom <= '0';
				  s <= 21;
			    when 21 => xor48 <= '1'; 
				  s <= 22;
			    when 22 => xor48 <= '0'; 
				  s <= 23;
			    when 23 => sbox <= '1';
				  s <= 24;
			    when 24 => sbox <= '0';
				  s <= 25;
			    when 25 => xor32 <= '1';
				  s <= 26;
			    when 26 => xor32 <= '0';
				  s <= 27;
			    when 27 => muxout <= '1';
				  s <= 28;
			    when 28 => muxout <= '0';
				  s <= 29;

--============================ End Round II ==========================

--=========================== move data to muxin and build key 3 ============================ 

			    when 29 => muxin <= '1'; keycom <= '1';
				  s <= 30;
			    when 30 => muxin <= '0'; keycom <= '0';
				  s <= 31;
			    when 31 => xor48 <= '1'; 
				  s <= 32;
			    when 32 => xor48 <= '0'; 
				  s <= 33;
			    when 33 => sbox <= '1';
				  s <= 34;
			    when 34 => sbox <= '0';
				  s <= 35;
			    when 35 => xor32 <= '1';
				  s <= 36;
			    when 36 => xor32 <= '0';
				  s <= 37;
			    when 37 => muxout <= '1';
				  s <= 38;
			    when 38 => muxout <= '0';
				  s <= 39;

--============================ End Round III==========================

--=========================== move data to muxin and build key 4 ============================ 

			    when 39 => muxin <= '1'; keycom <= '1';
				  s <= 40;
			    when 40 => muxin <= '0'; keycom <= '0';
				  s <= 41;
			    when 41 => xor48 <= '1'; 
				  s <= 42;
			    when 42 => xor48 <= '0'; 
				  s <= 43;
			    when 43 => sbox <= '1';
				  s <= 44;
			    when 44 => sbox <= '0';
				  s <= 45;
			    when 45 => xor32 <= '1';
				  s <= 46;
			    when 46 => xor32 <= '0';
				  s <= 47;
			    when 47 => muxout <= '1';
				  s <= 48;
			    when 48 => muxout <= '0';
				  s <= 49;

--============================ End Round IV =========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 49 => muxin <= '1'; keycom <= '1';
				  s <= 50;
			    when 50 => muxin <= '0'; keycom <= '0';
				  s <= 51;
			    when 51 => xor48 <= '1'; 
				  s <= 52;
			    when 52 => xor48 <= '0'; 
				  s <= 53;
			    when 53 => sbox <= '1';
				  s <= 54;
			    when 54 => sbox <= '0';
				  s <= 55;
			    when 55 => xor32 <= '1';
				  s <= 56;
			    when 56 => xor32 <= '0';
				  s <= 57;
			    when 57 => muxout <= '1';
				  s <= 58;
			    when 58 => muxout <= '0';
				  s <= 59;

--============================ End Round V =========================
			    
--=========================== move data to muxin and build key 2 ============================ 

			    when 59 => muxin <= '1'; keycom <= '1';
				  s <= 60;
			    when 60 => muxin <= '0'; keycom <= '0';
				  s <= 61;
			    when 61 => xor48 <= '1'; 
				  s <= 62;
			    when 62 => xor48 <= '0'; 
				  s <= 63;
			    when 63 => sbox <= '1';
				  s <= 64;
			    when 64 => sbox <= '0';
				  s <= 65;
			    when 65 => xor32 <= '1';
				  s <= 66;
			    when 66 => xor32 <= '0';
				  s <= 67;
			    when 67 => muxout <= '1';
				  s <= 68;
			    when 68 => muxout <= '0';
				  s <= 69;

--============================ End Round VI ==========================
			    
--=========================== move data to muxin and build key 7 ============================ 

			    when 69 => muxin <= '1'; keycom <= '1';
				  s <= 70;
			    when 70 => muxin <= '0'; keycom <= '0';
				  s <= 71;
			    when 71 => xor48 <= '1'; 
				  s <= 72;
			    when 72 => xor48 <= '0'; 
				  s <= 73;
			    when 73 => sbox <= '1';
				  s <= 74;
			    when 74 => sbox <= '0';
				  s <= 75;
			    when 75 => xor32 <= '1';
				  s <= 76;
			    when 76 => xor32 <= '0';
				  s <= 77;
			    when 77 => muxout <= '1';
				  s <= 78;
			    when 78 => muxout <= '0';
				  s <= 79;

--============================ End Round VII ==========================
			    
--=========================== move data to muxin and build key 8  ============================ 

			    when 79 => muxin <= '1'; keycom <= '1';
				  s <= 80;
			    when 80 => muxin <= '0'; keycom <= '0';
				  s <= 81;
			    when 81 => xor48 <= '1'; 
				  s <= 82;
			    when 82 => xor48 <= '0'; 
				  s <= 83;
			    when 83 => sbox <= '1';
				  s <= 84;
			    when 84 => sbox <= '0';
				  s <= 85;
			    when 85 => xor32 <= '1';
				  s <= 86;
			    when 86 => xor32 <= '0';
				  s <= 87;
			    when 87 => muxout <= '1';
				  s <= 88;
			    when 88 => muxout <= '0';
				  s <= 89;

--============================ End Round II ==========================
			    
--=========================== move data to muxin and build key 9 ============================ 

			    when 89 => muxin <= '1'; keycom <= '1';
				  s <= 90;
			    when 90 => muxin <= '0'; keycom <= '0';
				  s <= 91;
			    when 91 => xor48 <= '1'; 
				  s <= 92;
			    when 92 => xor48 <= '0'; 
				  s <= 93;
			    when 93 => sbox <= '1';
				  s <= 94;
			    when 94 => sbox <= '0';
				  s <= 95;
			    when 95 => xor32 <= '1';
				  s <= 96;
			    when 96 => xor32 <= '0';
				  s <= 97;
			    when 97 => muxout <= '1';
				  s <= 98;
			    when 98 => muxout <= '0';
				  s <= 99;

--============================ End Round IX ==========================
			    

--=========================== move data to muxin and build key 10 ============================ 

			    when 99 => muxin <= '1'; keycom <= '1';
				  s <= 100;
			    when 100 => muxin <= '0'; keycom <= '0';
				  s <= 101;
			    when 101 => xor48 <= '1'; 
				  s <= 102;
			    when 102 => xor48 <= '0'; 
				  s <= 103;
			    when 103 => sbox <= '1';
				  s <= 104;
			    when 104 => sbox <= '0';
				  s <= 105;
			    when 105 => xor32 <= '1';
				  s <= 106;
			    when 106 => xor32 <= '0';
				  s <= 107;
			    when 107 => muxout <= '1';
				  s <= 108;
			    when 108 => muxout <= '0';
				  s <= 109;

--============================ End Round X ==========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 109 => muxin <= '1'; keycom <= '1';
				  s <= 110;
			    when 110 => muxin <= '0'; keycom <= '0';
				  s <= 111;
			    when 111 => xor48 <= '1'; 
				  s <= 112;
			    when 112 => xor48 <= '0'; 
				  s <= 113;
			    when 113 => sbox <= '1';
				  s <= 114;
			    when 114 => sbox <= '0';
				  s <= 115;
			    when 115 => xor32 <= '1';
				  s <= 116;
			    when 116 => xor32 <= '0';
				  s <= 117;
			    when 117 => muxout <= '1';
				  s <= 118;
			    when 118 => muxout <= '0';
				  s <= 119;

--============================ End Round XI ==========================

--=========================== move data to muxin and build key 2 ===== 

			    when 119 => muxin <= '1'; keycom <= '1';
				  s <= 120;
			    when 120 => muxin <= '0'; keycom <= '0';
				  s <= 121;
			    when 121 => xor48 <= '1'; 
				  s <= 122;
			    when 122 => xor48 <= '0'; 
				  s <= 123;
			    when 123 => sbox <= '1';
				  s <= 124;
			    when 124 => sbox <= '0';
				  s <= 125;
			    when 125 => xor32 <= '1';
				  s <= 126;
			    when 126 => xor32 <= '0';
				  s <= 127;
			    when 127 => muxout <= '1';
				  s <= 128;
			    when 128 => muxout <= '0';
				  s <= 129;

--============================ End Round XII ==========================

--=========================== move data to muxin and build key 3 ============================ 

			    when 129 => muxin <= '1'; keycom <= '1';
				  s <= 130;
			    when 130 => muxin <= '0'; keycom <= '0';
				  s <= 131;
			    when 131 => xor48 <= '1'; 
				  s <= 132;
			    when 132 => xor48 <= '0'; 
				  s <= 133;
			    when 133 => sbox <= '1';
				  s <= 134;
			    when 134 => sbox <= '0';
				  s <= 135;
			    when 135 => xor32 <= '1';
				  s <= 136;
			    when 136 => xor32 <= '0';
				  s <= 137;
			    when 137 => muxout <= '1';
				  s <= 138;
			    when 138 => muxout <= '0';
				  s <= 139;

--============================ End Round XIII ==========================

--=========================== move data to muxin and build key 4 ============================ 

			    when 139 => muxin <= '1'; keycom <= '1';
				  s <= 140;
			    when 140 => muxin <= '0'; keycom <= '0';
				  s <= 141;
			    when 141 => xor48 <= '1'; 
				  s <= 142;
			    when 142 => xor48 <= '0'; 
				  s <= 143;
			    when 143 => sbox <= '1';
				  s <= 144;
			    when 144 => sbox <= '0';
				  s <= 145;
			    when 145 => xor32 <= '1';
				  s <= 146;
			    when 146 => xor32 <= '0';
				  s <= 147;
			    when 147 => muxout <= '1';
				  s <= 148;
			    when 148 => muxout <= '0';
				  s <= 149;

--============================ End Round XIV =========================

--=========================== move data to muxin and build key 2 ============================ 

			    when 149 => muxin <= '1'; keycom <= '1';
				  s <= 150;
			    when 150 => muxin <= '0'; keycom <= '0';
				  s <= 151;
			    when 151 => xor48 <= '1'; 
				  s <= 152;
			    when 152 => xor48 <= '0'; 
				  s <= 153;
			    when 153 => sbox <= '1';
				  s <= 154;
			    when 154 => sbox <= '0';
				  s <= 155;
			    when 155 => xor32 <= '1';
				  s <= 156;
			    when 156 => xor32 <= '0';
				  s <= 157;
			    when 157 => muxout <= '1';
				  s <= 158;
			    when 158 => muxout <= '0';
				  s <= 159;

--============================ End Round XV =========================
			    
--=========================== move data to muxin and build key 2 ============================ 

			    when 159 => muxin <= '1'; keycom <= '1';
				  s <= 160;
			    when 160 => muxin <= '0'; keycom <= '0';
				  s <= 161;
			    when 161 => xor48 <= '1'; 
				  s <= 162;
			    when 162 => xor48 <= '0'; 
				  s <= 163;
			    when 163 => sbox <= '1';
				  s <= 164;
			    when 164 => sbox <= '0';
				  s <= 165;
			    when 165 => xor32 <= '1';
				  s <= 166;
			    when 166 => xor32 <= '0';
				  s <= 167;
			    when 167 => muxout <= '1';
				  s <= 168;
			    when 168 => muxout <= '0';
				  s <= 169;

--============================ End Round XVI Final ==========================

--============================ Output Buffer ==========================--


			    when 169 => outbuffer <= '1';
				  s <= 170;
			    when 170 => outbuffer <= '0';
				  s <= 171;
			    when 171 => outbuffer <= '1';
				  s <= 172;
			    when 172 => outbuffer <= '0';
				  s <= 173;
			    when 173 => outbuffer <= '1';
				  s <= 174;
			    when 174 => outbuffer <= '0';
				  s <= 175;
			    when 175 => outbuffer <= '1';
				  s <= 176;
			    when 176 => outbuffer <= '0';
				  s <= 177;
				when others =>
						s <= 177;
		     end case;  ----- state
		  end if;   ---- rising edge
	
    end process;
end descontrol;

--===================================  maindes =====================
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity maindes is
	port (datain,keyin : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(15 downto 0);
	      clk,reset,deen : in std_logic);
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
		 sbox      : out std_logic;
		 keycom    : out std_logic);
      
end component;

component xor32
	port (dataina,datainb : in std_logic_vector(31 downto 0);
	      dataout : out std_logic_vector(31 downto 0);
	      clk : in std_logic);
end  component;

component xor48
	port (dataina,datainb : in std_logic_vector(47 downto 0);
	      dataout : out std_logic_vector(47 downto 0);
	      clk : in std_logic);
end  component;

component inbuffer
	port (datain : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  component;

component outbuffer
	port (datain : in std_logic_vector(63 downto 0);
	      dataout : out std_logic_vector(15 downto 0);
	      clk,reset : in std_logic);
end  component;

component keybuffer
	port (datain : in std_logic_vector(15 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  component;

component muxin
	port (datain,dataloop : in std_logic_vector(63 downto 0);
	      dataout : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  component;

component muxout
	port (datain : in std_logic_vector(63 downto 0);
	      dataout,dataloop : out std_logic_vector(63 downto 0);
	      clk,reset : in std_logic);
end  component;

component permute
	port (i : in std_logic_vector(64 downto 1);
	      o : out std_logic_vector(64 downto 1));
      
end  component;

component depermute
	port (i : in std_logic_vector(64 downto 1);
	      o : out std_logic_vector(64 downto 1));
      
end  component;

component sbox
	port (i : in std_logic_vector(1 to 48);
	      clk : in std_logic;
	      o : out std_logic_vector(1 to 32));
      
end component;

component exp
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 48));
      
end  component;

component pp
	port (i : in std_logic_vector(1 to 32);
	      o : out std_logic_vector(1 to 32));
      
end  component;

component keycom
	port (i : in std_logic_vector(1 to 64);
	      k : out std_logic_vector(1 to 48);
	      clk,reset,deen : in std_logic);
      
end  component;


signal  in64,key64,out64,pin64,depout64,indes64,turndes:std_logic_vector(1 to 64);
signal  tmptomuxout:std_logic_vector(1 to 64);
signal  outexp48,tosbox48,turnkey:std_logic_vector(1 to 48);
signal  toppbox32,toxor32,tomuxout32,tmptoexp:std_logic_vector(1 to 32);
signal  allreset,inbufck,outbufck,keybufck,xor32ck,xor48ck:std_logic;
signal  muxinck,muxoutck,sboxck,keycomck:std_logic;


begin
	tmptomuxout <= indes64(33 to 64)&tomuxout32;
	tmptoexp <= indes64(33 to 64);

	s1:des port map (clk,reset,allreset,inbufck,outbufck,keybufck,xor32ck
			,xor48ck,muxinck,muxoutck,sboxck,keycomck);
	s2:inbuffer port map (datain,in64,inbufck,allreset);
	s3:permute port map (in64,pin64);
	s4:depermute port map (out64,depout64);
	s5:outbuffer port map (depout64,dataout,outbufck,allreset);
	s6:keybuffer port map (keyin,key64,keybufck,allreset);
	s7:muxin port map (pin64,turndes,indes64,muxinck,allreset);
	s8:muxout port map (tmptomuxout,out64,turndes,muxoutck,allreset);
	s9:exp port map (tmptoexp,outexp48);
	s10:xor48 port map (outexp48,turnkey,tosbox48,xor48ck);
	s11:keycom port map (key64,turnkey,keycomck,allreset,deen);
	s12:sbox port map (tosbox48,sboxck,toppbox32);
	s13:pp port map (toppbox32,toxor32);
	s14:xor32 port map (indes64(1 to 32),toxor32,tomuxout32,xor32ck);
	   
end chipdes;
