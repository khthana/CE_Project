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
    source		    : EthernetAddr; {oe 16/1/41}
    destination     : EthernetAddr; {oe 16/1/41}
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

{ษอออออออออออออออออออ
อออออออออออออออออออออออออออออออออออออออออออออออออออป
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
      Message9       = '';
      Message10       = '';
      Message11       = '';
      Message12       = '';
      Message13       = '';
      Message14       = '';
      Message15       = '';
      Message16       = '';

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
      8 : Message := Message5;
      9 : Message := Message6;
      10 : Message := Message7;
      11 : Message := Message5;
      12 : Message := Message6;
      13 : Message := Message7;
      14 : Message := Message5;
      15 : Message := Message6;
      16 : Message := Message7;
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

procedure capa(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+8,b+11,'C',e,4);
     w.writetext(a+34,b+11,'apture',e,0);
end;

procedure helpa(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+12,b+11,'H',e,4);
     w.writetext(a+28,b+11,'elp',e,0);
end;

procedure stopa(a,b,c,d:integer;e:boolean);
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+14,b+11,'S',e,4);
     w.writetext(a+28,b+11,'top',e,0);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE CapturePacket;                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Capture Packet to file.                            บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE CapturePacket;
VAR
      tInfo   : TPacketInfo;
      tFile   : TPacketFile;
      tFile2  : THeaderFile;
      tHeader : FileHeader;
      I,J     : Integer;
      TPacket : TPacketInfo;
      tTime,CurTime : Time;
      Hr,Minu,Scd,Scd100 : Word;
      tInt,LastNumPacket : Word;
      PeakPacket,PeakBit : Integer;
      PeakPktTime,PeakBitTime : Time;
      StartTime : Time;
      StartStat,StopStat      : TSTATISTICS;
      ByteCount,LastCount     : LongInt;
      CurTraffic,TrafficLevel : Real;
      PeakUtilize : Real;
      tstr : string;
      Count : Integer;

      {** use for pre-filter}
      min_size,max_size:integer;
      all_size:string;
      address_1,address_2:string;
      tieee,tethernet:string;
      fieee,fethernet:boolean;
      toffset,tlength,tvalue:string;
      offset,lengthf:integer;
      copy_length:integer;
      pass_filter:boolean;
      Timer3 : _Timer;

      {** use for setting }
      num_packet : integer;
      cap_file : boolean;
      tcap_file : string;
      update : integer;
      time_cap : integer;
      ftype    : boolean;

      {** use for read command key }
      capture : boolean;
BEGIN

     Count := 0;                    { Intitialize Variable }
     Lost := 0;
     J := Sizeof(TPacket);
     capture := true;
     ByteCount := 0; LastCount := 0;
     PeakPacket := 0; PeakBit := 0; PeakUtilize := 0;
     CurTraffic := 0; TrafficLevel := 0; PeakUtilize := 0;
     LastNumPacket := 0;

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
     DisposeINICollection;
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
     GetProfileInt(ProFileName,'setting','time_cap',time_cap,100);
     GetProfileInt(ProFileName,'setting','update',update,1);
     GetProfileString(ProFileName,'setting','cap_file',tcap_file,'true');
     if tcap_file = 'true' then cap_file:= true else cap_file := false;
     {** end form setting}
     If not cap_file then
        if not (EMS_INSTALL) then exit;

     if cap_file then
     begin
          Assign(tFile,'test.Cap');            { Open Data File For Flush Data }
          {$I-} Rewrite(tFile); {$I+}
          IF (IOResult <> 00) THEN
          BEGIN
               w.dispmsg(' Error ','Can not open file,please check it !');
               EMS_RELEASE;
               Exit;
          END;
     end;

     gettime2(tHeader.StartTime);
     gettime2(StartTime);
     gettime2(CurTime);
     fer_tip := 1;
     w.window(30,50,getmaxx-30,getmaxy-150,'Capture Packet');
     {w.chenar(35,55,getmaxx-35,75);}{oe 17/5/41}
     w.fill(44,80,getmaxx-44,getmaxy-160,10,1);
     tstr :=       'Start Time     : ' + WriteTime(StartTime);
     w.tex(35,85,tstr,true);
     w.tex(320,85, 'Active Time    : ',true);
     w.tex(35,105, 'Rcv Packet     : ',true);
     w.tex(320,105,'Rcv Byte       : ',true);
     w.tex(35,125, 'Avg Pkt/s      : ',true);
     w.tex(320,125,'Avg Utilize    : ',true);
     w.tex(35,145, 'Peak Pkt/s     : ',true);
     w.tex(320,145,'Peak Byte/s    : ',true);
     w.tex(35,165, 'Peak Pkt Time  : ',true);
     w.tex(320,165,'Peak Byte Time : ',true);
     w.tex(35,185, 'Peak Utilize   : ',true);
     w.tex(320,185,'Lost Packet    : ',true);
     w.tex(55,230,'Buffer Packet',true);
     w.tex(55,280,'Buffer Time',true);

{     w.buton(42,300,102,320,9,'~C~apture',true,true);
     w.buton(112,300,162,320,9,'~S~top',true,true);
     w.buton(172,300,222,320,9,'~H~elp',true,true);}
     capa(42,300,102,320,False);
     stopa(112,300,162,320,False);
{     helpa(172,300,222,320,False);}

     pktdriver.GetStatistics(StartStat);

     GetTime2(CurTime); { Make Header 6/1/40 }
     tHeader.StartTime  := CurTime;
     PeakPktTime        := CurTime;
     PeakBitTime        := CurTime;

     Timer1.Init(1);
     Timer1.Start;
     Timer2.Init(update);
     Timer2.Start;
     Timer3.Init(Time_Cap);
     Timer3.Start;

     REPEAT

           IF ( PacketCount = 1 ) and capture THEN       { Receive Packet }
           BEGIN
              {** for global statistic }
              IF RcvLength < 60 THEN Inc(INFORMATION.Undersize_S);
              IF RcvLength > 1514 THEN Inc(INFORMATION.Oversize_S);

              IF (all_size='true') or ((RcvLength > min_size) and (RcvLength < max_size))
              then begin

                   {** read input }
                Move(Rcvpacket,tInfo,Copy_Length);

                pass_filter:=true;

                IF (Lengthf > 0) and (Lengthf<=4) and (Lengthf <> sizeof(tvalue)) and (tvalue <> '') then
                begin
                    for i := 0 to lengthf-1 do
                    begin
                      If Rcvpacket[offset+i] <> hex2byte(tvalue[(i*2)+1]) then pass_filter := false;
                    end;
                end;

                   {** check for type of frame }
                IF ((FEthernet and (tInfo.Header.TypeLen > $EE05)) or
                   (FIEEE and (tInfo.Header.TypeLen <= $EE05))) and
                   pass_filter and
                   {** check for address}
                   (((address_1 = 'any') or (getethernetaddress2(tInfo.header.sourceaddr)=address_1)
                   or (getethernetaddress2(tInfo.header.destaddr)=address_1))  and
                   ((address_2 = 'any') or (getethernetaddress2(tInfo.header.destaddr)=address_2))
                   or (getethernetaddress2(tInfo.header.sourceaddr)=address_2)) then
                   begin

                      { ** check information }
                      IF CompareEthernetAddr(tinfo.Header.SourceAddr,BROADCAST)
                         or CompareEthernetAddr(tinfo.Header.DestAddr,BROADCAST)
                      THEN Inc(INFORMATION.Broadcast_S);
                      { ** begin of capture module }
                      Inc(Count);
                      If Count > num_packet then capture := false;
                      Inc(ByteCount,RcvLength);
                      GetTime2(tInfo.PktTime);
                      tInfo.Length := RcvLength;
                      { ** check for mode capture }
                      if cap_file then Write(tFile,tInfo) else WritePacketArray(Count,tInfo);
                      { ** end of capture module }
                   end;
              end;

                RcvLength   := 0;
                PacketCount := 0;            { Reset flag for new frames }
           END;

           IF KeyPressed THEN Key := ReadKey;
           IF upcase(Key) = 'C' then
           Begin
		        capa(42,300,102,320,True);
                capture := true;
                Key := #0;
           End;
           IF upcase(Key) = 'S' then
           Begin
		        stopa(112,300,162,320,True);
                capture := false;
                Key := #0;
           End;
{           IF upcase(Key) = 'H' then
           Begin
		        helpa(172,300,222,320,True);
                key := #0;
	 	   End;}

           IF Timer1.Timeout THEN
           BEGIN
                {** Check INFORMATION }
			    capa(42,300,102,320,False);
     			stopa(112,300,162,320,False);
{     			helpa(172,300,222,320,False);}

                INFORMATION.Packet_S := Count-LastCount;
                INFORMATION.Drop_S   := LOST-LastLost;
                INFORMATION.Byte_S   := ByteCount-LastByteCount;
                INFORMATION.Utilize  := ((INFORMATION.Byte_S * 100 DIV 1240256) + ((INFORMATION.Packet_S*300) DIV 310064));
{                INFORMATION.Utilize  := (((INFORMATION.Byte_S) DIV 1240256) + ((INFORMATION.Packet_S)DIV 155032));}
                { div by 9922048}

                TrafficLevel := ((ByteCount - LastByteCount) / (MaxEthernetCapacity)*75);
                CurTraffic   := (TrafficLevel / 75) * 100;

                GetTime2(Curtime);

                IF PeakPacket < Count-LastCount THEN
                   BEGIN
                        PeakPacket := Count-LastCount;
                        PeakPktTime := CurTime;
                   END;
                IF PeakBit < ByteCount-LastByteCount THEN
                   BEGIN
                        PeakBit := ByteCount - LastByteCount;
                        PeakBitTime := CurTime;
                   END;
                IF PeakUtilize < CurTraffic THEN
                   BEGIN
                        PeakUtilize := CurTraffic;
                   END;

                TimeDifferent(tHeader.StartTime,CurTime,tTime);

                LastByteCount := ByteCount;
                LastLOST      := LOST;
                LastCount     := Count;

           IF Timer2.timeout then
           begin
                if cap_file then DisplayInfo(6) else DisplayInfo(7);

                If Capture then
                Begin
                GetTime2(CurTime);
                TimeDifferent(StartTime,CurTime,tTime);

                w.fill(435,78,515,92,10,1);
                w.tex(435,85,WriteTime(tTime),true);

                str(Count:8,tstr);
                w.fill(155,98,235,112,10,1);
                w.tex(155,105,tstr,true);

                str(ByteCount:8,tstr);
                w.fill(435,98,515,112,10,1);
                w.tex(435,105,tstr,true);

                str((I-LastNumPacket):8,tstr);
                w.fill(155,118,235,132,10,1);
                w.tex(155,125,tstr,true);

                str(Trunc(CurTraffic):8,tstr);
                w.fill(435,118,515,132,10,1);
                w.tex(435,125,tstr,true);

                str(PeakPacket:8,tstr);
                w.fill(155,138,235,152,10,1);
                w.tex(155,145,tstr,true);

                w.fill(155,158,235,172,10,1);
                w.tex(155,165,WriteTime(PeakPktTime),true);

                str(PeakBit:8,tstr);
                w.fill(435,138,515,152,10,1);
                w.tex(435,145,tstr,true);

                w.fill(435,158,515,172,10,1);
                w.tex(435,165,WriteTime(PeakbitTime),true);

                str(Trunc(PeakUtilize):8,tstr);
                w.fill(155,178,235,192,10,1);
                w.tex(155,185,tstr,true);

                str(Lost:8,tstr);
                w.fill(435,178,515,192,10,1);
                w.tex(435,185,tstr,true);

                tstr := 'Ethernet Address : ' + GetEthernetAddress(MyEthernetAddr);
                w.fill(155,198,335,212,10,1);
                w.tex(155,205,tstr,true);

                { ** Num packet ** }
                tint := 0;
              {  tInt := ((Count * 100) div num_packet);}
                tint := count DIV 10;
         {       If Count >= num_packet then tInt := 100;}
                if tint > 100 then tint := 100;
                w.procent(155,230,515,240,tInt,10);
                w.fill(157,232,157+((tInt*(513-157)) div 100),238,4,1);

                { ** Num Time ** }
                tint := 0;
                tInt := (tTime.Hour*3600 +tTime.Minute*60 + tTime.Second )*100 div time_cap;
                If ((tTime.Hour*3600 +tTime.Minute*60 + tTime.Second ) = time_cap) then tInt := 100;
                If (tInt >= 95) then tInt := 100;
                w.procent(155,280,515,290,tInt,10);
                w.fill(157,282,157+((tInt*(515-155)) div 100),288,4,1);
                end;


                INFORMATION.Broadcast_S := 0;
                INFORMATION.Undersize_S := 0;
                INFORMATION.Oversize_S := 0;
                INFORMATION.Packet_S   := 0;
           end;
                Timer1.Start;
           END;

           IF Timer3.timeout then
           begin
            capture := false
           end;

     UNTIL (Key = #27);   { Stop when }
     Key := #0;

     GetTime2(tHeader.StopTime); { Make Header 6/1/40 }
     pktdriver.GetStatistics(StopStat);

     tHeader.RunTime.Hour   := tHeader.StopTime.Hour - tHeader.StartTime.Hour;
     tHeader.RunTime.Minute := tHeader.StopTime.Minute - tHeader.StartTime.Minute;
     tHeader.RunTime.Second := tHeader.StopTime.Second - tHeader.StartTime.Second;
     tHeader.MyAddr    := MyEthernetAddr;
     tHeader.RcvPacket := StopStat.Packets_in   - StartStat.Packets_in;
     tHeader.RcvByte   := StopStat.Bytes_in     - StartStat.Bytes_in;
     tHeader.Error     := StopStat.Errors_in    - StartStat.Errors_in;
     tHeader.Lost      := StopStat.Packets_lost - StartStat.Packets_lost;

     If not (cap_file) then
     begin
          { Display Message for flushing }
          w.fill(3,458,519,475,10,1);
          w.tex(12,467,'Now flushing buffer to disk.',true);

          for I := 0 to num_packet do
          begin
               ReadPacketArray(I,tInfo);
               Write(tFile,tInfo)
          end;
          Close(tFile);
          { Display Message for flush finished }
     Assign(tFile2,'test.Hed');            { Open Data File For Flush Data }

     {$I-} Rewrite(tFile2); {$I+}
     IF (IOResult <> 00) THEN
     BEGIN
          cm := 0;
          w.dispmsg(' Error ','Can not open file,please check it !');
          w.refwin(stay,stay);
          if not cap_file then
                EMS_RELEASE;
     END;

     Write(tFile2,tHeader);

     Close(tFile2);
     end;


     cm := 0;
     w.refwin(stay,stay);

     WriteProfileString(ProfileName,'NILL','NILL','NILL');
     if not cap_file then
         EMS_RELEASE;
     BufferCount := I;
     BufferFill := TRUE;
END;

procedure changestring(a:string;var value:integer);
var b,sum:integer;
begin
     value := 0;
     for b := 1 to 2 do
     begin
          case a[b] of
          '0' : value := 0;
  		  '1' : value := 1;
          '2' : value := 2;
		  '3' : value := 3;
          '4' : value := 4;
		  '5' : value := 5;
  		  '6' : value := 6;
          '7' : value := 7;
		  '8' : value := 8;
          '9' : value := 9;
          'A','a'  : value := 10;
          'B','b'  : value := 11;
          'C','c'  : value := 12;
          'D','d'  : value := 13;
          'E','e'  : value := 14;
          'F','f'  : value := 15;
          end;
          if b = 1 then sum := value*16;
          if b = 2 then sum := sum+value;
     end;
     value := sum;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GenPacket;                                                 บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Create Color Bar                                   บ
 บ                 ณ Input : Location,Color,Value,High                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GenPacket;
VAR     tFileName : String[13];
        ch        : Char;
        num_packet,size,delaytime : integer;
        tnum_transmit,ttime_transmit: string;
        tsize       : string;
        tdelay      : string;
        packetcount : integer;
        testether:string;
        fcon        : boolean;
        ftype       : boolean;  { type of send packet }
        trueexit,sendexit :boolean;
        code : integer;
        b :array[0..5] of string;
        time_transmit,num_transmit : integer;
        update : integer;
        tdata_packet,a1,a2,a3,a4,a5,a6,a : string;
        b1,b2,b3,b4,b5,b6:integer;
        c1,c2,c3,c4,c5,c6:integer;
        tsource:string;
        tdestination:string;
        Timer1,Timer2 : _Timer;
        Counter : integer;
        I,J,K : Integer;

label   genpacket1;

BEGIN
      packetcount := 0;
      trueexit := false;
      sendexit := false;
      size := 64;
      delaytime := 100;
      tsize := '64';
      tdelay := '100';

      DisposeINICollection;
      GetProfileInt(ProFileName,'setting','time_transmit',time_transmit,30);
      GetProfileInt(ProFileName,'setting','num_transmit',num_transmit,1000);
      GetProfileInt(ProFileName,'setting','update',update,1);
      str(time_transmit,ttime_transmit); str(num_transmit,tnum_transmit);
      GetProfileString(ProFileName,'setting','data_packet',tdata_packet,'Lan Network Monitoring');
      GetProfileString(ProfileName,'setting','tsource',tsource,'111111-111111');
      GetProfileString(ProfileName,'setting','tdestination',tdestination,'FFFFFF-FFFFFF');

      fer_tip:=5; w.newwin(120,100,520,430,'Generate Packet',true);
      w.newtext(140,150,'~N~um Packet : ');
      w.newinput(220,143,260,157,tnum_transmit,'N');

      w.newtext(140,170,'~T~ime : ');
      w.newinput(220,163,260,177,ttime_transmit,'T');

      w.newtext(140,190,'~S~ize');
      w.newtext(240,190,'~D~elay');
      w.newinput(180,183,220,197,tsize,'S');
      w.newinput(280,183,320,197,tdelay,'D');

      w.newbut(420,140,500,160,'~G~enerate',9,os2,'');
      w.newbut(420,180,500,200,'~F~inished',9,os2,'');

      w.newcheck(140,210,'~C~ontinue',2,false);

      w.newcheck(230,210,'Ti~m~e/Num',2,false);

      w.newtext(140,240,'~P~acket Value');
      w.newinput(140,260,500,275,tdata_packet,'P');

	  w.newtext(140,320,'S~o~urce Address (Ethernet Address Form)');
	  w.newinput(140,340,500,355,tsource,'o');

	  w.newtext(140,370,'D~e~stination Address (Ethernet Address Form)');
	  w.newinput(140,390,500,405,tdestination,'e');
      repeat
genpacket1:
        w.handleevent;
        if cm=2 then
        begin
         {**  read from input }
         tnum_transmit := w.get_input(1);
         ttime_transmit := w.get_input(2);
         tsize := w.get_input(3);
         tdelay := w.get_input(4);
         tdata_packet := w.get_input(5);
         tsource := w.get_input(6);
         tdestination := w.get_input(7);
         fcon := w.check_result(0);
         ftype := w.check_result(1);
         PacketCount := 0;
         a1 := tdestination[1]+tdestination[2];
         changestring(a1,b1);
         a2 := tdestination[3]+tdestination[4];
         changestring(a2,b2);
         a3 := tdestination[5]+tdestination[6];
         changestring(a3,b3);
         a4 := tdestination[8]+tdestination[9];
         changestring(a4,b4);
         a5 := tdestination[10]+tdestination[11];
         changestring(a5,b5);
         a6 := tdestination[12]+tdestination[13];
         changestring(a6,b6);
         a1 := tsource[1]+tsource[2];
         changestring(a1,c1);
         a2 := tsource[3]+tsource[4];
         changestring(a2,c2);
         a3 := tsource[5]+tsource[6];
         changestring(a3,c3);
         a4 := tsource[8]+tsource[9];
         changestring(a4,c4);
         a5 := tsource[10]+tsource[11];
         changestring(a5,c5);
         a6 := tsource[12]+tsource[13];
         changestring(a6,c6);

         {** check validate value}
         val(tnum_transmit,num_transmit,code);
         if ((code <> 0) or (num_transmit <= 0) or (num_transmit > 32768)) {and not(fcon)} then
         begin
           w.dispmsg('Error','Number packet must be integer `and more than 0 but less than 32768');
           goto genpacket1;
         end;

         val(ttime_transmit,time_transmit,code);
         if ((code <> 0) or (time_transmit <= 0) or (time_transmit > 32768)) {and not(fcon)} then
         begin
           w.dispmsg('Error','Time to transmit must be integer `and more than 0 but less than 32768');
           goto genpacket1;
         end;

         val(tsize,size,code);
         if (code <> 0) or (size < 0) or (size > 1500) then
         begin
           w.dispmsg('Error','Size packet must be integer `between 0 to 1500');
           goto genpacket1;
         end;

         val(tdelay,delaytime,code);
         if (code <> 0) or (delaytime > 1000) or (delaytime < 0) then
         begin
           w.dispmsg('Error','Delay must be integer `between 0 to 1000');
           goto genpacket1;
         end;
         {** initial value for exit send }
         sendexit:=false;
{         For I := 0 TO 5 Do}
		 SendPacket.Destaddr[0] := b1;{oe 16/5/41}
		 SendPacket.Destaddr[1] := b2;{oe 16/5/41}
         SendPacket.Destaddr[2] := b3;{oe 16/5/41}
	     SendPacket.Destaddr[3] := b4;{oe 16/5/41}
         SendPacket.Destaddr[4] := b5;{oe 16/5/41}
         SendPacket.Destaddr[5] := b6;{oe 16/5/41}
{         SendPacket.Destaddr := Destination;}
         SendPacket.SourceAddr[0]      := c1;
         SendPacket.SourceAddr[1]      := c2;
         SendPacket.SourceAddr[2]      := c3;
         SendPacket.SourceAddr[3]      := c4;
         SendPacket.SourceAddr[4]      := c5;
         SendPacket.SourceAddr[5]      := c6;
         {SendPacket.SourceAddr := source;}
         SendPacket.TypeLen         := $5E00;  { my define type }

         FOR I := 1 to 1500 DO
             SendPacket.Data[I] := #0;
{         SendPacket.Data := tdata_packet; }

         if (Length(tdata_packet) > size)
            then Move(tData_packet,SendPacket.Data,size)
            else Move(tData_packet,SendPacket.Data,Length(tdata_packet));

         Timer1.Init(Time_Transmit);
         Timer1.Start;
         Timer2.Init(update);
         Timer2.Start;

         Counter := DelayTime;

         repeat
           IF KeyPressed THEN Key := ReadKey;
           CASE Key OF
             '-' : BEGIN IF (DelayTime < 1000)THEN Inc(DelayTime); Key := #00; END;
             '+' : BEGIN IF (DelayTime > 1  ) THEN Dec(DelayTime); Key := #00; END;
           END;

           Inc (counter);

           If Counter >= DelayTime then
           Begin
              pktDriver.SendPkt(@SendPacket,13+Size);   {SendDataCount + 14 - 1}
              Inc(PacketCount);
              Counter := 0;
              { ** Update display }
              w.fill(140,283,450,297,10,1);
              str(PacketCount,tstr);
              w.texl(140,290,'Packet Send : '+tstr);
              str(DelayTime,tstr);
              w.texl(340,290,'Delay Time : '+tstr);
           end;

           If not(fcon) then
           Begin
             If not(ftype) and Timer1.Timeout then sendexit := true;
             If ftype and (PacketCount >= num_transmit)  then
                sendexit:=true;
           End;

           IF timer2.timeout then
           begin
              timer2.start;
           end;

         UNTIL (Key = #27) or (sendexit);
        end;
        If Key = #27 then trueexit := true;
      until (trueexit) or (cm=1) or (cm=3);

     Key := #0;
     cm := 0;
     WriteProfileString(ProfileName,'NILL','NILL','NILL');
     w.clrwin(1);
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
     StrFileName = 'caphlp.hlp';
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


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ          MAIN PROGRAM FOR Ethernet Monitor VERSION 1.00              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
BEGIN

     ClrScr;
     pktDriver.ScanForPktDriver;
     InitPktDriver;
{     Delay(1500);
     ClrScr;}

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
     w.newbut(2,2,68,18,'C~a~pture',4,os2,'');
     w.newbut(68,2,134,18,'~G~enerate',4,os2,'');
     w.newbut(134,2,184,18,'~H~elp',4,os2,'');
     w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

     repeat
     w.handleevent;
     case cm of
          0 : Begin
                If Event_ch = #27 then cm := 3;
              End;
          1 : Capturepacket;
          2 : GenPacket;
          3 : helpoe;

     end;
     until cm=4;
     w.clrwin(1); w.done;
     ExitProgram;
END.

