{    Last change:  O    12 Feb 97    6:03 am    }
PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G+,I-,L+,N-,O-,R-,S-,V+,X+}
{$M  30720 0 655360}
USES   OBJECTS,PKTDRVR,ETHER,TIMER,STRINGS,CRT,DOS,INIF,EMS,stringop,grafica,g_applic,util256,graph,mouse;
       { ONE 10/1/40 Add INIF,EMS }
CONST  MaxEthernetCapacity = 1250000; { Max. theroetical ethernet capacity }
       DefaultFileName     = 'DATA.DAT';
       ProfileName         = 'Ether.Ini';
       FullBlock           = 'Û';
       ElementNum          = PAGESIZE DIV Sizeof(TPacketInfo); { ONE 10/1/40 }
       BROADCAST : EthernetAddr = ($FF,$FF,$FF,$FF,$FF,$FF);
       UNKNOWNADDR : EthernetAddr = ($0,$0,$0,$0,$0,$0);
       { Constant use in DisplayProtocol }
       LastLayer2Protocol  = 4;
       LastLayer3Protocol  = 7;
       LastLayer4Protocol  = 7;
       LastUpLayerProtocol = 9;
       LastProtocol        = LastLayer2Protocol + LastLayer3Protocol + LastLayer4Protocol + LastUpLayerProtocol;
       { use for Extend protocol in .INI file}
       DefaultString = 'Notfound';
       ExtProtocolLimit = 20;    { Can add 20 protocols per section }
       { CONSTant use in DisplayFrameSize }
       MinFrameSize   = 64;
       MaxFrameSize   = 1518;

{ Indexes of protocol }
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
     {display conversation constant}
      MaxConverBuffer     = 50;      { ONE 10/1/40 USE for Conversation Display }
      MaxMode             = 5;       { ONE 10/1/40 USE for Conversation Display }
      MaxSort             = 5;
      PageSize            = 15;

      MaxStat             = 300;

TYPE
       adapplic=object(g_application)
                procedure background; virtual;
                end;

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
{ Type definition use in procedure DisplayFrameSize }
       TFrameSizeTable = RECORD
                               GoodSize : ARRAY [MinFrameSize..MaxFrameSize] OF integer;
                               Small    : integer;
                               Medium   : integer;
                               Large    : integer;
                               Short    : integer;
                               Long     : integer;
                         END;
           {Type definition use in procedure DisplayProtocol}
      Statistic   = RECORD
                       Packet_S    : Word;
                       Packet_T    : LongInt;
                       Utilize     : Integer;
                       Error_S     : Word;
                       Error_T     : LongInt;
                       Drop_S      : Word;
                       Drop_T      : LongInt;
                       Byte_S      : LongInt;
                       Byte_T      : LongInt;
                       BroadCast_S : Word;
                       BroadCast_T : LongInt;
                       Undersize_S : Word;
                       Undersize_T : LongInt;
                       Oversize_S  : Word;
                       Oversize_T  : LongInt;
                    END;
       Conversation = RECORD { ONE 9/1/40 use to conversation module }
                       SourceAddr  : EthernetAddr;
                       DestAddr    : EthernetAddr;
                       PacketCount : LongInt;
                       PacketCountS: LongInt;
                       ByteCount   : LongInt;
                       ByteCountS  : LongInt;
                       PacketCount2 : LongInt;
                       PacketCountS2: LongInt;
                       ByteCount2   : LongInt;
                       ByteCountS2  : LongInt;
                       Used        : Boolean;
                       StartTime   : Time;
                       LastTime    : Time;
                       Protocol    : Array [0..3] of Integer
                     END;

       {Display conversation type}
       aptr = 0..MaxConverBuffer;


VAR
    PacketBuffer    : EMSArray;        { ONE 10/1/40 Add EMS Buffer }
    MaxPacketBuffer : Word;

    hispacket: array[00..210,1..48] of integer;{oe 25/5/41}
    term,term1,timeinterval,totaloe:integer;{oe 25/5/41}
    startoe1,samstart,samend:time;

    pktDriver       : TPKTDRVR;        { Instance of the TPKTDRVR object }
    pktDriverInfo   : TDRVRINFO;       { record for driver information }
    pktDriverAccess : TACCESSTYPE;     { record used for accessing packet driver }
    pktStatistics   : TSTATISTICS;     { record used for satistics of packet }

    Rcvpacket       : PacketFrame;     { Rcv buffer }

    RcvIEEE802      : TPacketIEEE802;  { record used for IEEE802.3 type }
    RcvNCP          : NCPFrame;
    RcvIPX          : IPXFrame;
    RcvTCP          : TCPFrame;

    RcvEthernetII   : TpacketEtherII;  { record used for Ethernet II type }
    RcvEtherLength  : TpacketEtherII;
    RcvEtherII      : EtherIIFrame;

    RcvLength       : Word;            { Length of packet }
    RcvHeader       : MACheader;       { Header           }

    VerPacket       : PacketFrame;
    VerHeader       : MACheader;

    SendPacket      : TSendPacket;     { Send packet buffer }
    TypeField       : Word;            { type field of Send packet }

    PacketCount     : Word;            { Packet counter   }
    PacketDelay     : Word;
    Lost            : Word;
    TotalPacket     : LongInt;

    CurTraffic      : Real;            { Used for evalute traffic }
    CumTraffic      : LongInt;

    I,tInt          : Integer;         { Used for handle file operation }
    FrameType       : String;
    FileName        : String[13];

    AllStation      : Boolean;         { Stored Information of Received Packet }
    AllSource       : Boolean;
    AllDestination  : Boolean;
    AllPacket       : Boolean;
    IsEtherII       : Boolean;
    IsIEEE802       : Boolean;
    SourceAddr      : EthernetAddr;
    DestinationAddr : EthernetAddr;
    SendSourceAddr  : EthernetAddr;
    SendDestAddr    : EthernetAddr;
    BufferCount     : Integer;
    Mode            : Integer;
    BufferFill      : Boolean;

    Timer1          : _TIMER;          { Timer for Trick Monitor Traffic }
    Timer2          : _TIMER;
    Interval        : LongInt;

    MyEthernetAddr  : EthernetAddr;    { My Station Ethernet Address }
    SendDataCount   : Byte;            { Counter Size of Send fields }

    C               : Char;            { Temperary Valiable }
    Key             : Char;
    J               : Integer;
    tF              : Text;
    Byt             : Byte;
    tStr,ttStr      : String;
                         sttt,bttt:time;
    Found           : Boolean;
    IntRet          : integer;      { Return value as integer }
    BoolnRet        : Boolean;      { Return value as Boolean }
    w               : adapplic      ;

    { information display module }
    INFORMATION     : Statistic;       { ONE 17/1/40 for check error }
    Threshold       : Statistic;       { ONE 17/1/40 for check error }
    LastLOST   : Longint;
    Count,LastCount : LongInt;
    ByteCount,LastByteCount : LongInt;

    { setting }
    alias_mode      : boolean;

    { statistic }
    BuffStat  : Array[00..242{maxstat}] of statistic;
    pointstat : integer;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE pktReceiver                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Receive Packets                                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
{$S-}
PROCEDURE pktReceiver;ASSEMBLER;
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

        JNZ  @@EXIT

        MOV  DX,SEG Rcvpacket
        MOV  ES,DX
        MOV  DI,OFFSET Rcvpacket

        MOV  DX,SEG RcvLength
        MOV  DS,DX
        MOV  SI,OFFSET RcvLength
        MOV  WORD PTR DS:[SI],CX     { Store length of frame in PacketLength }

        JMP  @@Exit

@@Lost:
        INC  LOST                     { Increase Lost packet }
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

procedure adapplic.background;
var f,n: integer;
    getpal,temppal : palette256;
begin
     hide;
     setcolor(12);
     setviewport(0,21,639,454,true);
     setfillstyle(1,0); bar(0,0,getmaxx,getmaxy);
     tstr := 'LAN Monitoring and Analysis ';
     for I:= 0 to 5 do
       for J:= 0 to 24 do
       begin
         outtextxy(0+I*220,10+j*20,tstr);
       end;

     SetFillStyle(1, 10);
     bar(260,80,420,220);

     SetFillStyle(1, 2);
     bar(280,100,400,200);

     SetFillStyle(1, 10);
     bar(260,240,420,260);

     SetFillStyle(10, 10);
     bar(40,280,600,282);

     SetFillStyle(10, 10);
     bar(340,260,342,280);

     for I:= 0 to 11 do
        line(80+i*40,300,100+i*40,300);
     for I:= 0 to 11 do
        line(100+i*40,320,120+i*40,320);
     for I:= 0 to 22 do
        line(100+i*20,300,100+i*20,320);
     setcolor(1);
     for I:= 0 to 20 do
        line(300-I,220+I,380+I,220+I);
     setviewport(0,0,639,479,true);
     show;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE EMS_INSTALL;                                               บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Initialize EMS.                                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Function EMS_INSTALL:boolean;
VAR    Pages           : Word;            { ONE 10/1/40 Keep Pages avail }
       tempstr         : string;
BEGIN
     Pages    := PacketBuffer.Pages_Available;
     PacketBuffer.Alloc(Pages);
     MAXPACKETBUFFER := ElementNum * Pages;
     If EmsError<>0 Then
       Begin
        str(Pages:8,tempstr);
        w.dispmsg('Ems don''t have enough memory','Alloc '+tempstr+' Pages Error!');
        PacketBuffer.Release;
        EMS_INSTALL := false;
       End else EMS_INSTALL := true;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE EMS_RELEASE;                                               บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Terminate EMS.                                     บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE EMS_RELEASE;
BEGIN
          PacketBuffer.Release;
END;

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
 บ PROCEDURE TerminatePktDriver;                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Releases the handle and terminates packet driver.  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE TerminatePktDriver;
BEGIN
     pktDriver.ReleaseType;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  ByteToHEXASCII (...) : String;                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts Byte    to a HEX-ASCII-String             บ
 บ                 ณ requests.                                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION ByteToHEXASCII(tByte : Byte) : String;
CONST
     HEXChars: array [0..15] of char = '0123456789ABCDEF';
VAR  Nibble1 : Byte;
     Nibble2 : Byte;
     tStr    : String;
BEGIN
     Nibble1 := (tByte AND $0F);        { AND 00001111b }
     Nibble2 := (tByte AND $F0) SHR 4;  { AND 11110000b }
     tStr := HEXChars[Nibble2]+HEXChars[Nibble1];
     ByteToHEXASCII := tStr;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  WordToHEXASCII (...) : String;                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts Word to a HEX-ASCII-String                บ
 บ                 ณ requests.                                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION WordToHEXASCII(tWord : Word) : String;
VAR  tStr : String;
BEGIN
     tStr := ByteToHexASCII(Hi(tWord));
     tStr := tStr+ByteToHexASCII(Lo(tWord));
     WordToHexASCII := tStr;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION TestOpenFile(Name:String):Boolean;                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Test File is open able                             บ
 บ                 ณ Input : File name to test                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION TestOpenFile(Name:String):Boolean;
VAR
  tFile : TPacketFile;
BEGIN
     Assign(tFile,Name);            { Open Data File For Flush Data }
     {$I-} Rewrite(tFile); {$I+}
     IF (IOResult <> 00) THEN
       BEGIN
          TestOpenFile := FALSE;
       END
     ELSE
       BEGIN
          Close(tFile);
          TestOpenFile := TRUE;
     END;
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
     PacketBuffer.MapIN(PageNum,0);
     PacketBuffer.PacketArry^[ Element ] := Data;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  GetEthernetAddress                                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts a 6 byte ethernet address (ONE 8/1/40     บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetEthernetAddress(tEtherAddr : EthernetAddr) : String;
VAR tString : String;
    tHost1  : String;
    tHost2  : String;
    tCount  : Byte;
    EntryValue : String;
    I          : Integer;
    alias_mode : boolean;
BEGIN
     tString := '';
     tHost1 := '';
     tHost2 := '';

     FOR tCount := 0 TO 2 DO   { Find Factory Address }
     BEGIN
          tHost1 := tHost1 + ByteToHexASCII(tEtherAddr[tCount]);
     END;

     FOR tCount := 3 TO 5 DO   { Find Number Address }
     BEGIN
          tHost2 := tHost2 + ByteToHexASCII(tEtherAddr[tCount]);
     END;

     tString := tHost1 + '-' + tHost2;

     GetProfileString(ProfileName,'setting','alias',EntryValue,'true');
     IF EntryValue = 'true' then
     Begin
     GetProfileString(ProfileName,'Alias Name', tString, EntryValue, '');
     IF (EntryValue='') THEN
        BEGIN
           GetProfileString(ProfileName,'Host Number', tHost1, EntryValue, '');
           IF EntryValue='' THEN GetEthernetAddress := tString
           ELSE BEGIN
               while EntryValue[0] < #6 do EntryValue := EntryValue + ' ';
               GetEthernetAddress := EntryValue+'-'+tHost2; { Find Host Address }
           End;
        END
     ELSE BEGIN
         while EntryValue[0] < #13 do EntryValue := EntryValue + ' ';
         GetEthernetAddress := EntryValue; { Equal Alias Name }
     End;
     End ELSE GetEthernetAddress := tString;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  GetEthernetAddress2                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts a 6 byte ethernet address (ONE 8/1/40     บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetEthernetAddress2(tEtherAddr : EthernetAddr) : String;
VAR tHost1  : String;
    tHost2  : String;
    tCount  : Byte;
    EntryValue : String;
    tSize,I : Integer;
BEGIN
     tHost1 := '';
     tHost2 := '';

     FOR tCount := 0 TO 2 DO   { Find Factory Address }
     BEGIN
          tHost1 := tHost1 + ByteToHexASCII(tEtherAddr[tCount]);
     END;

     FOR tCount := 3 TO 5 DO   { Find Number Address }
     BEGIN
          tHost2 := tHost2 + ByteToHexASCII(tEtherAddr[tCount]);
     END;

     GetEthernetAddress2 := tHost1 + '-' + tHost2;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE TranslateEthernetAddress(..);                              บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Translates a dash separated ethernet address into  บ
 บ                 ณ 6 Bytes.                                           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE TranslateEthernetAddress(tStr : String; VAR tEtheraddr : EthernetAddr);
VAR tDigit : String;
    tByte  : Byte;
    Err    : Integer;
    tVal   : Byte;
BEGIN
     tDigit :='';
     FOR tByte := 1 TO Length(tStr) DO
     BEGIN
          IF (Copy(tStr,tByte,1) <> '-') THEN tDigit := tDigit + Copy(tStr,tByte,1);
     END;
     FOR tByte := 0 TO 5 DO
     BEGIN
          Val('$'+Copy(tDigit,(tByte*2)+1,2),tVal,Err);
          tEtheraddr[tByte] := tVal;
     END;
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
 บ FUNCTION  GetFragment(...) : Byte;                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts Low 13 bits of Word to Word               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetFragment(tWord : Data16) : Word;
VAR  ttWord        :  Word;
BEGIN
     MOVE(tword,ttWord,2);
     ttWord := SwapWord(ttWord);
     GetFragment := (ttWord AND $1F);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION CompareEthernetAddr(Addr1,Addr2 : EthernetAAddr) : Boolean; บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Compare 2 Ethernet Address Reture                  บ
 บ                 ณ TRUE if they are EQUAL                             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION CompareEthernetAddr(Addr1,Addr2 : EthernetAddr) : Boolean;
VAR      Result : Boolean;
         Count  : Byte;
BEGIN
     Result := TRUE;
     Count  := 0;
     REPEAT
           IF (Addr1[Count] <> Addr2[Count]) THEN Result := FALSE;
           INC (Count);
     UNTIL Not(Result) OR (Count = 6);
     CompareEthernetAddr  := Result;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  Get4HighBit(...) : Byte;                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts High-Nibble of Byte to Byte               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get4HighBit(tByte : Data8) : Byte;
VAR      Nibble,ttByte :  Byte;
BEGIN
     MOVE(tByte,ttByte,1);
     Get4Highbit := (ttByte AND $F0) SHR 4;  { AND 11110000b }
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  Get4LowBit(...) : Byte;                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts Low-Nibble of Byte to Byte                บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get4LowBit(tByte : Data8) : Byte;
VAR      Nibble,ttByte :  Byte;
BEGIN
     MOVE(tByte,ttByte,1);
     Get4Lowbit := (ttByte AND $0F) ;  { AND 00001111b }
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Get8bit(tdata8 : data8) : String;                           บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 8 bit -> String              บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get8bit(tdata8 : data8) : String;
VAR tString : String;
    tCount  : Byte;
    AddrLen : Byte;
BEGIN
     AddrLen := SizeOf(data8)-1;
     tString := '';
     FOR tCount:=0  TO AddrLen DO
     BEGIN
          tString := tString + ByteToHexASCII(tdata8[tCount]);
     END;
     Get8bit := tString;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION GetData16toASCII(tdata16 : data16) : String;                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 16 bit -> String             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetData16ToASCII(tdata16 : data16) : String;
VAR      tWord : Word ;
BEGIN
     Move(tdata16,tWord,2);
     GetData16ToASCII := WordToHEXASCII(SwapWord(tWord));
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE Get16bit(tdata16 : data16) : String;                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 16 bit -> String             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get16bit(tdata16 : data16) : String;
VAR tString : String;
    tCount  : Byte;
    AddrLen : Byte;
BEGIN
     AddrLen := SizeOf(data16)-1;
     tString := '';
     FOR tCount:=0  TO AddrLen DO
     BEGIN
          tString := tString + ByteToHexASCII(tdata16[tCount]);
          IF (tCount < AddrLen) THEN tString := tString + '-';
     END;
     Get16bit := tString;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Get32bit(tdata32 : data32) : String;                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 32 bit -> String             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get32bit(tdata32 : data32) : String;
VAR tString,ttString : String[8];
    tWord            : Array[00..01] of Word;
    tCount           : Byte;
BEGIN
     Move(tData32,tWord,4);
     tString := WordToHEXASCII(SwapWord(tWord[0]));
     ttString := tString + WordToHEXASCII(SwapWord(tWord[1]));
     Get32Bit := ttString;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION PrintIP(tdata32 : data32) : String;                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 32 bit -> String             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION PrintIP(tdata32 : data32) : String;
VAR tString  : String;
    tString1 : String;
    tDigit   : String[02];
    tCount   : Byte;
    AddrLen  : Byte;
BEGIN
     AddrLen := SizeOf(tdata32)-1;
     tString := '';

     FOR tCount := 0 TO AddrLen DO
     BEGIN
          Str(tdata32[tCount],tString1);
          tString := tString + tString1;
          IF (tCount < AddrLen) THEN tString := tString + '.';
     END;
     GetProfileString(ProfileName, 'Alias IP', tString, tString1, tString);
     PrintIp := tString1;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION PrintIP2(tdata32 : data32) : String;                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert Array of Data 32 bit -> String             บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION PrintIP2(tdata32 : data32) : String;
VAR tString  : String;
    tString1 : String;
    tDigit   : String[02];
    tCount   : Byte;
    AddrLen  : Byte;
BEGIN
     AddrLen := SizeOf(tdata32)-1;
     tString := '';

     FOR tCount := 0 TO AddrLen DO
     BEGIN
          Str(tdata32[tCount],tString1);
          tString := tString + tString1;
          IF (tCount < AddrLen) THEN tString := tString + '.';
     END;
     PrintIp2 := tString;
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
 บ PROCEDURE ExitProgram                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Exit Program                                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ExitProgram;
BEGIN
     TerminatePktDriver;
     Halt(0);
END;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  WriteTime                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Write Time in String Format 00:00:00 (one 7/1/40)  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Function WriteTime(tTime : Time):String;
VAR tmp     : String;
    Time    : String;
    TimeTmp : Byte;
    Hour,Minute,Second,Sec100 : Word;

BEGIN
     Hour := tTime.Hour; Minute := tTime.Minute; Second := tTime.Second; Sec100 := tTime.Sec100;
     Str(Hour:2,tmp);   If Pos(' ',tmp)<>0 then Time :=   '0'+tmp[2] else Time :=      tmp;
     Time := Time+':';
     Str(Minute:2,tmp); If Pos(' ',tmp)<>0 then Time := Time+'0'+tmp[2] else Time := Time+tmp;
     Time := Time+':';
     Str(Second:2,tmp); If Pos(' ',tmp)<>0 then Time := Time+'0'+tmp[2] else Time := Time+tmp;
     TimeTmp := Hour; WriteTime := Time
END;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE SetTimeInterval(sTime:Integer);                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Set time duration                                  บ
 บ                 ณ Input : time                                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE SetTimeInterval(sTime:Integer);
BEGIN
     Interval := sTime;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  TimeDifferent                                              บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Find StartTime - StopTime  (one 7/1/40)            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure TimeDifferent(StartTime : Time; StopTime : Time; VAR tTime : Time);
VAR  Flag  : Boolean;
     tSysTime,tSysTime2,tSysTime3 : Word;
     Hour,Minute,Second : Word;
BEGIN
     Hour := StartTime.Hour; Minute := StartTime.Minute; Second := StartTime.Second;
     tSysTime   := Hour*3600+Minute*60+Second;

     Hour := StopTime.Hour; Minute := StopTime.Minute; Second := StopTime.Second;
     tSysTime2  := Hour*3600+Minute*60+Second;

     tSysTime3  := tSysTime2 - tSysTime;

     tTime.Hour   := tSysTime3 Div 3600;
     tTime.Minute := (tSysTime3-(tTime.Hour*3600)) Div 60;
     tTime.Second := (tSysTime3-(tTime.Hour*3600)-(tTime.Minute*60));
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
 บ FUNCTION GetLongint(tLongInt : LongInt) : String;                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Convert LongInt -> String                          บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetLongInt(tLongInt : LongInt) : String;
VAR tString          : String[8];
    tWord            : Array[00..01] of Word;
    tCount           : Byte;
BEGIN
     Move(tLongInt,tWord,4);
     tString := WordToHEXASCII(tWord[0]);
     tString := tString + WordToHEXASCII(tWord[1]);
     GetLongInt := tString;
END;

FUNCTION CompareIPAddr(Addr1,Addr2 : Data32) : Boolean;
VAR      Result : Boolean;
         Count  : Byte;
BEGIN
     Result := TRUE;
     Count  := 0;
     REPEAT
           IF (Addr1[Count] <> Addr2[Count]) THEN Result := FALSE;
           INC (Count);
     UNTIL Not(Result) OR (Count = 4);
     CompareIPAddr  := Result;
END;

FUNCTION Hex2Byte (S : string) : Byte;
{ returns hexadecimal string as decimal value }
CONST
  HexString : array [0..15] of char = '0123456789ABCDEF';
VAR
  Len   : byte absolute S;
  Loop  : byte;
  Li    : longint;
  Num   : longint;
BEGIN
  Num := 0;
  for Loop := 1 to 2 do begin
    Li := 0;
    while
      (HexString [Li] <> Upcase(S [Loop]))         { compare letter }
        and
      (Li < 16)
    do
      inc (Li);                            { inc counter }
    if Li = 16 then begin
      Hex2Byte := 255;                           { -1 if invalid }
      exit;
      end;
    Num := Num + Li shl ((Len - Loop) * 4);   { add to Num }
    end;
  Hex2Byte := Num;                          { return value }
END;

FUNCTION Hex2Dec (S : string) : longint;
{ returns hexadecimal string as decimal value }

CONST
  HexString : array [0..15] of char = '0123456789ABCDEF';

VAR
  Len   : byte absolute S;
  Loop  : byte;
  Li    : longint;
  Num   : longint;

BEGIN
  if S [1] = '$' then delete (S, 1, 1);
  if upcase (S [Len]) = 'H' then dec (S [0]);
  Num := 0;
  for Loop := 1 to Len do begin
    Li := 0;
    while
      (HexString [Li] <> Upcase(S [Loop]))         { compare letter }
        and
      (Li < 16)
    do
      inc (Li);                            { inc counter }
    if Li = 16 then begin
      Hex2Dec := -1;                           { -1 if invalid }
      exit;
      end;
    Num := Num + Li shl ((Len - Loop) * 4);   { add to Num }
    end;
  Hex2Dec := Num;                          { return value }
END;

Procedure Assign32(Var DataType : Data32; LongIntType : LongInt);
BEGIN
     DataType[0] := LongIntType MOD $100;
     DataType[1] := LongIntType DIV $100;
     DataType[2] := LongIntType DIV $10000;
     DataType[3] := LongIntType DIV $1000000;
END;

Procedure Assign16(Var DataType : Data16; WordType : Word);
BEGIN
     DataType[1] := WordType MOD $100;
     DataType[0] := WordType DIV $100;
END;

Function Compare16(DataType : Data16; WordType : Word): Boolean;
Var      tWord : Word;
BEGIN
     Compare16 := False;
     Move(DataType,tWord,2);
     IF SwapWord(tWord) = WordType then Compare16 := True;
END;

Procedure Assign8(Var DataType : Data8; ByteType : Byte);
BEGIN
     Move(ByteType,DataType,1);
END;

Function Compare8(DataType : Data8; ByteType : Byte): Boolean;
Var      tByte : Byte;
BEGIN
     Compare8 := False;
     Move(DataType,tByte,1);
     IF tByte = ByteType then Compare8 := True;
END;

Procedure AssignIP(Var DataType : Data32; Byte1,Byte2,Byte3,Byte4 : Byte);
BEGIN
     DataType[0] := Byte1;
     DataType[1] := Byte2;
     DataType[2] := Byte3;
     DataType[3] := Byte4;
END;

Procedure ConvertIP(EntryName : String; Var IP : data32);
CONST  DecChars : Array[0..15] of Char = '0123456789';
Var I,J    : Integer;
    TByte  : Byte;
    TTByte : Byte;
BEGIN
     J := 0; TTByte := 0; I := 1;
     EntryName := EntryName + #0;
     While EntryName[I] <> #0 Do
     BEGIN
          IF EntryName[I] = '.' THEN
          BEGIN
               IP[J] := TTByte;
               TTByte := 0;
               INC(J);
          END ELSE
          BEGIN
               TByte := pos(UpCase(EntryName[I]),DecChars)-1;
               TTByte := TTByte * 10 + TByte;
          END;
          INC(I);
     END;
     IP[J] := TTByte;
END;


Procedure ConvertEthernetAddr(EntryName : String; Var Ethernet : EthernetAddr);
CONST  HexChars : Array[0..15] of Char = '0123456789ABCDEF';
Var I: Integer;
BEGIN
     For I:= 1 to 3 do
     BEGIN
          Ethernet[I-1] := pos(UpCase(EntryName[2*I]),HexChars)-1  +
                   ((pos(UpCase(EntryName[2*I-1]),HexChars))-1) shl  4 { *  16}
     END;

     For I:= 4 to 6 do
     BEGIN
          Ethernet[I-1] := pos(UpCase(EntryName[2*I+1]),HexChars)-1  +
                   ((pos(UpCase(EntryName[2*I]),HexChars))-1) shl  4 { *  16}
     END;

END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayInfo;   # call by Displayconversation               บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Display Conversation Station                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DisplayInfo(TypeMessage,hh:Integer);
CONST Message1       = 'Conversation                         ';
      Message2       = 'Conversation                         ';
      Message3       = 'Conversation Per Second              ';
      Message4       = 'Conversation Per Second              ';
      Message5       = 'Conversation By Protocol             ';
      Message6       = 'Capturing Packet to file             ';
      Message7       = 'Capturing Packet to EMS              ';
      Message8       = 'Statistic module                     ';
      DefaultMessage = 'Default Message                      ';
VAR
      ArryTime   : Array[00..13] of char;
      StrTime    : String;
      CurTime    : Time;
      I          : Integer;
      Message    : String;
      errorstr   : String;
      tStr,ttStr,tttStr : String;
      error      : boolean;

BEGIN
     { ** read from initial value or setting }
     GetProfileWord(ProFileName,'THRESHOLD','Packet_S',THRESHOLD.Packet_S,300);
     GetProfileInt(ProFileName,'THRESHOLD','Utilize',THRESHOLD.Utilize,20);
     GetProfileWord(ProFileName,'THRESHOLD','Error_S',THRESHOLD.Error_S,20);
     GetProfileWord(ProFileName,'THRESHOLD','Drop_S',THRESHOLD.Drop_S,100);
     GetProfileLongInt(ProFileName,'THRESHOLD','Byte_S',THRESHOLD.Byte_S,200000);
     GetProfileWord(ProFileName,'THRESHOLD','Broadcast_S',THRESHOLD.Broadcast_S,70);
     GetProfileWord(ProFileName,'THRESHOLD','Undersize_S',THRESHOLD.Undersize_S,250);
     GetProfileWord(ProFileName,'THRESHOLD','Oversize_S',THRESHOLD.Oversize_S,50);

     if hh <> 1 then
     begin
     GetTime2(CurTime);
     StrTime := WriteTime(CurTime);
     {w.fill(531,458,636,475,10,1);}
     w.fill(190,413,280,427,10,1);
{     w.texl(190,380,tstr+' Byte/S');}
     w.texl(190,420,StrTime);
     end;

     CASE typeMessage of
      1 : Message := Message1;
      2 : Message := Message2;
      3 : Message := Message3;
      4 : Message := Message4;
      5 : Message := Message5;
      6 : Message := Message6;
      7 : Message := Message7;
     ELSE Message := DefaultMessage;
     END;

     IF INFORMATION.Packet_S >= Threshold.Packet_S
        THEN BEGIN
{          DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Packet_S:8,tstr);
           str(Threshold.Packet_S:8,ttstr);
           Message := '     ~Error~ Packet per second now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Utilize  >= Threshold.Utilize
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Utilize:4,tstr);
           str(Threshold.Utilize:4,ttstr);
           Message := '     ~Error~ Utilize now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Drop_S   >= Threshold.Drop_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Drop_S:8,tstr);
           str(Threshold.Drop_S:4,ttstr);
           Message := '     ~Error~ Drop packet now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Byte_S   >= Threshold.Byte_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Byte_S:8,tstr);
           str(Threshold.Byte_S:8,ttstr);
           Message := '     ~Error~ Byte per second now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Broadcast_S >= Threshold.Broadcast_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Broadcast_S:8,tstr);
           str(Threshold.Broadcast_S:8,ttstr);
           Message := '     ~Error~ Broadcast per second now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Undersize_S >= Threshold.Undersize_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Undersize_S:8,tstr);
           str(Threshold.Undersize_S:8,ttstr);
           Message := '     ~Error~ Undersize packet / sec. now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Oversize_S >= Threshold.Oversize_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Oversize_S:8,tstr);
           str(Threshold.Oversize_S:8,ttstr);
           Message := '     ~Error~ Oversize packet / sec. now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;
     IF INFORMATION.Error_S  >= Threshold.Error_S
        THEN BEGIN
{           DisposeINICollection;}
           error := true;
           inc(INFORMATION.Error_s);
           str(INFORMATION.Error_S:4,tstr);
           str(Threshold.Utilize:4,ttstr);
           Message := '     ~Error~ Utilize now ~'+tstr+'~ exceed from ~'+ttstr+'~';
           WriteProfileString('error.ini','error event',writetime(curtime),Message);
        END;

     IF error then WriteProfileString('error.ini','NILL','NILL','NILL');

     w.fill(3,458,519,475,10,1);
     w.tex(12,467,Message,true);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE IncTime (var TimeInput : Time;AddTime : Integer);			บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Inc Time by Added Time								บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure IncTime (var TimeInput : Time;AddTime : Integer);
var counttime : longint;
    hour1,minute1,second1:longint;
begin
     hour1 := timeinput.Hour;
	 minute1 := timeinput.minute;
     second1 := timeinput.second;
     counttime := (hour1*3600) + (minute1*60) + second1;
     counttime := counttime + AddTime;

     TimeInput.Hour   := counttime div 3600;
     TimeInput.Minute := (counttime-((counttime div 3600)*3600)) div 60;
     TimeInput.Second := (counttime-((counttime div 3600)*3600)-
				        (((counttime- ((counttime div 3600)*3600)) div 60)*60));
end;


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

procedure bara(a,b,c,d:integer;color:word);
var  FillInfo: FillSettingsType;
begin
     GetFillSettings(FillInfo);
     setfillstyle(1,color);
     bar(a,b,c,d);
     SetFillStyle(FillInfo.Pattern, FillInfo.Color);
end;

procedure dspmode(e:boolean);
begin
     w.btin1(240,290,360,310,'',10,10,e);
     w.writetext(275,300,'Change',e,0);
     w.writetext(313,300,'M',e,4);
     w.writetext(329,300,'ode',e,0);

end;

procedure button100(e:boolean);
begin
     w.btin1(550,140,620,160,'',10,10,e);
     w.writetext(571,150,'Size',e,0);
     w.writetext(592,150,'1',e,4);
     w.writetext(603,150,'00',e,0);
end;

procedure button250(e:boolean);
begin
     w.btin1(550,170,620,190,'',10,10,e);
     w.writetext(571,180,'Size',e,0);
     w.writetext(592,180,'2',e,4);
     w.writetext(603,180,'50',e,0);

end;

procedure button500(e:boolean);
begin
     w.btin1(550,200,620,220,'',10,10,e);
     w.writetext(571,210,'Size',e,0);
     w.writetext(592,210,'5',e,4);
     w.writetext(603,210,'00',e,0);

end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE Stat;   													บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ0 Display Statistic									บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure stat(check,opcheck,aa:integer;statstart,statend:time;chkcon,chkkeep:integer);
const Month : array [1..12] of String[3] =
                          ('Jan','Feb','Mar','Apr',
                           'May','Jun','Jul','Aug',
                           'Sep','Oct','Nov','Dec');
    Gchar : array [1..36] of Char = '0123456789abcdefghijklmnopqrstuvwxyz';
var
    tInfo : tPacketInfo;
    F               : File;            { Any File type use for long term }
    y, m, d, dow : Word;               { year month day for use long term }
    NumWriten    : Word;               { Numword that writen in long term }
    CurTime,wrttime      : Time;
    bb,cc,dd:integer;
{    hispacket: array[00..70,1..48] of integer;}
{    hisutilize: array[00..70,1..48] of integer;}
    timer3       : _Timer;
   { totalinfo    : statistic;}{oe}
    display_mode,old_mode    : byte;
    Filename : String;
    { general setting}
    byteoe:longint;
    update       : integer;
{    timeinterval : integer;}
    { ** for update display }
    sequence,seoe     : integer;
    show         : boolean;
    tTime,oeTime2,oestr1,oestr2 : string;
    code         : integer;
    display      : boolean;
    starttime,endtime : time;
    first        : boolean;
    oeTime1,TempTime,oetime3     : time;
    maxscale     : integer;
    sampleoe  :longint;
    b7,c7,d7,e7,f7,g7:string;
    oestart,oestop,oediff:Time;
    changesize:integer;
    size100,size250,size500:integer;
    chkscale:integer;
    cccc,aaaa,bbbb,bbbb1,dddd,dddd1,oea{,term,term1}:integer;
    diff,timestart,oeoe,timeend,timenow :longint;
    diffoe:string;
    hour2,minute2,second2:longint;

procedure timeoeja;
var countoeja:longint;
    wrttime:time;
begin{timeoeja}
               wrttime := statstart;
               if opcheck =1 then
               begin
                  inctime(wrttime,(241*term1*timeinterval));
               end
               else inctime(wrttime,(49*term*timeinterval));
               diffoe := WriteTime(wrttime);
               w.fill(30,258,100,272,10,1);
               w.texl(40,265,diffoe);

               wrttime:= statstart;
               if opcheck =1 then
               begin
                  inctime(wrttime,(241*term1*timeinterval)+(60*timeinterval));
               end
               else inctime(wrttime,(49*term*timeinterval)+(12*timeinterval));
               diffoe := WriteTime(wrttime);
               w.fill(150,258,220,272,10,1);
               w.texl(160,265,diffoe);

               wrttime:= statstart;
               if opcheck =1 then
               begin
                  inctime(wrttime,(241*term1*timeinterval)+(120*timeinterval));
               end
               else inctime(wrttime,(49*term*timeinterval)+(24*timeinterval));
               diffoe := WriteTime(wrttime);
               w.fill(270,258,340,272,10,1);
               w.texl(280,265,diffoe);

               wrttime := statstart;
               if opcheck =1 then
               begin
               	  inctime(wrttime,(241*term1*timeinterval)+(180*timeinterval));
               end
               else inctime(wrttime,(49*term*timeinterval)+(36*timeinterval));
               diffoe := WriteTime(wrttime);
               w.fill(390,258,460,272,10,1);
               w.texl(400,265,diffoe);

               wrttime := statstart;
               if opcheck =1 then
               begin
                  inctime(wrttime,(241*term1*timeinterval)+(240*timeinterval));
               end
               else inctime(wrttime,(49*term*timeinterval)+(48*timeinterval));
               diffoe := WriteTime(wrttime);
               w.fill(510,258,570,272,10,1);
               w.texl(520,265,diffoe);

end;{timeoeja}


begin
     gettime2(oetime3);
     if chkcon =1 then begin
					   oetime3.second := oetime3.second+timeinterval;
					   statstart := oetime3;
					   end;
     cccc:=1;
{     startoe1 := statstart;}
	 dddd:=0;
     dddd1:=0;
     chkscale :=5;
{     timeinterval := 10;}
     timeinterval := aa;
     changesize:=3;{packet 500}
     mode := 1;
     display := false;
     first   := true;
     lost := 0;
     term := 0;
     term1 := 0;
{     GetProfileInt(ProFileName,'setting','update',update,1);}

     DisposeINICollection;
     update := aa;
     GetDate(y,m,d,dow);
     Str(d:0,tStr);
     Str(y:2,ttStr);
     if Length(tStr) = 1 then tStr := '0' + tStr;
     tStr := tStr + month[m] + ttStr[3] + ttStr[4];

     Filename := tStr + '.ini';

     fer_tip := 5;
     muta_fer:= false;
     old_mode:=0;
     display_mode := 0;
     w.hide;
     pointstat := 0;
     bbbb:=0;
     bbbb1:=0;
{     wrttime:=statstart;}
     hour2 := statstart.hour;
     minute2 := statstart.minute;
     second2 := statstart.second;

     timestart := (hour2*3600)+(minute2*60)+second2;

     hour2 := statend.hour;
     minute2 := statend.minute;
     second2 := statend.second;

     timeend := (hour2*3600)+(minute2*60)+second2;
{     oeoe := timeend;}
     if check = 1 then w.newwin(10,30,630,450,'Statistic',true)
     else w.newwin(10,30,630,450,'Sampling',true);
{     w.chenar1(560,200,595,220,4,false);}
     w.chenar2(30,320,610,440,false);
     w.chenar2(35,325,605,435,true);
     w.writetext(40,340,'Utilize       :',false,0);
     w.writetext(40,360,'Packet / s    :',false,0);
     w.writetext(40,380,'Byte / s      :',false,0);
     w.writetext(40,400,'Total Packets :',false,0);
     if check <> 1 then
	 w.writetext(40,420,'Time          :',false,0);
     w.writetext(340,340,'Oversize/s  :',false,0);
     w.writetext(340,360,'Undersize/s :',false,0);
     w.writetext(340,380,'Drop / s    :',false,0);
     w.writetext(340,400,'Total Bytes :',false,0);

{          w.fill(40,313,100,327,10,1);
          str(timenow,diffoe);
		  w.tex(40,320,diffoe,true);}

{     w.btin1(240,290,360,310,'',10,10,false);
     w.writetext(275,300,'Change',false,0);
     w.writetext(313,300,'M',false,4);
     w.writetext(329,300,'ode',false,0);}
     dspmode(false);

     statstart.sec100 := 0;
     statend.sec100 := 0;
     TimeDifferent(statstart,statend,oediff);

     hour2 := oediff.hour;
     minute2 := oediff.minute;
     second2 := oediff.second;

	 diff := (hour2*3600)+(minute2*60)+second2;
     if check  =1 then diff := 5000000;
{     str(diff,diffoe);
     w.fill(40,433,100,447,10,1);
     w.tex(40,440,diffoe,true);}

     str(statstart.hour,b7);str(statstart.minute,c7);str(statstart.second,d7);
     str(statend.hour,e7);str(statend.minute,f7);str(statend.second,g7);
     oestr1 := 'Start  '+b7+':'+c7+':'+d7;
     oestr2 := '    '+'Stop  '+e7+':'+f7+':'+g7;
     if (statstart.hour <> 0) or (statstart.minute <> 0) or (statstart.second <> 0)  then
     begin
     w.writetext(300,420,oestr1,false,0);
     w.writetext(400,420,oestr2,false,0);
     end;
     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
     graph_scale(horizdir,horizdir,'','');
     w.show;
  {   w.writetext(570,250,'Time',false,0);
     w.writetext(60,80,'percent',false,0);}

     { ** INITIAL INFORMATION & THRESHOLD ONE 19/1/40}
     INFORMATION.Packet_S   := 0;
     INFORMATION.Utilize    := 0;
     INFORMATION.Error_S    := 0;
     INFORMATION.Drop_S     := 0;
     INFORMATION.Byte_S     := 0;
     INFORMATION.BroadCast_S:= 0;
     INFORMATION.Undersize_S:= 0;
     INFORMATION.Oversize_S := 0;
     INFORMATION.Byte_T := 0;
     INFORMATION.Packet_T := 0;

     {Init Timer}
     Timer1.Init(1);
     Timer1.Start;
     Timer2.Init(update);
     Timer2.Start;
{     Timer3.Init(timeinterval);
     Timer3.Start;}

     REPEAT
     IF ( PacketCount = 1 ) THEN       { Receive Packet }
     BEGIN
              {** for global statistic }
              IF RcvLength < 60 THEN Inc(INFORMATION.Undersize_S);
              IF RcvLength > 1514 THEN Inc(INFORMATION.Oversize_S);

              {** read input }
              Move(Rcvpacket,tInfo,sizeof(Rcvpacket)); { copy_length }

                      IF CompareEthernetAddr(tInfo.Header.SourceAddr,BROADCAST)
                         or CompareEthernetAddr(tInfo.Header.DestAddr,BROADCAST)
                      THEN Inc(INFORMATION.Broadcast_S);
                      { ** begin of statistic module }
                      Inc(count);
                      Inc(ByteCount,RcvLength);
                      GetTime2(tInfo.PktTime);
                      tInfo.Length := RcvLength;
                      { ** end of statistic module }
              RcvLength   := 0;
              PacketCount := 0;            { Reset flag for new frames }
     END;

     if keypressed then key := readkey;
     IF upcase(key) = '1' then begin
								changesize := 1;
								end;
     IF upcase(key) = '2' then begin
								changesize := 2;
							   end;
     IF upcase(key) = '5' then begin
								changesize := 3;
							   end;
     IF upcase(key) = 'M' then
     Begin
          dspmode(true);
          Key := #0;
                Mode := Mode + 1;
                Display := true;
                w.refwins(stay,stay);
    { w.chenar1(560,200,595,220,4,false);}
     w.chenar2(30,320,610,440,false);
     w.chenar2(35,325,605,435,true);
     w.writetext(40,340,'Utilize       :',false,0);
     w.writetext(40,360,'Packet / s    :',false,0);
     w.writetext(40,380,'Byte / s      :',false,0);
     w.writetext(40,400,'Total Packets :',false,0);
     if check <> 1 then
	 w.writetext(40,420,'Time          :',false,0);
     w.writetext(340,340,'Oversize/s :',false,0);
     w.writetext(340,360,'Undersize/s:',false,0);
     w.writetext(340,380,'Drop / s   :',false,0);
	 w.writetext(340,400,'Total Bytes :',false,0);
     if (statstart.hour <> 0) or (statstart.minute <> 0) or (statstart.second <> 0)  then
       begin
        w.writetext(300,420,oestr1,false,0);
        w.writetext(400,420,oestr2,false,0);
       end;
     TimeDifferent(oestart,oestop,oediff);

     hour2 := oediff.hour;
     minute2 := oediff.minute;
     second2 := oediff.second;

	 diff := (hour2*3600)+(minute2*60)+second2;
     if check  =1 then diff := 5000000;
{     w.fill(40,433,100,447,10,1);
     str(diff,diffoe);
     w.tex(40,440,diffoe,true);}

     dspmode(false);
                IF Mode > 2 THEN Mode := 1;
          case mode of
             1: Begin
                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Utilize',false,1);
                End;
             2: Begin
                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Packet',false,1);
 					 button100(false);
                     button250(false);
					 button500(false);
                End;
          End;
     End;

     IF Timer1.Timeout THEN
     BEGIN
		  GetTime2(oeTime1);

          hour2 := oetime1.hour;
          minute2 := oetime1.minute;
          second2 := oetime1.second;

          timenow := (hour2*3600)+(minute2*60)+second2;

          if timenow = timestart then cccc:=2;

{          w.fill(40,313,100,327,10,1);
          str(timenow,diffoe);
		  w.tex(40,320,diffoe,true);

          w.fill(140,313,200,327,10,1);
          str(statend.hour,diffoe);
		  w.tex(140,320,diffoe,true);

          w.fill(240,313,300,327,10,1);
          str(statend.minute,diffoe);
		  w.tex(240,320,diffoe,true);

          w.fill(340,313,400,327,10,1);
          str(statend.second,diffoe);
		  w.tex(340,320,diffoe,true);

          w.fill(40,293,100,307,10,1);
          str(timestart,diffoe);
		  w.tex(40,300,diffoe,true);

          w.fill(140,293,200,307,10,1);
          str(cccc,diffoe);
		  w.tex(140,300,diffoe,true);

          w.fill(240,293,300,307,10,1);
          str(opcheck,diffoe);
		  w.tex(240,300,diffoe,true);}

{          timeend := (statend.hour*3600)+(statend.minute*60)+statend.second;}
{          w.fill(340,293,400,307,10,1);
          str(timeend,diffoe);
		  w.tex(340,300,diffoe,true);}


          oeTime2 := 'Time ' + WriteTime(oeTime1);
          w.fill(531,458,636,475,10,1);
		  w.tex(540,467,oeTime2,true);

          {** Check INFORMATION }
          INFORMATION.Packet_S := Count;
          INFORMATION.Utilize  := ((INFORMATION.Byte_S * 100 DIV 1240256) + ((INFORMATION.Packet_S*300) DIV 310064));
          INFORMATION.Byte_S   := ByteCount;
          INFORMATION.Byte_T   := INFORMATION.Byte_T+ByteCount;
          INFORMATION.Packet_T := INFORMATION.Packet_T + Count;
          INFORMATION.Drop_S   := LOST;
          LOST                 := 0;
          ByteCount            := 0;
          Count                := 0;

          Timer1.Start;
     END;
     cc := 1;
     IF Timer2.Timeout or display THEN
     BEGIN


        if (diff >= update) and (opcheck = 1) then
        begin{diffoe}
          diff := diff-update;
{          if diff >= 0 then
          begin
          w.fill(40,433,100,447,10,1);
          str(diff,diffoe);
		  w.tex(40,440,diffoe,true);
          end;}

          buffstat[pointstat].Utilize := INFORMATION.Utilize;
          buffstat[pointstat].Broadcast_S := INFORMATION.Broadcast_s;
          buffstat[pointstat].Undersize_s := INFORMATION.Undersize_s;
          buffstat[pointstat].Oversize_s := INFORMATION.Oversize_s;
          buffstat[pointstat].Packet_S := INFORMATION.Packet_S;
          buffstat[pointstat].Byte_S := INFORMATION.Byte_S;
          buffstat[pointstat].Drop_S := INFORMATION.Drop_S;
          buffstat[pointstat].ERROR_S := INFORMATION.ERROR_S;
          inc(pointstat);
          MaxScale := 48 * 10;

          bbbb1 := dddd1 DIV 241;
          if bbbb1 = 1 then
		  begin
		      pointstat := 0;
              term1 := term1+1;
{              for aaaa := 1 to 240 do
              begin
                   hispacket[term1,aaaa] := buffstat[aaaa].packet_s;
                   hisutilize[term1,aaaa] := buffstat[aaaa].utilize;
              end;}
          end;
          dddd1 := dddd1 mod 241;

          if check  = 1 then DisplayInfo(8,1)
		                else DisplayInfo(8,2);
     { ** check mode of display }
     case mode of
         1:begin
               { reset graph and other values }
               init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
               graph_scale(horizdir,horizdir,'','');
               ref_graph;

               w.writetext(570,250,'Time',false,0);
               w.writetext(50,80,'Percent',false,0);


               timeoeja;

               show := true;
               TempTime := StartTime;
               sequence := 0;

               { ** read from buffer file }
          repeat
            tInt := 0;
{            IF sequence <= pointstat then
               tInt := buffstat[sequence].Utilize;
               tint := (tint*3) DIV 2;
            IF tInt > 150 then tInt := 150;


            { display graph and others }
  {          IF show then bara(((2*sequence)-1)+60,250,
						((2*sequence)+1)+60,250-tint,4);
            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);}

            IF (sequence = pointstat-timeinterval) and (dddd1>0) then
			begin
			     for aaaa := 1 to dddd1 do
				 begin
               tInt := buffstat[sequence+((aaaa-dddd1)*timeinterval)].Utilize;

{               str(tint,diffoe);
               w.fill(40,283,100,297,10,1);
               w.tex(40,290,diffoe,true);}

{               str(dddd1,diffoe);
               w.fill(120,283,180,297,10,1);
               w.tex(120,290,diffoe,true);}

            tint := (tint*3) DIV 2;
            IF tInt > 150 then tInt := 150;


            { display graph and others }
{            if show then bara(((2*sequence)-1)+60,250,
						((2*sequence)+1)+60,250-tint,4);}
              if show then bara(59+(2*aaaa),250,61+(2*aaaa),250-tint,4);
             end;{sequence}
          end;
            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);

          inc(dddd1);
          str(INFORMATION.Utilize,tstr);
          w.fill(190,333,220,347,10,1);
          w.texl(190,340,tstr+'%');
          str(INFORMATION.Packet_S,tstr);
          w.fill(190,353,280,367,10,1);
          w.texl(190,360,tstr+' packet/S');
          str(INFORMATION.Byte_S,tstr);
          w.fill(190,373,280,387,10,1);
          w.texl(190,380,tstr+' Byte/S');

          str(INFORMATION.Packet_T,tstr);
          w.fill(190,393,280,407,10,1);{18/5/41 oe}
          w.texl(190,400,tstr+' Packets');{18/5/41 oe}

          str(INFORMATION.Oversize_S,tstr);
          w.fill(440,333,560,347,10,1);
          w.texl(440,340,tstr+' packet/S');
          str(INFORMATION.Undersize_S,tstr);
          w.fill(440,353,560,367,10,1);
          w.texl(440,360,tstr+' packet/S');
          str(INFORMATION.DROP_S,tstr);
          w.fill(440,373,560,387,10,1);
          w.texl(440,380,tstr+' packet/S');

          str(INFORMATION.Byte_T,tstr);
          w.fill(440,393,560,407,10,1);
          w.texl(440,400,tstr+' Bytes');

          end;

        2:begin
               { reset graph and other values }

               w.writetext(570,250,'Time',false,0);
               w.writetext(50,80,'Packet',false,0);
               w.fill(30,250,57,85,10,1);
               if changesize = 1 then init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
               if changesize = 2 then init_graph(60,250,240,10,2,15,20,1,0,0,0,25,1);
               if changesize = 3 then init_graph(60,250,240,10,2,15,20,1,0,0,0,50,1);
               graph_scale(horizdir,horizdir,'','');
               ref_graph;

               timeoeja;

               show := true;
               sequence := 1;

               { ** read from buffer file }

            repeat
               tInt := 0;
            IF (sequence = pointstat-timeinterval) and (dddd1>0) then
			begin
			     for aaaa := 1 to dddd1 do
				 begin
               tInt := buffstat[sequence+((aaaa-dddd1)*timeinterval)].Packet_S;

{               str(tint,diffoe);
               w.fill(40,283,100,297,10,1);
               w.tex(40,290,diffoe,true);}

{               str(dddd1,diffoe);
               w.fill(120,283,180,297,10,1);
               w.tex(120,290,diffoe,true);}

             if changesize = 1 then tInt := (tInt *3) DIV 2;{oe 19/5/41}
             if changesize = 2 then tInt := (tInt *3) DIV 5;{oe 19/5/41}
             if changesize = 3 then tInt := (tInt *3) DIV 10;{oe 19/5/41}
            IF tInt > 150 then tInt := 150;
{             if show then bara(60+((2*aaaa*timeinterval)-1),250,
  			              60+((2*aaaa*timeinterval)+1),250-tint,4);}
              if show then bara(59+(2*aaaa),250,61+(2*aaaa),250-tint,4);
                end;
            end;

            { display graph and others }

            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);

{          repeat
               tInt := 0;
            IF sequence <= pointstat then
               tInt := buffstat[sequence].Packet_S;


             tInt := (tInt * 3) DIV 10;{oe 19/5/41}
{            IF tInt > 150 then tInt := 150;


            { display graph and others }
{            IF show then bara(60+((2*sequence)-1),250,60+((2*sequence)+1)
							 ,250-tInt,4);

            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);}

          inc(dddd1);
          str(INFORMATION.Utilize,tstr);
          w.fill(190,333,220,347,10,1);
          w.texl(190,340,tstr+'%');
          str(INFORMATION.Packet_S,tstr);
          w.fill(190,353,280,367,10,1);
          w.texl(190,360,tstr+' packet/S');
          str(INFORMATION.Byte_S,tstr);
          w.fill(190,373,280,387,10,1);
          w.texl(190,380,tstr+' Byte/S');

          str(INFORMATION.Packet_T,tstr);
          w.fill(190,393,280,407,10,1);{18/5/41 oe}
          w.texl(190,400,tstr+' Packets');{18/5/41 oe}

          str(INFORMATION.Oversize_S,tstr);
          w.fill(440,333,560,347,10,1);
          w.texl(440,340,tstr+' packet/S');
          str(INFORMATION.Undersize_S,tstr);
          w.fill(440,353,560,367,10,1);
          w.texl(440,360,tstr+' packet/S');
          str(INFORMATION.DROP_S,tstr);
          w.fill(440,373,560,387,10,1);
          w.texl(440,380,tstr+' packet/S');

		  str(INFORMATION.Byte_T,tstr);
          w.fill(440,393,560,407,10,1);
          w.texl(440,400,tstr+' Bytes');

          end;
        end;

     { ** INITIAL INFORMATION & THRESHOLD ONE 19/1/40}
     INFORMATION.Packet_S   := 0;
     INFORMATION.Utilize    := 0;
     INFORMATION.Error_S    := 0;
     INFORMATION.Drop_S     := 0;
     INFORMATION.Byte_S     := 0;
     INFORMATION.BroadCast_S:= 0;
     INFORMATION.Undersize_S:= 0;
     INFORMATION.Oversize_S := 0;
     Display := false;
     Timer2.start;
     end;{diffoe}

      if (Timenow <= timeend) and (opcheck = 2) and
         ((chkcon = 1) or (cccc =2)) then
        begin{check time start and time stop}

{          w.fill(40,433,100,447,10,1);
          str(diff,diffoe);
		  w.tex(40,440,diffoe,true);}
          if check  = 1 then DisplayInfo(8,1)
		                else DisplayInfo(8,2);

{          str(pointstat,diffoe);
          w.fill(40,303,100,317,10,1);
          w.tex(40,310,diffoe,true);}
          byteoe:= INFORMATION.Byte_S ;
          byteoe := byteoe DIV 200;

          buffstat[pointstat].Utilize := INFORMATION.Utilize;
          buffstat[pointstat].Broadcast_S := INFORMATION.Broadcast_s;
          buffstat[pointstat].Undersize_s := INFORMATION.Undersize_s;
          buffstat[pointstat].Oversize_s := INFORMATION.Oversize_s;
          buffstat[pointstat].Packet_S := INFORMATION.Packet_S;
          buffstat[pointstat].Byte_S := byteoe;{INFORMATION.Byte_S;}
          buffstat[pointstat].Drop_S := INFORMATION.Drop_S;
          buffstat[pointstat].ERROR_S := INFORMATION.ERROR_S;
          inc(pointstat,timeinterval);
          MaxScale := 48 * 10;

          bbbb := dddd DIV 49;
          if bbbb = 1 then
		  begin
		      pointstat := 0;
              term := term+1;
{           if chkpacket then beroe1 := 1 else beroe1 := 0;
           if chkutilize then beroe2 := 1 else beroe2 := 0;
           if chkbroad then beroe3 := 1 else beroe3 := 0;
           if chkover then beroe4 := 1 else beroe4 := 0;
           if chkunder then beroe5 := 1 else beroe5 := 0;
           if chkerror then beroe6 := 1 else beroe6 := 0;
           if chkbyte then beroe7 := 1 else beroe7 := 0;
           if chkdrop then beroe8 := 1 else beroe8 := 0;}

              for aaaa := 1 to 48 do
              begin
				   if chkkeep = 1 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].packet_s;
				   if chkkeep = 2 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].utilize;
				   if chkkeep = 3 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].broadcast_s;
				   if chkkeep = 4 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].oversize_s;
				   if chkkeep = 5 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].undersize_s;
				   if chkkeep = 6 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].error_s;
				   if chkkeep = 7 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].byte_s ;
				   if chkkeep = 8 then hispacket[term,aaaa] := buffstat[aaaa*timeinterval].drop_s;
              end;

          end;
          dddd := dddd mod 49;
{          if pointstat > 240 then pointstat := 0;}


     { ** check mode of display }
     case mode of
         1:begin
               { reset graph and other values }
               init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
               graph_scale(horizdir,horizdir,'','');
               ref_graph;

               w.writetext(570,250,'Time',false,0);
               w.writetext(50,80,'Percent',false,0);

               timeoeja;

               show := true;
               TempTime := StartTime;
               sequence := 0;
               { ** read from buffer file }

          repeat
            tInt := 0;
            IF (sequence = pointstat-timeinterval) and (dddd>0) then
			begin
			     for aaaa := 1 to dddd do
				 begin
               tInt := buffstat[sequence+((aaaa-dddd)*timeinterval)].Utilize;

{               str(tint,diffoe);
               w.fill(40,283,100,297,10,1);
               w.tex(40,290,diffoe,true);}

{               str(dddd,diffoe);
               w.fill(120,283,180,297,10,1);
               w.tex(120,290,diffoe,true);}

            tint := (tint*3) DIV 2;
            IF tInt > 150 then tInt := 150;


            { display graph and others }
{            if show then bara(((2*sequence)-1)+60,250,
						((2*sequence)+1)+60,250-tint,4);}
              if show then bara(59+(10*aaaa),250,61+(10*aaaa),250-tint,4);
             end;{sequence}
          end;
            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);

          inc(dddd);
          str(INFORMATION.Utilize,tstr);
          w.fill(190,333,220,347,10,1);
          w.texl(190,340,tstr+'%');
          str(INFORMATION.Packet_S,tstr);
          w.fill(190,353,280,367,10,1);
          w.texl(190,360,tstr+' packet/S');
          str(INFORMATION.Byte_S,tstr);
          w.fill(190,373,280,387,10,1);
          w.texl(190,380,tstr+' Byte/S');

          str(INFORMATION.Packet_T,tstr);
          w.fill(190,393,280,407,10,1);{18/5/41 oe}
          w.texl(190,400,tstr+' Packets');{18/5/41 oe}

          str(INFORMATION.Oversize_S,tstr);
          w.fill(440,333,560,347,10,1);
          w.texl(440,340,tstr+' packet/S');
          str(INFORMATION.Undersize_S,tstr);
          w.fill(440,353,560,367,10,1);
          w.texl(440,360,tstr+' packet/S');
          str(INFORMATION.DROP_S,tstr);
          w.fill(440,373,560,387,10,1);
          w.texl(440,380,tstr+' packet/S');

          str(INFORMATION.Byte_T,tstr);
          w.fill(440,393,560,407,10,1);
          w.texl(440,400,tstr+' Bytes');

          end;

        2:begin
               { reset graph and other values }

               w.writetext(570,250,'Time',false,0);
               w.writetext(50,80,'Packet',false,0);

               w.fill(30,250,57,85,10,1);
               if changesize = 1 then init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
               if changesize = 2 then init_graph(60,250,240,10,2,15,20,1,0,0,0,25,1);
               if changesize = 3 then init_graph(60,250,240,10,2,15,20,1,0,0,0,50,1);
               graph_scale(horizdir,horizdir,'','');
               ref_graph;

               timeoeja;

               show := true;
               sequence := 0;
			   bbbb:=1;
            {   dddd := dddd mod 49;}
               { ** read from buffer file }
            repeat
               tInt := 0;
            IF (sequence = pointstat-timeinterval) and (dddd>0) then
			begin
			     for aaaa := 1 to dddd do
				 begin
               tInt := buffstat[sequence+((aaaa-dddd)*timeinterval)].Packet_S;

{               str(tint,diffoe);
               w.fill(40,283,100,297,10,1);
               w.tex(40,290,diffoe,true);}

{               str(dddd,diffoe);
               w.fill(120,283,180,297,10,1);
               w.tex(120,290,diffoe,true);}

             if changesize = 1 then tInt := (tInt *3) DIV 2;{oe 19/5/41}
             if changesize = 2 then tInt := (tInt *3) DIV 5;{oe 19/5/41}
             if changesize = 3 then tInt := (tInt *3) DIV 10;{oe 19/5/41}

            IF tInt > 150 then tInt := 150;
{             if show then bara(60+((2*aaaa*timeinterval)-1),250,
  			              60+((2*aaaa*timeinterval)+1),250-tint,4);}
              if show then bara(59+(10*aaaa),250,61+(10*aaaa),250-tint,4);
                end;
            end;

            { display graph and others }

            Inc(Sequence);
            IncTime(TempTime,TimeInterval);
          until (Sequence=239) or (Sequence> pointstat) or not(show);

          inc(dddd);
          str(INFORMATION.Utilize,tstr);
          w.fill(190,333,220,347,10,1);
          w.texl(190,340,tstr+'%');
          str(INFORMATION.Packet_S,tstr);
          w.fill(190,353,280,367,10,1);
          w.texl(190,360,tstr+' packet/S');
          str(INFORMATION.Byte_S,tstr);
          w.fill(190,373,280,387,10,1);
          w.texl(190,380,tstr+' Byte/S');

          str(INFORMATION.Packet_T,tstr);
          w.fill(190,393,280,407,10,1);{18/5/41 oe}
          w.texl(190,400,tstr+' Packets');{18/5/41 oe}

          str(INFORMATION.Oversize_S,tstr);
          w.fill(440,333,560,347,10,1);
          w.texl(440,340,tstr+' packet/S');
          str(INFORMATION.Undersize_S,tstr);
          w.fill(440,353,560,367,10,1);
          w.texl(440,360,tstr+' packet/S');
          str(INFORMATION.DROP_S,tstr);
          w.fill(440,373,560,387,10,1);
          w.texl(440,380,tstr+' packet/S');

		  str(INFORMATION.Byte_T,tstr);
          w.fill(440,393,560,407,10,1);
          w.texl(440,400,tstr+' Bytes');

          end;
        end;
     { ** INITIAL INFORMATION & THRESHOLD ONE 19/1/40}
     INFORMATION.Packet_S   := 0;
     INFORMATION.Utilize    := 0;
     INFORMATION.Error_S    := 0;
     INFORMATION.Drop_S     := 0;
     INFORMATION.Byte_S     := 0;
     INFORMATION.BroadCast_S:= 0;
     INFORMATION.Undersize_S:= 0;
     INFORMATION.Oversize_S := 0;
     Display := false;
     Timer2.start;

    end;{check time start and time stop}

  END;{Timer2}

     {** write to file }
{     IF Timer3.Timeout THEN
     BEGIN
      {    totalinfo.Utilize := totalinfo.Utilize DIV timeinterval;
          totalinfo.Broadcast_S := totalinfo.Broadcast_S DIV timeinterval;
          totalinfo.Undersize_S := totalinfo.Undersize_S DIV timeinterval;
          totalinfo.Oversize_S := totalinfo.Oversize_S DIV timeinterval;
          totalinfo.Packet_S := totalinfo.Packet_S DIV timeinterval;
          totalinfo.Byte_S := totalinfo.Byte_S DIV timeinterval;
          totalinfo.Drop_S := totalinfo.Drop_S DIV timeinterval;
          totalinfo.ERROR_S := totalinfo.ERROR_S DIV timeinterval;}

          { ** Write to file }
{          GetTime2(EndTime);
          If first then begin first := false; StartTime := EndTime; end;

{          buffstat[pointstat].Utilize := totalinfo.Utilize;
          buffstat[pointstat].Broadcast_S := totalinfo.Broadcast_s;
          buffstat[pointstat].Undersize_s := totalinfo.Undersize_s;
          buffstat[pointstat].Oversize_s := totalinfo.Oversize_s;
{          buffstat[pointstat].Packet_S:= totalinfo.Packet_S;}
{          buffstat[pointstat].Packet_S := INFORMATION.Packet_S;
          buffstat[pointstat].Byte_S := totalinfo.Byte_S;
          buffstat[pointstat].Drop_S := totalinfo.Drop_S;
          buffstat[pointstat].ERROR_S := totalinfo.ERROR_S;
          inc(pointstat,timeinterval);
          MaxScale := 48 * 10;
          if pointstat > 240 then pointstat := 0;}


{          totalinfo.Utilize := 0;
          totalinfo.Broadcast_S := 0;
          totalinfo.Undersize_S := 0;
          totalinfo.Oversize_S := 0;
          totalinfo.Packet_S   := 0;
          totalinfo.Byte_S     := 0;
          totalinfo.Drop_S     := 0;
          totalinfo.ERROR_S    := 0;
          Timer3.Start;
     END;}

     UNTIL key=#27;



     w.clrwin(1);
     cm := 0;
     Key := #0;

end;

procedure history;
var tint:integer;
    diffoe,tchkdisplay:string;
    chkdisplay:integer;
    code:integer;
    chkstatus:integer;
    chkstatoe:boolean;

procedure displayhis;
var aaaa:integer;
    wrtime:time;

begin{display history}

     fer_tip := 5;
     muta_fer := false;
	 w.newwin(10,30,630,450,'History',true);
	 REPEAT

     { reset graph and other values }
           if totaloe = 4 then{oversize}
             begin{oversize}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Oversize',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);
	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);

			 end;{oversize}

           if totaloe = 8 then{drop}
			 begin{drop}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Drop Packet',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);

			 end;{drop}

           if totaloe = 7 then{Byte}
		     begin{Byte}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,1000,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Byte',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Byte',false,0);

			 end;{Byte}

           if totaloe = 6 then{error}
			 begin{error}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Error Packet',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);

			 end;{error}

           if totaloe =5 then{undersize}
			 begin{undersize}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Undersize',false,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);

			 end;{undersize}

           if totaloe =3 then{Broadcast}
             begin{Broadcast}
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Broadcast',false,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);

			 end;{Broadcast}

           if totaloe = 2 then{Utilize}
           			 begin
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,10,1);
                     graph_scale(horizdir,horizdir,'','');
                     ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Utilize',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

	                 w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Percent',false,0);

                     end;
		   if totaloe = 1 then {packet}
                     begin
                     init_graph(60,250,240,10,2,15,20,1,0,0,0,50,1);
     	             graph_scale(horizdir,horizdir,'','');
     	             ref_graph;

                     w.fill(260,73,370,87,10,1);
                     w.writetext(260,80,'Packet',false,1);

                     w.fill(570,243,640,257,10,1);
                     w.fill(50,73,120,87,10,1);

                     w.writetext(570,250,'Time',false,0);
                     w.writetext(50,80,'Packet',false,0);
                     end;

     {show := true;
     TempTime := StartTime;
     sequence := 0;}

               wrtime := samstart;
              { if timeinterval =1 then
               begin
                  inctime(wrtime,241*(chkdisplay-1)*timeinterval);
               end
               else} inctime(wrtime,49*(chkdisplay-1)*timeinterval);
               diffoe := WriteTime(wrtime);
               w.fill(30,258,100,272,10,1);
               w.texl(40,265,diffoe);

               wrtime:= samstart;
               {if timeinterval =1 then
               begin
                  inctime(wrtime,(241*(chkdisplay-1)*timeinterval)+(60*timeinterval));
               end
               else} inctime(wrtime,(49*(chkdisplay-1)*timeinterval)+(12*timeinterval));
               diffoe := WriteTime(wrtime);
               w.fill(150,258,220,272,10,1);
               w.texl(160,265,diffoe);

               wrtime:= samstart;
             {  if timeinterval =1 then
               begin
                  inctime(wrtime,(241*(chkdisplay-1)*timeinterval)+(120*timeinterval));
               end
               else} inctime(wrtime,(49*(chkdisplay-1)*timeinterval)+(24*timeinterval));
               diffoe := WriteTime(wrtime);
               w.fill(270,258,340,272,10,1);
               w.texl(280,265,diffoe);

               wrtime := samstart;
            {   if timeinterval =1 then
               begin
               	  inctime(wrtime,(241*(chkdisplay-1)*timeinterval)+(180*timeinterval));
               end
               else} inctime(wrtime,(49*(chkdisplay-1)*timeinterval)+(36*timeinterval));
               diffoe := WriteTime(wrtime);
               w.fill(390,258,460,272,10,1);
               w.texl(400,265,diffoe);

               wrtime := samstart;
             {  if timeinterval =1 then
               begin
                  inctime(wrtime,(241*(chkdisplay-1)*timeinterval)+(240*timeinterval));
               end
               else} inctime(wrtime,(49*(chkdisplay-1)*timeinterval)+(48*timeinterval));
               diffoe := WriteTime(wrtime);
               w.fill(510,258,570,272,10,1);
               w.texl(520,265,diffoe);

	 		for aaaa := 1 to 48 do
	 		begin{for a}
	    		tint := 0;
                tint := hispacket[chkdisplay,aaaa];

{        		str(tint,diffoe);
        		w.fill(40,283,100,297,10,1);
        		w.tex(40,290,diffoe,true);}
                if (totaloe <> 1) and (totaloe <> 7) then tint := (tint*3) DIV 2;
                if totaloe = 1 then tint := (tint*3) DIV 10;
                if totaloe = 7 then tint := tint*3;
        		IF tInt > 150 then tInt := 150;


     { display graph and others }
        		bara(59+(10*aaaa),250,61+(10*aaaa),250-tint,4);
     		end;{for a}
	       w.handleevent;
	 UNTIL (event_ch=#27) or (Key=#27);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;

end;{display history}

label sample1;
begin{history}

     fer_tip := 5;
     muta_fer := false;
     DisposeINIcollection;
     GetProfileInt(ProFileName,'setting','chkdisplay',chkdisplay,1);
     str(chkdisplay,tchkdisplay);

	 w.newwin(100,100,500,300,'History',true);

     str(term,diffoe);
	 w.newtext(120,150,'T~o~tal of your data page');
     w.newtext(120,170,diffoe);

     w.newtext(120,190,'S~e~e page');
     w.newinput(120,205,150,220,tchkdisplay,'e');

{     w.newtext(120,240,'do not click if you want to see paket');
     w.newtext(120,260,'click if you want to see utilize');
{    w.newcheck(120,275,' P~a~cket/utilize',2,false);}

     w.newbut(420,205,480,225,'S~t~art',9,os2,'');

	 REPEAT
sample1 :
           w.handleevent;
           if cm=2 then
           begin
           tchkdisplay := w.get_input(1);
{           chkstatoe := w.check_result(0);}

           {check value}
		   val(tchkdisplay,chkdisplay,code);
{		   val(tsec_stop,sec_stop,code);
         if ((code <> 0) or (sec_stop < 0) or (sec_stop > 60)) then
         begin
           w.dispmsg('Error','Second Stop must be integer `and more than 0 but less than 60');
           goto sample1;
         end;
           val(tsec_samp,sec_samp,code);
        if checkoe then checkoe1 :=1 else checkoe1 := 2;
        samstart.hour := hour_start;
        samstart.minute := min_start;
        samstart.second := sec_start;
        samend.hour := hour_stop;
        samend.minute := min_stop;
        samend.second := sec_stop;
        stat(3,checkoe1,sec_samp,samstart,samend);
       end;{handle event repeat}
         displayhis;
         end;
	 UNTIL (event_ch=#27) or (Key=#27) or (cm=1);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;

end;

procedure helpoe;
const
     StrFileName = 'stathlp.hlp';
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
     close(fStr);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;

end;

procedure Samoe;
var hour_start,min_start,sec_start:integer;
	hour_stop,min_stop,sec_stop:integer;
    code:integer;
    chktime:time;
{    samstart,samend:time;}
    checkoe1:integer;
    checkoe,chkutilize,chkbyte:boolean;
    chkpacket,chkerror,chkbroad,chkdrop,chkover,chkunder:boolean;
    sec_samp:integer;
    beroe1,beroe2,beroe3,beroe4,beroe5,beroe6,beroe7,beroe8:integer;
{    totaloe:integer;}
    thour_start,tmin_start,tsec_start:string;
    thour_stop,tmin_stop,tsec_stop:string;
    tsec_samp:string;
label sample1;
begin
     fer_tip := 5;
     muta_fer := false;
     DisposeINIcollection;
     gettime2(chktime);
     GetProfileInt(ProFileName,'setting','hour_start',hour_start,chktime.hour);
     GetProfileInt(ProFileName,'setting','min_start',min_start,chktime.minute+2);
	 GetProfileInt(ProFileName,'setting','sec_start',sec_start,chktime.second);
     GetProfileInt(ProFileName,'setting','hour_stop',hour_stop,chktime.hour+2);
     GetProfileInt(ProFileName,'setting','min_stop',min_stop,chktime.minute);
     GetProfileInt(ProFileName,'setting','sec_stop',sec_stop,chktime.second);
     GetProfileInt(ProFileName,'setting','sec_samp',sec_samp,9);
     str(hour_start,thour_start);
     str(min_start,tmin_start);
     str(sec_start,tsec_start);
     str(hour_stop,thour_stop);
     str(min_stop,tmin_stop);
     str(sec_stop,tsec_stop);
     str(sec_samp,tsec_samp);

	 w.newwin(100,100,500,400,'Sampling',true);

	 w.newtext(264,150,'~H~our');
     w.newinput(260,160,300,175,thour_start,'H');

     w.newtext(120,168,'Time Start');

	 w.newtext(302,168,':');

     w.newtext(310,150,'~M~inute');
     w.newinput(310,160,350,175,tmin_start,'M');

     w.newtext(352,168,':');

     w.newtext(360,150,'~S~econd');
     w.newinput(360,160,400,175,tsec_start,'S');

     w.newtext(264,200,'H~o~ur');
     w.newinput(260,210,300,225,thour_stop,'o');

     w.newtext(120,218,'Time Stop');

     w.newbut(420,205,480,225,'S~t~art',9,os2,'');

     w.newtext(302,218,':');

     w.newtext(310,200,'M~i~nute');
     w.newinput(310,210,350,225,tmin_stop,'i');

     w.newtext(352,218,':');

     w.newtext(360,200,'S~e~cond');
     w.newinput(360,210,400,225,tsec_stop,'e');

     w.newtext(120,268,'Every Sampling');

     w.newtext(260,250,'Se~c~ond');
     w.newinput(260,260,300,275,tsec_samp,'c');

     w.newcheck(340,260,' Sampling ~N~ow',2,false);

     w.newcheck(150,300,'Pac~k~et',2,false);
     w.newcheck(330,300,'~U~tilize',2,false);
     w.newcheck(150,320,'~B~roadcast',2,false);
     w.newcheck(330,320,'O~v~ersize',2,false);
     w.newcheck(150,340,'Un~d~ersize',2,false);
     w.newcheck(330,340,'E~r~ror',2,false);
     w.newcheck(150,360,'B~y~te',2,false);
     w.newcheck(330,360,'Dro~p~',2,false);
	 REPEAT
sample1 :
           w.handleevent;
           if cm=2 then
           begin
           thour_start := w.get_input(1);
     	   tmin_start := w.get_input(2);
     	   tsec_start := w.get_input(3);
	 	   thour_stop := w.get_input(4);
     	   tmin_stop := w.get_input(5);
     	   tsec_stop := w.get_input(6);
     	   tsec_samp := w.get_input(7);
           checkoe := w.check_result(0);
           chkpacket := w.check_result(1);
		   chkutilize := w.check_result(2);
           chkbroad := w.check_result(3);
           chkover	:= w.check_result(4);
   		   chkunder := w.check_result(5);
           chkerror := w.check_result(6);
           chkbyte  := w.check_result(7);
           chkdrop  := w.check_result(8);
           {check value}

           if chkpacket then beroe1 := 1 else beroe1 := 0;
           if chkutilize then beroe2 := 1 else beroe2 := 0;
           if chkbroad then beroe3 := 1 else beroe3 := 0;
           if chkover then beroe4 := 1 else beroe4 := 0;
           if chkunder then beroe5 := 1 else beroe5 := 0;
           if chkerror then beroe6 := 1 else beroe6 := 0;
           if chkbyte then beroe7 := 1 else beroe7 := 0;
           if chkdrop then beroe8 := 1 else beroe8 := 0;

           totaloe := beroe1+beroe2+beroe3+beroe4+beroe5+beroe6+beroe7+beroe8;
         if (totaloe <> 1) then
         begin
           w.dispmsg('Error','Please Choose only one to sampling');
           goto sample1;
		 end;

		   val(thour_start,hour_start,code);
         if ((code <> 0) or (hour_start < 0) or (hour_start > 23)) then
         begin
           w.dispmsg('Error','Hour Start must be integer `and more than 0 but less than 24');
           goto sample1;
         end;

		   val(tmin_start,min_start,code);
         if ((code <> 0) or (min_start < 0) or (min_start > 60)) then
         begin
           w.dispmsg('Error','Minute Start must be integer `and more than 0 but less than 60');
           goto sample1;
         end;

		   val(tsec_start,sec_start,code);
         if ((code <> 0) or (sec_start < 0) or (sec_start > 60)) then
         begin
           w.dispmsg('Error','Second Start must be integer `and more than 0 but less than 60');
           goto sample1;
         end;
		   val(thour_stop,hour_stop,code);
         if ((code <> 0) or (hour_stop < 0) or (hour_stop > 23)) then
         begin
           w.dispmsg('Error','Hour Stop must be integer `and more than 0 but less than 24');
           goto sample1;
         end;

		   val(tmin_stop,min_stop,code);
         if ((code <> 0) or (min_stop < 0) or (min_stop > 60)) then
         begin
           w.dispmsg('Error','Minute Stop must be integer `and more than 0 but less than 60');
           goto sample1;
         end;

		   val(tsec_stop,sec_stop,code);
         if ((code <> 0) or (sec_stop < 0) or (sec_stop > 60)) then
         begin
           w.dispmsg('Error','Second Stop must be integer `and more than 0 but less than 60');
           goto sample1;
         end;
           val(tsec_samp,sec_samp,code);

        if chkpacket then totaloe := 1;
        if chkutilize then totaloe := 2;
        if chkbroad then totaloe := 3;
        if chkover then totaloe := 4;
        if chkunder then totaloe := 5;
        if chkerror then totaloe := 6;
        if chkbyte then totaloe := 7;
        if chkdrop then totaloe := 8;
        if checkoe then checkoe1 := 1 else checkoe1:=2;
        samstart.hour := hour_start;
        samstart.minute := min_start;
        samstart.second := sec_start;
        samend.hour := hour_stop;
        samend.minute := min_stop;
        samend.second := sec_stop;
        stat(3,2,sec_samp,samstart,samend,checkoe1,totaloe);
       end;{handle event repeat}
	 UNTIL (event_ch=#27) or (Key=#27) or (cm=1);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;
end;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE InitialEnvironment;                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Intialize Start Environment for program            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE InitialEnvironment;
var entryvalue:string;
BEGIN

     GetMyEthernetAddr;
     {Station Initial}
     AllStation      := TRUE;
     AllSource       := TRUE;
     AllDestination  := TRUE;
     AllPacket       := TRUE;
     IsEtherII       := TRUE;
     IsIEEE802       := TRUE;
     Mode            := 1;
     BufferFill      := FALSE;

     {Timer Initial}
     Interval        := 1;

     {Reciever Initial}
     Lost            := 0;

     {Buffer Initial}
     IF (not PacketBuffer.Ems_Installed) Then
     BEGIN
            Write('Please Load Ems386 befor use this program!!');
            ExitProgram;
     END;

     {setting mode}
     GetProfileString(ProfileName,'setting', 'alias', EntryValue, 'true');
     if EntryValue = 'true' then alias_mode := true else alias_mode := false;

END;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ          MAIN PROGRAM FOR Ethernet Monitor VERSION 1.00              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
BEGIN

     ClrScr;

     pktDriver.ScanForPktDriver;
     InitPktDriver;
     Delay(1500);
     ClrScr;

     InitialEnvironment;

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
  w.newbut(2,2,52,18,'S~t~at',4,os2,'');
  w.newbut(52,2,122,18,'S~a~mpling',4,os2,'');
  w.newbut(122,2,182,18,'H~i~story',4,os2,'');
  w.newbut(182,2,232,18,'~H~elp',4,os2,'');
  w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

  repeat
    w.handleevent;
    case cm of
      1 : begin
          gettime2(sttt);
	      stat(1,1,1,sttt,bttt,0,0);
          end;
      2 : Samoe;
      3 : History;
      4 : Helpoe;
    end;
  until cm=5;
  w.clrwin(1); w.done;
  ExitProgram;
END.

