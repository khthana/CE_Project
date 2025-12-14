library IEEE;
use IEEE.std_logic_1164.all;

Entity Write_trm is
        port(
                reset        : in Std_logic;
                state_trmclk : in Std_logic;
                write_clk    : in Std_logic;       --'0' when write to trm_reg.
                write        : out Std_logic
            );
End Write_trm;

Architecture Write_trm_1 of write_trm is
Begin
        Process(write_clk,state_trmclk)
        Begin
                If reset = '0' or state_trmclk = '1' then
                    write <= '0';
                Elsif write_clk'event and write_clk = '0' then
                    write <= '1';
                End if;
        End Process;
End Write_trm_1;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Transmit_control is
        port(
                Reset : in std_logic ;
                Mreset : in Std_logic ;
                trmclk : in Std_logic ;
                state_trmclk : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                trm_reg : in Std_logic_vector(7 downto 0) ;
                state_trm : inout integer range 0 to 15;
                tx : inout Std_logic
            );
End Transmit_control;

Architecture tran_con of transmit_control is
signal Nstate_trm : integer range 0 to 15;
signal Ntx        : std_logic;
signal txparity   : std_logic;
Begin
        txparity <= (Trm_reg(7) xor Trm_reg(6) xor Trm_reg(5) xor Trm_reg(4) xor Trm_reg(3) xor Trm_reg(2) xor Trm_reg(1) xor Trm_reg(0));
        --Transmit control
        Process(reset,mreset,trmclk,state_trmclk)
        Begin
                If (reset = '0' or mreset = '1') or (state_trmclk = '0') then
                    state_trm <= 0;
                    tx     <= '1';
                Elsif trmclk'event and trmclk = '1' then
                    state_trm <= Nstate_trm;
                    tx     <= Ntx;
                End if;
        End Process;

        Process(state_trm,control)
        Begin
                If state_trm < 9 then
                    Nstate_trm <= state_trm + 1;
                Elsif (state_trm = 9 and control(3 downto 2) = "00") then
                    Nstate_trm <= 10;
                Elsif (state_trm = 9 and
                      (control(3 downto 2) = "10" or control(3 downto 2) = "11")) then
                    Nstate_trm <= 12;
                Elsif (state_trm = 10 or state_trm = 12)
                   or (state_trm = 9 and control(3 downto 2) = "01") then
                    Nstate_trm <= 11;
                Elsif (state_trm = 11) then
                    Nstate_trm <= 13;
                Elsif (state_trm = 13) then
                    Nstate_trm <= 0;
                Else
                    Nstate_trm <= state_trm;
                End if;
        End Process;

        Process(state_trm,trm_reg,control,txparity,tx)
        Begin
            If (state_trm = 0) then
                Ntx <= '0';
            Elsif state_trm = 1 then
                Ntx <= trm_reg(7);
            Elsif state_trm = 2 then
                Ntx <= trm_reg(6);
            Elsif state_trm = 3 then
                Ntx <= trm_reg(5);
            Elsif state_trm = 4 then
                Ntx <= trm_reg(4);
            Elsif state_trm = 5 then
                Ntx <= trm_reg(3);
            Elsif state_trm = 6 then
                Ntx <= trm_reg(2);
            Elsif state_trm = 7 then
                Ntx <= trm_reg(1);
            Elsif state_trm = 8 then
                Ntx <= trm_reg(0);
            Elsif (state_trm = 9 and
                  (control(3 downto 2) = "00" or control(3 downto 2) = "01"))
               or (state_trm = 12 or state_trm = 10) then
                Ntx <= '1';
            Elsif (state_trm = 9 and control(3 downto 2) = "10") then
                Ntx <= txparity;
            Elsif (state_trm = 9 and control(3 downto 2) = "11") then
                Ntx <= not(txparity);
            Else
                Ntx <= tx;
            End if;
        End Process;
End tran_con;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Transmit_clock is
        port(
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                clk : in Std_logic ;
                write : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_trm : in integer range 0 to 15;
                trmclk : inout Std_logic;
                state_trmclk : inout Std_logic
            );
End Transmit_clock;

Architecture tran_clk of transmit_clock is
signal Nstate_trmclk : std_logic;
signal Ntrmclk       : std_logic;
signal trmcount      : integer range 0 to 127;
signal Ntrmcount     : integer range 0 to 127;
Begin
        --Transmit clock generator
        Process(reset,mreset,clk)
        Begin
                If reset = '0' or mreset = '1' then
                    state_trmclk <= '0';
                    trmcount     <= 0;
                    trmclk       <= '0';
                Elsif clk'event and clk = '1' then
                    state_trmclk <=  Nstate_trmclk;
                    trmcount     <= Ntrmcount;
                    trmclk       <= Ntrmclk;
                End if;
        End Process;

        Process(state_trmclk,write,state_trm)
        Begin
                If (state_trmclk = '0' and write = '1') then
                    Nstate_trmclk <= '1';
                Elsif (state_trmclk = '1' and state_trm = 13) then
                    Nstate_trmclk <= '0';
                Else
                    Nstate_trmclk <= state_trmclk;
                End if;
        End Process;

        Process(state_trmclk,trmcount,control)
        Begin
                If (state_trmclk = '0') or (state_trmclk = '1' and trmcount = 1) then
                    If control(1 downto 0) = "00" then
                        Ntrmcount <= 8;
                    Elsif control(1 downto 0) = "01" then
                        Ntrmcount <= 16;
                    Else
                        Ntrmcount <= 32;
                    End if;
                Elsif (state_trmclk = '1') then
                    Ntrmcount <= trmcount - 1;
                Else
                    Ntrmcount <= trmcount;
                End if;
        End Process;

        Process(state_trmclk,trmcount,trmclk)
        Begin
                If (state_trmclk = '0') then
                    Ntrmclk <= '0';
                Elsif (state_trmclk = '1' and trmcount = 1) then
                    Ntrmclk <= not(trmclk);
                Else
                    Ntrmclk <= trmclk;
                End if;
        End Process;
End tran_clk;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Receive_control is
        port(
                rx : in Std_logic ;
                clk : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                recclk : in Std_logic ;
                state_recclk : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_rec : inout integer range 0 to 15;
                rec_reg : inout Std_logic_vector(7 downto 0);
                rxparity : out Std_logic 
            );
End Receive_control;

Architecture rec_con of receive_control is
signal Nstate_rec : integer range 0 to 15;
signal rtmp       : std_logic_vector(7 downto 0);
signal Nrtmp      : std_logic_vector(7 downto 0);
signal Nrec_reg   : std_logic_vector(7 downto 0);
Begin
        rxparity <= (rtmp(7) xor rtmp(6) xor rtmp(5) xor rtmp(4) xor rtmp(3) xor rtmp(2) xor rtmp(1) xor rtmp(0));
        --Receive control
        Process(reset,mreset,recclk,state_recclk)
        Begin
                If (reset = '0' or mreset = '1') or (state_recclk = '0') then
                    state_rec <= 0;
                Elsif recclk'event and recclk = '1' then
                    state_rec <= Nstate_rec;
                End if;
        End Process;

        Process(reset,mreset,recclk)
        Begin
                If (reset = '0' or mreset = '1') then
                    rtmp      <= "00000000";
                Elsif recclk'event and recclk = '1' then
                    rtmp      <= Nrtmp;
                End if;
        End Process;

        Process(reset,mreset,clk)
        Begin
                If (reset = '0' or mreset = '1') then
                    rec_reg   <= "00000000";
                Elsif clk'event and clk = '1' then
                    rec_reg   <= Nrec_reg;
                End if;
        End Process;

        Process(state_rec,control)
        Begin
                If state_rec < 9 then
                    Nstate_rec <= state_rec + 1;
                Elsif (state_rec = 9 and control(3 downto 2) = "00") then
                    Nstate_rec <= 10;
                Elsif (state_rec = 9 and
                      (control(3 downto 2) = "10" or control(3 downto 2) = "11")) then
                    Nstate_rec <= 12;
                Elsif (state_rec = 10 or state_rec = 12)
                   or (state_rec = 9 and control(3 downto 2) = "01") then
                    Nstate_rec <= 11;
                Else
                    Nstate_rec <= state_rec;
                End if;
        End Process;

        Process(state_rec,rtmp,rx)
        Begin
                If (state_rec < 9) then
                    Nrtmp(7 downto 1) <= rtmp(6 downto 0);
                    Nrtmp(0)          <= rx;
                Else
                    Nrtmp <= rtmp;
                End if;
        End Process;

        Process(state_rec,rtmp,rec_reg)
        Begin
                If state_rec = 9 then
                    Nrec_reg <= rtmp;
                Else
                    Nrec_reg <= rec_reg;
                End if;
        End Process;
End rec_con;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Receive_clock is
        port(
                rx : in Std_logic ;
                clk : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_rec : in integer range 0 to 15;
                recclk : inout Std_logic ;
                state_recclk : inout Std_logic 
            );
End Receive_clock;

Architecture receive_clk of receive_clock is
signal Nstate_recclk : std_logic;
signal Nrecclk       : std_logic;
signal reccount      : integer range 0 to 127;
signal Nreccount     : integer range 0 to 127;
Begin
        --Receive clock generator
        Process(reset,mreset,clk)
        Begin
                If reset = '0' or mreset = '1' then
                    state_recclk <= '0';
                    reccount     <= 0;
                    recclk       <= '0';
                Elsif clk'event and clk = '1' then
                    state_recclk <= Nstate_recclk;
                    reccount     <= Nreccount;
                    recclk       <= Nrecclk;
                End if;
        End Process;

        Process(state_recclk,rx,state_rec)
        Begin
                If (state_recclk = '0' and rx = '0') then
                    Nstate_recclk <= '1';
                Elsif (state_recclk = '1' and state_rec = 11 and rx = '1') then
                    Nstate_recclk <= '0';
                Else
                    Nstate_recclk <= state_recclk;
                End if;
        End Process;

        Process(state_recclk,reccount,control)
        Begin
                If (state_recclk = '0') then
                    Nreccount <= 1;
                Elsif (state_recclk = '1' and reccount = 1) then
                    If control(1 downto 0) = "00" then
                        Nreccount <= 8;
                    Elsif control(1 downto 0) = "01" then
                        Nreccount <= 16;
                    Else
                        Nreccount <= 32;
                    End if;
                Elsif (state_recclk = '1') then
                    Nreccount <= reccount - 1;
                Else
                    Nreccount <= reccount;
                End if;
        End Process;

        Process(state_recclk,reccount,recclk,state_rec)
        Begin
                If (state_recclk = '1' and state_rec = 13) then
                    Nrecclk <= '0';
                Elsif (state_recclk = '1' and reccount = 1) then
                    Nrecclk <= not(recclk);
                Else
                    Nrecclk <= recclk;
                End if;
        End Process;
End receive_clk;

library IEEE;
use IEEE.std_logic_1164.all;

Entity Status_register is
        port(
                rx : in Std_logic ;
                a0 : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                wr_clk : in Std_logic ;
                rd_clk : in Std_logic ;
                recclk : in Std_logic ;
                rxparity : in Std_logic ;
                state_trmclk : in Std_logic ;
                state_recclk : in Std_logic ;
                state_rec : in integer range 0 to 15 ;
                control : in Std_logic_vector(7 downto 0) ;
                status : inout Std_logic_vector(7 downto 0)
            );
End status_register;

Architecture sta_reg of status_register is
signal fe   : std_logic;
signal pe   : std_logic;
Begin
        status(7) <= status(0) or status(1);   ---IRQ Bit;
        status(2) <= '0';                      ---NA
        status(3) <= '0';                      ---NA

--*******************************************************************

        ---TDRF Bit
        Process(reset,mreset,wr_clk,state_trmclk)
        Begin
                If (reset = '0' or mreset = '1') or (wr_clk = '0') then
                    status(1) <= '0';
                Elsif state_trmclk'event and state_trmclk = '0' then
                    status(1) <= '1';
                End if;
        End Process;

--*******************************************************************

        ---RDRF and OV Bit
        Process(reset,mreset,rd_clk,state_recclk)
        Begin
                If (reset = '0' or mreset = '1') or (rd_clk = '0' and a0 = '1') then
                    status(0) <= '0';
                    status(5) <= '0';
                Elsif state_recclk'event and state_recclk = '0' then
                    status(0) <= '1';
                    status(5) <= status(0);
                End if;
        End Process;

--*******************************************************************

        ---FE Bit
        Process(reset,mreset,rd_clk,recclk)
        Begin
                If (reset = '0' or mreset = '1') or (rd_clk = '0' and a0 = '1') then
                    status(4) <= '0';
                Elsif recclk'event and recclk = '1' then
                    status(4) <= FE;
                End if;
        End Process;

        Process(status,control,rx,state_rec)
        Begin
                If status(4) = '0' and rx = '0' and
                   (
                    (state_rec = 9 and control(3) = '0') or
                    (state_rec = 10 and control(2) = '0') or
                    (state_rec = 12 and control(3) = '1')
                   ) then
                    fe <= '1';
                Else
                    fe <= status(4);
                End if;        
        End Process;

--*******************************************************************

        ---PE Bit
        Process(reset,mreset,rd_clk,recclk)
        Begin
                If (reset = '0' or mreset = '1') or (rd_clk = '0' and a0 = '1') then
                    status(6) <= '0';
                Elsif recclk'event and recclk = '1' then
                    status(6) <= PE;
                End if;
        End Process;

        Process(status,state_rec,control,rx,rxparity)
        Begin
                If status(6) = '0' and state_rec = 9 then
                    If (control(3 downto 2) = "10" and not(rx = rxparity))
                    or (control(3 downto 2) = "11" and (rx = rxparity)) then
                        pe <= '1';
                    Else
                        pe <= '0';
                    End if;
                Else
                    pe <= status(6);
                End if;        
        End Process;

--*******************************************************************

End sta_reg;

library IEEE;
use IEEE.std_logic_1164.all;
entity UART is
        port(
            reset : in  std_logic ;
            clk   : in  std_logic ;
            CS    : in  std_logic ;
            RD    : in  std_logic ;
            WR    : in  std_logic ;
            A0    : in  std_logic ;
            Rx    : in  std_logic ;
            Tx    : inout std_logic ;
            INT   : out std_logic ;
            data  : inout std_logic_vector(7 downto 0)
            );
end UART;

Architecture uart1 of UART is
---Write_trm
signal write_clk : std_logic;
signal write : std_logic;
-------------------------------------------------
---Transmit control
signal state_trm  : integer range 0 to 15;
-------------------------------------------------
---Transmit clock generator
signal state_trmclk  : std_logic;
signal trmclk        : std_logic;
-------------------------------------------------
---Receive control
signal state_rec  : integer range 0 to 15;
signal rxparity   : std_logic;
-------------------------------------------------
---Receive clock generator
signal state_recclk  : std_logic;
signal recclk        : std_logic;
-------------------------------------------------
---Register
signal control : std_logic_vector(7 downto 0);
signal status  : std_logic_vector(7 downto 0);
signal trm_reg : std_logic_vector(7 downto 0);
signal rec_reg : std_logic_vector(7 downto 0);
signal datatmp : std_logic_vector(7 downto 0);
-------------------------------------------------
---Temp Register
signal Ncontrol : std_logic_vector(7 downto 0);
signal Ntrm_reg : std_logic_vector(7 downto 0);
signal Nrec_reg : std_logic_vector(7 downto 0);
-------------------------------------------------
---Read Write
signal wr_clk : std_logic;
signal rd_clk : std_logic;
-------------------------------------------------
---Master reset
signal mreset : std_logic;
-------------------------------------------------
--*******************************************************************
Component write_trm
        port(
                reset        : in Std_logic;
                state_trmclk : in Std_logic;
                write_clk    : in Std_logic;       --'0' when write to trm_reg.
                write        : out Std_logic
            );
End component;

Component transmit_control
        port(
                Reset : in std_logic ;
                Mreset : in Std_logic ;
                trmclk : in Std_logic ;
                state_trmclk : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                trm_reg : in Std_logic_vector(7 downto 0) ;
                state_trm : inout integer range 0 to 15;
                tx : inout Std_logic
            );
End component;

Component transmit_clock
        port(
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                clk : in Std_logic ;
                write : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_trm : in integer range 0 to 15;
                trmclk : inout Std_logic;
                state_trmclk : inout Std_logic
            );
End component;

Component receive_control
        port(
                rx : in Std_logic ;
                clk : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                recclk : in Std_logic ;
                state_recclk : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_rec : inout integer range 0 to 15;
                rec_reg : inout Std_logic_vector(7 downto 0);
                rxparity : out Std_logic 
            );
End component;

Component receive_clock
        port(
                rx : in Std_logic ;
                clk : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                control : in Std_logic_vector(7 downto 0) ;
                state_rec : in integer range 0 to 15;
                recclk : inout Std_logic ;
                state_recclk : inout Std_logic 
            );
End component;

Component status_register
        port(
                rx : in Std_logic ;
                a0 : in Std_logic ;
                Reset : in Std_logic ;
                Mreset : in Std_logic ;
                wr_clk : in Std_logic ;
                rd_clk : in Std_logic ;
                recclk : in Std_logic ;
                rxparity : in Std_logic ;
                state_trmclk : in Std_logic ;
                state_recclk : in Std_logic ;
                state_rec : in integer range 0 to 15 ;
                control : in Std_logic_vector(7 downto 0) ;
                status : inout Std_logic_vector(7 downto 0)
            );
End component;


--*******************************************************************

Begin
        U1 : write_trm port map(reset,state_trmclk,write_clk,write);
        U2 : transmit_control port map(Reset,Mreset,trmclk,state_trmclk,control,trm_reg,state_trm,tx);
        U3 : transmit_clock port map (Reset,Mreset,clk,write,control,state_trm,trmclk,state_trmclk);
        U4 : receive_control port map(rx,clk,Reset,Mreset,recclk,state_recclk,control,state_rec,rec_reg,rxparity);
        U5 : receive_clock port map(rx,clk,Reset,Mreset,control,state_rec,recclk,state_recclk);
        U6 : status_register port map(rx,a0,Reset,Mreset,wr_clk,rd_clk,recclk,rxparity,
             state_trmclk,state_recclk,state_rec,control,status);

        write_clk <= CS or not(A0) or WR;
        wr_clk   <= CS or WR;
        rd_clk   <= CS or RD;
        mreset   <= control(0) and control(1);
        INT <= not(control(7) and status(0)) and not(control(6) and status(1));
--*******************************************************************

        ---Write Register
        Process(reset,mreset,wr_clk)
        Begin
                If reset = '0' or mreset = '1' then
                    control <= "11000100";
                    trm_reg <= "01000001";
                Elsif wr_clk'event and wr_clk = '0' then
                    control <= Ncontrol;
                    trm_reg <= Ntrm_reg;
                End if;
        End Process;

        Process(a0,data,control)
        Begin
                If (a0 = '0') then
                    Ncontrol <= data;
                Else
                    Ncontrol <= control;
                End if;
        End Process;

        Process(a0,data,trm_reg)
        Begin
                If a0 = '1' then
                    Ntrm_reg <= data;
                Else
                    Ntrm_reg <= trm_reg;
                End if;
        End Process;

--*******************************************************************

        ---Read Register
        Process(A0,status,rec_reg)
        Begin
                Case A0 is
                    When '0' => datatmp <= status;
                    when '1' => datatmp <= rec_reg;
                    when others => datatmp <= "00000000";
                End case;
        End Process;

        Process(reset,mreset,rd_clk)
        Begin
                If (reset = '0' or mreset = '1') or rd_clk = '1' then
                    data <= "ZZZZZZZZ";
                Else
                    data <= datatmp;
                End if;
        End Process;

--*******************************************************************

End uart1;
