library IEEE;
use IEEE.std_logic_1164.all;

entity Clock_generator is
     port (
               clk      : in std_logic;
               reset    : in std_logic;
               Mreset   : in std_logic;
               start    : in std_logic;
               CS       : in std_logic;
               WR       : in std_logic;
               SCL      : in std_logic;
               control  : in std_logic_vector(7 downto 0);
               clk_1    : out std_logic;
               clk_2    : out std_logic;
               clk_23   : out std_logic
          );
end Clock_generator;

architecture Clock_gen of Clock_generator is
signal count     : integer range 0 to 31;
signal Ncount    : integer range 0 to 7;
signal Nclk_1    : std_logic;
signal Nclk_2    : std_logic;
signal Nclk_23   : std_logic;
begin
        --Generate Clock

        AD : Process (reset,start,CS,WR,control,clk)
        Begin
                If reset = '0' or (start = '0' and CS = '0' and WR = '0' and control(2 downto 1) = "10") then
                    count  <= 0;
                    clk_1  <= '0';
                    clk_2  <= '0';
                    clk_23 <= '0';
                Elsif clk'event and clk = '1' then
                    count  <= Ncount;
                    clk_1  <= Nclk_1;
                    clk_2  <= Nclk_2;
                    clk_23 <= Nclk_23;
                End if;
        End Process;

        Process(count,scl)
        Begin
                If (scl = '1' and count = 0) then
                    Ncount <= 1;
                Elsif count = 1 then
                    Ncount <= 2;
                Elsif count = 2 then
                    Ncount <= 3;
                Elsif count = 3 then
                    Ncount <= 4;
                Elsif scl = '0' and count = 4 then
                    Ncount <= 5;
                Elsif count = 5 then
                    Ncount <= 6;
                Elsif count = 6 then
                    Ncount <= 0;
                Else
                    Ncount <= count;
                End If;
        End Process;

        Process(count)
        Begin
                If count = 1 then
                    Nclk_1 <= '1';
                Else
                    Nclk_1 <= '0';
                End If;
        End Process;

        Process(count)
        Begin
                If count = 3 then
                    Nclk_2 <= '1';
                Else
                    Nclk_2 <= '0';
                End If;
        End Process;

        Process(count)
        Begin
                If (count = 3) or (count = 5) then
                    Nclk_23 <= '1';
                Else
                    Nclk_23 <= '0';
                End If;
        End Process;
end Clock_gen;


--Shift In Control------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Shift_in_con is
     port (
               reset  : in std_logic;
               Mreset : in std_logic;
               clk_1  : in std_logic;
               S      : in std_logic;
               start  : in std_logic;
               SDA    : in std_logic;
               sitmp  : out std_logic_vector (7 downto 0);
               shift_in : out std_logic_vector (7 downto 0);
               state_si : out integer range 0 to 15
          );
end Shift_in;

architecture Shiftin of Shift_in_con is
--Shift In Control---------------
signal LRB       : std_logic;
signal Nstate_si : integer range 0 to 15;
signal NLRB      : std_logic;
signal Nsitmp    : std_logic_vector(7 downto 0);
begin

        --Shift In Process
        AE : Process(reset,start,clk_1,S)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    state_si <= 0;
                    sitmp    <= "00000000";
                    LRB      <= '0';
                Elsif clk_1'event and clk_1 = '1' then
                    state_si <= Nstate_si;
                    sitmp    <= Nsitmp;
                    LRB      <= NLRB;
                End if;
        End Process;

        
        Process(reset,clk_1)
        Begin
                If reset = '0' then
                    shift_in <= "00000000";
                Elsif clk_1'event and clk_1 = '1' then
                    shift_in <= Nshift_in;
                End if;
        End Process;

        Process(state_si,sda)
        Begin
                If state_si = 9 then
                    Nstate_si <= 1;
                Else
                    Nstate_si <= state_si + 1;
                End if;
                NLRB  <= sda;
        End Process;

        Process(state_si,sitmp,sda,shift_in)
        Begin
                If state_si = 8 then
                    Nsitmp    <=  sitmp;
                    Nshift_in <= sitmp;
                Else
                    Nsitmp(7 downto 1) <= sitmp(6 downto 0);
                    Nsitmp(0)          <= sda;
                    Nshift_in          <= shift_in;
                End if;
        End Process;
end Shiftin;

---Compare Address------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Compare_add is
     port (
               reset  : in std_logic;
               Mreset : in std_logic;
               clk_2  : in std_logic;
               S      : in std_logic;
               start  : in std_logic;
               own_adr  : in std_logic_vector (7 downto 0);
               sitmp    : in std_logic_vector (7 downto 0);
               state_si : in integer range 0 to 15;
               detect   : out std_logic;
               wr_rd    : out std_logic
          );
end Compare_add;

architecture Compart_add1 of Compare_add is
signal state_comp  : std_logic;
signal Nstate_comp : std_logic;
signal Ndetect     : std_logic;
signal Nwr_rd      : std_logic;
begin
        --Compare Address
        AF : Process(reset,start,clk_2,S)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    state_comp <= '0';
                    detect     <= '0';
                    wr_rd      <= '0';
                Elsif clk_2'event and clk_2 = '1' then
                    state_comp <= Nstate_comp;
                    detect     <= Ndetect;
                    wr_rd      <= Nwr_rd;
                End if;
        End Process;

        Process(state_comp,state_si)
        Begin
                If state_comp = '0' and state_si = 8 then
                    Nstate_comp <= '1';
                Else
                    Nstate_comp <= state_comp;
                End if;
        End Process;

        Process(state_comp,state_si,sitmp,wr_rd)
        Begin
                If state_comp = '0' and state_si = 8 then
                    Nwr_rd  <= sitmp(0);
                Else
                    Nwr_rd      <= wr_rd;
                End if;
        End Process;

        Process(state_comp,state_si,sitmp,own_adr,detect)
        Begin
                If state_comp = '0' and state_si = 8 then
                    If sitmp(7 downto 1) = own_adr(6 downto 0) then
                        Ndetect <= '1';
                    Else
                        Ndetect <= '0';
                    End if;
                Else
                    Ndetect     <= detect;
                End if;
        End Process;
end Compare_add1;

library IEEE;
use IEEE.std_logic_1164.all;

entity Shiftout_con is
     port (
               reset  : in std_logic;
               Mreset : in std_logic;
               clk_23 : in std_logic;
               SCL    : in std_logic;
               SDA    : in std_logic;
               detect : in std_logic;
               wr_rd  : in std_logic;
               LAB    : in std_logic;
               lack   : in std_logic;
               control   : in std_logic_vector (7 downto 0);
               shift_out : in std_logic_vector (7 downto 0);
               state_si  : in integer range 0 to 15;
               sdotmp    : out std_logic
          );
end Shiftout_con;

architecture Shiftout_con1 of Shiftout_con is
---Shift Out Control----------------
signal state_so  : integer range 0 to 31;
signal lack      : std_logic;
signal Nstate_so : integer range 0 to 31;
signal Nsdaotmp  : std_logic;
signal Nlack     : std_logic;
begin
        --Shift Out Control
        AG : Process(reset,LAB,clk_23)
        Begin
                If reset = '0' or LAB = '1' then
                    state_so <= 0;
                    sdaotmp  <= '1';
                Elsif clk_23'event and clk_23 = '1' then
                    state_so <= Nstate_so;
                    sdaotmp  <= Nsdaotmp;
                End if;
        End Process;

        Process(reset,control,state_so,state_si,detect,scl,wr_rd,sda,lack)
        Begin
                If reset = '0' then
                    Nstate_so <= 0;
                Elsif (state_so = 0 and control(2 downto 1) = "10" and scl = '1') then
                    Nstate_so <= 1;
                Elsif (state_so = 0 and detect = '1' and state_si = 8 and scl = '0')
                   or (state_so = 24 and lack = '0' and scl = '1') then
                    Nstate_so <= 15;
                Elsif (state_so = 1  and scl = '0') then
                    Nstate_so <= 2;
                Elsif (state_so = 2  and scl = '0') then
                    Nstate_so <= 3;
                Elsif (state_so = 3  and scl = '0') then
                    Nstate_so <= 4;
                Elsif (state_so = 4  and scl = '0') then
                    Nstate_so <= 5;
                Elsif (state_so = 5  and scl = '0') then
                    Nstate_so <= 6;
                Elsif (state_so = 6  and scl = '0') then
                    Nstate_so <= 7;
                Elsif (state_so = 7  and scl = '0') then
                    Nstate_so <= 8;
                Elsif (state_so = 8  and scl = '0') then
                    Nstate_so <= 9;
                Elsif (state_so = 9  and scl = '0') then
                    Nstate_so <= 10;
                Elsif (state_so = 10  and control(2 downto 1) = "10" and wr_rd = '0' and scl = '0') then
                    Nstate_so <= 11;
                Elsif (state_so = 10  and control(2 downto 1) = "00" and wr_rd = '0' and scl = '0') then
                    Nstate_so <= 2;
                Elsif ((state_so = 10 or state_so = 13) and control(2 downto 1) = "01"  and scl = '0') then
                    Nstate_so <= 12;
                Elsif ((state_so = 10 or state_so = 14) and wr_rd = '1' and scl = '0' and state_si = 8) then
                    Nstate_so <= 13;
                Elsif (state_so = 11 and scl = '1') then
                    Nstate_so <= 1;
                Elsif (state_so = 12 and scl = '1')
                   or (state_so = 24 and lack = '1' and scl = '1')
                   or (state_so = 15 and wr_rd = '0' and scl = '0') then
                    Nstate_so <= 0;
                Elsif (state_so = 13 and scl = '0') then
                    Nstate_so <= 14;
                Elsif (state_so = 15 and wr_rd = '1' and scl = '0') then
                    Nstate_so <= 16;
                Elsif (state_so = 16 and scl = '0') then
                    Nstate_so <= 17;
                Elsif (state_so = 17 and scl = '0') then
                    Nstate_so <= 18;
                Elsif (state_so = 18 and scl = '0') then
                    Nstate_so <= 19;
                Elsif (state_so = 19 and scl = '0') then
                    Nstate_so <= 20;
                Elsif (state_so = 20 and scl = '0') then
                    Nstate_so <= 21;
                Elsif (state_so = 21 and scl = '0') then
                    Nstate_so <= 22;
                Elsif (state_so = 22 and scl = '0') then
                    Nstate_so <= 23;
                Elsif (state_so = 23 and scl = '0') then
                    Nstate_so <= 24;
                Else
                    Nstate_so <= state_so;
                End if;
        End Process;

        Process(reset,state_so,state_si,scl,wr_rd,sdaotmp,control,shift_out)
        Begin
                If (reset = '0')
                or ((state_so = 9 or state_so = 23) and scl = '0')
                or (state_so = 10  and control(2 downto 1) = "10" and wr_rd = '0' and scl = '0')
                or (state_so = 12 and scl = '1')
                or (state_so = 15 and wr_rd = '0'and scl = '0')
                or (state_so = 13 and scl = '0' and not(control(2 downto 1) = "01")) then
                    Nsdaotmp <= '1';
                Elsif ((state_so = 0 or state_so = 11) and control(2 downto 1) = "10" and scl = '1')
                   or ((state_so = 10 or state_so = 13)  and control(2 downto 1) = "01" and scl = '0') then
                    Nsdaotmp <= '0';
                Elsif (state_so = 1 and scl = '0')
                   or (state_so = 10 and control(2 downto 1)= "00" and scl = '0' and wr_rd = '0')
                   or (state_so = 15 and wr_rd = '1' and scl = '0') then
                    Nsdaotmp <= shift_out(7);
                Elsif ((state_so = 2 or state_so = 16) and scl = '0') then
                    Nsdaotmp <= shift_out(6);
                Elsif ((state_so = 3 or state_so = 17) and scl = '0') then
                    Nsdaotmp <= shift_out(5);
                Elsif ((state_so = 4 or state_so = 18) and scl = '0') then
                    Nsdaotmp <= shift_out(4);
                Elsif ((state_so = 5 or state_so = 19) and scl = '0') then
                    Nsdaotmp <= shift_out(3);
                Elsif ((state_so = 6 or state_so = 20) and scl = '0') then
                    Nsdaotmp <= shift_out(2);
                Elsif ((state_so = 7 or state_so = 21) and scl = '0') then
                    Nsdaotmp <= shift_out(1);
                Elsif ((state_so = 8 or state_so = 22) and scl = '0') then
                    Nsdaotmp <= shift_out(0);
                Elsif ((state_so = 10 or state_so = 14) and wr_rd = '1' and state_si = 8 and scl = '0')
                   or (state_so = 0 and detect = '1' and state_si = 8 and scl = '0') then
                    Nsdaotmp <= not(control(0));
                Else
                    Nsdaotmp <= sdaotmp;
                End if;
        End Process;
end Shiftout_con1;

library IEEE;
use IEEE.std_logic_1164.all;

entity Lack is
     port (
               reset  : in std_logic;
               Mreset : in std_logic;
               clk_2  : in std_logic;
               SDA    : in std_logic;
               SCL    : in std_logic;
               state_si : in integer range 0 to 15;
               lack     : out std_logic
          );
end Lack;

architecture Lack1 of Lack is
signal Nlack   : std_logic;
begin
        --Lack Process
        Process(reset,clk_2)
        Begin
                If reset = '0' then
                    Lack <= '0';
                Elsif clk_2'event and clk_2 = '1' then
                    lack <= Nlack;
                End if;
        End Process;

        Process(reset,state_si,scl,sda,Lack)
        Begin
                If reset = '0' then
                    Nlack <= '0';
                Elsif (state_si = 9 and scl = '1') then
                    Nlack <= sda;
                Else
                    Nlack <= Lack;
                End if;
        End Process;
end Lack1;

library IEEE;
use IEEE.std_logic_1164.all;

entity SCL_generator of
     port (
               reset  : in std_logic;
               Mreset : in std_logic;
               clk    : in std_logic;
               LAB    : in std_logic;
               SCL    : in std_logic;
               P      : in std_logic;
               control  : in std_logic_vector(7 downto 0);
               clk_reg  : in std_logic_vector(7 downto 0);
               sclotmp  : out std_logic
          );
end SCL_generator;

architecture SCL_gen of SCL_generator is
signal state_scl  : std_logic;
signal Nstate_scl : std_logic;
signal clktmp     : std_logic_vector(7 downto 0);
signal Nclktmp    : std_logic_vector(7 downto 0);
begin
        --SCL Generator
        Process(reset,P,LAB,clk)
        Begin
                If reset = '0' or P = '1' or LAB = '1' then
                    state_scl <= '0';
                    clktmp    <= "11111111";
                    sclotmp   <= '1';
                Elsif clk'event and clk = '1' then
                    state_scl <= Nstate_scl;
                    clktmp    <= Nclktmp;
                    sclotmp   <= Nsclotmp;
                End if;
        End Process;

        Process(state_scl,control)
        Begin
                If (state_scl = '0' and control(2 downto 1) = "10")
                or (state_scl = '1') then
                    Nstate_scl <= '1';
                Else
                    Nstate_scl <= state_scl;
                End if;
        End Process;

        Process(state_scl,control,clktmp,clk_reg,sclotmp,scl)
        Begin
                If (state_scl = '0' and control(2 downto 1) = "10")
                or (state_scl = '1' and clktmp = "00000001") then
                    Nclktmp <= clk_reg;
                Elsif (state_scl = '1' and sclotmp = scl) then
                    Nclktmp(0) <= clktmp(0) xor '1';
                    Nclktmp(1) <= clktmp(1) xor not(clktmp(0));
                    Nclktmp(2) <= clktmp(2) xor not(clktmp(0) or clktmp(1));
                    Nclktmp(3) <= clktmp(3) xor not(clktmp(0) or clktmp(1) or clktmp(2));
                    Nclktmp(4) <= clktmp(4) xor not(clktmp(0) or clktmp(1) or clktmp(2) or clktmp(3));
                    Nclktmp(5) <= clktmp(5) xor not(clktmp(0) or clktmp(1) or clktmp(2) or clktmp(3) or clktmp(4));
                    Nclktmp(6) <= clktmp(6) xor not(clktmp(0) or clktmp(1) or clktmp(2) or clktmp(3) or clktmp(4) or clktmp(5));
                    Nclktmp(7) <= clktmp(7) xor not(clktmp(0) or clktmp(1) or clktmp(2) or clktmp(3) or clktmp(4) or clktmp(5) or clktmp(6));
                Else
                    Nclktmp <= clktmp;
                End if;
        End Process;

        Process(state_scl,clktmp,sclotmp)
        Begin
                If (state_scl = '1' and clktmp = "00000001") then
                    Nsclotmp <= not(sclotmp);
                Else
                    Nsclotmp <= sclotmp;
                End if;
        End Process;
end SCL_gen;

library IEEE;
use IEEE.std_logic_1164.all;

entity Status_reg of
     port (
               -- PIN Bit
               reset  : in std_logic;
               Mreset : in std_logic;
               clk    : in std_logic;
               STS    : in std_logic;
               wr_rd  : in std_logic;
               CS     : in std_logic;
               WR     : in std_logic;
               RD     : in std_logic;
               A1A0   : in std_logic_vector(2 downto 0);
               state_si  : in integer range 0 to 15;
               status(7) : out std_logic;

               -- LAB Bit
               reset   : in std_logic;
               Mreset  : in std_logic;
               clk     : in std_logic;
               SDA     : in std_logic;
               sdaotmp : in std_logic;
               start   : in std_logic;
               control : in std_logic_vector(7 downto 0);
               control : in std_logic_vector(7 downto 0);
               control : in std_logic_vector(7 downto 0);
               state_so  : in integer range 0 to 31;
               LAB       : out std_logic;

               -- STS Bit
               P       : in std_logic;
               wr_rd   : in std_logic;
               control : in std_logic_vector(7 downto 0);
               STS     : out std_logic
          );
end Status_reg;

architecture Status1 of Status_reg is
signal S    : std_logic;
signal pin  : std_logic;
signal sts  : std_logic;
signal lab  : std_logic;
signal Nlab : std_logic;
signal master  : std_logic;
signal Nmaster : std_logic;
---Pin bit
signal state_pin  : std_logic_vector(1 downto 0);
signal Nstate_pin : std_logic_vector(1 downto 0);
------------------------------------
begin
        ---PIN Bit
        Process(reset,start,s,clk)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    state_pin <= "00";
                    status(7) <= '1';
                Elsif clk'event and clk = '1' then
                    state_pin <= Nstate_pin;
                    status(7) <= pin;
                End if;
        End Process;

        Process(state_pin,state_si,cs,wr,rd)
        Begin
                If (state_pin = "00" and state_si = 9) or (STS = '1') then
                    Nstate_pin <= "01";
                Elsif (state_pin = "01" and cs = '0' and (wr and rd) = '0') then
                    Nstate_pin <= "10";
                Elsif (state_pin = "10" and state_si = 1) then
                    Nstate_pin <= "00";
                Else
                    Nstate_pin <= state_pin;
                End if;
        End Process;

        Process(status,state_si,cs,wr,rd)
        Begin
                If (state_pin = "00" and state_si = 9) then
                    pin <= '0';
                Elsif (state_pin = "01" and cs = '0' and (wr and rd) = '0') then
                    pin <= '1';
                Else
                    pin <= status(7);
                End if;
        End Process;

--*********************************************************

        --STS Bit
        Process(p,control,wr_rd)
        Begin
                If (p = '1' and not(control(2 downto 1) = "01") and wr_rd = '0') then
                    sts <= '1';
                Else
                    sts <= '0';
                End if;
        End Process;

--*********************************************************

        --LAB Bit
        Process(reset,start,clk)
        Begin
                If reset = '0' or start = '0' then
                    lab <= '0';
                    master <= '0';
                Elsif clk'event and clk = '1' then
                    lab <= Nlab;
                    master <= Nmaster;
                End if;
        End Process;

        Process(lab,sda,sdaotmp,state_so)
        Begin
                If lab = '0' and sda = '0' and sdaotmp = '1' and
                   not(state_so = 10 or state_so = 24)  and master = '1' then
                    Nlab <= '1';
                Else
                    Nlab <= lab;
                End if;
        End Process;

        Process(master,start,control,shift_out)
        Begin
                If master = '0' and start = '1' and control(2 downto 1) = "10"
                and shift_out(0) = '0' then
                    Nmaster <= '1';
                Elsif start = '0' then
                    Nmaster <= '0';
                Else
                    Nmaster <= master;
                End if;
        End Process;
end Status1;

library IEEE;
use IEEE.std_logic_1164.all;

entity Write of
     port (
		reset            : in std_logic;
		Wreg_clk    : in std_logic;
		A1A0	     : in std_logic;
		data	     : in std_logic_vector(7 downto 0);
		control        : in std_logic_vector(7 downto 0);
		shift_out     : in std_logic_vector(7 downto 0);
		own_adr      : in std_logic_vector(7 downto 0);
		clk_reg        : in std_logic_vector(7 downto 0);
		data	     : out std_logic_vector(7 downto 0);
		control         : out std_logic_vector(7 downto 0);
		shift_out      : out std_logic_vector(7 downto 0);
		own_adr      : out std_logic_vector(7 downto 0);
		clk_reg        : out std_logic_vector(7 downto 0)
          );
end Write;

architecture Write_con of Write is
signal state_scl  : std_logic;
signal Nstate_scl : std_logic;
signal clktmp     : std_logic_vector(7 downto 0);
signal Nclktmp    : std_logic_vector(7 downto 0);
begin
        --Write Process
        Process(reset,WReg_clk)
        Begin
                If reset = '0' then
                    control   <= "00001001";
                    shift_out <= "11001100";
                    own_adr   <= "01010101";
                    clk_reg   <= "11110000";
                ElsIf WReg_clk'event and WReg_clk = '0' then
                    control   <= Ncontrol;
                    shift_out <= Nshift_out;
                    own_adr   <= Nown_adr;
                    clk_reg   <= Nclk_reg;
        	End if;
        End Process;
        	
        Process(reset,A1A0,data,control)
        Begin
                If reset = '0' then
                    Ncontrol <= "00000001";
                Elsif A1A0 = "00" then
                    Ncontrol <= data;
                Else
                    Ncontrol <= control;
                End if;
        End Process;

        Process(reset,A1A0,data,shift_out)
        Begin
                If reset = '0' then
                    Nshift_out <= "11001100";
                Elsif A1A0 = "01" then
                    Nshift_out <= data;
                Else
                    Nshift_out <= shift_out;
                End if;
        End Process;

        Process(reset,A1A0,data,own_adr)
        Begin
                If reset = '0' then
                    Nown_adr <= "01010101";
                Elsif A1A0 = "10" then
                    Nown_adr <= data;
                Else
                    Nown_adr <= own_adr;
                End if;
        End Process;

        Process(reset,A1A0,data,clk_reg)
        Begin
                If reset = '0' then
                    Nclk_reg <= "00001000";
                Elsif A1A0 = "11" then
                    Nclk_reg <= data;
                Else
                    Nclk_reg <= clk_reg;
                End if;
        End Process;
end Write_con;

library IEEE;
use IEEE.std_logic_1164.all;

entity Read of
     port (
               RReg_clk : in std_logic;
               A1A0     : in std_logic_vector(2 downto 0);
               status   : in std_logic_vector(7 downto 0);
               clk_reg  : in std_logic_vector(7 downto 0);
               own_adr  : in std_logic_vector(7 downto 0);
               shift_in : in std_logic_vector(7 downto 0);
               DATA     : out std_logic_vector(7 downto 0);
          );
end Read;

architecture RD_con of Read is
signal datatmp    : std_logic_vector(7 downto 0);
begin
        --Read Process
        Process(A1A0,status,shift_in,own_adr,clk_reg)
        Begin
                Case A1A0 is
                    When "00"  => datatmp <= status;
                    When "01"  => datatmp <= shift_in;
                    When "10"  => datatmp <= own_adr;
                    When "11"  => datatmp <= clk_reg;
                    when others => datatmp <= "00000000";
                End case;
        End Process;

        Process(RReg_clk)
        Begin
                If RReg_clk = '1' then
                    data <= "ZZZZZZZZ";
                Else
                    data <= datatmp;
                End if;
        End Process;
end Rd_con;
