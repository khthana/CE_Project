PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G-,I-,L+,N-,O-,R-,S-,V+,X+}

USES   ETHER,PKTDRVR,TIMER,STRINGS,CRT,DOS,INIF,EMS,stringop,grafica,g_applic,util256,graph,mouse;

const  backgroundu:string='porn02.tpi';
       MaxEthernetCapacity = 1250000; { Max. theroetical ethernet capacity }
       DefaultFileName     = 'DATA.DAT';
       FullBlock           = 'Û';
       ElementNum          = PAGESIZE DIV Sizeof(TPacketInfo);
       { Constant use in DisplayFrameSize }
       MinFrameSize   = 64;
       MaxFrameSize   = 1518;

TYPE
{ Type definition use in procedure DisplayFrameSize }
       TFrameSizeTable = RECORD
                               GoodSize : ARRAY [MinFrameSize..MaxFrameSize] OF integer;
                               Small    : integer;
                               Medium   : integer;
                               Large    : integer;
                               Short    : integer;
                               Long     : integer;
                         END;

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
    tall 		 : integer       ;

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

    RcvIEEE802      : TPacketIEEE802;  { record used for IEEE802.3 type }
    RcvNCP          : NCPFrame;
    RcvIPX          : IPXFrame;
    RcvTCP          : TCPFrame;

    RcvEthernetII   : TpacketEtherII;  { record used for Ethernet II type }
    RcvEtherLength  : TpacketEtherII;
    RcvEtherII      : EtherIIFrame;

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

procedure bara(a,b,c,d:integer;color:word);
var  FillInfo: FillSettingsType;
begin
     GetFillSettings(FillInfo);
     setfillstyle(1,color);
     bar(a,b,c,d);
     SetFillStyle(FillInfo.Pattern, FillInfo.Color);
end;

{ !!! =================| End Modules |================= !!!
  !!! ================================================= !!! }

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
 บ PROCEDURE ResetFrameSizeTable;                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Reset frame size counter                           บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ResetFrameSizeTable(VAR FTable : TFrameSizeTable);
VAR       I : integer;
BEGIN
     FOR I := MinFrameSize TO MaxFrameSize DO
     BEGIN
          FTable.GoodSize[I] := 0;
     END;
     FTable.Small := 0;
     FTable.Medium := 0;
     FTable.Large := 0;
     FTable.Short := 0;
     FTable.Long  := 0;
END;

procedure all(a,b,c,d:integer;e:boolean);{display all button}
begin
	 w.btin1(a,b,c,d,'',10,10,e);
	 w.writetext(a+21,b+11,'A',e,4);
	 w.writetext(a+34,b+11,'ll',e,0);
end;

procedure medium(a,b,c,d:integer;e:boolean);{display medium}
begin
	 w.btin1(a,b,c,d,'',10,10,e);
	 w.writetext(a+10,b+11,'M',e,4);
	 w.writetext(a+34,b+11,'edium',e,0);
end;

procedure small(a,b,c,d:integer;e:boolean);{display small}
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+15,b+11,'S',e,4);
     w.writetext(a+35,b+11,'mall',e,0);
end;

procedure large(a,b,c,d:integer;e:boolean);{display large}
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+16,b+11,'L',e,4);
     w.writetext(a+34,b+11,'arge',e,0);
end;

procedure detail(a,b,c,d:integer;e:boolean);{display detail}
begin
     w.btin1(a,b,c,d,'',10,10,e);
     w.writetext(a+12,b+11,'D',e,4);
     w.writetext(a+34,b+11,'etail',e,0);
end;

procedure graphoe(a:integer;var tall:integer);
begin
    case j of
	0..24      :  tall := 384;
	25..49     :  tall := 369;
	50..74     :  tall := 354;
	75..99     :  tall := 339;
	100..124   :  tall := 324;
	125..149   :  tall := 309;
	150..174   :  tall := 294;
	175..199   :  tall := 279;
	200..224   :  tall := 264;
	225..249   :  tall := 249;
	250..274   :  tall := 234;
	275..299   :  tall := 219;
	300..324   :  tall := 204;
	325..349   :  tall := 189;
 	350..374   :  tall := 174;
	375..399   :  tall := 159;
	400..424   :  tall := 144;
	425..449   :  tall := 129;
	450..474   :  tall := 114;
	475..484   :  tall :=  99;
	end;
end;

procedure packet(a,b,c,d:integer);{display packet}
begin
     w.btin1(a,b,c,d,'',10,10,False);
     w.writetext(a+8,b+11,'P',False,4);
     w.writetext(a+32,b+11,'kt',False,0);
end;

procedure initoe;
begin
	 init_graph(85,400,300,20,1,15,30,1,0,0,10,10,1);
     graph_scale(horizdir,horizdir,'%','size');
     w.fill(55,93,77,400,10,1);
     w.texl(45,384,'64-88');
     w.texl(40,369,'89-113');
     w.texl(35,354,'114-138');
     w.texl(35,339,'139-163');
     w.texl(35,324,'164-188');
     w.texl(35,309,'189-213');
     w.texl(35,294,'214-238');
     w.texl(35,279,'239-263');
     w.texl(35,264,'264-288');
     w.texl(35,249,'289-313');
     w.texl(35,234,'314-338');
     w.texl(35,219,'339-363');
     w.texl(35,204,'364-388');
     w.texl(35,189,'389-413');
     w.texl(35,174,'414-438');
     w.texl(35,159,'439-463');
     w.texl(35,144,'464-488');
     w.texl(35,129,'489-513');
     w.texl(35,114,'514-538');
     w.texl(35,99,'539-544');

end;

procedure bytea(a,b,c,d:integer);{display byte}
begin
     w.btin1(a,b,c,d,'',10,10,False);
     w.writetext(a+8,b+11,'B',False,4);
     w.writetext(a+32,b+11,'yt',False,0);
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE DisplayFrameSize;                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Show frame size distribution                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE DisplayFrameSize;
VAR     FrameSizeTable  : TFrameSizeTable;
        TotalPacket     : integer;
        display_mode,old_mode    : byte;
        percent,temp : longint;
        row,col : integer;
BEGIN
     fer_tip := 5;
     muta_fer:= false;
     old_mode:=0;
     display_mode := 0;

     w.hide;
     w.newwin(20,40,620,440,'Frame Size Distribution',true);
     w.writetext(260,80,'Small Size Frames',false,1);
     small(440,110,500,130,False);
	 w.chenar1(520,110,555,130,4,false);
     medium(440,145,500,165,False);
     w.chenar(520,145,555,165);
     large(440,180,500,200,False);
     w.chenar(520,180,555,200);
     detail(440,215,500,235,False);
     w.chenar2(400,95,610,280,false);
     w.chenar2(405,100,605,275,true);
     w.chenar2(400,285,610,400,false);
	 w.chenar2(405,290,605,395,true);
	 all(440,250,500,270,False);
     w.writetext(480,320,'Short Packet :',false,0);
     w.writetext(480,340,'Long Packet  :',false,0);
     w.writetext(480,360,'Total Good Packet :',false,0);
     { disable button }
     w.setbuton(2,false);
     w.setbuton(3,false);
     initoe;
     w.fill(85,95,386,99,1,1);
     w.show;
     { set timer interrupt }
     Timer1.Init(1);
     Timer1.Start;

     { Init frame size counter }
     ResetFrameSizeTable(FrameSizeTable);
     TotalPacket :=0;

     REPEAT
{ -------- check is keyboard pressed? -------------------------------------- }
           IF KeyPressed THEN
           BEGIN
                Key := ReadKey;
                CASE display_mode OF
                0 : case Key of
					'M','m' :
						begin
						  medium(440,145,500,165,True);
						  inc(display_mode);
						end;
                    'L','l' :
                        begin
						  large(440,180,500,200,True);
						  inc(display_mode,2);
                        end;
                    'A','a' :
                        begin
						  all(440,250,500,270,True);
						  inc(display_mode,3);
					    end;
                    'D','d' :
                        begin
						  detail(440,215,500,235,True);
						  inc(display_mode,4);
						end;
                    end;
                1 : case Key of
                     'S','s' :
                        begin
						  small(440,110,500,130,True);
						  dec(display_mode);
						end;
                     'L','l' :
					    begin
						  large(440,180,500,200,True);
						  inc(display_mode);
						end;
                     'A','a' :
                        begin
						  all(440,250,500,270,True);
					      inc(display_mode,2);
						end;
                     'D','d' :
                        begin
						  detail(440,215,500,235,True);
						  inc(display_mode,3);
                        end;
                    end;
                2 : case Key of
                      'S','s' :
                         begin
						   small(440,110,500,130,True);
					       dec(display_mode,2);
						 end;
                      'M','m' :
                         begin
						   medium(440,145,500,165,True);
				   		   dec(display_mode);
						 end;
                      'A','a' :
					     begin
						   all(440,250,500,270,True);
						   inc(display_mode);
						 end;
                      'D','d' :
                         begin
						   detail(440,215,500,235,True);
						   inc(display_mode,2);
						 end;
                    end;
                3 : case Key of
                      'S','s' :
                          begin
							small(500,130,560,150,True);
							dec(display_mode,3);
						  end;
                      'M','m' :
                          begin
							medium(500,165,560,185,True);
							dec(display_mode,2);
						  end;
                      'L','l' :
                          begin
							large(500,200,560,220,True);
							dec(display_mode);
						  end;
                      'D','d' :
                          begin
							detail(500,235,560,255,True);
							inc(display_mode);
						  end;
                    end;
                4 : case Key of
                      'S','s' :
                          begin
							small(440,110,500,130,True);
							dec(display_mode,4);
						  end;
                      'M','m' :
                          begin
							medium(440,145,500,165,True);
							dec(display_mode,3);
						  end;
                      'L','l' :
                          begin
							large(440,180,500,200,True);
							dec(display_mode,2);
						  end;
                      'A','a' :
					      begin
							all(440,250,500,270,True);
							dec(display_mode);
						  end;
                    end;
                END;
           END;

{ -------- Has a packet recieved? ------------------------------------------ }
           IF (PacketCount = 1) THEN
           BEGIN
                CASE RcvLength OF
                     0..59     : Inc(FrameSizeTable.Short);
                     60..544   : BEGIN
                     { RcvLength = 60 not a short packet because when we gotten packet from
                       packet driver we didn't recieve FCS<4 bytes> yet }
                                      Inc(FrameSizeTable.GoodSize[RcvLength+4]);
                                      Inc(FrameSizeTable.Small);
                                      Inc(TotalPacket);
                                 END;
                     545..1029 : BEGIN
                                      Inc(FrameSizeTable.GoodSize[RcvLength+4]);
                                      Inc(FrameSizeTable.Medium);
                                      Inc(TotalPacket);
                                 END;
                     1030..1514: BEGIN
                                 Inc(FrameSizeTable.GoodSize[RcvLength+4]);
                                 Inc(FrameSizeTable.Large);
                                 Inc(TotalPacket);
                                 END;
                ELSE Inc(FrameSizeTable.Long);
                END;
           END;
           PacketCount := 0;
           RcvLength   := 0;
{ -------------------------------------------------------------------------- }

           IF Timer1.Timeout THEN
           BEGIN
                { display }
                case display_mode of
                     0 : begin
                           w.hide;
                           if old_mode <> display_mode then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Frame Size Distribution',true);
                             w.writetext(260,80,'Small Size Frames',false,1);
							 small(440,110,500,130,False);
	 						 w.chenar1(520,110,555,130,4,false);
     						 medium(440,145,500,165,False);
     						 w.chenar(520,145,555,165);
     						 large(440,180,500,200,False);
     						 w.chenar(520,180,555,200);
     						 detail(440,215,500,235,False);
     						 w.chenar2(400,95,610,280,false);
     						 w.chenar2(405,100,605,275,true);
     						 w.chenar2(400,285,610,400,false);
	 						 w.chenar2(405,290,605,395,true);
	 						 all(440,250,500,270,False);
                             w.writetext(480,320,'Short Packets :',false,0);
                             w.writetext(480,340,'Long Packets  :',false,0);
                             w.writetext(480,360,'Total Good Packets :',false,0);
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             initoe;
							 w.fill(85,95,386,99,1,1);
                           end;
                           { reset graph and other values }
                           ref_graph;
						   w.fill(85,95,386,99,1,1);
						   w.chenar1(520,110,555,130,4,false);
     					   w.chenar(520,145,555,165);
     					   w.chenar(520,180,555,200);
                           w.fill(560,315,600,325,10,1);
                           w.fill(560,335,600,345,10,1);
                           w.fill(560,355,600,365,10,1);

                           { display graph and others }
                           for j:=0 to 484 do
                           begin
                               if FrameSizeTable.GoodSize[64+j] > 0 then
                               begin
                                 percent := FrameSizeTable.GoodSize[64+j];
                                 temp := 100*percent mod TotalPacket;
                                 percent := 100*percent div TotalPacket;

                             if temp > (TotalPacket div 2) then inc(percent);
                                 graphoe(j,tall);
								 bara(85,tall-4,85+(3*percent),tall+6,4);
                               end;
                           end;

                           { display percent of Small Frame Size }
                           if FrameSizeTable.Small <> 0 then
                           begin
                             percent := FrameSizeTable.Small;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
							 w.texl(525,120,int2str(percent)+'%');
                           end
                           else w.texl(525,120,'0%');

                           { display percent of Medium Frame Size }
                           if FrameSizeTable.Medium <> 0 then
                           begin
                             percent := FrameSizeTable.Medium;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
							  w.texl(525,155,int2str(percent)+'%');
                           end
                           else w.texl(525,155,'0%');

                           { display percent of Large Frame Size }
                           if FrameSizeTable.Large <> 0 then
                           begin
                             percent := FrameSizeTable.Large;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,190,int2str(percent)+'%');
                           end
                           else w.texl(525,190,'0%');

                           { display general informations }
                           w.texl(580,320,int2str(FrameSizeTable.Short));
                           w.texl(580,340,int2str(FrameSizeTable.Long));
                           w.texl(580,360,int2str(TotalPacket));

                           w.show
                         end;
                     1 : begin
                           w.hide;
                           if old_mode <> display_mode then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Frame Size Distribution',true);
                             w.writetext(260,80,'Medium Size Frames',false,8);
							 small(440,110,500,130,False);
	 						 w.chenar(520,110,555,130);
     						 medium(440,145,500,165,False);
     						 w.chenar1(520,145,555,165,4,False);
     						 large(440,180,500,200,False);
     						 w.chenar(520,180,555,200);
     						 detail(440,215,500,235,False);
     						 w.chenar2(400,95,610,280,false);
     						 w.chenar2(405,100,605,275,true);
     						 w.chenar2(400,285,610,400,false);
	 						 w.chenar2(405,290,605,395,true);
	 						 all(440,250,500,270,False);
                             w.writetext(480,320,'Short Packets :',false,0);
                             w.writetext(480,340,'Long Packets  :',false,0);
                             w.writetext(480,360,'Total Good Packets :',false,0);
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);

                             init_graph(90,400,300,20,1,15,30,1,0,0,10,10,1);
							 w.fill(90,95,391,99,1,1);
     						 graph_scale(horizdir,horizdir,'%','size');
     						 w.fill(55,93,82,400,10,1);
     						 w.texl(40,384,'545-569');
     						 w.texl(40,369,'570-594');
     						 w.texl(40,354,'595-619');
     						 w.texl(40,339,'620-644');
     						 w.texl(40,324,'645-669');
     						 w.texl(40,309,'670-694');
     						 w.texl(40,294,'695-719');
     						 w.texl(40,279,'720-744');
     						 w.texl(40,264,'745-769');
     						 w.texl(40,249,'770-794');
     						 w.texl(40,234,'795-819');
     						 w.texl(40,219,'820-844');
     						 w.texl(40,204,'845-869');
     						 w.texl(40,189,'870-894');
     						 w.texl(40,174,'895-919');
     						 w.texl(40,159,'920-944');
     						 w.texl(40,144,'945-969');
     						 w.texl(40,129,'970-994');
     						 w.texl(35,114,'995-1019');
     						 w.texl(30,99,'1020-1029');
                           end;

                           { reset graph and display }
                           ref_graph;
						   w.fill(90,95,391,99,1,1);
						   w.chenar(520,110,555,130);
     					   w.chenar1(520,145,555,165,4,False);
     					   w.chenar(520,180,555,200);
                           w.fill(560,315,600,325,10,1);
                           w.fill(560,335,600,345,10,1);
                           w.fill(560,355,600,365,10,1);

                           { display graph and others }
                           for j:=0 to 484 do
                           begin
                               if FrameSizeTable.GoodSize[549+j] > 0 then
                               begin
                                 percent := FrameSizeTable.GoodSize[549+j];
                                 temp := 100*percent mod TotalPacket;
                                 percent := 100*percent div TotalPacket;
                                 if temp > (TotalPacket div 2) then inc(percent);
								 graphoe(j,tall);
								 bara(90,tall-4,90+(3*percent),tall+6,4);
                               end;
                           end;

                           { display percent of Medium Frame Size }
                           if FrameSizeTable.Medium <> 0 then
                           begin
                             percent := FrameSizeTable.Medium;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,155,int2str(percent)+'%');
                           end
                           else w.texl(525,155,'0%');

                           { display percent of Small Frame Size }
                           if FrameSizeTable.Small <> 0 then
                           begin
                             percent := FrameSizeTable.Small;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,120,int2str(percent)+'%');
                           end
                           else w.texl(525,120,'0%');

                           { display percent of Large Frame Size }
                           if FrameSizeTable.Large <> 0 then
                           begin
                             percent := FrameSizeTable.Large;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,190,int2str(percent)+'%');
                           end
                           else w.texl(525,190,'0%');

                           { display general informations }
                           w.texl(580,320,int2str(FrameSizeTable.Short));
                           w.texl(580,340,int2str(FrameSizeTable.Long));
                           w.texl(580,360,int2str(TotalPacket));

                           w.show;
                         end;
                     2 : begin
                           w.hide;
                           if old_mode <> display_mode then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Frame Size Distribution',true);
                             w.writetext(260,80,'Large Size Frames',false,9);
							 small(440,110,500,130,False);
	 						 w.chenar(520,110,555,130);
     						 medium(440,145,500,165,False);
     						 w.chenar(520,145,555,165);
     						 large(440,180,500,200,False);
     						 w.chenar1(520,180,555,200,4,False);
     						 detail(440,215,500,235,False);
     						 w.chenar2(400,95,610,280,false);
     						 w.chenar2(405,100,605,275,true);
     						 w.chenar2(400,285,610,400,false);
	 						 w.chenar2(405,290,605,395,true);
	 						 all(440,250,500,270,False);
                             w.writetext(480,320,'Short Packets :',false,0);
                             w.writetext(480,340,'Long Packets  :',false,0);
                             w.writetext(480,360,'Total Good Packets :',false,0);
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);

							 init_graph(95,400,300,20,1,15,30,1,0,0,10,10,1);
							 w.fill(95,95,396,99,1,1);
     						 graph_scale(horizdir,horizdir,'%','size');
     						 w.fill(55,93,87,400,10,1);
     						 w.texl(35,384,'1030-1054');
     						 w.texl(35,369,'1055-1079');
     						 w.texl(35,354,'1080-1104');
     						 w.texl(35,339,'1105-1129');
     						 w.texl(35,324,'1130-1154');
     						 w.texl(35,309,'1155-1179');
     						 w.texl(35,294,'1180-1204');
     						 w.texl(35,279,'1205-1229');
     						 w.texl(35,264,'1230-1254');
     						 w.texl(35,249,'1255-1279');
     						 w.texl(35,234,'1280-1304');
     						 w.texl(35,219,'1305-1329');
     						 w.texl(35,204,'1330-1354');
     						 w.texl(35,189,'1355-1379');
     						 w.texl(35,174,'1380-1404');
     						 w.texl(35,159,'1405-1429');
     						 w.texl(35,144,'1430-1454');
     						 w.texl(35,129,'1455-1479');
     						 w.texl(35,114,'1480-1504');
     						 w.texl(35,99,'1505-1514');

                           end;

                           { reset graph and display }
                           ref_graph;
						   w.fill(95,95,391,99,1,1);
						   w.chenar(520,110,555,130);
     					   w.chenar(520,145,555,165);
     					   w.chenar1(520,180,555,200,4,False);
                           w.fill(560,315,600,325,10,1);
                           w.fill(560,335,600,345,10,1);
                           w.fill(560,355,600,365,10,1);

                           { display graph and others }
                           for j:=0 to 484 do
                           begin
                               if FrameSizeTable.GoodSize[1034+j] <> 0 then
                               begin
                                 percent := FrameSizeTable.GoodSize[1034+j];
                                 temp := 100*percent mod TotalPacket;
                                 percent := 100*percent div TotalPacket;
                                 if temp > (TotalPacket div 2) then inc(percent);
								 graphoe(j,tall);
								 bara(95,tall-4,95+(3*percent),tall+6,4);
                               end;
                           end;

                           { display percent of Large Frame Size }
                           if FrameSizeTable.Large <> 0 then
                           begin
                             percent := FrameSizeTable.Large;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,190,int2str(percent)+'%');
                           end
                           else w.texl(525,190,'0%');

                           { display percent of Small Frame Size }
                           if FrameSizeTable.Small <> 0 then
                           begin
                             percent := FrameSizeTable.Small;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,120,int2str(percent)+'%');
                           end
                           else w.texl(525,120,'0%');

                           { display percent of Medium Frame Size }
                           if FrameSizeTable.Medium <> 0 then
                           begin
                             percent := FrameSizeTable.Medium;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,155,int2str(percent)+'%');
                           end
                           else w.texl(525,155,'0%');

                           { display general informations }
                           w.texl(580,320,int2str(FrameSizeTable.Short));
                           w.texl(580,340,int2str(FrameSizeTable.Long));
                           w.texl(580,360,int2str(TotalPacket));

                           w.show;
                         end;
                     3 : begin
                           w.hide;
                           if old_mode <> display_mode then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Frame Size Distribution',true);
                             w.writetext(260,80,'All Size Frames',false,0);
							 small(500,130,560,150,False);
	 						 w.chenar1(570,130,605,150,7,False);
     						 medium(500,165,560,185,False);
     						 w.chenar1(570,165,605,185,8,False);
     						 large(500,200,560,220,False);
     						 w.chenar1(570,200,605,220,9,False);
     						 detail(500,235,560,255,False);
     						 w.chenar2(30,320,610,430,false);
     						 w.chenar2(35,325,605,425,true);
	 						 all(500,270,560,290,False);
                             w.chenar2(30,320,610,430,false);
                             w.chenar2(35,325,605,425,true);
                             w.writetext(120,340,'Short Packets :',false,0);
                             w.writetext(120,360,'Long Packets  :',false,0);
                             w.writetext(120,380,'Total Good Packets :',false,0);
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);
                             w.setbuton(4,false);

                             init_graph(60,250,3,10,100,15,1,1,0,0,0,10,0);
                             graph_scale(vertdir,horizdir,'size','%');
                           end;

                           { reset graph and display }
                           ref_graph;
						   w.chenar1(570,130,605,150,7,False);
     					   w.chenar1(570,165,605,185,8,False);
     					   w.chenar1(570,200,605,220,9,False);
                           w.fill(190,335,250,345,10,1);
                           w.fill(190,355,250,365,10,1);
                           w.fill(190,375,250,385,10,1);

                           { display graph and percent of Small Frame Size }
                           if FrameSizeTable.Small <> 0 then
                           begin
                             percent := FrameSizeTable.Small;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             bar_graph(1,percent,7);
                             w.texl(575,140,int2str(percent)+'%');
                           end
                           else w.texl(575,140,'0%');

                           { display graph and percent of Medium Frame Size }
                           if FrameSizeTable.Medium <> 0 then
                           begin
                             percent := FrameSizeTable.Medium;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             bar_graph(2,percent,8);
                             w.texl(575,175,int2str(percent)+'%');
                           end
                           else w.texl(575,175,'0%');

                           { display graph and percent of Large Frame Size }
                           if FrameSizeTable.Large <> 0 then
                           begin
                             percent := FrameSizeTable.Large;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             bar_graph(3,percent,9);
                             w.texl(575,210,int2str(percent)+'%');
                           end
                           else w.texl(575,210,'0%');

                           { display general informations }
                           w.texl(220,340,int2str(FrameSizeTable.Short));
                           w.texl(220,360,int2str(FrameSizeTable.Long));
                           w.texl(220,380,int2str(TotalPacket));

                           w.show;
                         end;
                     4 : begin
                           w.hide;
                           if old_mode <> display_mode then
                           begin
                             w.clrwin(1);
                             w.newwin(20,40,620,440,'Frame Size Distribution',true);
                             w.writetext(260,80,'Frame Size in Detail',false,0);
							 small(440,110,500,130,False);
	 						 w.chenar(520,110,555,130);
     						 medium(440,145,500,165,False);
     						 w.chenar(520,145,555,165);
     						 large(440,180,500,200,False);
     						 w.chenar1(520,180,555,200,4,False);
     						 detail(440,215,500,235,False);
     						 w.chenar2(400,95,610,280,false);
     						 w.chenar2(405,100,605,275,true);
     						 w.chenar2(400,285,610,400,false);
	 						 w.chenar2(405,290,605,395,true);
	 						 all(440,250,500,270,False);
                             w.writetext(480,320,'Short Packets :',false,0);
                             w.writetext(480,340,'Long Packets  :',false,0);
                             w.writetext(480,360,'Total Good Packets :',false,0);
                             { disable button }
                             w.setbuton(2,false);
                             w.setbuton(3,false);

                             w.chenar2(60,95,390,400,true);
                             w.fill(60,95,390,400,5,1);
							 w.chenar2(60,95,390,400,false);
							 w.chenar2(65,100,385,395,true);
							 w.chenar2(220,100,225,395,false);
							 w.btin1(100,110,160,130,'',10,10,False);
     						 w.writetext(108,121,'S',False,4);
     						 w.writetext(132,121,'mall',False,0);

                           end;

                           row := 0;
                           col := 0;

                           { reset graph and display }
                           w.fill(60,95,390,400,5,1);
						   w.chenar2(60,95,390,400,false);
						   w.chenar2(65,100,385,395,true);
                           w.chenar2(220,100,225,395,false);
						   w.chenar(520,110,555,130);
     					   w.chenar(520,145,555,165);
     					   w.chenar(520,180,555,200);
                           w.fill(560,315,600,325,10,1);
                           w.fill(560,335,600,345,10,1);
                           w.fill(560,355,600,365,10,1);
						   w.btin1(66,101,142,120,'',10,10,False);
     					   w.writetext(104,112,'Size',False,0);
                           w.btin1(143,101,219,120,'',10,10,False);
     					   w.writetext(181,112,'Packet',False,0);
						   w.btin1(226,101,305,120,'',10,10,False);
     					   w.writetext(264,112,'Size',False,0);
						   w.btin1(306,101,384,120,'',10,10,False);
     					   w.writetext(344,112,'Packet',False,0);

							{ display frame size in detail }
                           for i:=64 to 1518 do
                           begin
                                if FrameSizeTable.GoodSize[i] > 0 then
                                begin    {255}
                                   w.texl(100+col*160,130+row*8,int2str(i));
                                   w.texl(175+col*165,130+row*8,int2str(FrameSizeTable.GoodSize[i]));
                                   inc(row);
                                   if row=25 then
                                   begin
                                     row := 0;
                                     inc(col);
                                   end;
                                end;
                           end;

                           { display percent of Small Frame Size }
                           if FrameSizeTable.Small <> 0 then
                           begin
                             percent := FrameSizeTable.Small;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,120,int2str(percent)+'%');
                           end
                           else w.texl(525,120,'0%');

                           { display percent of Medium Frame Size }
                           if FrameSizeTable.Medium <> 0 then
                           begin
                             percent := FrameSizeTable.Medium;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,155,int2str(percent)+'%');
                           end
                           else w.texl(525,155,'0%');

                           { display percent of Large Frame Size }
                           if FrameSizeTable.Large <> 0 then
                           begin
                             percent := FrameSizeTable.Large;
                             temp := 100*percent mod TotalPacket;
                             percent := 100*percent div TotalPacket;
                             if temp > (TotalPacket div 2) then inc(percent);
                             w.texl(525,190,int2str(percent)+'%');
                           end
                           else w.texl(525,190,'0%');

                           { display general informations }
                           w.texl(580,320,int2str(FrameSizeTable.Short));
                           w.texl(580,340,int2str(FrameSizeTable.Long));
                           w.texl(580,360,int2str(TotalPacket));

                           w.show;
                         end;
                end;

                old_mode:=display_mode;
{                ResetFrameSizeTable(FrameSizeTable);
                TotalPacket := 0;}
                Timer1.Start;
           END;
     UNTIL (event_ch=#27) or (Key=#27);
     Key := #0;
     w.clrwin(1); cm:=0;
     muta_fer := true;
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
     tStr := 'his a test message generate from Ethernet Monitor Version 1.00 Revision A !!!!!';
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

procedure helpoe;
const
     StrFileName = 'framehlp.hlp';
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
     w.newbut(2,2,52,18,'~F~rame',4,os2,'');
     w.newbut(52,2,102,18,'~H~elp',4,os2,'');
     w.newbut(586,2,636,18,'~Q~uit',4,os2,'');

     REPEAT
           w.handleevent;
           case cm of
                1 : displayframesize;
				2 : helpoe;
           end;
     UNTIL cm=3;
     ExitProgram;
END.
