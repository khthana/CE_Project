UNIT ETHER;
INTERFACE
type
       { 6 Byte ethernet address }
{ ONE 10/1/40 Include IN EMS }
       EthernetAddr = Array[00..05] of Byte;
       Data48       = Array[00..05] of Byte;
       Data32       = Array[00..03] of Byte;
       Data16       = Array[00..01] of Byte;
       Data8        = Array[00..00] of Byte;
       PacketFrame  = Array[00..1524] of Byte;

{ ONE 10/1/40 Include IN EMS }
       MACHeader    = RECORD
                          DestAddr   : EthernetAddr;
                          SourceAddr : EthernetAddr;
                          TypeLen    : Word;
                      END;   { IEEE 802.3 header }

       IPXFrame     = RECORD { IPX Frame }
                       DestAddr    : EthernetAddr;
                       SourceAddr  : EthernetAddr;
                       TypeLen     : Word;
                         CheckSum  : Data16;
                         Length    : Data16;
                         Transport : Data8;
                         PacketType: Data8;
                         DestNet   : Data32;
                         DestHost  : EthernetAddr;
                         DestSock  : Data16;
                         SourceNet : Data32;
                         SourceHost: EthernetAddr;
                         SourceSock: Data16;
                         IPXData   : Array[00..1480] of Byte; {576 Theroetical}
                      END;

       NCPFrame     = RECORD { NCP Packet }
                         RequestType  : Word;
                         SequenceNum  : Word;
                         TaskNumber   : Word;
                         Reserved     : Word;
                         ServiceCode  : Word;
                         NCPData      : Array[00..1480] of Char;
                      END;

       EtherIIFrame = RECORD { Ethernet II Frame }
                      DestAddr     : EthernetAddr;
                      SourceAddr   : EthernetAddr;
                        TypeII     : Data16;
                        Version    : Data8;
                        Typeserv   : Data8;
                        Length     : Data16;
                        Identification : Data16;
                        Flag       : Data16;
                        TTL        : Data8;
                        Protocol   : Data8;
                        HChkSum    : Data16;
                        SourceAdd  : Data32;
                        DestinAdd  : Data32;
                        EtherIIData: Array[00..1490] of Byte; {576 Theroetical}
                      END;

       ICMPFrame    = RECORD
                      DestAddr     : EthernetAddr;
                      SourceAddr   : EthernetAddr;
                        TypeII     : Data16;
                        Version    : Data8;
                        Typeserv   : Data8;
                        Length     : Data16;
                        Identification : Data16;
                        Flag       : Data16;
                        TTL        : Data8;
                        Protocol   : Data8;
                        HChkSum    : Data16;
                        SourceAdd  : Data32;
                        DestinAdd  : Data32;
                        TypeICMP   : Data8;
                        Code       : Data8;
                        Checksum   : Data16;
                        Identifier : Data16;
                        SeqNum     : Data16;
                        ICMPData   : Array[00..31] of Char;
                      END;

       ARPFrame    =  RECORD
                        EthernetII   : Macheader;
                        HardwareType : Data16;
                        ProtocolType : Data16;
                        HardwareAddrL : Data8;
                        ProtocolAddrL : Data8;
                        Operation     : Data16;
                        SourceHardwareAddr : EthernetAddr;
                        IPSourceAddr  : Data32;
                        DestHardwareAddr : EthernetAddr;
                        IPDestAddr    : Data32;
                      END;

       TCPFrame    =  RECORD  {TCP Frame}
                        SourcePort   : Data16;
                        DestPort     : Data16;
                        SequenceNum  : Data32;
                        Acknowledge  : Data32;
                        DataOffset   : Data16;  {Contain Dataoffset + Reserve + Flag}
                        Window       : Data16;
                        CheckSum     : Data16;
                        UrgentPosite : Data16;
                        TCPData      : Array[00..1470] of Char;
                      END;

{ ONE 17/1/40
  REMOVE to Module EMS}
       Time = RECORD { ONE Add 6/1/40}
                Hour   : Word;
                Minute : Word;
                Second : Word;
                Sec100 : Word;
              END;

       TPacketInfo =  RECORD
                        Header : MACHeader;
                        Data   : Array[00..1500] OF Byte;
                        Length : Word; { ONE 6/1/40 }
                        PktTime : Time;
                      END;
       TPacketFile  = File of TPacketInfo; { ONE 6/1/40 }

       FileHeader = RECORD { ONE Add 6/1/40 }
                      StartTime : Time;
                      StopTime  : Time;
                      RunTime   : Time;
                      MyAddr    : EthernetAddr;
                      RcvPacket : Longint;
                      RcvByte   : Longint;
                      Error     : Longint;
                      Lost      : Longint;
                    END;

       THeaderFile = File of FileHeader; { ONE Add 6/1/40 }

       TPacketIEEE802 = RECORD
                           DestAddr    : EthernetAddr;
                           SourceAddr  : EthernetAddr;
                           TypeLen     : Word;
                           CheckSum    : Data16;
                           Length      : Data16;
                           Transport   : Data8;
                           PacketType  : Data8;
                           DestNet     : Data32;
                           DestHost    : EthernetAddr;
                           DestSock    : Data16;
                           SourceNet   : Data32;
                           SourceHost  : EthernetAddr;
                           SourceSock  : Data16;
                           Hour        : Word;
                           Minute      : Word;
                           Second      : Word;
                           Sec100      : Word;
                        END;

       TPacketEtherII = RECORD
                           DestAddr     : EthernetAddr;
                           SourceAddr   : EthernetAddr;
                           TypeII       : Word;

                           Version      : Data8;
                           Typeserv     : Data8;
                           Length       : Data16;
                           Identification : Data16;
                           Flag         : Data16;
                           TTL          : Data8;
                           Protocol     : Data8;
                           HChkSum      : Data16;
                           SourceAdd    : Data32;
                           DestinAdd    : Data32;
                           SourcePort   : Data16;
                           DestPort     : Data16;
                           Hour         : Word;
                           Minute       : Word;
                           Second       : Word;
                           Sec100       : Word;
                        END;

       TSendPacket  =   RECORD
                           DestAddr     : EthernetAddr;
                           SourceAddr   : EthernetAddr;
                           TypeLen      : Word;
                           Data         : ARRAY[01..256] OF Char;
                        END;
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
                       CRCError_S  : Word;
                       CRCError_T  : LongInt;
                       Undersize_S : Word;
                       Undersize_T : LongInt;
                       Oversize_S  : Word;
                       Oversize_T  : LongInt;
                    END;
IMPLEMENTATION
END.
