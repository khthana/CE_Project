library IEEE;
use IEEE.std_logic_1164.all;

Entity Detect_S is
     port (
               SDA   : in std_logic;
               SCL   : in std_logic;
               reset : in std_logic;
               S     : out std_logic
          );
end Detect_S;

architecture Detect_S1 of Detect_S is
begin
        -- Start Process
        AA : Process (sda,scl,reset)
        Begin
                If reset = '0' or scl = '0' then
                        S <= '0';
                Elsif sda'event and sda = '0' then
                        S <= '1';
                End if;
        End Process;
end Detect_S1;


library IEEE;
use IEEE.std_logic_1164.all;

Entity Detect_P is
     port (
               SDA   : in std_logic;
               SCL   : in std_logic;
               reset : in std_logic;
               S     : in std_logic;
               P     : out std_logic
          );
end Detect_P;

architecture Detect_P1 of Detect_P is
begin
        -- Stop Process
        AB : Process (sda,scl,reset,S)
        Begin
                If reset = '0' or scl = '0' or S = '1' then
                        P <= '0';
                Elsif sda'event and sda = '1' then
                        P <= '1';
                End if;
        End Process;
end Detect_P1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Remember_S is
     port (
               clk   : in std_logic;
               reset : in std_logic;
               S     : in std_logic;
               P     : in std_logic;
               start : out std_logic
          );
end Remember_S;

architecture Remember_S1 of Remember_S is
begin
        -- Remember Start Process
        AC : Process (reset,clk)
        Begin
                If reset = '0' then
                    start <= '0';
                Elsif clk'event and clk = '1' then
                    start <= Nstart;
                End if;
        End Process;

        Process (S,P,start)
        Begin
                If S = '1' then
                    Nstart <= '1';
                Elsif P = '1' then
                    Nstart <= '0';
                Else
                    Nstart <= start;
                End if;
        End Process;
end Remember_S1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Clock_generator is
     port (
               clk      : in std_logic;
               reset    : in std_logic;
               S        : in std_logic;
               start    : in std_logic;
               si_clk   : out std_logic;
               comp_clk : out std_logic;
               adr_clk  : out std_logic;
               wr_clk   : out std_logic;
               so_clk   : out std_logic;
               get_clk  : out std_logic;
          );
end Clock_generator;

architecture Clock_gen of Clock_generator is
signal count     : integer range 0 to 31;
signal Ncount    : integer range 0 to 31;
signal Nsi_clk   : std_logic;
signal Ncomp_clk : std_logic;
signal Nadr_clk  : std_logic;
signal Nwr_clk   : std_logic;
signal Nso_clk   : std_logic;
signal Ngd_clk   : std_logic;
begin
        --Generate Clock

        AD : Process (reset,clk,start,S)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    count    <= 0;
                    si_clk   <= '0';
                    comp_clk <= '0';
                    adr_clk  <= '0';
                    wr_clk   <= '0';
                    so_clk   <= '0';
                    gd_clk   <= '0';       ---get data after read from memory
                Elsif clk'event and clk = '1' then
                    count    <= Ncount;
                    si_clk   <= Nsi_clk;
                    comp_clk <= Ncomp_clk;
                    adr_clk  <= Nadr_clk;
                    wr_clk   <= Nwr_clk;
                    so_clk   <= Nso_clk;
                    gd_clk   <= Ngd_clk;
                End if;
        End Process;

        Process(count,scl)                 ---Ncount
        Begin
                If scl = '1' and count = 0 then
                    Ncount    <= 1;
                Elsif count = 1 then
                    Ncount    <= 2;
                Elsif count = 2 then
                    Ncount    <= 3;
                Elsif count = 3 then
                    Ncount    <= 4;
                Elsif count = 4 then
                    Ncount    <= 5;
                Elsif count = 5 then
                    Ncount    <= 6;
                Elsif scl = '0' and count = 6 then
                    Ncount    <= 7;
                Elsif count = 7 then
                    Ncount    <= 0;
                Else
                    Ncount    <= count;
                End If;
        End Process;

        Process(count,scl)                 ---Nsi_clk
        Begin
                If scl = '1' and count = 0 then
                    Nsi_clk   <= '1';
                Else
                    Nsi_clk   <= '0';
                End If;
        End Process;

        Process(count,scl)                 ---Ncomp_clk
        Begin
                If count = 1 then
                    Ncomp_clk <= '1';
                Else
                    Ncomp_clk <= '0';
                End If;
        End Process;

        Process(count,scl)                 ---Nadr_clk
        Begin
                If count = 2 then
                    Nadr_clk  <= '1';
                Else
                    Nadr_clk  <= '0';
                End If;
        End Process;

        Process(count,scl)                 ---Nwr_clk
        Begin
                If count = 3 or count = 5 then
                    Nwr_clk   <= '1';
                Else
                    Nwr_clk   <= '0';
                End If;
        End Process;

        Process(count,scl)                 ---Ngd_clk
        Begin
                If count = 4 then
                    Ngd_clk   <= '1';
                Else
                    Ngd_clk   <= '0';
                End If;
        End Process;

        Process(count,scl)                 ---Nso_clk
        Begin
                If count = 7 then
                    Nso_clk   <= '1';
                Else
                    Nso_clk   <= '0';
                End If;
        End Process;
end Clock_gen;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Shiftin_con is
     port (
               SDA    : in std_logic;
               detect : in std_logic;
               si_clk : in std_logic;
               S      : in std_logic;
               start  : in std_logic;
               reset  : in std_logic;
               LRB    : out std_logic;
               shift_in : out std_logic_vector(7 downto 0);
               state_si : out integer range 0 to 15
          );
end Shiftin_con;

architecture Shift_in1 of Shiftin_con is
signal Nstate_si : integer range 0 to 15;
signal Nshift_in : std_logic_vector(7 downto 0);
signal NLRB      : std_logic;
begin
        --Shift In Process
        AE : Process(reset,start,si_clk,S)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    state_si <= 0;
                    shift_in <= "00000000";
                    LRB      <= '0';
                Elsif si_clk'event and si_clk = '1' then
                    state_si <= Nstate_si;
                    shift_in <= Nshift_in;
                    LRB      <= NLRB;
                End if;
        End Process;

        Process(state_si,shift_in,sda,detect,wr_rd)
        Begin
                If state_si = 9 then
                    Nstate_si <= 1;
                Elsif state_si = 8 then
                    If detect = '1' then
                        Nstate_si <= 9;
                    Else
                        Nstate_si <= 8;
                    End if;
                Else
                    Nstate_si <= state_si + 1;
                End if;
                NLRB  <= sda;
        End Process;

        Process(state_si,shift_in,sda,detect,wr_rd)
        Begin
                If state_si = 8 then
                    Nshift_in <= shift_in;
                Else
                    Nshift_in(7 downto 1) <= shift_in(6 downto 0);
                    Nshift_in(0) <= sda;
                End if;
        End Process;
end Shift_in;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Compare_address is
     port (
               start    : in std_logic;
               comp_clk : in std_logic;
               reset    : in std_logic;
               S        : in std_logic;
               state_si : in integer range 0 to 15;
               shift_in : in std_logic_vector(7 downto 0);
               detect   : out std_logic;
               wr_rd    : out std_logic
          );
end Compare_address;

architecture Compare_address1 of Compare_address is
signal state_comp  : std_logic;
signal Nstate_comp : std_logic;
signal Ndetect     : std_logic;
signal Nwr_rd      : std_logic;
begin
        --Compare Address
        AF : Process(reset,start,comp_clk,S)
        Begin
                If reset = '0' or start = '0' or S = '1' then
                    state_comp <= '0';
                    detect     <= '0';
                    wr_rd      <= '0';
                Elsif comp_clk'event and comp_clk = '1' then
                    state_comp <= Nstate_comp;
                    detect     <= Ndetect;
                    wr_rd      <= Nwr_rd;
                End if;
        End Process;

        Process(state_comp,detect,state_si,shift_in,wr_rd)
        Begin
                If state_comp = '0' then
                    If state_si = 8 then
                        Nstate_comp <= '1';
                    Else
                        Nstate_comp <= '0';
                    End if;
                Else
                    Nstate_comp <= state_comp;
                End if;
        End Process;

        Process(state_comp,detect,state_si,shift_in,wr_rd)
        Begin
                If state_comp = '0' then
                    If (state_si = 8) and (shift_in(7 downto 1) = "1010101") then
                        Ndetect <= '1';
                        Nwr_rd  <= shift_in(0);
                    Else
                        Ndetect <= '0';
                        Nwr_rd  <= '0';
                    End if;
                Else
                    Ndetect     <= detect;
                    Nwr_rd      <= wr_rd;
                End if;
        End Process;
end Compare_address1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Write_control is
     port (
               reset  : in std_logic;
               start  : in std_logic;
               S      : in std_logic;
               wr_clk : in std_logic;
               wr_rd  : in std_logic;
               state_si  : in integer range 0 to 15;
               state_adr : in integer range 0 to 3;
               wrtmp     : out std_logic
          );
end Write_control;

architecture Write_control1 of Write_control is
signal Nstate_adr  : integer range 0 to 3;
signal Nwrtmp      : std_logic;
begin
        --Write Process
        AI : Process(reset,start,wr_clk,S)
        Begin
                If (reset = '0' or start = '0' or S = '1') then
                    wrtmp <= '1';
                Elsif wr_clk'event and wr_clk = '1' then
                    wrtmp <= Nwrtmp;
                End if;
        End Process;

        Process(wrtmp,state_si,state_adr,wr_rd)
        Begin
                If wrtmp = '1' then
                    If (state_si = 8 and state_adr = 3 and wr_rd = '0') then
                        Nwrtmp <= '0';
                    Else
                        Nwrtmp <= wrtmp;
                    End if;
                Else
                    Nwrtmp <= '1';
                End if;
        End Process;
end Write_control1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Read_control is
     port (
               reset  : in std_logic;
               start  : in std_logic;
               S      : in std_logic;
               wr_clk : in std_logic;
               wr_rd  : in std_logic;
               state_so  : in integer range 0 to 31;
               rdtmp     : out std_logic
          );
end Read_control;

architecture Read_control1 of Read_control is
signal Nrdtmp       : std_logic;
begin
        --Read Process
        AJ : Process(reset,start,wr_clk,S)
        Begin
                If (reset = '0' or start = '0' or S = '1') then
                    rdtmp <= '1';
                Elsif wr_clk'event and wr_clk = '1' then
                    rdtmp <= Nrdtmp;
                End if;
        End Process;

        Process(rdtmp,state_so,wr_rd)
        Begin
                If rdtmp = '1' then
                    If ((state_so = 1 or state_so = 11) and wr_rd = '1') then
                        Nrdtmp <= '0';
                    Else
                        Nrdtmp <= rdtmp;
                    End if;
                Else
                    Nrdtmp <= '1';
                End if;
        End Process;
end Read_control1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Address_reg is
     port (
               reset   : in std_logic;
               start   : in std_logic;
               S       : in std_logic;
               adr_clk : in std_logic;
               detect  : in std_logic;
               state_si  : in integer range 0 to 15;
               shift_in  : in std_logic_vector (7 downto 0);
               addr      : out std_logic_vector (7 downto 0);
               state_adr : out integer range 0 to 3;
          );
end Address_reg;

architecture Address_reg1 of Address_reg is
signal Nstate_adr  : integer range 0 to 3;
begin
        --Address Reg
        AG : Process(reset,start,adr_clk,S)
        Begin
                If (reset = '0' or start = '0' or S = '1') then
                    state_adr <= 0;
                Elsif adr_clk'event and adr_clk = '1' then
                    state_adr <= Nstate_adr;
                End if;
        End Process;

        Process(reset,adr_clk)
        Begin
                If reset = '0' then
                    addr <= "00000000";
                Elsif adr_clk'event and adr_clk = '1' then
                    addr <= Naddr;
                End if;
        End Process;

        Process(state_si,detect,state_adr,shift_in)
        Begin
                If (state_si = 8 and detect = '1') then
                    If state_adr = 0 and shift_in(0) = '0' then
                        Nstate_adr <= 1;
                    Elsif (state_adr = 1) or (state_adr = 0 and shift_in(1) = '0') then
                        Nstate_adr <= 2;
                    Else
                        Nstate_adr <= 3;
                    End if;
                Else
                    Nstate_adr <= state_adr;
                End if;
        End Process;

        Process(state_si,detect,state_adr,addr,shift_in)
        Begin
                If state_si = 8 and detect = '1' then
                    If state_adr = 1 then
                        Naddr <= shift_in;
                    Elsif state_adr = 3 then
                        Naddr(0) <= addr(0) xor '1';
                        Naddr(1) <= addr(1) xor addr(0);
                        Naddr(2) <= addr(2) xor (addr(1) and addr(0));
                        Naddr(3) <= addr(3) xor (addr(2) and addr(1) and addr(0));
                        Naddr(4) <= addr(4) xor (addr(3) and addr(2) and addr(1) and addr(0));
                        Naddr(5) <= addr(5) xor (addr(4) and addr(3) and addr(2) and addr(1) and addr(0));
                        Naddr(6) <= addr(6) xor (addr(5) and addr(4) and addr(3) and addr(2) and addr(1) and addr(0));
                        Naddr(7) <= addr(7) xor (addr(6) and addr(5) and addr(4) and addr(3) and addr(2) and addr(1) and addr(0));
                    End if;
                Else
                    Naddr <= addr;
                End if;
        End Process;
end Address_reg1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Data_register is
     port (
               reset     : in std_logic;
               start     : in std_logic;
               S         : in std_logic;
               comp_clk  : in std_logic;
               detect    : in std_logic;
               state_adr : in integer range 0 to 3;
               state_si  : in integer range 0 to 15;
               shift_in  : in std_logic_vector (7 downto 0);
               data_reg  : out std_logic_vector (7 downto 0)
          );
end Data_register;

architecture Data_reg1 of Data_register is
signal Nstate_data  : integer range 0 to 3;
begin
        --Data Reg
        AH : Process(reset,start,comp_clk,S)
        Begin
                If (reset = '0' or start = '0' or S = '1') then
                    state_data <= 0 ;
                    data_reg   <= "00000000";
                Elsif comp_clk'event and comp_clk = '1' then
                    state_data <= Nstate_data;
                    data_reg   <= Ndata_reg;
                End if;
        End Process;

        Process(state_si,detect,state_data,shift_in,data_reg,state_adr)
        Begin
                If state_si = 8 and detect = '1' then
                    If (state_adr = 2 and state_data = 0)
                       or (state_data = 1) then
                        Nstate_data <= 1 ;
                        Ndata_reg   <= shift_in;
                    Else
                        Nstate_data <= 0 ;
                        Ndata_reg   <= "00000000";
                    End if;
                Else
                    Nstate_data <= state_data ;
                    Ndata_reg   <= data_reg;
                End if;
        End Process;
end Data_reg1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Shiftout_con is
     port (
               reset     : in std_logic;
               start     : in std_logic;
               S         : in std_logic;
               so_clk    : in std_logic;
               detect    : in std_logic;
               LRB       : in std_logic;
               wr_rd     : in std_logic;
               state_si  : in integer range 0 to 15;
               shift_out : in std_logic_vector (7 downto 0);
               sda_o     : out std_logic;
               state_so  : out integer range 0 to 31
          );
end Shiftout_con;

architecture Shiftout_con1 of Shiftout_con is
signal sotmp     : std_logic_vector(7 downto 0);
signal Nstate_so : integer range 0 to 31;
signal Nsotmp    : std_logic_vector(7 downto 0);
signal Nsda_o    : std_logic;
begin
        --Shift Out
        AK : Process(reset,start,so_clk,S)
        Begin
                If (reset = '0' or start = '0' or S = '1') then
                    state_so <= 0;
                    sotmp    <= "00000000";
                    sda_o    <= '1';
                Elsif so_clk'event and so_clk = '1' then
                    state_so <= Nstate_so;
                    sotmp    <= Nsotmp;
                    sda_o    <= Nsda_o;
                End if;
        End Process;

        Process(state_so,detect,wr_rd,shift_out,sotmp,state_so,state_si,LRB)
        Begin
                If (state_so = 0 and detect = '1') or (state_so = 10) then
                    If wr_rd = '1' then
                        Nstate_so <= 1;
                    Else
                        If state_si = 8 then
                            Nstate_so <= 10;
                        Else
                            Nstate_so <= 0;
                        End if;
                    End if;
                Elsif (state_so = 1) or (state_so = 11 and LRB = '0') then
                    Nstate_so <= 2;
                Elsif state_so = 9 then
                    Nstate_so <= 11;
                Elsif (state_so = 11 and LRB = '1') then
                    Nstate_so <= 12;
                Elsif state_so = 19 then
                    Nstate_so <= 19;
                Elsif not(state_so = 0) then
                    Nstate_so <= state_so + 1;
                Else
                    Nstate_so <= state_so;
                End if;
        End Process;

        Process(state_so,shift_out,sotmp)        ---Nsotmp(7 downto 1)
        Begin
                If (state_so = 1) or (state_so = 11) then
                    Nsotmp(7 downto 1) <= shift_out(6 downto 0);
                Elsif not(state_so = 0 or state_so = 9 or state_so = 10 or
                      state_so = 19) then
                    Nsotmp(7 downto 1) <= sotmp(6 downto 0);
                Else
                    Nsotmp(7 downto 1) <= sotmp(7 downto 1);
                End if;
        End Process;

        Process(state_so,shift_out,sotmp)        ---Nsotmp(0)
        Begin
                If (state_so = 1) or (state_so = 11) or not(state_so = 0) then
                    Nsotmp(0) <= '0';
                Else
                    Nsotmp(0) <= sotmp(0);
                End if;
        End Process;

        Process(state_so,detect,wr_rd,shift_out,sotmp,state_si)
        Begin
                If (state_so = 0 and detect = '1')
                   and (wr_rd = '1' or state_si = 8) then
                    Nsda_o <= '0';
                Elsif (state_so = 1 or state_so = 11) then
                    Nsda_o <= shift_out(7);
                Elsif not(state_so = 0 or state_so = 9 or state_so = 10 or
                      state_so = 19) then
                    Nsda_o   <= sotmp(7);
                Else
                    Nsda_o   <= '1';
                End if;
        End Process;
end Shiftout_con1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Get_data is
     port (
               reset     : in std_logic;
               rdtmp     : in std_logic;
               get_clk   : in std_logic;
               shift_out : out std_logic_vector (7 downto 0);
          );
end Get_data;

architecture Get_data1 of Get_data is
signal Nshift_out : std_logic_vector(7 downto 0);
begin
        --Get data
        AL : Process(reset,gd_clk)
        Begin
                If reset = '0' then
                    shift_out <= "00000000";
                Elsif gd_clk'event and gd_clk = '1' then
                    shift_out <= Nshift_out;
                End if;
        End Process;

        Process(rdtmp,data,shift_out)
        Begin
                If rdtmp = '0' then
                    Nshift_out <= data;
                Else
                    Nshift_out <= shift_out;
                End if;
        End Process;
end Get_data1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Control_data is
     port (
               data_reg : in std_logic_vector(7 downto 0);
               rdtmp    : in std_logic;
               data     : out std_logic_vector (7 downto 0);
          );
end Control_data;

architecture Control_data1 of Control_data is
begin
        --Control Data Port
        AM : Process(rdtmp,data_reg)
        Begin
                If rdtmp = '0' then
                    data <= "ZZZZZZZZ";
                Else
                    data <= data_reg;
                End if;
        End Process;
end Control_data1;

