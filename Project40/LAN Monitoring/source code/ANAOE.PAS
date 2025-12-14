PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G+,I-,L+,N-,O-,R-,S-,V+,X+}

USES   ETHER,PKTDRVR,TIMER,STRINGS,CRT,DOS,INIF,EMS,stringop,grafica,g_applic,util256,graph,mouse;

const  DefaultFileName     = 'DATA.DAT';
       ElementNum          = PAGESIZE DIV Sizeof(TPacketInfo);
       { use for Extend protocol in .INI file}
       DefaultString = 'Notfound';
       INIFile       = 'Protocol';
       ExtProtocolLimit = 20;    { Can add 20 protocols per section }
{ Constant use in DisplayProtocol }
       LastLayer2Protocol  = 4;
       LastLayer3Protocol  = 7;
       LastLayer4Protocol  = 7;
       LastUpLayerProtocol = 9;
       LastProtocol        = LastLayer2Protocol + LastLayer3Protocol + LastLayer4Protocol + LastUpLayerProtocol;
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

    { use for display }
       __X             = 30;

TYPE
     { use for Extend protocol in .INI file }
     TTableLookup = ARRAY [1..20] OF string;

     TEtherFrame         = RECORD        { For EtherII and Ether802.3 }
                          MAC   : MACHeader;
                          Data  : ARRAY [00..100] OF Byte;
                          END;
     TEther8022Frame     = RECORD
                          MAC   : MACHeader;
                          DSAP  : Byte;
                          SSAP  : Byte;
                          Control : Byte;
                          Data  : ARRAY [00..100] OF Byte;
                          END;
     TEtherSNAPFrame     = RECORD
                          MAC   : MACHeader;
                          DSAP  : Byte;
                          SSAP  : Byte;
                          Control : Byte;
                          OrganizeCode : ARRAY [0..2] OF Byte;
                          EtherType : Data16;
                          Data  : ARRAY [00..100] OF Byte;
                          END;
     TIPXPacket          = RECORD
                          CheckSum : Data16;
                          Length   : Data16;
                          Transport: Byte;
                          PacketType : Byte;
                          DestNet  : Data32;
                          DestHost : EthernetAddr;
                          DestSock : Data16;
                          SourceNet  : Data32;
                          SourceHost : EthernetAddr;
                          SourceSock : Data16;
                          Data     : ARRAY [00..100] OF Byte;
                          END;
     TIPPacket           = RECORD
                          VersionHeadLen : Byte;
                          TOS     : Byte;
                          Length  : Data16;
                          ID      : Data16;
                          Flag    : Data16;
                          TTL     : Byte;
                          Protocol: Byte;
                          HeadChksum : Data16;
                          SourceAddr : Data32;
                          DestAddr   : Data32;
                          Data    : ARRAY [00..1400] OF Byte;
                          OptionData : ARRAY [00..100] OF Byte;
                          NO_option  : Boolean;
                          OptionLen  : integer;
                          END;
     TARPPacket          = RECORD
                          HWType  : Data16;
                          ProType : Data16;
                          HWAddrLength  : Byte;
                          ProAddrLength : Byte;
                          OperateCode : Data16;
                          SendHWAddr  : EthernetAddr;
                          SendProAddr : Data32;
                          TargetHWAddr  : EthernetAddr;
                          TargetProAddr : Data32;
                          END;
     TSPXPacket          = RECORD
                          Control : Byte;
                          DataType: Byte;
                          SourceID: Data16;
                          DestID  : Data16;
                          SeqNumber : Data16;
                          AckNumber : Data16;
                          AllocNumber : Data16;
                          Data : ARRAY [00..100] OF Byte;
                          DataLen : integer;
                          END;
     TNCPPacket          = RECORD
                          ReqRepType   : Data16;
                          SeqNumber : Byte;
                          ConnectNumLow  : Byte;
                          TaskNumber     : Byte;
                          ConnectNumHigh : Byte;
                          CompletionCode : Byte;
                          ConnectStatus  : Byte;
                          Data : ARRAY [00..100] OF Byte;
                          NCP_Req : Boolean;
                          END;
     TICMPPacket        = RECORD
                          Type_: Byte;
                          Code : Byte;
                          ChkSum : Data16;
                          Data : ARRAY [00..100] OF Byte;
                          END;
     T3_4_11Message     = RECORD
                          Unused : Data32;
                          Data : ARRAY [00..31] OF Byte;
                          DataLen : integer;
                          END;
     T0_8_15_16Message  = RECORD
                          ID : Data16;
                          SeqNumber : Data16;
                          Data : ARRAY [00..100] OF Byte;
                          DataLen : integer;
                          END;
     T13_14Message      = RECORD
                          ID : Data16;
                          SeqNumber : Data16;
                          Originate : Data32;
                          Receive   : Data32;
                          Transmit  : Data32;
                          END;
     T5Message          = RECORD
                          GatewayAddr : Data32;
                          Data : ARRAY [00..31] OF Byte;
                          DataLen : integer;
                          END;
     T12Message         = RECORD
                          Pointer : Byte;
                          Unused1 : Byte;
                          Unused2 : Data16;
                          Data : ARRAY [00..31] OF Byte;
                          DataLen : integer;
                          END;
     TTCPPacket         = RECORD
                          SourcePort : Data16;
                          DestPort   : Data16;
                          SeqNumber  : Data32;
                          AckNumber  : Data32;
                          HeaderLen  : Byte;
                          CodeBits   : Byte;
                          Windows    : Data16;
                          ChkSum     : Data16;
                          UrgentPoint: Data16;
                          Data : ARRAY [00..100] OF Byte;
                          OptionData : ARRAY [00..100] OF Byte;
                          NO_option  : Boolean;
                          OptionLen  : integer;
                          DataLen    : integer;
                          END;
     TUDPPacket         = RECORD
                          SourcePort : Data16;
                          DestPort   : Data16;
                          Length  : Data16;
                          ChkSum  : Data16;
                          Data : ARRAY [00..100] OF Byte;
                          DataLen : integer;
                          END;
     TRawData = ARRAY [00..1500] OF Byte;

     adapplic=object(g_application)
              procedure background; virtual;
              end;
VAR
    s            : string        ;
    w            : adapplic      ;
    i,fw,nw      : word          ;

    PacketBuffer    : EMSArray;
    Pages,KiloByte  : Word;            { ONE 10/1/40 Keep Pages avail }
    MaxPacketBuffer : Word;
    INFORMATION     : Statistic;       { ONE 17/1/40 for check error }
    Threshold       : Statistic;       { ONE 17/1/40 for check error }

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

    CurTraffic      : Real;            { Used for evalute traffic }
    CumTraffic      : LongInt;

    tInt            : Integer;         { Used for handle file operation }
    FrameType       : String;
    FileName        : String[13];

    HeaderFile      : FileHeader;      { ONE 6/1/40 for save files in module capture}

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


     IndexL2,IndexL3,IndexL4,IndexUL : integer;
     K             : integer;
     Line            : integer; { Count line number that display to screen }

     tPacket    : TPacketInfo;
     Count      : Integer;
     Position   : integer; { used to indexed position of option field in IP and TCP }
     End_Option : Boolean; { used for IP and TCP packet with option field }
     _Length     : integer; { " " }
     Address    : Data32;

     tFile      : TPacketFile;
     tFile2     : tHeaderFile;
     tempfile   : text;

     EtherFrame : TEtherFrame;
     Ether8022Frame : TEther8022Frame;
     EtherSNAPFrame : TEtherSNAPFrame;
     IPXPacket  : TIPXPacket;
     IPPacket   : TIPPacket;
     ARPPacket  : TARPPacket;
     SPXPacket  : TSPXPacket;
     NCPPacket  : TNCPPacket;
     ICMPPacket : TICMPPacket;
         _3_4_11Message    : T3_4_11Message;
         _0_8_15_16Message : T0_8_15_16Message;
         _13_14Message     : T13_14Message;
         _5Message         : T5Message;
         _12Message        : T12Message;
     TCPPacket  : TTCPPacket;
     UDPPacket  : TUDPPacket;

     RawData : TRawData;

procedure adapplic.background;
var f,n: integer;
begin
     hide;
     setfillstyle(1,0); bar(0,0,getmaxx,getmaxy);
     show;
end;

Procedure ClearBitA(var a;Bit:Word);assembler;
{----------------------------------------------------------------------------
                          |    high byte    |       low byte        |
  "Bit" position of "a"   | 7 6 5 4 3 2 1 0 | 15 14 13 12 11 10 9 8 |
 ----------------------------------------------------------------------------}
Const Bits:array[0..7] of Byte = ($1,$2,$4,$8,$10,$20,$40,$80);
asm
  Les di,a
  Mov si,bit
  Mov bx,si
  And si,07h
  Shr bx,03h
  Mov al,Byte(Bits[si])
  Not al                {invert the bit mask}
  And es:[di+bx],al     {mask off the selected bit}
end;

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
 บ FUNCTION  GetEthernetAddress                                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts a 6 byte ethernet address into a dash     บ
 บ                 ณ separated string.                                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetEthernetAddress(tEtherAddr : EthernetAddr) : String;
VAR tString : String;
    tDigit  : String[02];
    tCount  : Byte;
    AddrLen : Byte;
BEGIN
     AddrLen := SizeOf(EthernetAddr)-1;
     tString := '';

     FOR tCount := 0 TO AddrLen DO
     BEGIN
          tString := tString + ByteToHexASCII(tEtherAddr[tCount]);
          IF (tCount < AddrLen) THEN tString := tString + '-';
     END;
     GetEthernetAddress := tString;
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
 บ FUNCTION  GetBit(...) : String;                                      บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts High-Nibble of Byte to Byte               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION GetBit(tByte,Weigth : Byte) : String;
BEGIN
     GetBit := Chr(48 + ((tByte SHR Weigth) AND $01));
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  Get4BitHigh(...) : Byte;                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts High-Nibble of Byte to Byte               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get4BitHigh(tByte : Byte) : Byte;
BEGIN
     Get4BitHigh := tByte SHR 4;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ FUNCTION  Get4BitLow(...) : Byte;                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Converts Low-Nibble of Byte to Byte                บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Get4BitLow(tByte : Byte) : Byte;
BEGIN
     Get4BitLow := tByte AND $0F;  { AND 00001111b }
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
     PrintIP := tString;
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
     ttWord := (verpacket[14] SHL 8) + verpacket[15];
     IndexL2 := ChkLayer2Protocol(tWord,ttWord);
     { Check what layer 3 protocol is? }
     CASE IndexL2 OF
          EthernetII    :   BEGIN
                            tWord := SwapWord(VerHeader.TypeLen);
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_3 :   IndexL3 := IPX;
          EthernetSNAP  :   BEGIN
                            tWord := (verpacket[20] SHL 8) + verpacket[21];
                            IndexL3 := ChkLayer3Protocol(IndexL2,tWord);
                            END;
          Ethernet802_2 :   BEGIN
                            tWord := (verpacket[14] SHL 8) + verpacket[15];
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
                    IF Condition = ((verpacket[Offset] SHL 8) + verpacket[Offset+1]) THEN
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
                                            tByte := verpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_3   :  BEGIN
                                            tByte := verpacket[19];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := verpacket[27];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         Ethernet802_2   :  BEGIN
                                            tByte := verpacket[22];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                    END;
          IP      : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tByte := verpacket[23];
                                            IndexL4 := ChkLayer4Protocol(IndexL3,tByte);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tByte := verpacket[31];
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
                         IF Condition = verpacket[Offset] THEN
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
                                            tWord := (verpacket[34] SHL 8) + verpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (verpacket[42] SHL 8) + verpacket[43];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                    END;
          UDP     : CASE IndexL2 OF
                         EthernetII      :  BEGIN
                                            tWord := (verpacket[34] SHL 8) + verpacket[35];
                                            IndexUL := ChkUpLayerProtocol(IndexL4,tWord);
                                            END;
                         EthernetSNAP    :  BEGIN
                                            tWord := (verpacket[42] SHL 8) + verpacket[43];
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
                              IF Condition = ((verpacket[Offset] SHL 8) + verpacket[Offset+1]) THEN
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
 บ FUNCTION Incr;                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Increment data                                     บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
FUNCTION Incr(VAR Data : integer): integer;
BEGIN
     Inc(Data,10);
     if Data > 415 then
     begin
       outtextxy(10,466,'Press any key to view next page');
       Key := Readkey;
       w.fill(10,55,getmaxx-10,440,10,1);
       w.fill(3,458,519,475,10,1);
       Data := 55;
     end;
     Incr := Data;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetIPX;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get IPX packet from layer 2 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetIPX(Index : integer;VAR Packet : TIPXPacket);
VAR       Length : Word;
BEGIN
     CASE Index OF
          EthernetII    : BEGIN
                          Length := (EtherFrame.Data[2] SHL 8) + EtherFrame.Data[3];
                          Move(EtherFrame.Data,Packet,Length);
                          END;
          Ethernet802_3 : BEGIN
                          Length := (EtherFrame.Data[2] SHL 8) + EtherFrame.Data[3];
                          Move(EtherFrame.Data,Packet,Length);
                          END;
          EthernetSNAP  : BEGIN
                          Length := (EtherSNAPFrame.Data[2] SHL 8) + EtherSNAPFrame.Data[3];
                          Move(EtherSNAPFrame.Data,Packet,Length);
                          END;
          Ethernet802_2 : BEGIN
                          Length := (Ether8022Frame.Data[2] SHL 8) + Ether8022Frame.Data[3];
                          Move(Ether8022Frame.Data,Packet,Length);
                          END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetIP;                                                     บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get IP packet from layer 2 frame                   บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetIP(Index : integer;VAR Packet : TIPPacket);
VAR       Length : Word;
BEGIN
     CASE Index OF
          EthernetII    : BEGIN
                          Length := (EtherFrame.Data[2] SHL 8) + EtherFrame.Data[3];
                          Move(EtherFrame.Data,Packet,Length);
                          END;
          EthernetSNAP  : BEGIN
                          Length := (EtherSNAPFrame.Data[2] SHL 8) + EtherSNAPFrame.Data[3];
                          Move(EtherSNAPFrame.Data,Packet,Length);
                          END;
     END;
     IF (Index = EthernetII) OR (Index = EthernetSNAP) THEN
     BEGIN
          Packet.OptionLen := (Get4BitLow(Packet.VersionHeadLen) * 4) - 20;
          IF Packet.OptionLen = 0 THEN
               Packet.NO_option := TRUE
          ELSE
          BEGIN
              Packet.NO_option := FALSE;
              FOR J:=0 TO Packet.OptionLen - 1 DO
              BEGIN
                   Packet.OptionData[J] := Packet.Data[J];
                   Packet.Data[J] := Packet.Data[Packet.OptionLen + J];
              END;
          END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetARP;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get ARP packet from layer 2 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetARP(Index : integer;VAR Packet : TARPPacket);
VAR       Length : Word;
BEGIN
     CASE Index OF
          EthernetII    : BEGIN
                          Length := $1C;
                          Move(EtherFrame.Data,Packet,Length);
                          END;
          EthernetSNAP  : BEGIN
                          Length := $1C;
                          Move(EtherSNAPFrame.Data,Packet,Length);
                          END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetSPX;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get SPX packet from layer 3 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetSPX(Index : integer;VAR Packet : TSPXPacket);
VAR       Length : Word;
BEGIN
     IF Index = IPX THEN
     BEGIN
          Length := ((IPXPacket.Length[0] SHL 8) + IPXPacket.Length[1]) - $1E;
          Move(IPXPacket.Data,Packet,Length);
          Packet.DataLen := Length - 12;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetNCP;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get NCP packet from layer 3 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetNCP(Index : integer;VAR Packet : TNCPPacket);
VAR       Length : Word;
BEGIN
     IF Index = IPX THEN
     BEGIN
          Length := ((IPXPacket.Length[0] SHL 8) + IPXPacket.Length[1]) - $1E;
          Move(IPXPacket.Data,Packet,Length);
     END;
{     IF Length < xxxx }
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetICMP;                                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get ICMP packet from layer 3 frame                 บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetICMP(Index : integer;VAR Packet : TICMPPacket);
VAR       Length : Word;
BEGIN
     IF Index = IP THEN
     BEGIN
          Length := ((IPPacket.Length[0] SHL 8) + IPPacket.Length[1]) - ($00 + (IPPacket.VersionHeadLen AND $0F));
          Move(IPPacket.Data,Packet,Length);
          CASE Packet.Type_ OF
               0,8,15,16    : BEGIN
                              Move(Packet.Data,_0_8_15_16Message,Length - 8);
                              _0_8_15_16Message.DataLen := Length - 12;
                              END;
               3,4,11       : BEGIN
                              Move(Packet.Data,_3_4_11Message,Length - 8);
                              _3_4_11Message.DataLen := Length - 12;
                              END;
               13,14        : BEGIN
                              Move(Packet.Data,_13_14Message,Length - 8);
                              END;
               5            : BEGIN
                              Move(Packet.Data,_5Message,Length - 8);
                              _5Message.DataLen := Length - 12;
                              END;
               12           : BEGIN
                              Move(Packet.Data,_12Message,Length - 8);
                              _12Message.DataLen := Length - 12;
                              END;
          END;

     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetTCP;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get TCP packet from layer 3 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetTCP(Index : integer;VAR Packet : TTCPPacket);
VAR       Length : Word;
BEGIN
     IF Index = IP THEN
     BEGIN
          Length := ((IPPacket.Length[0] SHL 8) + IPPacket.Length[1]) - ($00 + (IPPacket.VersionHeadLen AND $0F));
          Move(IPPacket.Data,Packet,Length);
     END;
     IF Index = IP THEN
     BEGIN
          Packet.DataLen := Length - (Get4BitHigh(Packet.HeaderLen) * 4);
          Packet.OptionLen := (Get4BitHigh(Packet.HeaderLen) * 4) - 20;
          IF Packet.OptionLen = 0 THEN
              Packet.NO_option := TRUE
          ELSE
          BEGIN
              Packet.NO_option := FALSE;
              FOR J:=0 TO Packet.OptionLen -1 DO
              BEGIN
                   Packet.OptionData[J] := Packet.Data[J];
                   Packet.Data[J] := Packet.Data[Packet.OptionLen + J];
              END;
          END;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE GetUDP;                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Get UDP packet from layer 3 frame                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE GetUDP(Index : integer;VAR Packet : TUDPPacket);
VAR       Length : Word;
BEGIN
     IF Index = IP THEN
     BEGIN
          Length := ((IPPacket.Length[0] SHL 8) + IPPacket.Length[1]) - ($00 + (IPPacket.VersionHeadLen AND $0F));
          Move(IPPacket.Data,Packet,Length);
          Packet.DataLen := Length - 8;
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayRawData;                                            บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Display raw data                                   บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}

{PROCEDURE DisplayRawData(Data : TRawData; Length, Line : integer);
VAR       K,L : integer;
          TempData : ARRAY [00..1524] OF Char;
          xpos : integer;
BEGIN
     settextstyle(2,horizdir,4);
     outtextXY(__X+5,Incr(Line),'Data :');
     K := 0;
     L := 0;
     Move(Data,TempData,Length);
      WHILE (K <= Length-16) DO
      BEGIN
          xpos:=50;
          outtextxy(xpos,Incr(Line),WordToHexASCII(L*16));
          Inc(L);
          Inc(xpos,42);
          FOR J:= 1 TO 8 DO
          BEGIN
                outtextxy(xpos,Line,ByteToHexASCII(Data[K]));
                Inc(K);
                Inc(xpos,20);
          END;
          Inc(xpos,20);
          FOR J:= 1 TO 8 DO
          BEGIN
                outtextxy(xpos,Line,' '+ByteToHexASCII(Data[K]));
                Inc(K);
                Inc(xpos,20);
          END;
          xpos := 462;
          I := K-16;
          FOR J:= 1 TO 16 DO
          BEGIN
               CASE TempData[I] OF
                    ' '..'~' : outtextxy(xpos,Line,TempData[I])
               ELSE
                   outtextxy(xpos,Line,'.')
               END;
               Inc(I);
               Inc(xpos,7);
          END;
      END;
END;
}

PROCEDURE DisplayRawData(Data : TRawData; Length, Line : integer);
VAR       K,L,cnt : integer;
          TempData : ARRAY [00..1524] OF Char;
          xpos : integer;
BEGIN
     settextstyle(2,horizdir,4);
     outtextXY(__X+5,Incr(Line),'Data :');
     K := 0;
     L := 0;
     If Length > 0 then
     begin
     Move(Data,TempData,Length);
      WHILE (K <= Length-16) DO
      BEGIN
          xpos:=50;
		  cnt := 0;
          outtextxy(xpos,Incr(Line),WordToHexASCII(L*16));
          Inc(L);
          Inc(xpos,42);
          FOR J:= 1 TO 8 DO
          BEGIN
			   If K <= Length-16 then
				begin
                outtextxy(xpos,Line,ByteToHexASCII(Data[K]));
                Inc(K);
                Inc(xpos,20);
				Inc(cnt);
                end;
          END;
          Inc(xpos,20);
          FOR J:= 1 TO 8 DO
          BEGIN
		  	   If K <= Length-16 then
				begin
                outtextxy(xpos,Line,' '+ByteToHexASCII(Data[K]));
                Inc(K);
                Inc(xpos,20);
				Inc(cnt);
				end;
          END;
          xpos := 462;
          I := K-cnt;
          FOR J:= 1 TO cnt DO
          BEGIN
               CASE TempData[I] OF
                    ' '..'~' : outtextxy(xpos,Line,TempData[I])
               ELSE
                   outtextxy(xpos,Line,'.')
          END;
               Inc(I);
               Inc(xpos,7);
          END;
      END;
     end;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE Analysis;                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Analysis packet from capture file                  บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE Analysis;
VAR  done : boolean;
BEGIN
     done := TRUE;
     fer_tip := 5;
     muta_fer:= false;

     w.hide;
     w.newwin(0,25,getmaxx,450,'Protocol Analysis',true);
     w.show;

     Assign(tFile2,'test.Hed');            { Open Data File For Flush Data }
     {$I-} Reset(tFile2); {$I+}
     IF (IOResult <> 00) THEN
     BEGIN
       w.dispmsg(' Error ','Can not open file,please check it !');
       repeat
             w.handleevent;
       until cm=2;
       w.clrwin(1);
       Exit;
     END;

     If not Eof(tFile2) THEN Read(tFile2, HeaderFile);
     close(tFile2);

     Assign(tFile,'test.Cap');            { Open Data File For Flush Data }
     {$I-} Reset(tFile); {$I+}
     IF (IOResult <> 00) THEN
     BEGIN
       w.dispmsg(' Error ','Can not open file,please check it !');
       repeat
             w.handleevent;
       until cm=2;
       w.clrwin(1);
       Exit;
     END;

     I := 0;
     K := 0;
     REPEAT
           IF done THEN
           BEGIN
                IF NOT EOF(tFile) THEN
                BEGIN
                     Read(tFile, tPacket);
                     Inc(K);
                     Line := 55;
                     w.fill(10,55,getmaxx-10,440,10,1);
                END;

                Move(tPacket,VerPacket,tPacket.Length);
                Move(tPacket,VerHeader,Sizeof(VerHeader));
                VerifyPacket(IndexL2,IndexL3,IndexL4,IndexUL);

                settextstyle(2,horizdir,4);
                outtextXY(__X+50,Incr(Line),'Packet Number : '+int2str(K));
                Incr(Line);
                CASE IndexL2 OF
                     EthernetII    : BEGIN
                                          Move(tPacket,EtherFrame,tPacket.Length);
                                          { Display protocol information }
                                          outtextXY(__X+5,Incr(Line),'Layer 2 : --------- Ethernet II ----------');
                                          outtextXY(__X+20,Incr(Line),'Network Address : '
                                          + GetEthernetAddress(EtherFrame.MAC.SourceAddr)+ ' ----> '
                                          + GetEthernetAddress(EtherFrame.MAC.DestAddr));
                                          outtextXY(__X+20,Incr(Line),'Type : 0x'
                                          + WordToHexASCII(SwapWord(EtherFrame.MAC.TypeLen)));
                                     END;
                     Ethernet802_3 : BEGIN
                                          Move(tPacket,EtherFrame,tPacket.Length);
                                          { Display protocol information }
                                          outtextXY(__X+5,Incr(Line),'Layer 2 : --------- Ethernet 802.3 ----------');
                                          outtextXY(__X+20,Incr(Line),'Network Address : '
                                          + GetEthernetAddress(EtherFrame.MAC.SourceAddr)+ ' ----> '
                                          + GetEthernetAddress(EtherFrame.MAC.DestAddr));
                                          outtextXY(__X+20,Incr(Line),'Length : 0x'
                                          + WordToHexASCII(SwapWord(EtherFrame.MAC.TypeLen)));
                                     END;
                     EthernetSNAP  : BEGIN
                                          Move(tPacket,EtherSNAPFrame,tPacket.Length);
                                          { Display protocol information }
                                          outtextXY(__X+5,Incr(Line),'Layer 2 : --------- Ethernet SNAP ----------');
                                          outtextXY(__X+20,Incr(Line),'Network Address : '
                                          + GetEthernetAddress(EtherFrame.MAC.SourceAddr)+ ' ----> '
                                          + GetEthernetAddress(EtherFrame.MAC.DestAddr));
                                          outtextXY(__X+20,Incr(Line),'Length : 0x'
                                          + WordToHexASCII(SwapWord(EtherFrame.MAC.TypeLen)));
                                          outtextXY(__X+5,Incr(Line),'LLC : ----------------------------------');
                                          outtextXY(__X+20,Incr(Line),'DSAP : 0x'+ ByteToHexASCII(EtherSNAPFrame.DSAP));
                                          outtextXY(__X+20,Incr(Line),'SSAP : 0x'+ ByteToHexASCII(EtherSNAPFrame.SSAP));
                                          outtextXY(__X+20,Incr(Line),'Control : 0x'+ ByteToHexASCII(EtherSNAPFrame.Control));
                                          outtextXY(__X+20,Incr(Line),'Organization Code : 0x');
                                          FOR I:=0 TO 2 DO
                                              outtextXY(__X+150+12*i,Line,ByteToHexASCII(EtherSNAPFrame.OrganizeCode[I]));
                                          outtextXY(__X+20,Incr(Line),'Ethernet Type : 0x'
                                          + GetData16ToASCII(EtherSNAPFrame.EtherType));
                                     END;
                     Ethernet802_2 : BEGIN
                                          Move(tPacket,Ether8022Frame,tPacket.Length);
                                          { Display protocol information }
                                          outtextXY(__X+5,Incr(Line),'Layer 2 : --------- Ethernet 802.2 ----------');
                                          outtextXY(__X+20,Incr(Line),'Network Address : '
                                          + GetEthernetAddress(EtherFrame.MAC.SourceAddr)+ ' ----> '
                                          + GetEthernetAddress(EtherFrame.MAC.DestAddr));
                                          outtextXY(__X+20,Incr(Line),'Length : 0x'
                                          + WordToHexASCII(SwapWord(EtherFrame.MAC.TypeLen)));
                                          outtextXY(__X+5,Incr(Line),'LLC : ----------------------------------');
                                          outtextXY(__X+20,Incr(Line),'DSAP : 0x'+ ByteToHexASCII(Ether8022Frame.DSAP));
                                          outtextXY(__X+20,Incr(Line),'SSAP : 0x'+ ByteToHexASCII(Ether8022Frame.SSAP));
                                          outtextXY(__X+20,Incr(Line),'Control : 0x'+ ByteToHexASCII(Ether8022Frame.Control));
                                     END;
                END;
                CASE IndexL3 OF
                     IPX     : BEGIN
                               GetIPX(IndexL2,IPXPacket);
                               outtextXY(__X+5,Incr(Line),'Layer 3 : --------- IPX ----------');
                               outtextXY(__X+20,Incr(Line),'Checksum : 0x'+GetData16ToASCII(IPXPacket.CheckSum));
                               outtextXY(__X+20,Incr(Line),'Length : 0x'+GetData16ToASCII(IPXPacket.Length));
                               outtextXY(__X+20,Incr(Line),'Transport Control : 0x'+ByteToHexASCII(IPXPacket.Transport));
                               outtextXY(__X+20,Incr(Line),'Packet Type : 0x' + ByteToHexASCII(IPXPacket.PacketType));
                               outtextXY(__X+20,Incr(Line),'Network : ' + PrintIP(IPXPacket.SourceNet) +
                                    ' ----> ' + PrintIP(IPXPacket.DestNet));
                               outtextXY(__X+20,Incr(Line),'Host : '+GetEthernetAddress(IPXPacket.SourceHost) +
                                    ' ----> '+GetEthernetAddress(IPXPacket.DestHost));
                               outtextXY(__X+20,Incr(Line),'Socket : 0x'+GetData16ToASCII(IPXPacket.SourceSock) +
                                    ' ----> 0x'+GetData16ToASCII(IPXPacket.DestSock));
                               END;
                     NetBeui : BEGIN
                               END;
                     IP      : BEGIN
                               GetIP(IndexL2,IPPacket);
                               outtextXY(__X+5,Incr(Line),'Layer 3 : --------- IP ----------');
                               outtextXY(__X+20,Incr(Line),'Version : 0x'+ByteToHexASCII(IPPacket.VersionHeadLen SHR 4));
                               outtextXY(__X+20,Incr(Line),'Header Length : 0x' +
                                   ByteToHexASCII(IPPacket.VersionHeadLen AND $0F));
                               outtextXY(__X+20,Incr(Line),'Type Of Service : 0x'+ByteToHexASCII(IPPacket.TOS));
                               outtextXY(__X+20,Incr(Line),'Length : 0x'+GetData16ToASCII(IPPacket.Length));
                               outtextXY(__X+20,Incr(Line),'Identification : 0x'+GetData16ToASCII(IPPacket.ID));
                               outtextXY(__X+20,Incr(Line),'Flag :');
                               Move(IPPacket.Flag,Byt,1);
                               outtextXY(__X+25,Incr(Line),'Rev : '+GetBit(Byt,7)+' . .');
                               outtextXY(__X+25,Incr(Line),' DF : . '+GetBit(Byt,6)+' .');
                               outtextXY(__X+25,Incr(Line),' MF : . . '+GetBit(Byt,5));
                               Move(IPPacket.Flag,tWord,2);
                               ClearBitA(tWord,7);
                               ClearBitA(tWord,6);
                               ClearBitA(tWord,5);
                               outtextXY(__X+20,Incr(Line),'Fragment Offset : 0x'+WordToHexASCII(Swap(tWord)));
                               outtextXY(__X+20,Incr(Line),'Time To Live : 0x'+ByteToHexASCII(IPPacket.TTL));
                               outtextXY(__X+20,Incr(Line),'Protocol : 0x'+ByteToHexASCII(IPPacket.Protocol));
                               outtextXY(__X+20,Incr(Line),'Header Checksum : 0x'+GetData16ToASCII(IPPacket.HeadChksum));
                               outtextXY(__X+20,Incr(Line),'IP Address : '+PrintIP(IPPacket.SourceAddr)+' ----> ' +
                                   PrintIP(IPPacket.DestAddr));
                               IF IPPacket.NO_option THEN
                               outtextXY(__X+20,Incr(Line),'Option : No option')
                               ELSE
                               BEGIN
                                   outtextXY(__X+20,Incr(Line),'Option : ');
                                   Position := -1;
                                   End_Option := FALSE;
                                   WHILE NOT(End_Option) DO
                                   BEGIN
                                        Byt := IPPacket.OptionData[Incr(Position)];
                                        CASE Byt OF
                                             0    : End_Option := TRUE;
                                             1    : BEGIN
                                                    outtextXY(__X+25,Incr(Line),'Type 1 : No operation');
                                                    END;
                                             130  : BEGIN
                                                    outtextXY(__X+25,Incr(Line),'Type 130 : Security');
                                                    outtextXY(__X+25,Incr(Line),'Length : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    outtextXY(__X+25,Incr(Line),'Security : ');
                                                    tWord := IPPacket.OptionData[Incr(Position)] +
                                                             IPPacket.OptionData[Incr(Position)];
                                                    CASE tWord OF
                                                         $0000 : outtextXY(__X+30,Line,'Unclassified');
                                                         $F135 : outtextXY(__X+30,Line,'Confidential');
                                                         $789A : outtextXY(__X+30,Line,'EFTO');
                                                         $BC4D : outtextXY(__X+30,Line,'MMMM');
                                                         $5E26 : outtextXY(__X+30,Line,'PROG');
                                                         $AF13 : outtextXY(__X+30,Line,'Restricted');
                                                         $D788 : outtextXY(__X+30,Line,'Secret');
                                                         $6BC5 : outtextXY(__X+30,Line,'Top Secret');
                                                         $35E2,$9AF1,$4D78,$24BD,$135E,$89AF,$C4D6,$E26B :
                                                                 outtextXY(__X+20,Line,'Reserved');
                                                    ELSE outtextXY(__X+30,Line,'Unknown');
                                                    END;
                                                    Incr(Line);
                                                    tWord := IPPacket.OptionData[Incr(Position)] +
                                                             IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Compartment : '+WordToHexASCII(tWord));
                                                    Incr(Line);
                                                    tWord := IPPacket.OptionData[Incr(Position)] +
                                                             IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Handling Restrictions'+WordToHexASCII(tWord));
                                                    Incr(Line);
                                                    tStr := ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                            ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                            ByteToHexASCII(IPPacket.OptionData[Incr(Position)]);
                                                    outtextXY(__X+25,Line,'Transmission Control Code : '+tStr);
                                                    Incr(Line);
                                                    END;
                                             131  : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Type 131 : Loose Source and Record Route');
                                                    Incr(Line);
                                                    _Length := IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Length : '+ByteToHexASCII(_Length));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Pointer : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Route Data : ');
                                                    FOR I:=1 TO (_Length - 3) DIV 4 DO
                                                    BEGIN
                                                         FOR K:=0 TO 3 DO
                                                             Address[K] := IPPacket.OptionData[Incr(Position)];
                                                         outtextXY(__X+30,Incr(Line),PrintIP(Address));
                                                    END;
                                                    Incr(Line);
                                                    END;
                                             137  : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Type 137 : Strict Source and Record Route');
                                                    Incr(Line);
                                                    _Length := IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Length : '+ByteToHexASCII(_Length));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Pointer : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Route Data : ');
                                                    FOR I:=1 TO (_Length - 3) DIV 4 DO
                                                    BEGIN
                                                         FOR K:=0 TO 3 DO
                                                             Address[K] := IPPacket.OptionData[Incr(Position)];
                                                         outtextXY(__X+30,Incr(Line),PrintIP(Address));
                                                    END;
                                                    Incr(Line);
                                                    END;
                                             7    : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Type 7 : Record Route');
                                                    Incr(Line);
                                                    _Length := IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Length : '+ByteToHexASCII(_Length));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Pointer : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Route Data : ');
                                                    FOR I:=1 TO (_Length - 3) DIV 4 DO
                                                    BEGIN
                                                         FOR K:=0 TO 3 DO
                                                             Address[K] := IPPacket.OptionData[Incr(Position)];
                                                         outtextXY(__X+30,Incr(Line),PrintIP(Address));
                                                    END;
                                                    Incr(Line);
                                                    END;
                                             136  : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Type 136 : Stream Identifier');
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Length : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    tStr := ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                            ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                            ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                            ByteToHexASCII(IPPacket.OptionData[Incr(Position)]);
                                                    outtextXY(__X+25,Line,'Stream ID : '+tStr);
                                                    Incr(Line);
                                                    END;
                                             68   : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Type 68 : Internet Timestamp');
                                                    Incr(Line);
                                                    _Length := IPPacket.OptionData[Incr(Position)];
                                                    outtextXY(__X+25,Line,'Length : '+ByteToHexASCII(_Length));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Pointer : ' +
                                                        ByteToHexASCII(IPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Overflow : '+
                                                        ByteToHexASCII(Get4BitHigh(IPPacket.OptionData[Incr(Position)])));
                                                    Incr(Line);
                                                    outtextXY(__X+25,Line,'Flag : ' +
                                                        ByteToHexASCII(Get4BitLow(IPPacket.OptionData[Position])));
                                                    CASE Get4BitLow(IPPacket.OptionData[Position]) OF
                                                         0   : FOR I:=1 TO (_Length - 4) DIV 4 DO
                                                               BEGIN
                                                               Incr(Line);
                                                               tStr := ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]);
                                                               outtextXY(__X+30,Line,'Timestamp : '+tStr);
                                                               END;
                                                         1,3 : FOR I:=1 TO (_Length - 4) DIV 8 DO
                                                               BEGIN
                                                               Incr(Line);
                                                               FOR K:=0 TO 3 DO
                                                                   Address[K] := IPPacket.OptionData[Incr(Position)];
                                                               outtextXY(__X+30,Line,'Internet Address : '+PrintIP(Address));
                                                               Incr(Line);
                                                               tStr := ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]) +
                                                                       ByteToHexASCII(IPPacket.OptionData[Incr(Position)]);
                                                               outtextXY(__X+30,Line,'Timestamp : '+tStr);
                                                               END;
                                                    END;
                                                    Incr(Line);
                                                    END;
                                        END;
                                   END;
                               END;
                               END;
                     ARP     : BEGIN
                               GetARP(IndexL2,ARPPacket);
                               Incr(Line);
                               outtextXY(__X+5,Line,'Layer 3 : --------- ARP ----------');
                               Incr(Line);
                               outtextXY(__X+20,Line,'Hardware Type : 0x'+GetData16ToASCII(ARPPacket.HWType));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Protocol Type : 0x'+GetData16ToASCII(ARPPacket.ProType));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Hardware Addr Length : 0x'+ByteToHexASCII(ARPPacket.HWAddrLength));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Protocol Addr Length : 0x'+ByteToHexASCII(ARPPacket.ProAddrLength));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Operation Code : 0x'+GetData16ToASCII(ARPPacket.OperateCode));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Hardware Address : '+GetEthernetAddress(ARPPacket.SendHWAddr)+' ----> ' +
                                   GetEthernetAddress(ARPPacket.TargetHWAddr));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Protocol Address : '+PrintIP(ARPPacket.SendProAddr)+' ----> ' +
                                   PrintIP(ARPPacket.TargetProAddr));
                               END;
                     RARP    : BEGIN
                               END;
                     SNMP    : BEGIN
                               END;
                END;
                CASE IndexL4 OF
                     SPX     : BEGIN
                               GetSPX(IndexL3,SPXPacket);
                               Incr(Line);
                               outtextXY(__X+5,Line,'Layer 4 : --------- SPX ----------');
                               Incr(Line);
                               outtextXY(__X+20,Line,'Connection Control : 0x'+ByteToHexASCII(SPXPacket.Control));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Datastream Type : 0x'+ByteToHexASCII(SPXPacket.DataType));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Source Connection ID : 0x'+GetData16ToASCII(SPXPacket.SourceID));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Destination Connection ID : 0x'+GetData16ToASCII(SPXPacket.DestID));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Sequence Number : 0x'+GetData16ToASCII(SPXPacket.SeqNumber));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Acknowledgement Number : 0x'+GetData16ToASCII(SPXPacket.AckNumber));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Allocation Number : 0x'+GetData16ToASCII(SPXPacket.AllocNumber));
                               Incr(Line);
                               { display raw data here }
                               Move(SPXPacket.Data,RawData,SPXPacket.DataLen);
                               DisplayRawData(RawData,SPXPacket.DataLen,Line);
                               END;
                     NCP     : BEGIN
                               GetNCP(IndexL3,NCPPacket);
                               {xxxx}
                               END;
                     NetBios : BEGIN
                               END;
                     ICMP    : BEGIN
                               GetICMP(IndexL3,ICMPPacket);
                               Incr(Line);
                               outtextXY(__X+5,Line,'Layer 4 : --------- ICMP ----------');
                               Incr(Line);
                               outtextXY(__X+20,Line,'Type : 0x'+ByteToHexASCII(ICMPPacket.Type_));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Code : 0x'+ByteToHexASCII(ICMPPacket.Code));
                               Incr(Line);
                               outtextXY(__X+20,Line,'CheckSum : 0x'+GetData16ToASCII(ICMPPacket.ChkSum));
                               CASE ICMPPacket.Type_ OF
                                    0,8        : BEGIN
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Identifier : 0x' +
                                                     GetData16ToASCII(_0_8_15_16Message.ID));
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Sequence Number : 0x' +
                                                     GetData16ToASCII(_0_8_15_16Message.SeqNumber));
                                                 Incr(Line);
                                                 { display data here }
                                                 Move(_0_8_15_16Message.Data,RawData,_0_8_15_16Message.DataLen);
                                                 DisplayRawData(RawData,_0_8_15_16Message.DataLen,Line);
                                                 END;
                                    15,16      : BEGIN
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Identifier : 0x' +
                                                     GetData16ToASCII(_0_8_15_16Message.ID));
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Sequence Number : 0x' +
                                                     GetData16ToASCII(_0_8_15_16Message.SeqNumber));
                                                 END;
                                    3,4,11     : BEGIN
                                                 Incr(Line);
                                                 { display data here }
                                                 Move(_3_4_11Message.Data,RawData,_3_4_11Message.DataLen);
                                                 DisplayRawData(RawData,_3_4_11Message.DataLen,Line);
                                                 END;
                                    13,14      : BEGIN
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Originate Timestamp : 0x' +
                                                     Get32Bit(_13_14Message.Originate));
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Receive Timestamp : 0x' +
                                                     Get32Bit(_13_14Message.Receive));
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Transmit Timestamp : 0x' +
                                                     Get32Bit(_13_14Message.Transmit));
                                                 END;
                                    5          : BEGIN
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Gateway Internet Address : ' +
                                                     PrintIP(_5Message.GatewayAddr));
                                                 Incr(Line);
                                                 { display data here }
                                                 Move(_5Message.Data,RawData,_5Message.DataLen);
                                                 DisplayRawData(RawData,_5Message.DataLen,Line);
                                                 END;
                                    12         : BEGIN
                                                 Incr(Line);
                                                 outtextXY(__X+20,Line,'Pointer : 0x'+ByteToHexASCII(_12Message.Pointer));
                                                 Incr(Line);
                                                 { display data here }
                                                 Move(_12Message.Data,RawData,_12Message.DataLen);
                                                 DisplayRawData(RawData,_12Message.DataLen,Line);
                                                 END;
                               END;
                               END;
                     TCP     : BEGIN
                               GetTCP(IndexL3,TCPPacket);
                               Incr(Line);
                               outtextXY(__X+5,Line,'Layer 4 : --------- TCP ----------');
                               Incr(Line);
                               outtextXY(__X+20,Line,'Source Port : 0x'+GetData16ToASCII(TCPPacket.SourcePort));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Destination Port : 0x'+GetData16ToASCII(TCPPacket.DestPort));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Sequence Number : 0x'+Get32Bit(TCPPacket.SeqNumber));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Acknowledgement Number : 0x'+Get32Bit(TCPPacket.AckNumber));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Header Length : 0x'+ByteToHexASCII(TCPPacket.HeaderLen SHR 4));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Reserve : 0x'+ByteToHexASCII(TCPPacket.HeaderLen AND $0F));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Code Bits : 0x'+ByteToHexASCII(TCPPacket.CodeBits));
                               Byt := TCPPacket.CodeBits;
                               Incr(Line);
                               outtextXY(__X+20,Line,'URG : '+GetBit(Byt,7)+'.  ....');
                               Incr(Line);
                               outtextXY(__X+20,Line,'ACK : .'+GetBit(Byt,6)+'  ....');
                               Incr(Line);
                               outtextXY(__X+20,Line,'PSH : ..  '+GetBit(Byt,3)+'...');
                               Incr(Line);
                               outtextXY(__X+20,Line,'RST : ..  .'+GetBit(Byt,2)+'..');
                               Incr(Line);
                               outtextXY(__X+20,Line,'SYN : ..  ..'+GetBit(Byt,1)+'.');
                               Incr(Line);
                               outtextXY(__X+20,Line,'FIN : ..  ...'+GetBit(Byt,0));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Windows : 0x'+GetData16ToASCII(TCPPacket.Windows));
                               Incr(Line);
                               outtextXY(__X+20,Line,'CheckSum : 0x'+GetData16ToASCII(TCPPacket.ChkSum));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Urgent Pointer : 0x'+GetData16ToASCII(TCPPacket.UrgentPoint));
                               Incr(Line);
                               IF TCPPacket.NO_option THEN
                                  outtextXY(__X+20,Line,'Option : No option')
                               ELSE
                               BEGIN
                                   outtextXY(__X+20,Line,'Option : ');
                                   Position := -1;
                                   End_Option := FALSE;
                                   WHILE NOT(End_Option) DO
                                   BEGIN
                                        Byt := TCPPacket.OptionData[Incr(Position)];
                                        CASE Byt OF
                                             0    : End_Option := TRUE;
                                             1    : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+20,Line,'Kind 1 : No operation');
                                                    Incr(Line);
                                                    END;
                                             2    : BEGIN
                                                    Incr(Line);
                                                    outtextXY(__X+20,Line,'Kind 2 : Maximum Segment Size');
                                                    Incr(Line);
                                                    outtextXY(__X+20,Line,'Length : ' +
                                                        ByteToHexASCII(TCPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    outtextXY(__X+20,Line,'Maximem Segment Size : '+
                                                                   ByteToHexASCII(TCPPacket.OptionData[Incr(Position)]) +
                                                                   ByteToHexASCII(TCPPacket.OptionData[Incr(Position)]));
                                                    Incr(Line);
                                                    END;
                                        END;
                                   END;
                               END;
                               END;
                     UDP     : BEGIN
                               GetUDP(IndexL3,UDPPacket);
                               Incr(Line);
                               outtextXY(__X+5,Line,'Layer 4 : --------- UDP ----------');
                               Incr(Line);
                               outtextXY(__X+20,Line,'Source Port : 0x'+GetData16ToASCII(UDPPacket.SourcePort));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Destination Port : 0x'+GetData16ToASCII(UDPPacket.DestPort));
                               Incr(Line);
                               outtextXY(__X+20,Line,'Length : 0x'+GetData16ToASCII(UDPPacket.Length));
                               Incr(Line);
                               outtextXY(__X+20,Line,'CheckSum : 0x'+GetData16ToASCII(UDPPacket.ChkSum));
                               END;
                END;
                CASE IndexUL OF
                     Telnet  : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- Telnet ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     FTP     : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- FTP ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     FTP_Data: BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- FTP-Data ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     Finger  : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- Finger ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     Rlogin  : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- Rlogin ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     RPC     : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- RPC ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     SMTP    : BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- SMTP ----------');
                               Incr(Line);
                               { display data here }
                               Move(TCPPacket.Data,RawData,TCPPacket.DataLen);
                               DisplayRawData(RawData,TCPPacket.DataLen,Line);
                               END;
                     UDP_SNMP: BEGIN
                               Incr(Line);
                               outtextXY(__X+5,Line,'Upper Layer  : --------- UDP-SNMP ----------');
                               Incr(Line);
                               { display data here }
                               Move(UDPPacket.Data,RawData,UDPPacket.DataLen);
                               DisplayRawData(RawData,UDPPacket.DataLen,Line);
                               END;
                END;
           END;
           done := FALSE;
           IF KeyPressed THEN
           BEGIN
                KEY := ReadKey;
                done := TRUE;
           END;
           RcvLength   :=0;
           PacketCount := 0; { Reset flag that new frames can be received }
     UNTIL (Key = #27) or (I = HeaderFile.RcvPacket+1) or Eof(tFile);
     Key := #0;
     close(tFile);
     w.clrwin(1); cm:=0;
END;

procedure helpoe;
const
     StrFileName = 'anahlp.hlp';
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
     close(fstr);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ          MAIN PROGRAM FOR Ethernet Monitor VERSION 1.00              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
BEGIN
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
     w.newbut(2,2,72,18,'~A~nalysis',4,os2,'');
     w.newbut(72,2,112,18,'~H~elp',4,os2,'');
     w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

     REPEAT
           w.handleevent;
           case cm of
                1 : analysis;
				2 : helpoe;
           end;
     UNTIL cm=3;
     w.clrwin(1);
     w.done;
END.
