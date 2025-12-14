PROGRAM Ethernet_Monitor;
{$A+,B-,D+,E-,F+,G-,I-,L+,N-,O-,R-,S-,V+,X+}
{$M $2048 $0 $2048}

USES   CRT,DOS,UI;

VAR

    I,tInt          : Integer;         { Used for handle file operation }

    Menu            : PullDownType;    { Menu Section }
    MenuSelect      : Word;

    Window          : WindowType;      { Window Type }
    C               : Char;            { Temperary Valiable }
    Key             : Char;
    J               : Integer;
    tF              : Text;
    Byt             : Byte;
    tStr,ttStr      : String;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE HideCurSor;                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ HideCurSor                                         บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE HideCurSor;
VAR       pkRegs        :  Registers;
BEGIN
     WITH pkRegs DO
     BEGIN
          AX := $0100;
          CX := $1300;
          Intr($10,pkRegs);
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ShowCurSor;                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ ShowCurSor                                         บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ShowCurSor;
VAR       pkRegs        :  Registers;
BEGIN
     WITH pkRegs DO
     BEGIN
          AX := $0100;
          CX := $1213;
          Intr($10,pkRegs);
     END;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE LoadBackGround                                             บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Load Dune BackGround                               บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE LoadBackGround;
BEGIN
     For I := 0 To 1919 Do
         Mem[$B800:$A0+(I*2)] := 176;
     FOR I := 0 To 1919 Do
         Mem[$B800:$A1+(I*2)] := $07;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ExecFile(CommanLine,Param:String);                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Execute external file                              บ
 บ                 ณ Input : command line and parameter                 บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ExecFile(CommanLine,Param:String);
VAR     Window    : WindowType;
BEGIN
     Window.bX:=1; Window.bY:=1; Window.bW:=80; Window.bH:=25;
     Window.bAttr := 0;
     Window.bBorderAttr:=0;
     Window.bTitleAttr:=0;
     Window.bBStyle:=1;
     Window.sTitle:='';
     WindowOpen(Window);
     TextColor(Yellow);
     GotoXY(35,12);Write('Loading ...');

     SwapVectors;
     Exec(CommanLine,Param);
     SwapVectors;
     IF DosError <> 0 THEN{ Error? }
         WriteLn('Dos error #', DosError)
     ELSE
         WriteLn('Exec successful. ','Child process exit code = ',DosExitCode);
     WindowClose;
END;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ PROCEDURE ExitProgram                                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Description   : ณ Exit Program                                       บ
 ศอออออออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
PROCEDURE ExitProgram;
VAR  DialogRT   : Word;
     DialogPopup : DialogType;
BEGIN
     HideCursor;
     DialogPopup.Init(24,10,32,5,'');
     DialogPopup.AddText(1, 0, 6,1, $70, 'Do you want to EXIT ?');
     DialogPopup.AddButton(2, 0, 7, 3, RetDlgOK, ' OK ', 'Yes, I want to exit.');
     DialogPopup.AddButton(3, 0, 17, 3, RetDlgCancel, 'Cancel', 'No, I don''t');
     DialogRT := DialogPopup.Run;
     IF DialogRT = $FF00 THEN
     BEGIN
          ClrScr;
          WriteLn('ษออออออออออออออออออออออออออออออออออออออออออออออออออออป');
          WriteLn('บ        LAN Monitor & Analysis Version 3.00         บ');
          WriteLn('ฬออออออออออออออออออออออออออออออออออออออออออออออออออออน');
          WriteLn('บ Authorized: Jakaphong Tejachongcharoen ID 37014049 บ');
          WriteLn('บ             Taweesup  Apiwattanapong   ID 37014139 บ');
          WriteLn('ฬออออออออออออออออออออออออออออออออออออออออออออออออออออน');
          WriteLn('บ Advisor   : Thana Hongsuwan                        บ');
          WriteLn('ฬออออออออออออออออออออออออออออออออออออออออออออออออออออน');
          WriteLn('บ        Project of Computer Engineering KMITL       บ');
          WriteLn('บ              Copyright (C) 1997-1998               บ');
          WriteLn('ศออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
          ShowCurSor;
          Halt(0);
     END;
     DialogPopup.Done;
END;


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ          MAIN PROGRAM FOR Ethernet Monitor VERSION 1.00              บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
BEGIN

     {Menu Initial}
     bBStyle  := 1;
     MenuNormAttr := $2f;
     MenuBrightAttr := $24;
     MenuSelectAttr := $70;
     MenuSelectBrightAttr := $7e;
     MenuBorderAttr := $20;

     {Window Initial}
     Window.bX:=0; Window.bY:=0; Window.bW:=79; Window.bH:=24;
     Window.bAttr := 7;
     Window.bBorderAttr:=0;
     Window.bTitleAttr:=0;
     Window.bBStyle:=1;
     Window.sTitle:='';



     ClrScr;
     HideCursor;

     TextColor($e);
     TextBackGround($6);
     GotoXY(1,1);Write('                   LAN Monitor & Analysis Version 3.0                          ');

     LoadBackGround;
     TextBackGround(BLACK);

     REPEAT
           Menu.Init(1,2);
           Menu.Add('&Online' , 1,'Online Monitoring Packet',0);

           Menu.Add('&Conversation       ',11,'Display real time Conversation',1);
           Menu.Add('&Frame size         ',12,'Display Frame Size Distribution',1);
           Menu.Add('&Protocol In Use    ',13,'Display Protocol In Use',1);

           Menu.Add('O&ffline'  , 2,'Offline Monitoring Packet',0);
           Menu.Add('&Capture'  ,21,'Capture Packet',2);
           Menu.Add('Si&ngle'   ,22,'Monitoring specific Node',2);
           Menu.AddBar(23);
           Menu.Add('&Analysis' ,24,'Analysis Buffer',2);

           Menu.Add('F&ind Node', 3,'Find Node on the network',0);

           Menu.Add('&Statistic', 4,'Collect Statistic of network',0);

           Menu.Add('S&etting',5,'Setting INI File',0);
           Menu.Add('&Setup',51,'Setup Value',5);
           Menu.Add('&INI File',52,'Edit INI File',5);
           Menu.Add('&Address Book',53,'Address Book',5);

           Menu.Add('E&xit',7,'Exit Program',0);

           MenuSelect := Menu.Get(C);

           Menu.Done;

           TextColor(WHITE);
           TextBackGround(BLACK);

           Case MenuSelect OF
             1        :;
             11       :       ExecFile('CONOE.EXE','');
             12       :       ExecFile('FRAMEOE2.EXE','');
             13       :       ExecFile('PROOE.EXE','');

             2        :;
             21       :       ExecFile('CAPOE.EXE','');
             22       :	      ExecFile('SINGLE.EXE','');
             23       :;
             24       :       ExecFile('ANAOE.EXE','');

             3        :       ExecFile('FINDOE.EXE','');

             4        :       ExecFile('STATOE6.EXE','');

             5        :;
             51       :       ExecFile('SETFIL.EXE','');
             52       :       ExecFile('Q.EXE','Ether.ini');
             53       :       ExecFile('ADDRESS.EXE','');

             7        :       ExitProgram;
           END;
     UNTIL False;
END.

