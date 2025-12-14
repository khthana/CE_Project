PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G-,I-,L+,N-,O-,R-,S-,V+,X+}

USES   ETHER,PKTDRVR,TIMER,STRINGS,CRT,DOS,INIF,EMS,stringop,grafica,g_applic,util256,graph,mouse;

const  backgroundu:string='porn02.tpi';
       MaxEthernetCapacity = 1250000; { Max. theroetical ethernet capacity }
       DefaultFileName     = 'DATA.DAT';
       FullBlock           = 'Û';
       ElementNum          = PAGESIZE DIV Sizeof(TPacketInfo);
       { Constant use in DisplayProtocol }
       LastLayer2Protocol  = 4;
       LastLayer3Protocol  = 7;
       LastLayer4Protocol  = 7;
       LastUpLayerProtocol = 9;
       LastProtocol        = LastLayer2Protocol + LastLayer3Protocol + LastLayer4Protocol + LastUpLayerProtocol;
       { use for Extend protocol in .INI file}
       DefaultString = 'Notfound';
       INIFile       = 'Protocol';
       ExtProtocolLimit = 20;    { Can add 20 protocols per section }

{ based protocol ID }
  { Layer 2 }
       EthernetII      = 1;
       Ethernet802_3   = 2;
       EthernetSNAP    = 3;
       Ethernet802_2   = LastLayer2Protocol;
  { Layer 3 }
       IPX             = 1;
       NetBeui         = 2;
       IP              = 3;
       ARP             = 4;
       RARP            = 5;
       SNMP            = 6;
       OtherL3         = LastLayer3Protocol;
  { Layer 4 }
    { For IPX }
       SPX             = 1;
       NCP             = 2;
       NetBios         = 3;
    { For IP }
       ICMP            = 4;
       TCP             = 5;
       UDP             = 6;
       OtherL4         = LastLayer4Protocol;
  { Upper Layer }
    { For TCP }
       Telnet          = 1;
       FTP             = 2;
       FTP_Data        = 3;
       Finger          = 4;
       Rlogin          = 5;
       RPC             = 6;
       SMTP            = 7;
    { For UDP }
       UDP_SNMP        = 8;
       OtherUL         = LastUpLayerProtocol;

TYPE
{Type definition use in procedure DisplayProtocol}
       TProtocolCnt = RECORD
                      PacketCnt    :   integer;
                      ByteCnt      :   longint;
                      END;

       TAllProtocolStat   =   RECORD
                                    L2L3ProtocolStat  : ARRAY [1..LastLayer2Protocol,1..LastLayer3Protocol] OF TProtocolCnt;

                                    IPX_EtherIIStat   : ARRAY [1..4] OF TProtocolCnt;
                                    IPX_Ether8023Stat : ARRAY [1..4] OF TProtocolCnt;
                                    IPX_EtherSNAPStat : ARRAY [1..4] OF TProtocolCnt;
                                    IPX_Ether8022Stat : ARRAY [1..4] OF TProtocolCnt;
                                    IP_EtherIIStat    : ARRAY [1..4] OF TProtocolCnt;
                                    IP_EtherSNAPStat  : ARRAY [1..4] OF TProtocolCnt;

                                    TCP_EtherIIStat   : ARRAY [1..8] OF TProtocolCnt;
                                    TCP_EtherSNAPStat : ARRAY [1..8] OF TProtocolCnt;
                                    UDP_EtherIIStat   : ARRAY [1..8] OF TProtocolCnt;
                                    UDP_EtherSNAPStat : ARRAY [1..8] OF TProtocolCnt;
                              END;
       { use for Extend protocol in .INI file }
       TTableLookup = ARRAY [1..20] OF string;

type adapplic=object(g_application)
              procedure background; virtual;
              end;

var s            : string        ;
    w            : adapplic      ;
    i,fw,nw      : word          ;
    p1,p2        : palette256    ;
    pre          : byte          ;
    soare        : soarece       ;
    ala          : integer       ;

VAR
    PacketBuffer    : EMSArray;
    Pages,KiloByte  : Word;            { ONE 10/1/40 Keep Pages avail }
    MaxPacketBuffer : Word;
    INFORMATION     : Statistic;       { ONE 17/1/40 for check error }
    Threshold       : Statistic;       { ONE 17/1/40 for check error }
    RcvRawData      : Array[00..1524] of Char;

    pktDriver       : TPKTDRVR;        { Instance of the TPKTDRVR object }
    pktDriverInfo   : TDRVRINFO;       { record for driver information }
    pktDriverAccess : TACCESSTYPE;     { record used for accessing packet driver }
    pktStatistics   : TSTATISTICS;     { record used for satistics of packet }

    Rcvpacket       : PacketFrame;     { Rcv buffer }

    RcvLength       : Word;            { Length of packet }
    RcvHeader       : MACheader;       { Header           }

    VerHeader       : Macheader;       { use in module verify packet }
    VerPacket       : PacketFrame;

    SendPacket      : TSendPacket;     { Send packet buffer }
    TypeField       : Word;            { type field of Send packet }

    PacketCount     : Word;            { Packet counter   }
    PacketDelay     : Word;
    Lost            : Word;
    TotalPacket     : LongInt;

    HeaderFile      : FileHeader;      { ONE 6/1/40 for save files in module capture}

    Timer1          : _TIMER;          { Timer for Trick Monitor Traffic }
    Timer2          : _TIMER;
    Interval        : LongInt;

    MyEthernetAddr  : EthernetAddr;    { My Station Ethernet Address }

    Key             : Char;
    J               : Integer;
    Byt             : Byte;
    tWord           : Word;
    tStr,ttStr      : String;
    Found           : Boolean;
    IntRet          : integer;      { Return value as integer }
    BoolnRet        : Boolean;      { Return value as Boolean }
    { use for Extend protocol in .INI file }
    { use in DisplayProtocol }
    ExtL3Count      : shortint;
    ExtL4Count      : shortint;
    ExtULCount      : shortint;
    ExtLayer3Table  : TTableLookup;
    ExtLayer4Table  : TTableLookup;
    ExtUpLayerTable : TTableLookup;
{ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ }

procedure adapplic.background;
var f,n: integer;
begin
     hide;
{    setviewport(0,21,639,454,true);
     for f:=0 to 4 do
       for n:=0 to 4 do begin
                             setfillstyle(1,9);
                             bar(f*160,n*100,f*160+159,n*100+99);
                                  end;
     setviewport(0,0,639,479,true);}
     setfillstyle(1,0); bar(0,0,getmaxx,getmaxy);
     show;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE pktReceiver                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Receive Packets                                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
{$S-}
PROCEDURE pktReceiver; ASSEMBLER;
ASM
        PUSH AX                      { Push registers onto stack }
        PUSH BX
        PUSH CX
        PUSH DX

        CMP  AX,0001                 { AX=1 means frame copied }
        JZ   @@FrameCopied
        CMP  AX,0000                 { AX=0 means allocate memory please }
        JZ   @@AllocMemory
        JMP  @@EXIT                  { Invalid register contents for AX so exit}

@@AllocMemory:

        MOV  DX,0                    { ES:DI = 0000:0000, we don't want the packet }
        MOV  ES,DX
        MOV  DI,0                    { We don't grab the packet }

        MOV  DX,SEG PacketCount      { Set correct data segment }
        MOV  DS,DX
        MOV  DX,PacketCount
        CMP  DX,0

        JNZ  @@Exit                  { buffer is not free ! }

        MOV  DX,SEG Rcvpacket
        MOV  ES,DX
        MOV  DI,OFFSET Rcvpacket

        MOV  DX,SEG RcvLength
        MOV  DS,DX
        MOV  SI,OFFSET RcvLength
        MOV  WORD PTR DS:[SI],CX     { Store length of frame in PacketLength }

        JMP  @@Exit

@@FrameCopied:

        MOV  DX,SEG PacketCount       { Set correct data segment }
        MOV  DS,DX
        MOV  PacketCount,1            { Set Flag to 1 }

@@Exit:

        POP  DX                      { Pop registers from stack }
        POP  CX
        POP  BX
        POP  AX
END;
{$S+}

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE InitPktDriver;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Initialize packet driver.                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE InitPktDriver;
BEGIN
     WriteLn('Initializing packet driver....');
     IF (pktDriver.GetStatus <> INITIALIZED) THEN
      BEGIN
          WriteLn('Could not initialze packet driver...');
          WriteLn('Aborting...');
          Halt($FF);
      END
     ELSE
      BEGIN
      { Packet driver found. Show some information }
           WriteLn('Packet driver found:');
           pktDriver.DriverInfo(pktDriverInfo);
           WriteLn('Name    = ',StrPas(pktDriverInfo.PName));
           WriteLn('Version = ',pktDriverInfo.Version);
           WriteLn('IF-Type = ',pktDriverInfo.Type_);
           Write  ('Func    = ');

           CASE pktDriverInfo.Functionality OF
             01 : WriteLn('Basic functions present.');
             02 : WriteLn('Basic & extended functions present.');
             05 : WriteLn('Basic & high-performance functions present.');
             06 : WriteLn('Basic, high-performance & extended functions present.');
           END;
      END;

      { Fill in information used for accessing packet driver }
      WITH pktDriverAccess DO
      BEGIN
           if_class  := pktDriverInfo.Class;
           if_type   := ANYTYPE;
           if_number := 0;
           type_     := @TypeField;
           typelen   := 0;
           receiver  := @pktReceiver; { receiver procedure }
      END;

      { Access packet driver }
      pktDriver.AccessType(pktDriverAccess);
      WriteLn('Handle  = ',pktDriver.GetHandle);
      WriteLn;

      { Setting packet driver to promiscuous mode }
      pktDriver.SetRcvmode(6);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION SwapWord;                                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Swaps the Hi and Lo byte of a word.                บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION SwapWord(sWord : Word) : Word;
VAR tWord : Word;
BEGIN
     tWord := (Lo(sWord) SHL 8) + Hi(sWord);
     SwapWord := tWord;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetMyEthernetAddr;                                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get my Station Address                             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetMyEthernetAddr;
VAR      cWord : Word;
BEGIN
     pktDriver.GetAddress(@MyEthernetAddr,SizeOf(MyEthernetAddr),cWord);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE MakeSendPacket;                                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Create Simulate Send Packet                        บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE MakeSendPacket;
BEGIN
     GetMyEthernetAddr;
     For I := 0 TO 5 Do
         SendPacket.Destaddr[I] := $AA;
     SendPacket.SourceAddr      := MyEthernetAddr;
     SendPacket.TypeLen         := $5E00;
     tStr := 'This is a test message generate from Ethernet Monitor Version 1.00 Revision A !!!!!';
     Move(tStr,SendPacket.Data,76);
     SendPacket.Data[1] := 'T';
END;

Procedure ExitProgram;
begin
     PacketBuffer.Release;
     pktDriver.ReleaseType;
     w.done;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE InitialEnvironment;                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Intialize Start Environment for program            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE InitialEnvironment;
BEGIN
     {Timer Initial}
     Interval        := 1;

     {Reciever Initial}
     Lost            := 0;

     {Buffer Initial}
     IF (not PacketBuffer.Ems_Installed) Then
     BEGIN
            ExitProgram;
     END;

     Pages    := PacketBuffer.Pages_Available;
     KiloByte := Pages * 16;
     PacketBuffer.Alloc(Pages);
     MAXPACKETBUFFER := ElementNum * Pages;
     If EmsError<>0 Then
       Begin
        WriteLn ('Alloc ', Pages, ' Pages Error!' );
        PacketBuffer.Release;
        Halt(1);
       End;
     { INITIAL INFORMATION & THRESHOLD ONE 19/1/40}
     INFORMATION.Packet_S   := 0;
     INFORMATION.Utilize    := 0;
     INFORMATION.Error_S    := 0;
     INFORMATION.Drop_S     := 0;
     INFORMATION.Byte_S     := 0;
     INFORMATION.BroadCast_S:= 0;
     INFORMATION.CRCError_S := 0;
     INFORMATION.Undersize_S:= 0;
     INFORMATION.Oversize_S := 0;
END;

{ !!! ================================================= !!!
  !!! ===============| Graph Modules |================= !!! }

var  xco,yco : integer; { x-coordinate and y-coordinate }
     xscale,yscale : integer;   { graph scale }
     xn,yn : integer;   { xn and yn are number of ranges in x and y axis }
     xgrid,ygrid : integer; { show grid every 'xgrid' or 'ygrid' scales up to that axis }
     xvallow,yvallow,xplus,yplus : integer; {value at first grid position}
     g_bkground : word;

procedure init_graph(_xco,_yco,_xn,_yn,_xs,_ys,xg,yg,xvl,yvl,xp,yp:integer; bkcolor:word);
begin
     xco:=_xco; yco:=_yco; xn:=_xn; yn:=_yn; xscale:=_xs; yscale:=_ys;
     xgrid:=xg; ygrid:=yg;
     xvallow:=xvl; yvallow:=yvl; xplus:=xp; yplus:=yp;
     g_bkground := bkcolor;
end;

procedure ref_graph;
var  FillInfo: FillSettingsType;
begin
     GetFillSettings(FillInfo);
     setfillstyle(1,g_bkground);
     bar(xco,yco-yn*yscale,xco+(xn+1)*xscale,yco);
     SetFillStyle(FillInfo.Pattern, FillInfo.Color);
end;

procedure graph_scale(xdirection,ydirection:word; xa,ya:string);
var oldstyle : textsettingstype;
begin
     gettextsettings(oldstyle);  { get text style informations }

     setcolor(0);
     textcolor(0);
     line(xco-1,yco+1,xco+10+(xn+1)*xscale,yco+1);
     line(xco-1,yco+1,xco-1,yco-10-yn*yscale);
     settextjustify(lefttext,toptext);
     outtextxy(xco+(xn+1)*xscale+10,yco+15,xa);
     settextjustify(righttext,bottomtext);
     outtextxy(xco-15,yco-yn*yscale-10,ya);

     { draw grid of x axis }
     settextstyle(2,xdirection,4);
     settextjustify(centertext,toptext);
     for i:=1 to xn do
     begin
         if ((i mod xgrid)=0) or (i=1) then
         begin
            line(xco+i*xscale,yco+1,xco+i*xscale,yco+5);
            if xplus > 0 then
               case xdirection of
                    horizdir : outtextxy(xco+i*xscale,yco+7,int2str(xvallow+(i div xgrid)*xplus));
                    vertdir  : outtextxy(xco+i*xscale-3,yco+7,int2str(xvallow+(i div xgrid)*xplus));
               end;
         end
         else
            line(xco+i*xscale,yco+1,xco+i*xscale,yco+3);
     end;

     { draw grid of y axis }
     settextstyle(2,ydirection,4);
     settextjustify(righttext,centertext);
     for i:=1 to yn do
     begin
         if ((i mod ygrid)=0)  or (i=1) then
         begin
            line(xco-1,yco-i*yscale,xco-5,yco-i*yscale);
            if yplus > 0 then
               case ydirection of
                    horizdir : outtextxy(xco-7,yco-i*yscale-3,int2str(yvallow+(i div ygrid)*yplus));
                    vertdir  : outtextxy(xco-7,yco-i*yscale,int2str(yvallow+(i div ygrid)*yplus));
               end;
         end
         else
            line(xco-1,yco-i*yscale,xco-3,yco-i*yscale);
     end;

     { return to old style }
     with oldstyle do
     begin
          settextstyle(font,direction,charsize);
          settextjustify(horiz,vert);
     end;

     ref_graph;
end;

procedure bar_graph(no,hi:integer; color:word);
var  FillInfo: FillSettingsType;
begin
     GetFillSettings(FillInfo);
     setfillstyle(1,color);
     bar(xco+(no-1)*xscale+(xscale div 2),yco-abs(hi*yn*yscale div 100),xco+no*xscale+(xscale div 2),yco);
     SetFillStyle(FillInfo.Pattern, FillInfo.Color);
end;
{ !!! =================| End Modules |================= !!!
  !!! ================================================= !!! }

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ResetProtocolCnt;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ  Reset protocol counter                            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ResetProtocolCnt(VAR Protocol : TAllProtocolStat);
VAR       I,J : integer;
BEGIN
     FOR I:=1 TO LastLayer2Protocol DO
         FOR J:=1 TO LastLayer3Protocol DO
         BEGIN
              Protocol.L2L3ProtocolStat[I,J].PacketCnt    := 0;
              Protocol.L2L3ProtocolStat[I,J].ByteCnt      := 0;
         END;
     FOR I:=1 TO 4 DO
     BEGIN
          Protocol.IPX_EtherIIStat[I].PacketCnt   := 0;
          Protocol.IPX_Ether8023Stat[I].PacketCnt := 0;
          Protocol.IPX_EtherSNAPStat[I].PacketCnt := 0;
          Protocol.IPX_Ether8022Stat[I].PacketCnt := 0;
          Protocol.IPX_EtherIIStat[I].ByteCnt     := 0;
          Protocol.IPX_Ether8023Stat[I].ByteCnt   := 0;
          Protocol.IPX_EtherSNAPStat[I].ByteCnt   := 0;
          Protocol.IPX_Ether8022Stat[I].ByteCnt   := 0;

          Protocol.IP_EtherIIStat[I].PacketCnt    := 0;
          Protocol.IP_EtherSNAPStat[I].PacketCnt  := 0;
          Protocol.IP_EtherIIStat[I].ByteCnt      := 0;
          Protocol.IP_EtherSNAPStat[I].ByteCnt    := 0;
     END;
     FOR I:=1 TO 8 DO
     BEGIN
          Protocol.TCP_EtherIIStat[I].PacketCnt   := 0;
          Protocol.TCP_EtherIIStat[I].ByteCnt     := 0;
          Protocol.TCP_EtherSNAPStat[I].PacketCnt := 0;
          Protocol.TCP_EtherSNAPStat[I].ByteCnt   := 0;

          Protocol.UDP_EtherIIStat[I].PacketCnt   := 0;
          Protocol.UDP_EtherIIStat[I].ByteCnt     := 0;
          Protocol.UDP_EtherSNAPStat[I].PacketCnt := 0;
          Protocol.UDP_EtherSNAPStat[I].ByteCnt   := 0;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE IncProtocolCnt;                                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Increment each protocol counter                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE IncProtocolCnt(VAR P : TProtocolCnt);
BEGIN
     Inc(P.PacketCnt);
     Inc(P.ByteCnt,RcvLength);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DecProtocolCnt;                                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Decrement each protocol counter                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DecProtocolCnt(VAR P : TProtocolCnt);
BEGIN
     Dec(P.PacketCnt);
     Dec(P.ByteCnt,RcvLength);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ChkLayer2Protocol;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Check what layer 2 protocol is?                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ChkLayer2Protocol(TypeLen,ChkSum : Word) : integer;
BEGIN
     IF TypeLen > $5dc THEN ChkLayer2Protocol := EthernetII{ Ethernet II }
     ELSE
         CASE ChkSum OF
              $ffff  :  ChkLayer2Protocol := Ethernet802_3;{ Ethernet 802.3 }
              $aaaa  :  ChkLayer2Protocol := EthernetSNAP;{ Ethernet SNAP }
         ELSE ChkLayer2Protocol := Ethernet802_2;{ Ethernet 802.2 }
         END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ChkLayer3Protocol;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Check what layer 3 protocol is?                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ChkLayer3Protocol(Index : integer;PacketType : Word) : integer;
BEGIN
     CASE Index OF
     { Ethernet II,Ethernet SNAP }
          EthernetII,EthernetSNAP   : CASE PacketType OF
                    $0800   :  ChkLayer3Protocol := IP;{ IP }
                    $0806   :  ChkLayer3Protocol := ARP;{ ARP }
                    $8035   :  ChkLayer3Protocol := RARP;{ RARP }
                    $8137   :  ChkLayer3Protocol := IPX;{ IPX }
                    $814c   :  ChkLayer3Protocol := SNMP;{ SNMP }
                    $8191   :  ChkLayer3Protocol := NetBeui;{ NetBeui }
                    ELSE ChkLayer3Protocol := OtherL3;{ Other }
                    END;
     { Ethernet 802.3 }
          Ethernet802_3     :   ChkLayer3Protocol := IPX;{ IPX }
     { Ethernet 802.2 }
          Ethernet802_2     :   CASE PacketType OF
                    $e0e0           : ChkLayer3Protocol := IPX;{ IPX }
                    $f0f0           : ChkLayer3Protocol := NetBeui;{ NetBeui }
                    ELSE ChkLayer3Protocol := OtherL3;{ Other }
                    END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ChkLayer4Protocol;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Check what layer 4 protocol is?                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ChkLayer4Protocol(Index : integer;ProtocolType : Byte) : integer;
BEGIN
     CASE Index OF
          IPX{ IPX }     :    CASE ProtocolType OF
                            $00..$04   :   ;
                            $05        :   ChkLayer4Protocol := SPX;{ SPX }
                            $11        :   ChkLayer4Protocol := NCP;{ NCP }
                            $14        :   ChkLayer4Protocol := Netbios;{ NetBios Type 20 }
                            $20        :   ChkLayer4Protocol := Netbios;{ NetBios Type 32 }
                            ELSE ChkLayer4Protocol := OtherL4;{ Other }
                            END;
          IP{ IP }       :    CASE ProtocolType OF
                            $01   :   ChkLayer4Protocol := ICMP;{ ICMP }
                            $06   :   ChkLayer4Protocol := TCP;{ TCP }
                            $11   :   ChkLayer4Protocol := UDP;{ UDP }
                            ELSE ChkLayer4Protocol := OtherL4;{ Other }
                            END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ChkUpLayerProtocol;                                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Check what upper layer protocol is?                บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ChkUpLayerProtocol(Index : integer;Port : Word) : integer;
BEGIN
     CASE Index OF
          TCP{ TCP }  :   CASE Port OF
                             $0014  :   ChkUpLayerProtocol := FTP_Data;{ FTP-Data }
                             $0015  :   ChkUpLayerProtocol := FTP;{ FTP }
                             $0017  :   ChkUpLayerProtocol := Telnet;{ Telnet }
                             $0019  :   ChkUpLayerProtocol := SMTP;{ SMTP }
                             $004f  :   ChkUpLayerProtocol := Finger;{ Finger }
                             $0201  :   ChkUpLayerProtocol := Rlogin;{ Rlogin }
                             $0212  :   ChkUpLayerProtocol := RPC;{ RPC }
                        ELSE ChkUpLayerProtocol := OtherUL;{ Other }
                        END;
          UDP{ UDP }  :   CASE Port OF
                             $00a1  :   ChkUpLayerProtocol := UDP_SNMP;{ UDP-SNMP }
                        ELSE ChkUpLayerProtocol := OtherUL;{ Other }
                        END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION CntExtProtocol;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Count Extend protocol in specific section          บ
 บ                 ณ Return count value of Extend protocol in section   บ
 บ                 ณ [Section].If error return -1                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION CntExtProtocol(Section : string) :integer;
VAR      Cnt : integer;
         S   : string;
BEGIN
     Cnt := 1;
     GetProfileString(INIFile, Section, Chr(Cnt DIV 10+48)+ Chr(Cnt MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          CntExtProtocol := -1;
          Exit;
     END;
     { ---------- }
     WHILE  ( S <> DefaultString ) AND ( Cnt <= ExtProtocolLimit ) DO
     BEGIN
          Inc(Cnt);
          GetProfileString(INIFile, Section, Chr(Cnt DIV 10+48)+ Chr(Cnt MOD 10+48), S, DefaultString);
          { checkError }
          IF INIF_ReadError THEN
          BEGIN
               CntExtProtocol := -1;
               Exit;
          END;
          { ---------- }
     END;
     CntExtProtocol := Cnt - 1;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtName;                                               บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read Name of Extend protocol from .INI file        บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtName(Section : string; Number : shortint; VAR Name : string);
VAR       S : string;
          I : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          Name := 'ERROR';
          Exit;
     END;
     { ---------- }
     I := Pos(' ',S);
     Name := S;
     Delete(S,1,I);
     Delete(Name,I,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtL2;                                                 บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 2 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL2(Section : string; Number : shortint; VAR L2 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          L2 := 'ERROR';
          Exit;
     END;
     { ---------- }
     FOR I:=1 TO 2 DO
     BEGIN
          J := Pos(' ',S);
          L2 := S;
          Delete(S,1,J);
     END;
     Delete(L2,J,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtL3;                                                 บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 3 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL3(Section : string; Number : shortint; VAR L3 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          L3 := 'ERROR';
          Exit;
     END;
     { ---------- }
     FOR I:=1 TO 3 DO
     BEGIN
          J := Pos(' ',S);
          L3 := S;
          Delete(S,1,J);
     END;
     Delete(L3,J,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtL4;                                                 บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 4 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL4(Section : string; Number : shortint; VAR L4 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          L4 := 'ERROR';
          Exit;
     END;
     { ---------- }
     FOR I:=1 TO 4 DO
     BEGIN
          J := Pos(' ',S);
          L4 := S;
          Delete(S,1,J);
     END;
     Delete(L4,J,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtOffset;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read offset of Extend protocol from .INI file      บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtOffset(Section : string; Number : shortint; VAR Offset : string);
VAR       S : string;
          I,J,K : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          Offset := 'ERROR';
          Exit;
     END;
     { ---------- }
     IF Section = 'Layer 3 Protocol' THEN  K := 3;
     IF Section = 'Layer 4 Protocol' THEN  K := 4;
     IF Section = 'Upper Layer Protocol' THEN  K := 5;
     FOR I:=1 TO K DO
     BEGIN
          J := Pos(' ',S);
          Offset := S;
          Delete(S,1,J);
     END;
     Delete(Offset,J,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadExtCondition;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read condition of Extend protocol from .INI file   บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtCondition(Section : string; Number : shortint; VAR Condition : string);
VAR       S : string;
          I,J,K : integer;
BEGIN
     GetProfileString(INIFile, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
     { checkError }
     IF INIF_ReadError THEN
     BEGIN
          Condition := 'ERROR';
          Exit;
     END;
     { ---------- }
     IF Section = 'Layer 3 Protocol' THEN  K := 4;
     IF Section = 'Layer 4 Protocol' THEN  K := 5;
     IF Section = 'Upper Layer Protocol' THEN  K := 6;
     FOR I:=1 TO K DO
     BEGIN
          J := Pos(' ',S);
          Condition := S;
          Delete(S,1,J);
     END;
     Delete(Condition,J,Length(S)+1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ReadExt2Table;                                              บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read Extend protocol name in .INI file             บ
 บ                 ณ to table lookup                                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ReadExt2Table :Boolean;
VAR     I : shortint;
        S : string;
BEGIN
     ReadExt2Table := FALSE;
     FOR I:=1 TO ExtL3Count DO
     BEGIN
          ReadExtName('Layer 3 Protocol',I,S);
          { checkError }
          IF S = 'ERROR' THEN Exit;
          { --------- }
          ExtLayer3Table[I] := S;
     END;
     FOR I:=1 TO ExtL4Count DO
     BEGIN
          ReadExtName('Layer 4 Protocol',I,S);
          { checkError }
          IF S = 'ERROR' THEN Exit;
          { --------- }
          ExtLayer4Table[I] := S;
     END;
     FOR I:=1 TO ExtULCount DO
     BEGIN
          ReadExtName('Upper Layer Protocol',I,S);
          { checkError }
          IF S = 'ERROR' THEN Exit;
          { --------- }
          ExtUpLayerTable[I] := S;
     END;
     ReadExt2Table := TRUE;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE VerifyPacket;                                              บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Find what protocol in use                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE VerifyPacket(VAR IndexL2,IndexL3,IndexL4,IndexUL : integer);
VAR  tByte           : Byte;
     tWord           : Word;
     ttWord          : Word;
     Rcvpacket       : PacketFrame;
     RcvHeader       : MACHeader;

     { use for Extend protocol in .INI file }
     Str : string;
     TempIndex,Code,Condition,Offset    : integer;
     ExtNo,ExtCnt    : shortint;
     ExtIndexL3,ExtIndexL4,ExtIndexUL : shortint;
BEGIN
     Rcvpacket := Verpacket;
     RcvHeader := VerHeader;

     { Initial index }
     IndexL2 := 0;
     IndexL3 := 0;
     IndexL4 := 0;
     IndexUL := 0;
     { Check what layer 2 protocol is? }
     tWord := SwapWord(RcvHeader.TypeLen);
     ttWord := (Rcvpacket[14] SHL 8) + Rcvpacket[15];
     IndexL2 := ChkLayer2Protocol(tWord,ttWord);
     { Check what layer 3 protocol is? }
     CASE IndexL2 OF
          EthernetII    :   BEGIN
                            tWord := SwapWord(RcvHeader.TypeLen);
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_3 :   IndexL3 := IPX;
          EthernetSNAP  :   BEGIN
                            tWord := (Rcvpacket[20] SHL 8) + Rcvpacket[21];
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_2 :   BEGIN
                            tWord := (Rcvpacket[14] SHL 8) + Rcvpacket[15];
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
     END;

     { Check layer 3 protocol in .INI file }
     IF (ExtL3Count > 0) AND ((IndexL3 = 0) OR (IndexL3=OtherL3)) THEN
     BEGIN
          ExtNo := 1;   { reference order of Extend protocol }
          ExtCnt := ExtL3Count;
          Found := FALSE;
          WHILE (ExtCnt > 0) AND Not(Found) DO
          BEGIN
               ReadExtL2('Layer 3 Protocol',ExtNo,Str);
               Val(Str,TempIndex,Code);
               IF TempIndex = IndexL2 THEN
               BEGIN
                    ReadExtCondition('Layer 3 Protocol',ExtNo,Str);
                    Val(Str,Condition,Code);
                    ReadExtOffset('Layer 3 Protocol',ExtNo,Str);
                    Val(Str,Offset,Code);
                    IF Condition = ((Rcvpacket[Offset] SHL 8) + Rcvpacket[Offset+1]) THEN
                    BEGIN
                         Found := TRUE;
                         ExtIndexL3 := ExtNo;
                    END;
               END;
               Inc(ExtNo);
               Dec(ExtCnt);
          END;
          IF Found = TRUE THEN
             IndexL3 := LastLayer3Protocol + ExtIndexL3;
     END;

     { Check what layer 4 protocol is? }

     CASE IndexL3 OF
          IPX     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tByte := Rcvpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_3   :  BEGIN
                                            tByte := Rcvpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := Rcvpacket[27];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_2   :  BEGIN
                                            tByte := Rcvpacket[22];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                    END;
          IP      : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tByte := Rcvpacket[23];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := Rcvpacket[31];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                    END;
     END;
     { Check layer 4 protocol in .INI file }
     IF (ExtL4Count > 0) AND ((IndexL4 = 0) OR (IndexL4 = OtherL4)) THEN
     BEGIN
          ExtNo := 1;   { reference order of Extend protocol }
          ExtCnt := ExtL4Count;
          Found := FALSE;
          WHILE (ExtCnt > 0) AND Not(Found) DO
          BEGIN
               ReadExtL2('Layer 4 Protocol',ExtNo,Str);
               Val(Str,TempIndex,Code);
               IF TempIndex = IndexL2 THEN
               BEGIN
                    ReadExtL3('Layer 4 Protocol',ExtNo,Str);
                    Val(Str,TempIndex,Code);
                    IF TempIndex = IndexL3 THEN
                    BEGIN
                         ReadExtCondition('Layer 4 Protocol',ExtNo,Str);
                         Val(Str,Condition,Code);
                         ReadExtOffset('Layer 4 Protocol',ExtNo,Str);
                         Val(Str,Offset,Code);
                         IF Condition = Rcvpacket[Offset] THEN
                         BEGIN
                              Found := TRUE;
                              ExtIndexL4 := ExtNo;
                         END;
                    END;
               END;
               Inc(ExtNo);
               Dec(ExtCnt);
          END;
          IF Found = TRUE THEN
             IndexL4 := LastLayer4Protocol + ExtIndexL4;
     END;

     { Check what upper layer protocol is? }

     IF IndexL3 = IP THEN
     CASE IndexL4 OF
          TCP     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tWord := (Rcvpacket[34] SHL 8) + Rcvpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (Rcvpacket[42] SHL 8) + Rcvpacket[43];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                    END;
          UDP     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tWord := (Rcvpacket[34] SHL 8) + Rcvpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (Rcvpacket[42] SHL 8) + Rcvpacket[43];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                    END;
     END;
     { Check upper layer protocol in .INI file }
     IF (ExtULCount > 0) AND ((IndexUL = 0) OR (IndexUL = OtherUL)) THEN
     BEGIN
          ExtNo := 1;   { reference order of Extend protocol }
          ExtCnt := ExtULCount;
          Found := FALSE;
          WHILE (ExtCnt > 0) AND Not(Found) DO
          BEGIN
               ReadExtL2('Upper Layer Protocol',ExtNo,Str);
               Val(Str,TempIndex,Code);
               IF TempIndex = IndexL2 THEN
               BEGIN
                    ReadExtL3('Upper Layer Protocol',ExtNo,Str);
                    Val(Str,TempIndex,Code);
                    IF TempIndex = IndexL3 THEN
                    BEGIN
                         ReadExtL4('Upper Layer Protocol',ExtNo,Str);
                         Val(Str,TempIndex,Code);
                         IF TempIndex = IndexL4 THEN
                         BEGIN
                              ReadExtCondition('Upper Layer Protocol',ExtNo,Str);
                              Val(Str,Condition,Code);
                              ReadExtOffset('Upper Layer Protocol',ExtNo,Str);
                              Val(Str,Offset,Code);
                              IF Condition = ((Rcvpacket[Offset] SHL 8) + Rcvpacket[Offset+1]) THEN
                              BEGIN
                                   Found := TRUE;
                                   ExtIndexUL := ExtNo;
                              END;
                         END;
                    END;
               END;
               Inc(ExtNo);
               Dec(ExtCnt);
          END;
          IF Found = TRUE THEN
             IndexUL := LastUpLayerProtocol + ExtIndexUL;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION GetTime2;                                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Call GetTime by pass value type TIME (ONE 17/1/40) บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetTime2(Var Input:Time):String;
BEGIN
   GetTime(Input.Hour,Input.Minute,Input.Second,Input.Sec100);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ReadPacketArray;                                           บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read Packet from EMS Buffer                        บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadPacketArray(Point:Word;VAR Data:TPacketInfo);
VAR  PageNum                      : Word;
     Element                      : Word;
BEGIN
     PageNum := Point DIV ElementNum;
     Element := (Point MOD ElementNum) + 1;
     PacketBuffer.MapIn(PageNum, 0);
     Data := PacketBuffer.PacketArry^[ Element ];
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE WritePacketArray;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Write Packet to EMS Buffer                         บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure WritePacketArray(Point:Word;Data:TPacketInfo);
VAR  PageNum                      : Word;
     Element                      : Word;
BEGIN
     PageNum := Point DIV ElementNum;
     Element := (Point MOD ElementNum) + 1;
     PacketBuffer.MapIn(PageNum, 0);
     PacketBuffer.PacketArry^[ Element ] := Data;
END;

procedure all(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+10,b+11,'A',e,4);
     w.writetext(a+23,b+11,'ll',e,0);
end;

procedure datalink(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a-40,b,c-40,d,'',10,10,e);
     w.writetext(a+14-40,b+11,'D',e,4);
     w.writetext(a+43-40,b+11,'atalink',e,0);
end;

procedure network(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a-40,b,c-40,d,'',10,10,e);
     w.writetext(a+18-40,b+11,'N',e,4);
     w.writetext(a+45-40,b+11,'etwork',e,0);
end;

procedure transport(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a-40,b,c-40,d,'',10,10,e);
     w.writetext(a+10-40,b+11,'T',e,4);
     w.writetext(a+42-40,b+11,'ransport',e,0);
end;

procedure tcpip(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a-40,b,c-40,d,'',10,10,e);
     w.writetext(a+19-40,b+11,'T',e,0);
	 w.writetext(a+27-40,b+11,'C',e,4);
     w.writetext(a+47-40,b+11,'P/IP',e,0);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayProtocol;                                           บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Show protocol in use                               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DisplayProtocol;
VAR
     ProtocolStat    : TAllProtocolStat;
     IndexL2,IndexL3,IndexL4,IndexUL : integer;
     I,K             : integer;
     ModeSelect,OldMode : shortint;
     EachProtocolStat   : ARRAY [1..LastProtocol] OF TProtocolCnt;
                          { Indexes of ARRAY meaning are
                            EthernetII         1     SPX                12
                            Ethernet802_3      2     NCP                13
                            EthernetSNAP       3     NetBios            14
                            Ethernet802_2      4     ICMP               15
                            IPX                5     TCP                16
                            NetBeui            6     UDP                17
                            IP                 7     OtherL4            18
                            ARP                8     Telnet             19
                            RARP               9     FTP                20
                            SNMP               10    FTP_Data           21
                            OtherL3            11    Finger             22
                                                     Rlogin             23
                                                     RPC                24
                                                     SMTP               25
                                                     UDP-SNMP           26
                                                     OtherUL            LastProtocol }

     { use for Extend protocol in .INI file }
     ExtProtocolStat : ARRAY [1..ExtProtocolLimit*3] OF TProtocolCnt;
     L2ExtL3ProtocolStat : ARRAY [1..LastLayer2Protocol,1..ExtProtocolLimit] OF TProtocolCnt;

      tPacket    : TPacketInfo;
      tInfo      : TPacketInfo;
      tFile      : TPacketFile;
      tFrame     : PacketFrame;
      Count      : Integer;
      ByteCount  : LongInt;
      percent,temp : longint;
      oldstyle   : textsettingstype;

BEGIN { bbbbb }
     fer_tip := 5;
     muta_fer:= false;
     OldMode:=0;
     ModeSelect := 0;

     gettextsettings(oldstyle); { get text style informations }

     w.hide;
     w.newwin(20,40,620,440,'Protocol Distribution',true);
     w.writetext(260,80,'Datalink Layer',false,1);
     {w.newbut(520,110,555,130,'~P~kt',9,os2,'');
     w.newbut(520,140,555,160,'~B~yt',9,os2,'');}
{     w.newbut(520,170,555,190,'~A~ll',9,os2,'');}
{     all(520,170,555,190,false);}
{     w.newbut(90,330,120,350,'~<~-',9,os2,'');
     w.newbut(130,330,160,350,'-~>~',9,os2,'');}
{     w.newbut(180,330,260,350,'~D~atalink',9,os2,'');
     w.newbut(280,330,360,350,'~N~etwork',9,os2,'');
     w.newbut(380,330,460,350,'~T~ransport',9,os2,'');
     w.newbut(480,330,560,350,'T~C~P/IP',9,os2,'');}
     datalink(180,330,260,350,False);
     network(280,330,360,350,False);
     transport(380,330,460,350,False);
     tcpip(480,330,560,350,False);
     w.chenar2(30,360,610,430,true);
     w.writetext(85,380,'Total Packets:',false,0);
     w.chenar2(370,100,490,250,true);
     w.linie(455,102,455,248,10,2,true);
     w.writetext(412,110,'EthernetII',false,0);
     w.writetext(412,120,'802.3',false,0);
     w.writetext(412,130,'SNAP',false,0);
     w.writetext(412,140,'802.2',false,0);
     { disable button }
     w.setbuton(2,false);
     w.setbuton(3,false);
     w.setbuton(7,false);

     init_graph(100,250,4,10,50,15,1,1,0,0,0,10,1);
     graph_scale(horizdir,horizdir,'protocol','%');

     { write x grid name }
     settextstyle(2,horizdir,4);
     settextjustify(centertext,toptext);
     outtextxy(xco+1*xscale,yco+7,'EthernetII');
     outtextxy(xco+2*xscale,yco+7,'802.3');
     outtextxy(xco+3*xscale,yco+7,'SNAP');
     outtextxy(xco+4*xscale,yco+7,'802.2');

     { return to old style }
     with oldstyle do
     begin
          settextstyle(font,direction,charsize);
          settextjustify(horiz,vert);
     end;

     w.show;

     { set timer interrupt }
     Timer1.Init(1);
     Timer1.Start;

     { Init protocol counter value }
     ResetProtocolCnt(ProtocolStat);
     FOR I:=1 TO ExtProtocolLimit*3 DO
     BEGIN
          ExtProtocolStat[I].PacketCnt := 0;
          ExtProtocolStat[I].ByteCnt   := 0;
     END;
     FOR I:=1 TO LastLayer2Protocol DO
     FOR J:=1 TO ExtProtocolLimit DO
     BEGIN
          L2ExtL3ProtocolStat[I,J].PacketCnt := 0;
          L2ExtL3ProtocolStat[I,J].ByteCnt   := 0;
     END;

     { Init before use Extend protocol in .INI file }
     ExtL3Count := CntExtProtocol('Layer 3 Protocol');
     { checkError }
     IF ExtL3Count = -1 THEN Exit;
     { ---------- }
     ExtL4Count := CntExtProtocol('Layer 4 Protocol');
     { checkError }
     IF ExtL4Count = -1 THEN Exit;
     { ---------- }
     ExtULCount := CntExtProtocol('Upper Layer Protocol');
     { checkError }
     IF ExtULCount = -1 THEN Exit;
     { ---------- }
     IF Not(ReadExt2Table) THEN Exit;
     { Init display mode }

     Found := False;
     Count := 0;    { Save Num Packet }

     REPEAT
{ -------- check is keyboard pressed? -------------------------------------- }
           IF KeyPressed THEN
           BEGIN
                Key := ReadKey;
                CASE ModeSelect OF
                0 : case Key of
{                         '<',',' : inc(ModeSelect,4);
                         '>','.' : inc(ModeSelect);}

                         'N','n' : begin
								   network(280,330,360,350,True);
						           inc(ModeSelect);
								   end;

                         'T','t' : begin
								   transport(380,330,460,350,True);
								   inc(ModeSelect,2);
                                   end;

                         'C','c' : begin
								   tcpip(480,330,560,350,True);
						           inc(ModeSelect,3);
								   end;

{                         'A','a' : begin
                         		   all(520,170,555,190,True);
								   inc(ModeSelect,4);
								   end;}
                    end;
                1 : case Key of
{                         '<',',' : dec(ModeSelect);
                         '>','.' : inc(ModeSelect);}

                         'D','d' : begin
								   datalink(180,330,260,350,True);
								   dec(ModeSelect);
								   end;

                         'T','t' : begin
								   transport(380,330,460,350,True);
						           inc(ModeSelect);
								   end;

                         'C','c' : begin
								   tcpip(480,330,560,350,True);
						           inc(ModeSelect,2);
								   end;

{                         'A','a' : begin
						           all(520,170,555,190,True);
						           inc(ModeSelect,3);
								   end;}
                    end;
                2 : case Key of
{                         '<',',' : dec(ModeSelect);
                         '>','.' : inc(ModeSelect);}

                         'D','d' : begin
								   datalink(180,330,260,350,True);
						           dec(ModeSelect,2);
								   end;

                         'N','n' : begin
						 		   network(280,330,360,350,True);
								   dec(ModeSelect);
								   end;

                         'C','c' : begin
								   tcpip(480,330,560,350,True);
						           inc(ModeSelect);
								   end;

{                         'A','a' : begin
								   all(520,170,555,190,True);
						           inc(ModeSelect,2);
								   end;}
                    end;
                3 : case Key of
{                         '<',',' : dec(ModeSelect);
                         '>','.' : inc(ModeSelect);}

                         'D','d' : begin
						 		   datalink(180,330,260,350,True);
						           dec(ModeSelect,3);
								   end;

                         'N','n' : begin
								   network(280,330,360,350,True);
						           dec(ModeSelect,2);
								   end;

                         'T','t' : begin
								   transport(380,330,460,350,True);
						           dec(ModeSelect);
								   end;

{                         'A','a' : begin
 								   all(520,170,555,190,True);
						           inc(ModeSelect);
								   end;}
                    end;
                4 : case Key of
{                         '<',',' : dec(ModeSelect);
                         '>','.' : dec(ModeSelect,4);}

                         'D','d' : begin
							       datalink(180,330,260,350,True);
						           dec(ModeSelect,4);
								   end;

                         'N','n' : begin
								   network(280,330,360,350,True);
						           dec(ModeSelect,3);
								   end;

                         'T','t' : begin
								   transport(380,330,460,350,True);
						           dec(ModeSelect,2);
								   end;

                         'C','c' : begin
						           tcpip(480,330,560,350,True);
						           dec(ModeSelect);
								   end;
                    end;
                END;
           END;

{ -------- Has a packet recieve? ------------------------------------------- }
           IF (PacketCount = 1) THEN
           BEGIN
                Move(Rcvpacket,tInfo,RcvLength);
                GetTime2(tInfo.PktTime);
                tInfo.Length := RcvLength;
                WritePacketArray(Count,tInfo);
                Inc(count);
                Inc(ByteCount,RcvLength);
                IF RcvLength < 60 THEN Inc(INFORMATION.Undersize_S);
                IF RcvLength > 1514 THEN Inc(INFORMATION.Oversize_S);
                RcvLength   := 0;
                PacketCount := 0;            { Reset flag for new frames }
           END;

{ -------- If timer1 out, display to screen ---------------------------------- }
           IF Timer1.Timeout THEN
           BEGIN
                K := 0;
                { Check INFORMATION }
                INFORMATION.Packet_S := Count;
                INFORMATION.Utilize  := TRUNC(ByteCount/500000);
                INFORMATION.Drop_S   := LOST;
                INFORMATION.Byte_S   := ByteCount;
                WHILE K < Count DO
                BEGIN
                     ReadPacketArray(K,tPacket);
                     INC(K);
                     Move(tPacket,VerPacket,tPacket.Length);
                     Move(tPacket,VerHeader,Sizeof(VerHeader));
                     VerifyPacket(IndexL2,IndexL3,IndexL4,IndexUL);
                     IF IndexL3 <= LastLayer3Protocol THEN
                        IncProtocolCnt(ProtocolStat.L2L3ProtocolStat[IndexL2,IndexL3])
                     ELSE
                     BEGIN
                          IncProtocolCnt(L2ExtL3ProtocolStat[IndexL2,IndexL3 - LastLayer3Protocol]);
                          IncProtocolCnt(ExtProtocolStat[IndexL3 - LastLayer3Protocol]);
                     END;
                     IF IndexL4 <> 0 THEN
                     BEGIN
                          IF IndexL4 <= LastLayer4Protocol THEN
                          BEGIN
                               CASE IndexL3 OF
                                    IPX     : CASE IndexL2 OF
                                                   EthernetII      :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IPX_EtherIIStat[IndexL4])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IPX_EtherIIStat[4]);

                                                   Ethernet802_3   :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IPX_Ether8023Stat[IndexL4])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IPX_Ether8023Stat[4]);

                                                   EthernetSNAP    :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IPX_EtherSNAPStat[IndexL4])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IPX_EtherSNAPStat[4]);

                                                   Ethernet802_2   :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IPX_Ether8022Stat[IndexL4])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IPX_Ether8022Stat[4]);
                                              END;
                                    IP      : CASE IndexL2 OF
                                                   EthernetII      :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IP_EtherIIStat[IndexL4-3])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IP_EtherIIStat[4]);

                                                   EthernetSNAP    :  IF IndexL4 <> LastLayer4Protocol THEN
                                                                      IncProtocolCnt(ProtocolStat.IP_EtherSNAPStat[IndexL4-3])
                                                                      ELSE IncProtocolCnt(ProtocolStat.IP_EtherSNAPStat[4]);
                                              END;
                               END;
                          END
                          ELSE
                              IncProtocolCnt(ExtProtocolStat[ExtProtocolLimit + IndexL4 - LastLayer4Protocol]);
                     END;
                     IF IndexUL <> 0 THEN
                     BEGIN
                          IF IndexUL <= LastUpLayerProtocol THEN
                          BEGIN
                               CASE IndexL4 OF
                                    TCP     : CASE IndexL2 OF
                                                   EthernetII      :  IF IndexUL <> LastUpLayerProtocol THEN
                                                                      IncProtocolCnt(ProtocolStat.TCP_EtherIIStat[IndexUL])
                                                                      ELSE IncProtocolCnt(ProtocolStat.TCP_EtherIIStat[8]);
                                                   EthernetSNAP    :  IF IndexUL <> LastUpLayerProtocol THEN
                                                                      IncProtocolCnt(ProtocolStat.TCP_EtherSNAPStat[IndexUL])
                                                                      ELSE IncProtocolCnt(ProtocolStat.TCP_EtherSNAPStat[8]);
                                              END;
                                    UDP     : CASE IndexL2 OF
                                                   EthernetII      :  IF IndexUL <> LastUpLayerProtocol THEN
                                                                      IncProtocolCnt(ProtocolStat.UDP_EtherIIStat[IndexUL-7])
                                                                      ELSE IncProtocolCnt(ProtocolStat.UDP_EtherIIStat[8]);
                                                   EthernetSNAP    :  IF IndexUL <> LastUpLayerProtocol THEN
                                                                      IncProtocolCnt(ProtocolStat.UDP_EtherSNAPStat[IndexUL-7])
                                                                      ELSE IncProtocolCnt(ProtocolStat.UDP_EtherSNAPStat[8]);
                                              END;
                               END;
                          END
                          ELSE
                              IncProtocolCnt(ExtProtocolStat[ExtProtocolLimit*2 + IndexUL - LastUpLayerProtocol]);
                     END;
                END; { end while }

                { Init protocol counter value }
                FOR I:=1 TO LastProtocol DO
                BEGIN
                     EachProtocolStat[I].PacketCnt := 0;
                     EachProtocolStat[I].ByteCnt   := 0;
                END;
                { Count each layer 2 and 3 protocol }
                FOR IndexL2:=1 TO LastLayer2Protocol DO
                FOR IndexL3:=1 TO LastLayer3Protocol DO
                BEGIN
                     EachProtocolStat[IndexL2].PacketCnt :=
                     EachProtocolStat[IndexL2].PacketCnt +
                     ProtocolStat.L2L3ProtocolStat[IndexL2,IndexL3].PacketCnt;

                     EachProtocolStat[IndexL2].ByteCnt :=
                     EachProtocolStat[IndexL2].ByteCnt +
                     ProtocolStat.L2L3ProtocolStat[IndexL2,IndexL3].ByteCnt;

                     EachProtocolStat[4 + IndexL3].PacketCnt :=
                     EachProtocolStat[4 + IndexL3].PacketCnt +
                     ProtocolStat.L2L3ProtocolStat[IndexL2,IndexL3].PacketCnt;

                     EachProtocolStat[4 + IndexL3].ByteCnt :=
                     EachProtocolStat[4 + IndexL3].ByteCnt +
                     ProtocolStat.L2L3ProtocolStat[IndexL2,IndexL3].ByteCnt;
                END;
                FOR IndexL2:=1 TO LastLayer2Protocol DO
                FOR J:=1 TO ExtProtocolLimit DO
                BEGIN
                     EachProtocolStat[IndexL2].PacketCnt :=
                     EachProtocolStat[IndexL2].PacketCnt +
                     L2ExtL3ProtocolStat[IndexL2,J].PacketCnt;

                     EachProtocolStat[IndexL2].ByteCnt :=
                     EachProtocolStat[IndexL2].ByteCnt +
                     L2ExtL3ProtocolStat[IndexL2,J].ByteCnt;
                END;
                { Count each layer 4 protocol }
                FOR IndexL4:=1 TO 3 DO
                BEGIN
                     { Count next layer protocol of IPX }
                     EachProtocolStat[11 + IndexL4].PacketCnt :=
                     EachProtocolStat[11 + IndexL4].PacketCnt +
                     ProtocolStat.IPX_EtherIIStat[IndexL4].PacketCnt +
                     ProtocolStat.IPX_Ether8023Stat[IndexL4].PacketCnt +
                     ProtocolStat.IPX_EtherSNAPStat[IndexL4].PacketCnt +
                     ProtocolStat.IPX_Ether8022Stat[IndexL4].PacketCnt;

                     EachProtocolStat[11 + IndexL4].ByteCnt :=
                     EachProtocolStat[11 + IndexL4].ByteCnt +
                     ProtocolStat.IPX_EtherIIStat[IndexL4].ByteCnt +
                     ProtocolStat.IPX_Ether8023Stat[IndexL4].ByteCnt +
                     ProtocolStat.IPX_EtherSNAPStat[IndexL4].ByteCnt +
                     ProtocolStat.IPX_Ether8022Stat[IndexL4].ByteCnt;

                     { Count next layer protocol of IP }
                     EachProtocolStat[14 + IndexL4].PacketCnt :=
                     EachProtocolStat[14 + IndexL4].PacketCnt +
                     ProtocolStat.IP_EtherIIStat[IndexL4].PacketCnt +
                     ProtocolStat.IP_EtherSNAPStat[IndexL4].PacketCnt;

                     EachProtocolStat[14 + IndexL4].ByteCnt :=
                     EachProtocolStat[14 + IndexL4].ByteCnt +
                     ProtocolStat.IP_EtherIIStat[IndexL4].ByteCnt +
                     ProtocolStat.IP_EtherSNAPStat[IndexL4].ByteCnt;
                END;
                { Count other protocol of layer 4 }
                EachProtocolStat[18].PacketCnt :=
                EachProtocolStat[18].PacketCnt +
                ProtocolStat.IPX_EtherIIStat[4].PacketCnt +
                ProtocolStat.IPX_Ether8023Stat[4].PacketCnt +
                ProtocolStat.IPX_EtherSNAPStat[4].PacketCnt +
                ProtocolStat.IPX_Ether8022Stat[4].PacketCnt +
                ProtocolStat.IP_EtherIIStat[4].PacketCnt +
                ProtocolStat.IP_EtherSNAPStat[4].PacketCnt;

                EachProtocolStat[18].ByteCnt :=
                EachProtocolStat[18].ByteCnt +
                ProtocolStat.IPX_EtherIIStat[4].ByteCnt +
                ProtocolStat.IPX_Ether8023Stat[4].ByteCnt +
                ProtocolStat.IPX_EtherSNAPStat[4].ByteCnt +
                ProtocolStat.IPX_Ether8022Stat[4].ByteCnt +
                ProtocolStat.IP_EtherIIStat[4].ByteCnt +
                ProtocolStat.IP_EtherSNAPStat[4].ByteCnt;
                { Count each upper layer protocol }
                { Count upper layer protocol of TCP }
                FOR IndexUL:=1 TO 7 DO
                BEGIN
                     EachProtocolStat[18 + IndexUL].PacketCnt :=
                     EachProtocolStat[18 + IndexUL].PacketCnt +
                     ProtocolStat.TCP_EtherIIStat[IndexUL].PacketCnt +
                     ProtocolStat.TCP_EtherSNAPStat[IndexUL].PacketCnt;

                     EachProtocolStat[18 + IndexUL].ByteCnt :=
                     EachProtocolStat[18 + IndexUL].ByteCnt +
                     ProtocolStat.TCP_EtherIIStat[IndexUL].ByteCnt +
                     ProtocolStat.TCP_EtherSNAPStat[IndexUL].ByteCnt;
                END;
                { Count upper layer protocol of UDP }
                EachProtocolStat[26].PacketCnt :=
                EachProtocolStat[26].PacketCnt +
                ProtocolStat.UDP_EtherIIStat[1].PacketCnt +
                ProtocolStat.UDP_EtherSNAPStat[1].PacketCnt;

                EachProtocolStat[26].ByteCnt :=
                EachProtocolStat[26].ByteCnt +
                ProtocolStat.UDP_EtherIIStat[1].ByteCnt +
                ProtocolStat.UDP_EtherSNAPStat[1].ByteCnt;
                { Count other protocol of upper layer }
                EachProtocolStat[LastProtocol].PacketCnt :=
                EachProtocolStat[LastProtocol].PacketCnt +
                ProtocolStat.TCP_EtherIIStat[8].PacketCnt +
                ProtocolStat.TCP_EtherSNAPStat[8].PacketCnt +
                ProtocolStat.UDP_EtherIIStat[8].PacketCnt +
                ProtocolStat.UDP_EtherSNAPStat[8].PacketCnt;

                EachProtocolStat[LastProtocol].ByteCnt :=
                EachProtocolStat[LastProtocol].ByteCnt +
                ProtocolStat.TCP_EtherIIStat[8].ByteCnt +
                ProtocolStat.TCP_EtherSNAPStat[8].ByteCnt +
                ProtocolStat.UDP_EtherIIStat[8].ByteCnt +
                ProtocolStat.UDP_EtherSNAPStat[8].ByteCnt;

                { display each protocol count }

                CASE ModeSelect OF
                     0 : BEGIN
                           w.hide;
                           if OldMode <> ModeSelect then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Protocol Distribution',true);
                             w.writetext(260,80,'Datalink Layer',false,1);
{						     all(520,170,555,190,false);}
                             datalink(180,330,260,350,False);
     						 network(280,330,360,350,False);
     						 transport(380,330,460,350,False);
     						 tcpip(480,330,560,350,False);
     						 w.chenar2(30,360,610,430,true);
     						 w.writetext(85,380,'Total Packets:',false,0);
     						 w.chenar2(370,100,490,250,true);
     						 w.linie(455,102,455,248,10,2,true);
     						 w.writetext(412,110,'EthernetII',false,0);
     						 w.writetext(412,120,'802.3',false,0);
     						 w.writetext(412,130,'SNAP',false,0);
     						 w.writetext(412,140,'802.2',false,0);
{                             w.newbut(520,110,555,130,'~P~kt',9,os2,'');
                             w.newbut(520,140,555,160,'~B~yt',9,os2,'');
                             w.newbut(520,170,555,190,'~A~ll',9,os2,'');
                             w.newbut(85,330,115,350,'~<~-',9,os2,'');
                             w.newbut(125,330,155,350,'-~>~',9,os2,'');
                             w.newbut(175,330,255,350,'~D~atalink',9,os2,'');
                             w.newbut(275,330,355,350,'~N~etwork',9,os2,'');
                             w.newbut(375,330,455,350,'~T~ransport',9,os2,'');
                             w.newbut(475,330,555,350,'T~C~P/IP',9,os2,'');
                             w.chenar2(30,360,610,430,true);
                             w.writetext(40,380,'Total Packets:',false,0);
                             w.chenar2(370,100,490,250,true);
                             w.linie(455,102,455,248,10,2,true);
                             w.writetext(375,110,'EthernetII',false,0);
                             w.writetext(375,120,'802.3',false,0);
                             w.writetext(375,130,'SNAP',false,0);
                             w.writetext(375,140,'802.2',false,0);}
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(7,false);

                             init_graph(100,250,4,10,50,15,1,1,0,0,0,10,1);
                             graph_scale(horizdir,horizdir,'protocol','%');
                             { write x grid name }
                             settextstyle(2,horizdir,4);
                             settextjustify(centertext,toptext);
                             outtextxy(xco+1*xscale,yco+7,'EthernetII');
                             outtextxy(xco+2*xscale,yco+7,'802.3');
                             outtextxy(xco+3*xscale,yco+7,'SNAP');
                             outtextxy(xco+4*xscale,yco+7,'802.2');
                             { return to old style }
                             with oldstyle do
                             begin
                                  settextstyle(font,direction,charsize);
                                  settextjustify(horiz,vert);
                             end;
                           end;

                           { refresh graph and other show values }
                           ref_graph;
                           w.fill(460,102,488,248,9,1);
                           w.fill(160,375,190,385,10,1);

                           { show all }
                           for i:=1 to 4 do
                               if EachProtocolStat[i].PacketCnt <> 0 then
                               begin
                                 percent := EachProtocolStat[i].PacketCnt;
                                 temp := 100*percent mod Count;
                                 percent := 100*percent div Count;
                                 if temp > round(Count/2) then inc(percent);
                                 { show graph }
                                 bar_graph(i,percent,4);
                                 { show other display values }
                                 w.texl(465,100+i*10,int2str(EachProtocolStat[i].PacketCnt));
                               end;
                           { show general information }
                           w.texl(160,380,int2str(count));

                           w.show;
                         END;
                     1 : BEGIN
                           w.hide;
                           if OldMode <> ModeSelect then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Protocol Distribution',true);
                             w.writetext(260,80,'Network Layer',false,1);
{							 all(520,170,555,190,false);}
						     datalink(180,330,260,350,False);
     						 network(280,330,360,350,False);
     						 transport(380,330,460,350,False);
     						 tcpip(480,330,560,350,False);
     						 w.chenar2(30,360,610,430,true);
     						 w.writetext(85,380,'Total Packets:',false,0);

{                             w.newbut(520,110,555,130,'~P~kt',9,os2,'');
                             w.newbut(520,140,555,160,'~B~yt',9,os2,'');
                             w.newbut(520,170,555,190,'~A~ll',9,os2,'');
                             w.newbut(85,330,115,350,'~<~-',9,os2,'');
                             w.newbut(125,330,155,350,'-~>~',9,os2,'');
                             w.newbut(175,330,255,350,'~D~atalink',9,os2,'');
                             w.newbut(275,330,355,350,'~N~etwork',9,os2,'');
                             w.newbut(375,330,455,350,'~T~ransport',9,os2,'');
                             w.newbut(475,330,555,350,'T~C~P/IP',9,os2,'');
                             w.chenar2(30,360,610,430,true);
                             w.writetext(40,380,'Total Packets:',false,0);}
                             if ExtL3Count+LastLayer3Protocol > 14 then
                             begin
                               w.chenar2(370,100,490,250+(ExtL3Count+LastLayer3Protocol-14)*10,true);
                               w.linie(455,102,455,248+(ExtL3Count+LastLayer3Protocol-14)*10,10,2,true);
                             end
                             else
                             begin
                               w.chenar2(370,100,490,250,true);
                               w.linie(455,102,455,248,10,2,true);
                             end;
                             w.writetext(412,110,'IPX',false,0);
                             w.writetext(412,120,'NetBeui',false,0);
                             w.writetext(412,130,'IP',false,0);
                             w.writetext(412,140,'ARP',false,0);
                             w.writetext(412,150,'RARP',false,0);
                             w.writetext(412,160,'SNMP',false,0);
                             for i:=1 to ExtL3Count do
                                 w.writetext(412,100+(6+i)*10,ExtLayer3Table[i],false,0);
                             w.writetext(412,100+(7+ExtL3Count)*10,'Other',false,0);

                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(8,false);

                             init_graph(100,250,7+ExtL3Count,10,210 div (7+ExtL3Count),15,1,1,0,0,0,10,1);
                             graph_scale(vertdir,horizdir,'protocol','%');
                             { write x grid name }
                             settextstyle(2,vertdir,4);
                             settextjustify(centertext,toptext);
                             outtextxy(xco+1*xscale-3,yco+7,'IPX');
                             outtextxy(xco+2*xscale-3,yco+7,'NetBeui');
                             outtextxy(xco+3*xscale-3,yco+7,'IP');
                             outtextxy(xco+4*xscale-3,yco+7,'ARP');
                             outtextxy(xco+5*xscale-3,yco+7,'RARP');
                             outtextxy(xco+6*xscale-3,yco+7,'SNMP');
                             for i:=1 to ExtL3Count do
                                 outtextxy(xco+(6+i)*xscale-3,yco+7,ExtLayer3Table[i]);
                             outtextxy(xco+(7+ExtL3Count)*xscale-3,yco+7,'Other');
                             { return to old style }
                             with oldstyle do
                             begin
                                  settextstyle(font,direction,charsize);
                                  settextjustify(horiz,vert);
                             end;
                           end;

                           { refresh graph and other show values }
                           ref_graph;
                           if ExtL3Count+LastLayer3Protocol > 14 then
                              w.fill(460,102,488,248+(ExtL3Count+LastLayer3Protocol-14)*10,9,1)
                           else w.fill(460,102,488,248,9,1);
                           w.fill(160,375,190,385,10,1);

                           { show all }
                           for i:=1 to 6 do
                           begin
                             if EachProtocolStat[4+i].PacketCnt <> 0 then
                             begin
                               percent := EachProtocolStat[4+i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(i,percent,4);
                               { show other display values }
                               w.texl(465,100+i*10,int2str(EachProtocolStat[4+i].PacketCnt));
                             end;
                           end;

                           { for .INI protocol }
                           for i:=1 to ExtL3Count do
                             if ExtProtocolStat[i].PacketCnt <> 0 then
                             begin
                               percent := ExtProtocolStat[i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(6+i,percent,4);
                               { show other display values }
                               w.texl(465,100+(6+i)*10,int2str(ExtProtocolStat[i].PacketCnt));
                             end;

                           { for other protocol }
                           if EachProtocolStat[11].PacketCnt <> 0 then
                           begin
                             percent := EachProtocolStat[11].PacketCnt;
                             temp := 100*percent mod Count;
                             percent := 100*percent div Count;
                             if temp > round(Count/2) then inc(percent);
                             { show graph }
                             bar_graph(7+ExtL3Count,percent,4);
                             { show other display values }
                             w.texl(465,100+(7+ExtL3Count)*10,int2str(EachProtocolStat[11].PacketCnt));
                           end;

                           { show general information }
                           w.texl(160,380,int2str(count));

                           w.show;
                         END;
                     2 : BEGIN
                           w.hide;
                           if OldMode <> ModeSelect then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Protocol Distribution',true);
                             w.writetext(260,80,'Transport Layer',false,1);
{							 all(520,170,555,190,false);}
							 datalink(180,330,260,350,False);
     						 network(280,330,360,350,False);
     						 transport(380,330,460,350,False);
     						 tcpip(480,330,560,350,False);
     						 w.chenar2(30,360,610,430,true);
     						 w.writetext(85,380,'Total Packets:',false,0);
{                             w.newbut(520,110,555,130,'~P~kt',9,os2,'');
                             w.newbut(520,140,555,160,'~B~yt',9,os2,'');
                             w.newbut(520,170,555,190,'~A~ll',9,os2,'');
                             w.newbut(85,330,115,350,'~<~-',9,os2,'');
                             w.newbut(125,330,155,350,'-~>~',9,os2,'');
                             w.newbut(175,330,255,350,'~D~atalink',9,os2,'');
                             w.newbut(275,330,355,350,'~N~etwork',9,os2,'');
                             w.newbut(375,330,455,350,'~T~ransport',9,os2,'');
                             w.newbut(475,330,555,350,'T~C~P/IP',9,os2,'');
                             w.chenar2(30,360,610,430,true);
                             w.writetext(40,380,'Total Packets:',false,0);}
                             if ExtL4Count+LastLayer4Protocol > 14 then
                             begin
                               w.chenar2(370,100,490,250+(ExtL4Count+LastLayer4Protocol-14)*10,true);
                               w.linie(455,102,455,248+(ExtL4Count+LastLayer4Protocol-14)*10,10,2,true);
                             end
                             else
                             begin
                               w.chenar2(370,100,490,250,true);
                               w.linie(455,102,455,248,10,2,true);
                             end;
                             w.writetext(412,110,'SPX',false,0);
                             w.writetext(412,120,'NCP',false,0);
                             w.writetext(412,130,'NetBios',false,0);
                             w.writetext(412,140,'ICMP',false,0);
                             w.writetext(412,150,'TCP',false,0);
                             w.writetext(412,160,'UDP',false,0);
                             for i:=1 to ExtL4Count do
                                 w.writetext(412,100+(6+i)*10,ExtLayer4Table[i],false,0);
                             w.writetext(412,100+(7+ExtL4Count)*10,'Other',false,0);

                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(9,false);

                             init_graph(100,250,7+ExtL4Count,10,210 div (7+ExtL4Count),15,1,1,0,0,0,10,1);
                             graph_scale(vertdir,horizdir,'protocol','%');
                             { write x grid name }
                             settextstyle(2,vertdir,4);
                             settextjustify(centertext,toptext);
                             outtextxy(xco+1*xscale-3,yco+7,'SPX');
                             outtextxy(xco+2*xscale-3,yco+7,'NCP');
                             outtextxy(xco+3*xscale-3,yco+7,'NetBios');
                             outtextxy(xco+4*xscale-3,yco+7,'ICMP');
                             outtextxy(xco+5*xscale-3,yco+7,'TCP');
                             outtextxy(xco+6*xscale-3,yco+7,'UDP');
                             for i:=1 to ExtL4Count do
                                 outtextxy(xco+(6+i)*xscale-3,yco+7,ExtLayer4Table[i]);
                             outtextxy(xco+(7+ExtL4Count)*xscale-3,yco+7,'Other');
                             { return to old style }
                             with oldstyle do
                             begin
                               settextstyle(font,direction,charsize);
                               settextjustify(horiz,vert);
                             end;
                           end;

                           { refresh graph and other show values }
                           ref_graph;
                           if ExtL4Count+LastLayer4Protocol > 14 then
                              w.fill(460,102,488,248+(ExtL4Count+LastLayer4Protocol-14)*10,9,1)
                           else w.fill(460,102,488,248,9,1);
                           w.fill(160,375,190,385,10,1);

                           { show all }
                           for i:=1 to 6 do
                             if EachProtocolStat[11+i].PacketCnt <> 0 then
                             begin
                               percent := EachProtocolStat[11+i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(i,percent,4);
                               { show other display values }
                               w.texl(465,100+i*10,int2str(EachProtocolStat[11+i].PacketCnt));
                             end;

                           { for .INI protocol }
                           for i:=1 to ExtL4Count do
                           begin
                             if ExtProtocolStat[20+i].PacketCnt <> 0 then
                             begin
                               percent := ExtProtocolStat[20+i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(6+i,percent,4);
                               { show other display values }
                               w.texl(465,100+(6+i)*10,int2str(ExtProtocolStat[20+i].PacketCnt));
                             end;
                           end;

                           { for other protocol }
                           if EachProtocolStat[18].PacketCnt <> 0 then
                           begin
                             percent := EachProtocolStat[18].PacketCnt;
                             temp := 100*percent mod Count;
                             percent := 100*percent div Count;
                             if temp > round(Count/2) then inc(percent);
                             { show graph }
                             bar_graph(7+ExtL4Count,percent,4);
                             { show other display values }
                             w.texl(465,100+(7+ExtL4Count)*10,int2str(EachProtocolStat[18].PacketCnt));
                           end;

                           { show general information }
                           w.texl(160,380,int2str(count));

                           w.show;
                         END;
                     3 : BEGIN
                           w.hide;
                           if OldMode <> ModeSelect then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Protocol Distribution',true);
                             w.writetext(260,80,'TCP/IP Protocol',false,1);
{							 all(520,170,555,190,false);}
                             datalink(180,330,260,350,False);
     						 network(280,330,360,350,False);
     						 transport(380,330,460,350,False);
     						 tcpip(480,330,560,350,False);
     						 w.chenar2(30,360,610,430,true);
    	 					 w.writetext(85,380,'Total Packets:',false,0);
{                             w.newbut(520,110,555,130,'~P~kt',9,os2,'');
                             w.newbut(520,140,555,160,'~B~yt',9,os2,'');
                             w.newbut(520,170,555,190,'~A~ll',9,os2,'');
                             w.newbut(85,330,115,350,'~<~-',9,os2,'');
                             w.newbut(125,330,155,350,'-~>~',9,os2,'');
                             w.newbut(175,330,255,350,'~D~atalink',9,os2,'');
                             w.newbut(275,330,355,350,'~N~etwork',9,os2,'');
                             w.newbut(375,330,455,350,'~T~ransport',9,os2,'');
                             w.newbut(475,330,555,350,'T~C~P/IP',9,os2,'');
                             w.chenar2(30,360,610,430,true);
                             w.writetext(40,380,'Total Packets:',false,0);}
                             if ExtULCount+LastUpLayerProtocol > 14 then
                             begin
                               w.chenar2(370,100,490,250+(ExtULCount+LastUpLayerProtocol-14)*10,true);
                               w.linie(455,102,455,248+(ExtULCount+LastUpLayerProtocol-14)*10,10,2,true);
                             end
                             else
                             begin
                               w.chenar2(370,100,490,250,true);
                               w.linie(455,102,455,248,10,2,true);
                             end;
                             w.writetext(412,110,'Telnet',false,0);
                             w.writetext(412,120,'FTP',false,0);
                             w.writetext(412,130,'FTP-Data',false,0);
                             w.writetext(412,140,'Finger',false,0);
                             w.writetext(412,150,'Rlogin',false,0);
                             w.writetext(412,160,'RPC',false,0);
                             w.writetext(412,170,'SMTP',false,0);
                             w.writetext(412,180,'SNMP',false,0);
                             for i:=1 to ExtULCount do
                                 w.writetext(412,100+(8+i)*10,ExtUpLayerTable[i],false,0);
                             w.writetext(412,100+(9+ExtULCount)*10,'Other',false,0);

                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(10,false);

                             init_graph(100,250,9+ExtULCount,10,210 div (9+ExtULCount),15,1,1,0,0,0,10,1);
                             graph_scale(vertdir,horizdir,'port','%');
                             { write x grid name }
                             settextstyle(2,vertdir,4);
                             settextjustify(centertext,toptext);
                             outtextxy(xco+1*xscale-3,yco+7,'Telnet');
                             outtextxy(xco+2*xscale-3,yco+7,'FTP');
                             outtextxy(xco+3*xscale-3,yco+7,'FTP-Data');
                             outtextxy(xco+4*xscale-3,yco+7,'Finger');
                             outtextxy(xco+5*xscale-3,yco+7,'Rlogin');
                             outtextxy(xco+6*xscale-3,yco+7,'RPC');
                             outtextxy(xco+7*xscale-3,yco+7,'SMTP');
                             outtextxy(xco+8*xscale-3,yco+7,'SNMP');
                             for i:=1 to ExtULCount do
                                 outtextxy(xco+(8+i)*xscale-3,yco+7,ExtUpLayerTable[i]);
                             outtextxy(xco+(9+ExtULCount)*xscale-3,yco+7,'Other');
                             { return to old style }
                             with oldstyle do
                             begin
                               settextstyle(font,direction,charsize);
                               settextjustify(horiz,vert);
                             end;
                           end;

                           { refresh graph and other show values }
                           ref_graph;
                           if ExtULCount+LastUpLayerProtocol > 14 then
                              w.fill(460,102,488,248+(ExtULCount+LastUpLayerProtocol-14)*10,9,1)
                           else w.fill(460,102,488,248,9,1);
                           w.fill(160,375,190,385,10,1);

                           { show all }
                           for i:=1 to 8 do
                             if EachProtocolStat[18+i].PacketCnt <> 0 then
                             begin
                               percent := EachProtocolStat[18+i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(i,percent,4);
                               { show other display values }
                               w.texl(465,100+i*10,int2str(EachProtocolStat[18+i].PacketCnt));
                             end;

                           { for .INI protocol }
                           for i:=1 to ExtULCount do
                           begin
                             if ExtProtocolStat[40+i].PacketCnt <> 0 then
                             begin
                               percent := ExtProtocolStat[40+i].PacketCnt;
                               temp := 100*percent mod Count;
                               percent := 100*percent div Count;
                               if temp > round(Count/2) then inc(percent);
                               { show graph }
                               bar_graph(8+i,percent,4);
                               { show other display values }
                               w.texl(465,100+(8+i)*10,int2str(ExtProtocolStat[40+i].PacketCnt));
                             end;
                           end;

                           { for other protocol }
                           if EachProtocolStat[27].PacketCnt <> 0 then
                           begin
                             percent := EachProtocolStat[27].PacketCnt;
                             temp := 100*percent mod Count;
                             percent := 100*percent div Count;
                             if temp > round(Count/2) then inc(percent);
                             { show graph }
                             bar_graph(9+ExtULCount,percent,4);
                             { show other display values }
                             w.texl(465,100+(9+ExtULCount)*10,int2str(EachProtocolStat[27].PacketCnt));
                           end;

                           { show general information }
                           w.texl(160,380,int2str(count));

                           w.show;
                         END;
{                     4 : BEGIN
                           w.hide;
                           if OldMode <> ModeSelect then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Protocol Distribution',true);
                             w.writetext(260,80,'All Protocol',false,1);
							 all(520,170,555,190,false);
							 datalink(180,330,260,350,False);
     						 network(280,330,360,350,False);
     						 transport(380,330,460,350,False);
     						 tcpip(480,330,560,350,False);
     						 w.chenar2(30,360,610,430,true);
     						 w.writetext(85,380,'Total Packets:',false,0);
{                             w.newbut(520,110,555,130,'~P~kt',9,os2,'');
                             w.newbut(520,140,555,160,'~B~yt',9,os2,'');
                             w.newbut(520,170,555,190,'~A~ll',9,os2,'');
                             w.newbut(85,330,115,350,'~<~-',9,os2,'');
                             w.newbut(125,330,155,350,'-~>~',9,os2,'');
                             w.newbut(175,330,255,350,'~D~atalink',9,os2,'');
                             w.newbut(275,330,355,350,'~N~etwork',9,os2,'');
                             w.newbut(375,330,455,350,'~T~ransport',9,os2,'');
                             w.newbut(475,330,555,350,'T~C~P/IP',9,os2,'');
                             w.chenar2(30,360,610,430,true);
                             w.writetext(40,380,'Total Packets:',false,0);}
    {                         w.chenar2(370,100,490,250,true);
                             w.linie(455,102,455,248,10,2,true);
                             w.writetext(375,110,'',false,0);
                             w.writetext(375,120,'',false,0);
                             w.writetext(375,130,'',false,0);
                             w.writetext(375,140,'',false,0);
                             w.writetext(375,150,'',false,0);
                             w.writetext(375,160,'',false,0);
                             w.writetext(375,170,'',false,0);
                             w.writetext(375,180,'',false,0);

                             { disable button }
     {                        w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(4,false);

                             init_graph(100,250,7,10,30,15,1,1,0,0,0,10,1);
                             graph_scale(vertdir,horizdir,'protocol','%');
                             { write x grid name }
      {                       settextstyle(2,vertdir,4);
                             settextjustify(centertext,toptext);
                             outtextxy(xco+1*xscale-3,yco+7,'');
                             outtextxy(xco+2*xscale-3,yco+7,'');
                             outtextxy(xco+3*xscale-3,yco+7,'');
                             outtextxy(xco+4*xscale-3,yco+7,'');
                             outtextxy(xco+5*xscale-3,yco+7,'');
                             outtextxy(xco+6*xscale-3,yco+7,'');
                             outtextxy(xco+7*xscale-3,yco+7,'');
                             outtextxy(xco+8*xscale-3,yco+7,'');
                             { return to old style }
       {                      with oldstyle do
                             begin
                               settextstyle(font,direction,charsize);
                               settextjustify(horiz,vert);
                             end;
                           end;

                           { refresh graph and other show values }
        {                   ref_graph;
                           w.fill(460,102,488,248,9,1);
                           w.fill(160,375,190,385,10,1);

                           { show all }

                           { show general information }
         {                  w.texl(160,380,int2str(count));

                           w.show;
                         END;}
                END;

                OldMode := ModeSelect;
                { Reset protocol counter value }
                ResetProtocolCnt(ProtocolStat);
                FOR I:=1 TO ExtProtocolLimit*3 DO
                BEGIN
                     ExtProtocolStat[I].PacketCnt := 0;
                     ExtProtocolStat[I].ByteCnt   := 0;
                END;
                FOR I:=1 TO LastLayer2Protocol DO
                FOR J:=1 TO ExtProtocolLimit DO
                BEGIN
                     L2ExtL3ProtocolStat[I,J].PacketCnt := 0;
                     L2ExtL3ProtocolStat[I,J].ByteCnt   := 0;
                END;

{                Count := 0;
                ByteCount := 0;}
                Timer1.Start;
           END;
     UNTIL (Key = #27);
     Key := #0;
     w.clrwin(1); cm:=0;
END;

procedure helpoe;
const
     StrFileName = 'prohlp.hlp';
type
    Str40 = String[40];
    StrFile = FILE OF Str40;
var
    fStr : StrFile;
    page,line : integer;
    curStr : Str40;
begin
     fer_tip := 1;
     muta_fer := false;
     w.newwin(280,30,630,450,'Help',true);
     w.newbut(290,60,350,80,'~B~ack',9,os2,'');
     w.newbut(352,60,412,80,'~N~ext',9,os2,'');
     line := 0; page := 1;
     curStr:= '';
     Assign(fStr,StrFileName);
     Reset(fStr);
     REPEAT
        w.newfill(290,81,620,440,12,1);
        While ((line+1) mod 21 <> 0) and (line < FileSize(fStr)) do
        begin
	     Seek(fStr,line);
             Read(fStr,curStr);
             w.newtext(295,101+((line mod 21) *15),curStr);
             line := line+1;
        end;
        w.handleevent;
        case cm of
     {Back}  2 : If page > 1 then page := page-1;
     {Next}  3 : If page*21 < FileSize(fStr) then page := page+1;
        end; {end case}
        line := (page*21)-21;
     UNTIL (cm = 1);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;
     close(fStr);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ          MAIN PROGRAM FOR Ethernet Monitor VERSION 1.00              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
BEGIN
     pktDriver.ScanForPktDriver;
     InitPktDriver;
     Delay(100);

     InitialEnvironment;
     MakeSendPacket;

     soundenable:=false;
     w.init; _paleta:=3; w.ini_paleta;
     fer_tip:=0;
     t_color:=true;
     memimage:=true;
     relief:=false;
     nr_expl:=10;

     w.newwin(0,0,getmaxx,20,'',false);
     w.newchenar(0,455,639,479,0,1,false);
     w.newfill(1,456,638,478,10,1);
     w.newchenar(2,457,520,476,0,1,true);
     w.newchenar(530,457,637,476,0,1,true);
     w.newbut(2,2,66,18,'~P~rotocol',4,os2,'');
     w.newbut(66,2,116,18,'~H~elp',4,os2,'');
     w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

     REPEAT
           w.handleevent;
           case cm of
                1 : displayprotocol;
				2 : helpoe;
           end;
     UNTIL cm=3;
     ExitProgram;
     clrscr;
END.
