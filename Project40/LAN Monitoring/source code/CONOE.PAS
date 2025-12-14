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
    w               : adapplic      ;

    { information display module }
    INFORMATION     : Statistic;       { ONE 17/1/40 for check error }
    Threshold       : Statistic;       { ONE 17/1/40 for check error }
    LastLOST   : Longint;
    Count,LastCount : LongInt;
    ByteCount,LastByteCount : LongInt;

    { setting }
    alias_mode      : boolean;

    { conversation module }
    BuffConver      : Array[00..MaxConverBuffer] of Conversation;

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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE BackGround                                                 บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Make Background                                    บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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


     IF alias_mode then BEGIN

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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION CompareIPAddr(Addr1,Addr2 : Data32) : Boolean;              บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Compare two IP address return true if match        บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Hex2Byte (S : string) : Byte;								บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ returns hexadecimal string as decimal value		บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Hex2Dec (S : string) : longint;								บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ returns hexadecimal string as decimal value		บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Assign32(Var DataType : Data32; LongIntType : LongInt);		บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign valuet to mismatch datatype					บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure Assign32(Var DataType : Data32; LongIntType : LongInt);
BEGIN
     DataType[0] := LongIntType MOD $100;
     DataType[1] := LongIntType DIV $100;
     DataType[2] := LongIntType DIV $10000;
     DataType[3] := LongIntType DIV $1000000;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Assign16(Var DataType : Data16; WordType : Word);			บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign valuet to mismatch datatype					บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure Assign16(Var DataType : Data16; WordType : Word);
BEGIN
     DataType[1] := WordType MOD $100;
     DataType[0] := WordType DIV $100;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Assign8(Var DataType : Data8; ByteType : Byte);				บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign valuet to mismatch datatype					บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure Assign8(Var DataType : Data8; ByteType : Byte);
BEGIN
     Move(ByteType,DataType,1);
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Compare16(DataType : Data16; WordType : Word): Boolean;		บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ return true if match datatype with assign value	บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Function Compare16(DataType : Data16; WordType : Word): Boolean;
Var      tWord : Word;
BEGIN
     Compare16 := False;
     Move(DataType,tWord,2);
     IF SwapWord(tWord) = WordType then Compare16 := True;
END;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION Compare8(DataType : Data8; ByteType : Byte): Boolean;		บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ return true if match datatype with assign value	บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Function Compare8(DataType : Data8; ByteType : Byte): Boolean;
Var      tByte : Byte;
BEGIN
     Compare8 := False;
     Move(DataType,tByte,1);
     IF tByte = ByteType then Compare8 := True;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION AssignIP(Var DataType:Data32;Byte1,Byte2,Byte3,Byte4:Byte); บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign IP address from value in Byte1 to Byte4		บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Procedure AssignIP(Var DataType : Data32; Byte1,Byte2,Byte3,Byte4 : Byte);
BEGIN
     DataType[0] := Byte1;
     DataType[1] := Byte2;
     DataType[2] := Byte3;
     DataType[3] := Byte4;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ConvertIP(EntryName : String; Var IP : data32);				บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign IP address from string						บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ConvertEthernetAddr(EntryName:String;VarEthernet:EthernetAddบ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ assign Ethernet address from string				บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
 บ PROCEDURE ProtocolInUse;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Save Protocol Used In BuffConver     (ONE 8/1/40)  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ProtocolInUse(Point:integer; Layer2:integer; Layer3:Integer; Layer4:integer; UpLayer:integer);
Var I :integer;
    Found : Boolean;
BEGIN
     Found := False;
     I := 0;
     While (BuffConver[Point].Protocol[I] <>0) and (I <= 3)
     DO BEGIN
          IF (BuffConver[Point].Protocol[I] = Uplayer*1000 + Layer4*100 + Layer3*10 + Layer2) THEN Found:=True;
          I:=I+1;
     END;
     IF (not Found) and (I <= 4)
     THEN BEGIN
               BuffConver[Point].Protocol[I] := (Uplayer*1000 + Layer4*100 + Layer3*10 + Layer2);
          End;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE WriteProtocol;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Return Protocol InUse In format String(ONE 8/1/40) บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION WriteProtocol(Point:Integer):String;
Var I : Integer;
    tStr : String;
BEGIN
     I := 0;
     tStr := '';
     WHILE (BuffConver[Point].Protocol[I]<>0) and (I <= 3)
     DO BEGIN
               Case BuffConver[Point].Protocol[I] DIV 1000 of
               Telnet   : tStr := tStr + 'Telnet';
               FTP      : tStr := tStr + 'FTP';
               FTP_Data : tStr := tStr + 'FTP-DATA';
               Finger   : tStr := tStr + 'Finger';
               Rlogin   : tStr := tStr + 'Rlogin';
               RPC      : tStr := tStr + 'RPC';
               SMTP     : tStr := tStr + 'SMTP';
               ELSE     Case ((BuffConver[Point].Protocol[I] DIV 100) MOD 10) of
                          SPX     : tStr := tStr + 'SPX';
                          NCP     : tStr := tStr + 'NCP';
                          NetBios : tStr := tStr + 'NetBios';
                          ICMP    : tStr := tStr + 'ICMP';
                          TCP     : tStr := tStr + 'TCP';
                          UDP     : tStr := tStr + 'UDP';
                          ELSE    Case ((BuffConver[Point].Protocol[I] DIV 10) MOD 10) of
                                    IPX     : tStr := tStr + 'IPX';
                                    NetBeui : tStr := tStr + 'NetBeui';
                                    IP      : tStr := tStr + 'IP';
                                    ARP     : tStr := tStr + 'ARP';
                                    RARP    : tStr := tStr + 'RARP';
                                    SNMP    : tStr := tStr + 'SNMP';
                                    ELSE    Case BuffConver[Point].Protocol[I] of
                                              EthernetII    : tStr := tStr + 'EthernetII';
                                              Ethernet802_3 : tStr := tStr + 'Ethernet802_3';
                                              EthernetSNAP  : tStr := tStr + 'EThernetSNAP';
                                              Ethernet802_2 : tStr := tStr + 'Ethernet802_2';
                                              Else tStr := tStr + 'Unknown';
                                              END;
                                    END;
                          END;
               END;
               I := I+1;
               IF (BuffConver[Point].Protocol[I] <> 0) and (I <= 3)THEN tStr := tStr + ',';
     END;
     WriteProtocol := tStr;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayInfo;   # call by Displayconversation               บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Display Conversation Station                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DisplayInfo(TypeMessage:Integer);
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


     GetTime2(CurTime);
     StrTime := 'Time ' + WriteTime(CurTime);
     w.fill(531,458,636,475,10,1);
     w.tex(540,467,StrTime,true);

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
 บ PROCEDURE SortConverBuffer;  # call by Displayconversation           บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Sort ConverBuffer for display                      บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE SortConverBuffer(SORT:integer;CurConverBuffer:integer);
VAR
      Found      : Boolean;
      Pass,J,K   : aptr;
      Intchnge   : Boolean;
      Change     : Boolean;
      Hold       : Conversation;
BEGIN
      Pass     := 0;
      Intchnge := True;
      WHILE (Pass <= CurConverBuffer) and (Intchnge) DO
      BEGIN
           Intchnge := False;
           For J:= 0 to (CurConverBuffer-2-Pass) DO
           BEGIN
              CASE SORT of
              1 : IF (BuffConver[J].ByteCount+BuffConver[J].ByteCount2) <
                 (BuffConver[J+1].ByteCount+BuffConver[J+1].ByteCount2)
                    THEN Change := True;

              2 : IF (BuffConver[J].ByteCountS+BuffConver[J].ByteCountS2) <
                 (BuffConver[J+1].ByteCountS+BuffConver[J+1].ByteCountS2)
                    THEN Change := True;

              ELSE IF (BuffConver[J].ByteCount+BuffConver[J].ByteCount2) <
                 (BuffConver[J+1].ByteCount+BuffConver[J+1].ByteCount2)
                    THEN Change := True;

              END;
              IF Change Then
              BEGIN
                   Intchnge        := True;
                   Hold            := BuffConver[J];
                   BuffConver[J]   := BuffConver[J+1];
                   BuffConver[J+1] := Hold;
                   Change          := False;
              END;
           END;
           Pass := Pass + 1
      END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION ChkLayer2Protocol;  # Call by DisplayProtocol #             บ
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
 บ FUNCTION ChkLayer3Protocol;  # Call by DisplayProtocol #             บ
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
 บ FUNCTION ChkLayer4Protocol;  # Call by DisplayProtoco #             บ
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
 บ FUNCTION ChkUpLayerProtocol;  # Call by DisplayProtocol #            บ
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
 บ FUNCTION CntExtProtocol;      # Call by DisplayProtocol #            บ
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
     GetProfileString(ProfileName, Section, Chr(Cnt DIV 10+48)+ Chr(Cnt MOD 10+48), S, DefaultString);
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
          GetProfileString(ProfileName, Section, Chr(Cnt DIV 10+48)+ Chr(Cnt MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtName;          # Call by DisplayProtocol #          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read Name of Extend protocol from .INI file        บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtName(Section : string; Number : shortint; VAR Name : string);
VAR       S : string;
          I : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtL2;          # Call by DisplayProtocol #            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 2 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL2(Section : string; Number : shortint; VAR L2 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtL3;          # Call by DisplayProtocol #            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 3 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL3(Section : string; Number : shortint; VAR L3 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtL4;          # Call by DisplayProtocol #            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read layer 4 protocol of Extend protocol           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtL4(Section : string; Number : shortint; VAR L4 : string);
VAR       S : string;
          I,J : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtOffset;      # Call by DisplayProtocol #            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read offset of Extend protocol from .INI file      บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtOffset(Section : string; Number : shortint; VAR Offset : string);
VAR       S : string;
          I,J,K : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ PROCEDURE ReadExtCondition;   # Call by DisplayProtocol #            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Read condition of Extend protocol from .INI file   บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ReadExtCondition(Section : string; Number : shortint; VAR Condition : string);
VAR       S : string;
          I,J,K : integer;
BEGIN
     GetProfileString(ProfileName, Section, Chr(Number DIV 10+48)+ Chr(Number MOD 10+48), S, DefaultString);
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
 บ FUNCTION ReadExt2Table;       # Call by DisplayProtocol #            บ
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

     { use for Extend protocol in .INI file }
     Str : string;
     TempIndex,Code,Condition,Offset    : integer;
     ExtNo,ExtCnt    : shortint;
     ExtIndexL3,ExtIndexL4,ExtIndexUL : shortint;
BEGIN
     { Initial index }
     IndexL2 := 0;
     IndexL3 := 0;
     IndexL4 := 0;
     IndexUL := 0;
     { Check what layer 2 protocol is? }
     tWord := SwapWord(VerHeader.TypeLen);
     ttWord := (Verpacket[14] SHL 8) + Verpacket[15];
     IndexL2 := ChkLayer2Protocol(tWord,ttWord);
     { Check what layer 3 protocol is? }
     CASE IndexL2 OF
          EthernetII    :   BEGIN
                            tWord := SwapWord(VerHeader.TypeLen);
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_3 :   IndexL3 := IPX;
          EthernetSNAP  :   BEGIN
                            tWord := (Verpacket[20] SHL 8) + Verpacket[21];
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_2 :   BEGIN
                            tWord := (Verpacket[14] SHL 8) + Verpacket[15];
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
                    IF Condition = ((Verpacket[Offset] SHL 8) + Verpacket[Offset+1]) THEN
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

     { Refference :
     |    ProtocolStat.IPX_EtherIIStat[4] keep OtherL4 protocol counter value |
     |                  |       ||                                            |
     |                 (IP)   (802.3, 802.2, SNAP)                            }

     CASE IndexL3 OF
          IPX     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tByte := Verpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_3   :  BEGIN
                                            tByte := Verpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := Verpacket[27];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_2   :  BEGIN
                                            tByte := Verpacket[22];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                    END;
          IP      : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tByte := Verpacket[23];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := Verpacket[31];
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
                         IF Condition = Verpacket[Offset] THEN
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

     { Refference :
     |    ProtocolStat.TCP_EtherIIStat[8] keep OtherUL protocol counter |
     |                  |       ||                                      |
     |                (UDP)   (SNAP)                                    }

     IF IndexL3 = IP THEN
     CASE IndexL4 OF
          TCP     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tWord := (Verpacket[34] SHL 8) + Verpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (Verpacket[42] SHL 8) + Verpacket[43];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                    END;
          UDP     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tWord := (Verpacket[34] SHL 8) + Verpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (Verpacket[42] SHL 8) + Verpacket[43];
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
                              IF Condition = ((Verpacket[Offset] SHL 8) + Verpacket[Offset+1]) THEN
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
 บ PROCEDURE VerifyIP;		                                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Find what IP in this packet			            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Function VerifyIP(TPacket:TPacketInfo) : String;
Var      Layer2,Layer3,Layer4,UpLayer : Integer;
         tARP : ARPFRAME;
         tIP  : EtherIIFRAME;
BEGIN
     Move(tPacket,VerPacket,tPacket.Length);
     Move(tPacket,VerHeader,Sizeof(VerHeader));
     VerifyPacket(Layer2,Layer3,Layer4,UpLayer);
     Case Layer3 of
       IP    : BEGIN
                    Move(tPacket,tIP,Sizeof(tIP));
                    VerifyIP := PrintIP2(tIP.SourceAdd)
               END;
       ARP   : BEGIN
                    Move(tPacket,tARP,Sizeof(tIP));
                    VerifyIP := PrintIP2(tARP.IPSourceAddr)
               END;
     Else
       VerifyIP := '';
     End;
END;



{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayConversation;                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Capture Packet to Check Conversation (ONE 8/1/40)  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DisplayConversation;
var
{module display conversation}
    Display    : Boolean;
    tPacket    : TPacketInfo;
    tInfo      : TPacketInfo;
    Sort       : Integer;

    Layer2,Layer3,Layer4,Uplayer : Integer;

    CurConverBuffer : Integer;

    { use for display }
    FLine,Line   : String;
    tLine,ttLine : String;
    page       : Integer;
    StartLine,EndLine : Integer;
    DisplayCount : Integer;
    MaxLines:longint;
    i,j,k:integer;
    DISPLAYCOLL  : PStringCollection;
    {** used for pre filter }
    min_size,max_size:integer;
    all_size:string;
    address_1,address_2:string;
    tieee,tethernet:string;
    fieee,fethernet:boolean;
    toffset,tlength,tvalue:string;
    offset,lengthf:integer;
    copy_length:integer;
    pass_filter:boolean;
    {** used for setting }
    num_packet :integer;
    tcap_file : string;
    cap_file : boolean;
    update : integer;

procedure modea(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+13,b+11,'M',e,4);
     w.writetext(a+29,b+11,'ode',e,0);
end;

procedure sorta(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+13,b+11,'S',e,4);
     w.writetext(a+29,b+11,'ort',e,0);
end;

procedure upa(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+25,b+11,'Page',e,0);
     w.writetext(a+49,b+11,'u',e,4);
     w.writetext(a+57,b+11,'p',e,0);
end;

procedure downa(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+22,b+11,'Page',e,0);
     w.writetext(a+44,b+11,'d',e,4);
     w.writetext(a+60,b+11,'own',e,0);
end;

procedure tota(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+9,b+11,'T',e,4);
     w.writetext(a+39,b+11,'ot/Byte',e,0);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisposeDisplayCollection;   # call by Displayconversation  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Dispose Display Conversation                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure DisposeDisplayCollection;
begin
  if DisplayColl <> nil then Dispose(DisplayColl, Done);
  DisplayColl := nil;
end;

BEGIN   { BEGIN of Display Converbuffer }

     Found := False;
     Display := False;
     Count := 0;    { Save Num Packet }
     LastCount := 0;
     ByteCount := 0;
     LastByteCount := 0;
     LastLost := 0;
     Mode := 1;
     CurConverBuffer := 0;
     Page := 0;
     DisplayCount := 0;
     DisPlayColl := Nil;

     { ** INITIAL INFORMATION & THRESHOLD ONE 19/1/40}
     INFORMATION.Packet_S   := 0;
     INFORMATION.Utilize    := 0;
     INFORMATION.Error_S    := 0;
     INFORMATION.Drop_S     := 0;
     INFORMATION.Byte_S     := 0;
     INFORMATION.BroadCast_S:= 0;
     INFORMATION.Undersize_S:= 0;
     INFORMATION.Oversize_S := 0;

     {** for read pre filter }
{     DisposeINICollection;}
     GetProfileInt(ProFileName,'pre_filter','min_size',min_size,0);
     GetProfileInt(ProFileName,'pre_filter','max_size',max_size,1500);
     GetProfileInt(ProFileName,'pre_filter','copy_length',copy_length,1500);
     GetProfileString(ProFileName,'pre_filter','all_size',all_size,'true');
     GetProfileString(ProFileName,'pre_filter','address_1',address_1,'any');
     GetProfileString(ProFileName,'pre_filter','address_2',address_2,'any');
     GetProfileString(ProFileName,'pre_filter','ieee_802',tieee,'true');
     GetProfileString(ProFileName,'pre_filter','value',tvalue,'');
     if hex2dec(tvalue)=-1 then tvalue := '';
     GetProfileInt(ProFileName,'pre_filter','length',lengthf,0);
     GetProfileInt(ProFileName,'pre_filter','offset',offset,0);
     if tieee = 'true' then fieee := true else fieee := false;
     GetProfileString(ProFileName,'pre_filter','ethernet_ii',tethernet,'true');
     if tethernet = 'true' then fethernet := true else fethernet := false;
     {** end of read pre filter}
     {** read form setting}
     GetProfileInt(ProFileName,'setting','num_packet',num_packet,1000);
     GetProfileInt(ProFileName,'setting','update',update,1);
     GetProfileString(ProFileName,'setting','cap_file',tcap_file,'true');
     if tcap_file = 'true' then cap_file:= true else cap_file := false;
     {** end form setting}

     if not (EMS_INSTALL) then begin
      cm := 0;
      exit;  { INITIAL EMS }
     end;

     w.window(40,40,getmaxx-40,getmaxy-40,'Display Conversation');
     w.chenar(42,80,getmaxx-42,getmaxy-80);
     w.fill(44,80,getmaxx-44,getmaxy-80,12,1);
     modea(42,400,92,420,False);
     sorta(102,400,152,420,False);
     upa(162,400,232,420,False);
     downa(242,400,322,420,False);
     tota(332,400,402,420,False);
     FOR J := 0 TO MaxConverBuffer DO
     BEGIN
          BuffConver[J].Used   := False; { Clear Flag Buffer }
          BuffConver[J].Protocol[0] := 0;   { Clear protocol in use }
          BuffConver[J].Protocol[1] := 0;   { Clear protocol in use }
          BuffConver[J].Protocol[2] := 0;   { Clear protocol in use }
          BuffConver[J].Protocol[3] := 0;   { Clear protocol in use }
     END;

     {Init Timer}
     Timer1.Init(1);
     Timer1.Start;
     Timer2.Init(update);
     Timer2.Start;


     REPEAT
           IF ( PacketCount = 1 ) THEN       { Receive Packet }
           BEGIN
              {** for global statistic }
              IF RcvLength < 60 THEN Inc(INFORMATION.Undersize_S);
              IF RcvLength > 1514 THEN Inc(INFORMATION.Oversize_S);

              IF ((all_size='true') or ((RcvLength > min_size) and (RcvLength < max_size)))
              then begin

                {** read input }
                Move(Rcvpacket,tInfo,Copy_Length); { copy_length }

                pass_filter:=true;

                {** for global statistic }
                IF RcvLength < 60
                THEN Begin
                   Inc(INFORMATION.Undersize_S);
                   pass_filter := false;
                End;

                IF RcvLength > 1514
                THEN Begin
                   Inc(INFORMATION.Oversize_S);
                   pass_filter := false;
                End;

                IF (Lengthf > 0) and (Lengthf<=4) and (Lengthf <> sizeof(tvalue)) and (tvalue <> '') then
                begin
                    for i := 0 to lengthf-1 do
                    begin
                      If Rcvpacket[offset+i] <> hex2byte(tvalue[(i*2)+1]) then pass_filter := false;
                    end;
                end;
                   {** check for type of frame }
                IF {** check for pass offset value filter }
                   pass_filter and
                   {** check for address}
                   (((address_1 = 'any') or (getethernetaddress(tInfo.header.sourceaddr)=address_1)) and
                   ((address_2 = 'any') or (getethernetaddress(tInfo.header.destaddr)=address_2))) then
                   begin
                      { ** begin of conversation module }
                      Inc(count);
                      Inc(ByteCount,RcvLength);
                      GetTime2(tInfo.PktTime);
                      tInfo.Length := RcvLength;
                      WritePacketArray(Count,tInfo);
                      { ** end of conversation module }
                   end;
              end;

                RcvLength   := 0;
                PacketCount := 0;            { Reset flag for new frames }
           END;

           if keypressed then key := readkey;

           if upcase(key) = 'M' then begin
				modea(42,400,92,420,True);
                key := #0;
                Mode := Mode + 1;
                Display := true;
                w.fill(60,80,getmaxx-60,100,12,1);
                IF Mode > MaxMode THEN Mode := 1;
           END;
           if upcase(key) = 'S' then begin
				sorta(102,400,152,420,True);
                key := #0;
                Sort := Sort + 1;
                Display := true;
                IF Sort > MaxSort THEN Sort := 1;
           END;
           if upcase(key) = 'D' then begin
				downa(242,400,322,420,True);
                key := #0;
                { ** check for more than size }
                w.fill(60,80,getmaxx-60,getmaxy-100,12,1);
                IF ((Page*Pagesize) <= DisplayColl^.Count-1) THEN Page := Page + 1;
                Display := True;
           END;
           if upcase(key) = 'U' then begin
				upa(162,400,232,420,True);
                key := #0;
                w.fill(60,80,getmaxx-60,getmaxy-100,12,1);
                Page := Page - 1;
                IF Page < 0 THEN Page := 0;
                Display := True;
           END;
           if upcase(key) = 'T' then begin
				tota(332,400,402,420,True);
                key := #0;
                case mode of
                  1: mode := 3;
                  2: mode := 4;
                  3: mode := 1;
                  4: mode := 2;
                end;
                Display := True;
           END;

           IF Timer1.Timeout THEN
           BEGIN
                {** Check INFORMATION }
				modea(42,400,92,420,False);
     			sorta(102,400,152,420,False);
     			upa(162,400,232,420,False);
     			downa(242,400,322,420,False);
     			tota(332,400,402,420,False);
                INFORMATION.Packet_S := Count-LastCount;
                INFORMATION.Drop_S   := LOST-LastLost;
                INFORMATION.Byte_S   := ByteCount-LastByteCount;
                INFORMATION.Utilize  := ((INFORMATION.Byte_S*100 DIV 1240256) + ((INFORMATION.Packet_S*300) DIV 310064));
                LastLOST             := LOST;
                LastByteCount        := ByteCount;
                LastCount            := Count;
                FOR K := 0 to INFORMATION.Packet_S-1 DO
                BEGIN
                     { Read from EMS }
                     ReadPacketArray(K,tPacket);

                     { Check Protocol }
                     Move(tPacket,VerPacket,tPacket.Length);
                     Move(tPacket,VerHeader,Sizeof(VerHeader));
                     VerifyPacket(Layer2,Layer3,Layer4,UpLayer);

                     { Check INFORMATION }
                     IF CompareEthernetAddr(tPacket.Header.SourceAddr,BROADCAST)
                        or CompareEthernetAddr(tPacket.Header.DestAddr,BROADCAST)
                     THEN Inc(INFORMATION.Broadcast_S);

                     J := 0;  Found := False;
                     { Check Packet }
                     WHILE (BuffConver[J].Used=True) and (J<MaxConverBuffer)
                     DO BEGIN
                             { Check for case 1 }
                             IF ( CompareEthernetAddr(tPacket.Header.SourceAddr,BuffConver[J].SourceAddr)
                                and (CompareEthernetAddr(tPacket.Header.DestAddr,BuffConver[J].DestAddr)) )
                             THEN BEGIN
                                       INC(BuffConver[J].PacketCount);
                                       INC(BuffConver[J].PacketCountS);
                                       INC(BuffConver[J].ByteCount,tPacket.Length);
                                       INC(BuffConver[J].ByteCountS,tPacket.Length);
                                       GetTime2(BuffConver[J].LastTime);
                                       ProtocolInuse(J,Layer2,Layer3,Layer4,UpLayer);
                                       Found := True;
                             END
                             { Check for case 2 }
                             ELSE IF ( CompareEthernetAddr(tPacket.Header.SourceAddr,BuffConver[J].DestAddr)
                                and (CompareEthernetAddr(tPacket.Header.DestAddr,BuffConver[J].SourceAddr)) )
                             THEN BEGIN
                                       INC(BuffConver[J].PacketCount2);
                                       INC(BuffConver[J].PacketCountS2);
                                       INC(BuffConver[J].ByteCount2,tPacket.Length);
                                       INC(BuffConver[J].ByteCountS2,tPacket.Length);
                                       GetTime2(BuffConver[J].LastTime);
                                       ProtocolInuse(J,Layer2,Layer3,Layer4,UpLayer);
                                       Found := True;
                             END;
                             J := J+1;
                     END;

                     IF not Found and (CurConverBuffer<MaxConverBuffer) THEN
                     BEGIN
                          J := 0;
                          WHILE (BuffConver[J].Used<>False) DO J := J+1;
                          Inc(CurConverBuffer);
                          GetTime2(BuffConver[J].StartTime);
                          BuffConver[J].LastTime := BuffConver[J].StartTime;
                          BuffConver[J].Used         := True;
                          BuffConver[J].SourceAddr   := tPacket.Header.SourceAddr;
                          BuffConver[J].DestAddr     := tPacket.Header.DestAddr;
                          BuffConver[J].PacketCount  := 1;
                          BuffConver[J].ByteCount    := tPacket.Length;
                          BuffConver[J].PacketCountS := 1;
                          BuffConver[J].ByteCountS   := tPacket.Length;
                          BuffConver[J].PacketCount2 := 0;
                          BuffConver[J].ByteCount2   := 0;
                          BuffConver[J].PacketCountS2:= 0;
                          BuffConver[J].ByteCountS2  := 0;
                          ProtocolInuse(J,Layer2,Layer3,Layer4,UpLayer);
                     END;
                END;

                SortConverBuffer(Sort,CurConverBuffer);
                IF Mode > MaxMode THEN Mode := 1;
                CASE MODE of
                 1 : BEGIN
                          DisposeDisplayCollection;
                          DisplayColl := New(PStringCollection,Init(1,1));
                          DisplayColl^.Duplicates := true;
                          FLine := 'Num   SourceAddr     DestAddr       StartTime   LastTime   Packets     Bytes';
                          FOR J := 0 to CurConverBuffer-1 Do
                          BEGIN
                               Str((BuffConver[J].PacketCount+BuffConver[J].PacketCount2):7,tLine);
                               Str((BuffConver[J].ByteCount+BuffConver[J].ByteCount2):7,ttLine);
                               Line := GetEthernetAddress(BuffConver[J].SourceAddr) + '  '
                                        + GetEthernetAddress(BuffConver[J].DestAddr) + '  '
                                        + WriteTime(BuffConver[J].StartTime) + '    '
                                        + WriteTime(BuffConver[J].LastTime) + '   '
                                        + tLine + '    '
                                        + ttLine;
                               DisplayColl^.AtInsert(DisplayColl^.Count,NewStr(Line));
                          END;
                          MaxLines := CurConverBuffer;

                     END;
                 2 : BEGIN
                          DisposeDisplayCollection;
                          DisplayColl := New(PStringCollection,Init(1,1));
                          DisplayColl^.Duplicates := true;
                          FLine := 'Num   SourceAddr     DestAddr       Pkt(S->D) Pkt(D->S) Byte(S->D) Byte(D->S)';
                          FOR J := 0 to CurConverBuffer-1 Do
                          BEGIN
                               Str(BuffConver[J].PacketCount:7,tLine);
                               Line := GetEthernetAddress(BuffConver[J].SourceAddr) + '  '
                                        + GetEthernetAddress(BuffConver[J].DestAddr) + '  '
                                        + tLine + '   ';
                               Str(BuffConver[J].PacketCount2:7,tLine);
                               Line := Line + tLine + '   ';
                               Str(BuffConver[J].ByteCount:8,tLine);
                               Line := Line + tLine + '   ';
                               Str(BuffConver[J].ByteCount2:8,tLine);
                               Line := Line + tLine;
                               DisplayColl^.AtInsert(DisplayColl^.Count,NewStr(Line));
                          END;
                     END;
                 3 : BEGIN
                          DisposeDisplayCollection;
                          DisplayColl := New(PStringCollection,Init(1,1));
                          DisplayColl^.Duplicates := true;
                          FLine := 'Num   SourceAddr     DestAddr       StartTime   LastTime   Packets     Bytes';
                          FOR J := 0 to CurConverBuffer-1 Do
                          BEGIN
                               Str((BuffConver[J].PacketCountS+BuffConver[J].PacketCountS2):7,tLine);
                               Str((BuffConver[J].ByteCountS+BuffConver[J].ByteCountS2):7,ttLine);
                               Line := GetEthernetAddress(BuffConver[J].SourceAddr) + '  '
                                        + GetEthernetAddress(BuffConver[J].DestAddr) + '  '
                                        + WriteTime(BuffConver[J].StartTime) + '    '
                                        + WriteTime(BuffConver[J].LastTime) + '   '
                                        + tLine + '    '
                                        + ttLine;
                               DisplayColl^.AtInsert(DisplayColl^.Count,NewStr(Line));
                          END;
                     END;
                 4 : BEGIN
                          DisposeDisplayCollection;
                          DisplayColl := New(PStringCollection,Init(1,1));
                          DisplayColl^.Duplicates := true;
                          FLine := 'Num   SourceAddr     DestAddr       Pkt(S->D) Pkt(D->S) Byte(S->D) Byte(D->S)';
                          FOR J := 0 to CurConverBuffer-1 Do
                          BEGIN
                               Str(BuffConver[J].PacketCountS:7,tLine);
                               Line := GetEthernetAddress(BuffConver[J].SourceAddr) + '  '
                                        + GetEthernetAddress(BuffConver[J].DestAddr) + '  '
                                        + tLine + '   ';
                               Str(BuffConver[J].PacketCountS2:7,tLine);
                               Line := Line + tLine + '   ';
                               Str(BuffConver[J].ByteCountS:8,tLine);
                               Line := Line + tLine + '   ';
                               Str(BuffConver[J].ByteCountS2:8,tLine);
                               Line := Line + tLine;
                               DisplayColl^.AtInsert(DisplayColl^.Count,NewStr(Line));
                          END;
                     END;
                 5 : BEGIN
                          DisposeDisplayCollection;
                          DisplayColl := New(PStringCollection,Init(1,1));
                          DisplayColl^.Duplicates := true;
                          FLine := 'Num   SourceAddr     DestAddr       Protocol In Use';
                          FOR J := 0 to CurConverBuffer-1 Do
                          BEGIN
                               Line := GetEthernetAddress(BuffConver[J].SourceAddr) + '  '
                                        + GetEthernetAddress(BuffConver[J].DestAddr) + '  '
                                        + WriteProtocol(J);
                               DisplayColl^.AtInsert(DisplayColl^.Count,NewStr(Line));
                          END;
                     END;
                Else
                   MODE := 1
                End;

                J := 0;
                WHILE (BuffConver[J].Used<>False)
                DO BEGIN
                        BuffConver[J].PacketCountS  := 0;
                        BuffConver[J].PacketCountS2 := 0;
                        BuffConver[J].ByteCountS    := 0;
                        BuffConver[J].ByteCountS2   := 0;
                        J                           := J+1;
                END;

           IF Timer2.Timeout or Display THEN
           BEGIN
                DisplayInfo(Mode);

                StartLine := Pagesize*Page;
                EndLine   := Pagesize*Page + PageSize-1;

                IF (EndLine >= DisplayColl^.Count)
                then EndLine := DisplayColl^.Count-1;

                IF EndLine = -1 then EndLine := 0;

                w.fill(60,83,getmaxx-60,97,12,1);
                w.texl(60,90,FLine);
                IF StartLine < EndLine THEN
                 Begin
                   FOR I:= StartLine to EndLine-1 do
                   Begin
                     str((i+1):2,tline);
                     Line := tline+'  '+Pstring(DisplayColl^.At(I))^;
                     w.fill(60,103+(I-StartLine)*20,getmaxx-60,117+(I-StartLine)*20,12,1);
                     w.texl(60,110+(I-StartLine)*20,Line);
                   End;
                 End;

               INFORMATION.Broadcast_S := 0;
               INFORMATION.Undersize_S := 0;
               INFORMATION.Oversize_S := 0;
               INFORMATION.Packet_S   := 0;
               INFORMATION.Byte_S     := 0;
               INFORMATION.Drop_S     := 0;
               INFORMATION.ERROR_S    := 0;
               Display := false;
               Timer2.Start
           END;
               Timer1.Start;
           END;



     UNTIL (event_ch = #27) or (key=#27); { (cm = 1); { Stop when ESC or exit window }

     w.refwin(stay,stay);
     cm := 0;

     EMS_RELEASE; { TERMINATE EMS }

     Key := #0;
     BufferCount := I;
     BufferFill  := TRUE;
     DisposeDisplayCollection;
END;


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

procedure helpoe;
const
     StrFileName = 'conhlp.hlp';
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
  w.newbut(2,2,102,18,'~C~onversation',4,os2,'');
  w.newbut(102,2,152,18,'~H~elp',4,os2,'');
  w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

  repeat
    w.handleevent;
    case cm of
      1 : DisplayConversation;
	  2 : helpoe;
    end;
  until cm=3;
  w.clrwin(1); w.done;
  ExitProgram;
END.

