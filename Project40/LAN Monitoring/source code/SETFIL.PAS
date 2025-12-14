{    Last change:  O    12 Feb 97    6:03 am    }
PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G+,I-,L+,N-,O-,R-,S-,V+,X+}
{$M  30720 0 655360}
USES   OBJECTS,PKTDRVR,ETHER,TIMER,STRINGS,CRT,DOS,INIF,EMS,stringop,grafica,g_applic,util256,graph,mouse;
       { ONE 10/1/40 Add INIF,EMS }
CONST  MaxEthernetCapacity = 1250000; { Max. theroetical ethernet capacity }
       DefaultFileName     = 'DATA.DAT';
       ProfileName         = 'Ether.Ini';
       AddrFile 		   = 'Addr.ini';
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
 บ PROCEDURE Setting;   												บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Setup system value									บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure setting;
var code:integer; { use for check type right integer}
    num_packet,update:integer;
    fcap_file,trueexit:boolean;
    lastflag:integer; { 0 = capture to file, 1 = capture to EMS }
    tnum_transmit,ttime_transmit,ttime_cap,tnum_packet,talias,tupdate,cap_file:string;
    num_transmit,time_transmit,time_cap:integer;
    falias:boolean;
    tdata_packet:string;

label setting1,setting2;

begin
    trueexit := false;
    DisposeINICollection;
    GetProfileInt(ProFileName,'setting','update',update,1);

    GetProfileInt(ProFileName,'setting','time_transmit',time_transmit,30);
    GetProfileInt(ProFileName,'setting','num_transmit',num_transmit,1000);

    { ** capture packet }
    GetProfileInt(ProFileName,'setting','num_packet',num_packet,100);
    GetProfileInt(ProFileName,'setting','time_cap',time_cap,30);
    str(update,tupdate); str(time_transmit,ttime_transmit); str(num_transmit,tnum_transmit);
    str(num_packet,tnum_packet); str(time_cap,ttime_cap);
    GetProfileString(ProFileName,'setting','data_packet',tdata_packet,'Lan Network Monitoring');
    GetProfileString(ProFileName,'setting','alias',talias,'true');
    if talias = 'true' then falias := true
       else falias := false;
    GetProfileString(ProFileName,'setting','cap_file',cap_file,'true');
    if cap_file = 'true' then begin fcap_file := true; lastflag:=0; end
       else begin fcap_file := false; lastflag:=1; end;

    fer_tip:=5; w.newwin(120,110,520,425,'Setting Variable',true);

    w.newchenar(140,160,500,225,11,1,true);
    w.newchenar(140,235,500,300,11,1,true);
    w.newchenar(140,310,500,375,11,1,true);

    w.newfill(145,153,210,167,10,0);
    w.newfill(145,228,210,242,10,0);
    w.newfill(145,303,210,317,10,0);
    w.newchenar(145,153,210,167,11,1,false);
    w.newchenar(145,228,210,242,11,1,false);
    w.newchenar(145,303,210,317,11,1,false);

    w.newtext(148,160,'~General~');
    w.newtext(148,235,'~Generate~');
    w.newtext(148,310,'~Capture~');

    { general }
    w.newtext(160,195,'Update Rate');
    w.newcheck(160,170,'~A~lias',3,falias);
    w.newtracker(320,162,460,1,10,update);

    { generate }
    w.newtext(160,255,'~T~ransmit');
    w.newtext(160,285,'T~i~me');
    w.newinput(250,243,300,262,tnum_transmit,'T');
    w.newinput(250,273,300,292,ttime_transmit,'I');

    { capture }
    w.newtext(160,330,'~N~um. Packet');
    w.newtext(160,360,'Ti~m~e');
    w.newinput(250,318,300,337,tnum_packet,'N');
    w.newinput(250,348,300,367,ttime_cap,'M');
    w.newcheck(340,325,'~F~ile/EMS',3,fcap_file);

    w.newbut(160,390,260,410,'~O~k',9,os2,'');
    w.newbut(270,390,370,410,'~C~ancel',9,os2,'');
    w.newbut(380,390,480,410,'~H~elp',9,os2,'');

    w.newbut(340,243,440,263,'Fi~e~ld',9,os2,'');

    repeat
setting1:
      w.handleevent;
      if cm=2 then
      begin
       trueexit := true;
       tnum_transmit  := w.get_input(1);
       ttime_transmit := w.get_input(2);
       tnum_packet    := w.get_input(3);
       ttime_cap      := w.get_input(4);

       {check validate value}
       val(tnum_transmit,num_transmit,code);
       if (code <> 0) then
       begin
        w.dispmsg('Error','num. transmit must be integer');
        goto setting1;
       end;
       val(ttime_transmit,time_transmit,code);
       if (code <> 0) then
       begin
        w.dispmsg('Error','time transmit must be integer');
        goto setting1;
       end;
       val(tnum_packet,num_packet,code);
       if (code <> 0) then
       begin
        w.dispmsg('Error','num. packet must be integer');
        goto setting1;
       end;
       val(ttime_cap,time_cap,code);
       if (code <> 0) then
       begin
        w.dispmsg('Error','time capture must be integer');
        goto setting1;
       end;

       update := w.get_tracker(1);
       falias := w.check_result(0);
       fcap_file := w.check_result(1);

       {** write value to ini }
       WriteProfileInt(ProFileName,'setting','update',update);
       WriteProfileInt(ProFileName,'setting','num_transmit',num_transmit);
       WriteProfileInt(ProFileName,'setting','time_transmit',time_transmit);
       WriteProfileInt(ProFileName,'setting','num_packet',num_packet);
       WriteProfileInt(ProFileName,'setting','time_cap',time_cap);
       if falias then WriteProfileString(ProFileName,'setting','alias','true')
          else WriteProfileString(ProFileName,'setting','alias','false');
       if fcap_file then WriteProfileString(ProFileName,'setting','cap_file','true')
          else WriteProfileString(ProFileName,'setting','cap_file','false');
      end;

      if cm=4 then  { help field }
      begin
      end;

      if cm=5 then  { edit field }
      begin
                   fer_tip:=5; w.newwin(120,200,520,300,'Generate Packet Value Field',true);
                   w.newtext(140,250,'~V~alue: ');
                   w.newinput(200,243,400,257,tdata_packet,'V');
                   w.newbut(160,270,260,290,'~O~k',9,os2,'');
                   w.newbut(270,270,370,290,'~C~ancel',9,os2,'');
                   w.newbut(380,270,480,290,'~H~elp',9,os2,'');
                   repeat
setting2:            w.handleevent;
                    if cm=2 then {ok of edit value}
                    begin
                     tdata_packet := w.get_input(1);
                     WriteProfileString(ProFileName,'setting','data_packet',tdata_packet);
                    end;
                   until (cm=1) or (cm=3) or (cm=2);
                   w.clrwin(1); cm:=0;
      end;
    until (trueexit) or (cm=1) or (cm=3);

    WriteProfileString(ProFileName,'NILL','NILL','NILL');
    cm := 0;
    w.clrwin(1);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION CheckAddr;    												บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Check Name in Address Book							บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function CheckAddr(Name : String) : String;
var
	Num : integer;
    sName,sHWAddr : String;
    found : Boolean;
begin
	Num := 1;	Found := False;
    GetProfileString(AddrFile,Int2Str(Num),'Name',sName,'');
    while (sName <> '') and not found do
    	begin
        If Name = sName then
			begin
            GetProfileString(AddrFile,Int2Str(Num),'HWAddress',sHWAddr,'');
			Name := sHWAddr;
            found := True;
            end;
        Num := Num+1;
        GetProfileString(AddrFile,Int2Str(Num),'Name',sName,'');
        end;
    ChecKAddr := Name;
    DisposeINICollection;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE Filter;     												บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Filter capture packet								บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure filter;
var address_1,address_2:string;
    tmin_size,tmax_size,tcopy_length:string;
    min_size,max_size,copy_length:integer;
    all_size:string;
    faddr1,faddr2,fallsize,trueexit,trueexit2,trueexit3:boolean;
    tieee,tethernet:string;
    fieee,fethernet:boolean;
    code:integer; { use for check type right integer}
    toffset,tlength,tvalue:string;
    offset,lengthf:integer;
    value : longint;
    {** temp string}
    tstr : string;
label filter1,filter2,filter3;
begin
                trueexit := false; trueexit2:=false; trueexit3:=false;
                DisposeINICollection;
                GetProfileInt(ProFileName,'pre_filter','min_size',min_size,0);
                GetProfileInt(ProFileName,'pre_filter','max_size',max_size,1500);
                GetProfileInt(ProFileName,'pre_filter','copy_length',copy_length,1500);
                str(min_size,tmin_size); str(max_size,tmax_size); str(copy_length,tcopy_length);
                GetProfileString(ProFileName,'pre_filter','address_1',address_1,'any');
                GetProfileString(ProFileName,'pre_filter','address_2',address_2,'any');
                GetProfileString(ProFileName,'pre_filter','all_size',all_size,'true');
                if all_size = 'true' then fallsize := true else fallsize := false;
                GetProfileString(ProFileName,'pre_filter','ieee_802',tieee,'true');
                if tieee = 'true' then fieee := true else fieee := false;
                GetProfileString(ProFileName,'pre_filter','ethernet_ii',tethernet,'true');
                if tethernet = 'true' then fethernet := true else fethernet := false;
                if address_1 = 'any' then faddr1 := true else faddr1 := false;
                if address_2 = 'any' then faddr2 := true else faddr2 := false;

                fer_tip:=5; w.newwin(120,110,520,340,'Pre Filter',true);
                w.newtext(140,160,'~S~ource: ');
                w.newinput(210,153,320,167,address_1,'S');
                w.newtext(140,180,'~D~est.: ');
                w.newinput(210,173,320,187,address_2,'D');
                w.newtext(140,200,'~M~in Size: ');
                w.newinput(210,193,270,207,tmin_size,'M');
                w.newtext(140,220,'M~a~x Size: ');
                w.newinput(210,213,270,227,tmax_size,'A');
                w.newtext(340,220,'Co~p~y Length: ');
                w.newinput(440,213,480,227,tcopy_length,'P');

                w.newchenar(140,240,500,280,0,1,true);
                w.newtext(150,250,'   Please enter correct ~S~ource,~D~est. address   ');
                w.newtext(150,265,'               in form aabbcc-ddeeff              ');
                w.newbut(160,285,260,305,'~O~k',9,os2,'');
                w.newbut(270,285,370,305,'~C~ancel',9,os2,'');
                w.newbut(380,285,480,305,'~F~ield',9,os2,'');

                w.newcheck(340,193,'All si~z~e',2,fallsize);

                w.newcheck(340,153,'a~n~y source addr. ',2,faddr1);
                w.newcheck(340,173,'an~y~ dest. addr.  ',2,faddr2);

                w.newcheck(180,315,'~I~EEE 802',2,fieee);
                w.newcheck(340,315,'~E~thernet II',2,fethernet);

                repeat
filter1:
                  w.handleevent;

                  if cm=2 then begin
                   trueexit := true;
				   {Check Address Book}
                   address_1 := CheckAddr(w.get_input(1));
                   address_2 := CheckAddr(w.get_input(2));
                   tmin_size := w.get_input(3);
                   tmax_size := w.get_input(4);
                   tcopy_length := w.get_input(5);
                   {*** check validate value }
                   val(tmin_size,min_size,code);
                   if (code <> 0) or (min_size<0) or (min_size>1500) then
                   begin
                    w.dispmsg('Error','Value min. size must be integer Between 0 and 1500');
                    goto filter1;
                   end;
                   val(tmax_size,max_size,code);
                   if (code <> 0) or (max_size<0) or (max_size>1500) then
                   begin
                    w.dispmsg('Error','Value max. size must be integer Between 0 and 1500');
                    goto filter1;
                   end;
                   if min_size > max_size then
                   begin
                    w.dispmsg('Error','Value max. size must more than min. size');
                    goto filter1;
                   end;
                   val(tcopy_length,copy_length,code);
                   if (code <> 0) or (copy_length<14) or (copy_Length>1500) then
                   begin
                    w.dispmsg('Error','tcopy_length must between 14 and 1500');
                    goto filter1;
                   end;
                   fallsize := w.check_result(0);
                   faddr1   := w.check_result(1);
                   faddr2   := w.check_result(2);
                   fieee    := w.check_result(3);
                   fethernet := w.check_result(4);
                    {** write value to ini }
                    WriteProfileInt(ProFileName,'pre_filter','min_size',min_size);
                    WriteProfileInt(ProFileName,'pre_filter','max_size',max_size);
                    WriteProfileInt(ProFileName,'pre_filter','copy_length',copy_length);
                    if faddr1 then WriteProfileString(ProFileName,'pre_filter','address_1','any')
                       else WriteProfileString(ProFileName,'pre_filter','address_1',address_1);
                    if faddr2 then WriteProfileString(ProFileName,'pre_filter','address_2','any')
                       else WriteProfileString(ProFileName,'pre_filter','address_2',address_2);
                    if fallsize then WriteProfileString(ProFileName,'pre_filter','all_size','true')
                       else WriteProfileString(ProFileName,'pre_filter','all_size','false');
                    if fieee then WriteProfileString(ProFileName,'pre_filter','ieee_802','true')
                       else WriteProfileString(ProFileName,'pre_filter','ieee_802','false');
                    if fethernet then WriteProfileString(ProFileName,'pre_filter','ethernet_ii','true')
                       else WriteProfileString(ProFileName,'pre_filter','ethernet_ii','false');
                  end;
                  if cm=4 then begin
                GetProfileString(ProFileName,'pre_filter','value',tvalue,'');
                GetProfileInt(ProFileName,'pre_filter','length',lengthf,0);
                GetProfileInt(ProFileName,'pre_filter','offset',offset,0);
                str(lengthf,tlength); str(offset,toffset);
                tstr := tvalue;
                fer_tip:=5; w.newwin(220,150,420,340,'Set Field',true);
                w.newtext(260,200,'O~f~fset: ');
                w.newinput(320,193,380,207,toffset,'F');
                w.newtext(260,220,'Length: ');
                w.newinput(320,213,380,227,tlength,'D');
                w.newbut(240,240,400,260,'~E~dit',9,os2,'');
                w.newbut(240,275,400,295,'~O~k',9,os2,'');
                w.newbut(240,310,400,330,'~C~ancle',9,os2,'');

                repeat
filter2:
                  w.handleevent;
                  if cm=2 then {edit mode }
                  begin
                   fer_tip:=5; w.newwin(120,200,520,300,'Set Value Field',true);
                   w.newtext(140,250,'~V~alue: ');
                   w.newinput(200,243,400,257,tstr,'V');
                   w.newbut(160,270,260,290,'~O~k',9,os2,'');
                   w.newbut(270,270,370,290,'~C~ancel',9,os2,'');
                   w.newbut(380,270,480,290,'~H~elp',9,os2,'');
                   repeat
filter3:            w.handleevent;
                    if cm=2 then {ok of edit value}
                    begin
                     tstr := w.get_input(1);
                     value  := hex2dec(tstr);
                     if (value=-1) then
                     begin
                        w.dispmsg('Error','must type hex digit');
                        goto filter3;
                     end;
                     if (Length(tstr) > 8) or((Length(tstr) mod 2) = 1) then
                     begin
                        w.dispmsg('Error','Value must 0 to 4 octet');
                        goto filter3;
                     end;
                     Lengthf := Sizeof(tstr) div 2;
                     tvalue := tstr;
                    end;
                   until (cm=1) or (cm=3) or (cm=2);
                   w.clrwin(1); cm:=0;
                  end;
                  if cm=3 then {ok}
                  begin
                   toffset := w.get_input(1);
                   tlength := w.get_input(2);
                   { ** check validate value }
                   val(toffset,offset,code);
                   if (code <> 0) or (offset<0) or (offset>1500) then
                   begin
                    w.dispmsg('Error','offset value must be integer Between 0 and 1500');
                    goto filter2;
                   end;
                   val(tlength,lengthf,code);
                   if (code <> 0) or (lengthf<0) or (lengthf>4) then
                   begin
                    w.dispmsg('Error','length value must be integer Between 0 and 4');
                    goto filter2;
                   end;

                   WriteProfileInt(ProFileName,'pre_filter','offset',offset);
                   WriteProfileInt(ProFileName,'pre_filter','length',lengthf);
                   WriteProfileString(ProFileName,'pre_filter','value',tvalue);
                  end;
                until (cm=1) or (cm=4) or (cm=3);
                w.clrwin(1); cm:=0;

                  end;
                until (trueexit) or (cm=1) or (cm=3);
                w.clrwin(1);
                cm := 0;
                WriteProfileString(ProFileName,'NILL','NILL','NILL');

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

procedure helpoe;
const
     StrFileName = 'sethlp.hlp';
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
  w.newbut(12,2,62,18,'~F~ilter',4,os2,'');
  w.newbut(72,2,132,18,'~S~etting',4,os2,'');
{  w.newbut(142,2,182,18,'~H~elp',4,os2,'');}
  w.newbut(582,2,632,18,'~Q~uit',4,os2,'');

  repeat
    w.handleevent;
    case cm of
      1 : Filter;
      2 : Setting;
     { 3 : Helpoe;}
    end;
  until cm=3;
  w.clrwin(1); w.done;
  ExitProgram;
END.

