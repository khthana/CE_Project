unit recs2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommInt, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Comm1: TComm;
    OpenButton: TButton;
    ConButton: TButton;
    SetButton: TButton;
    CloseButton: TButton;
    ExitButton: TButton;
    Edit2: TEdit;
    Ch1Button: TButton;
    Ch2Button: TButton;
    Ch3Button: TButton;
    Ch4Button: TButton;
    Ch5Button: TButton;
    Ch6Button: TButton;
    Ch7Button: TButton;
    Ch8Button: TButton;
    Edit1: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label2: TLabel;
    Edit10: TEdit;
    Label4: TLabel;
    DC1Button: TButton;
    DC2Button: TButton;
    Edit11: TEdit;
    Edit12: TEdit;
    Label5: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    SetT1Button: TButton;
    SetT2Button: TButton;
    SetT3Button: TButton;
    UpDown1: TUpDown;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    Timer2: TTimer;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Label20: TLabel;
    Label1: TLabel;
    Timer3: TTimer;
    Edit22: TEdit;

    procedure OpenButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Comm1RxChar(Sender: TObject; Count: Integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure ConButtonClick(Sender: TObject);
    procedure Ch1ButtonClick(Sender: TObject);
    procedure Ch2ButtonClick(Sender: TObject);
    procedure Ch3ButtonClick(Sender: TObject);
    procedure Ch4ButtonClick(Sender: TObject);
    procedure Ch5ButtonClick(Sender: TObject);
    procedure Ch6ButtonClick(Sender: TObject);
    procedure Ch7ButtonClick(Sender: TObject);
    procedure Ch8ButtonClick(Sender: TObject);
    procedure DC1ButtonClick(Sender: TObject);
    procedure DC2ButtonClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure Comm1Ring(Sender: TObject);
    procedure Comm1Dsr(Sender: TObject);
    procedure Comm1Cts(Sender: TObject);
    procedure Comm1Break(Sender: TObject);
    procedure Comm1Error(Sender: TObject; Errors: Integer);
    procedure SetButtonClick(Sender: TObject);
    procedure Comm1Rlsd(Sender: TObject);
    procedure Comm1RxFlag(Sender: TObject);
    procedure Comm1TxEmpty(Sender: TObject);
    procedure SetT1ButtonClick(Sender: TObject);
    procedure SetT2ButtonClick(Sender: TObject);
    procedure SetT3ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
  private
    { Private declarations }
//    function getBuffer : char;
//    procedure putBuffer(ch : char);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  openx,operate : boolean;
  FCurrentLIne : integer;
  QBuffer : array [0..4097] of char;
  head,tail : integer;
  tline : integer;
  tstage : integer;
  Pass : array [0..10] of char;
  pp : integer;

implementation

uses rseting, password;

{$R *.DFM}

procedure TForm1.OpenButtonClick(Sender: TObject);
var bufx : string;
begin
     head := 0;
     tail := 0;
     tstage := 0;
     Comm1.Open;
     openx := true;
     bufx := 'ats0=1' +chr(13) + chr(10);
     Comm1.write(bufx[1],length(bufx));
     OpenButton.Enabled := False;
     SetButton.Enabled := False;
     ConButton.Enabled := True;
     ConButton.SetFocus;
end;

procedure TForm1.CloseButtonClick(Sender: TObject);
begin
     Openx := false;
     Comm1.Close;
     OpenButton.Enabled := true;
     SetButton.Enabled := True;
     ConButton.Enabled := false;
     OpenButton.Enabled := True;
     Ch1Button.Enabled := False;
     Ch2Button.Enabled := False;
     Ch3Button.Enabled := False;
     Ch4Button.Enabled := False;
     Ch5Button.Enabled := False;
     Ch6Button.Enabled := False;
     Ch7Button.Enabled := False;
     Ch8Button.Enabled := False;
     DC1Button.Enabled := False;
     DC2Button.Enabled := False;
     SetT1Button.Enabled := False;
     SetT2Button.Enabled := False;
     SetT3Button.Enabled := False;
     //Button.Enabled := False;
     Timer1.Enabled := False;
     Label5.Visible := False;

end;

procedure TForm1.Comm1RxChar(Sender: TObject; Count: Integer);
var
    Buffer : array[0..1024] of Char;
//    bytesx : shortint;
    P,bytes : integer;
//    temp   : shortint;
begin
    Fillchar(Buffer, Sizeof(Buffer), 0);
    bytes := 0;
    if (openx) then
      bytes :=  Comm1.Read(Buffer,Count);
    for P := 0 to Bytes do
    begin
      if (head = 4096) then head := 0 else inc(head);
      Qbuffer[head] := Buffer[P];
{      case Buffer[P] of
        #10: begin
               Memo1.Lines[FCurrentLine] := Memo1.Lines[FCurrentLine] + 'x';
               Memo1.Lines.add('');
               Inc(FCurrentLine);
             end;
        #13: begin
               Memo1.Lines[FCurrentLine] := Memo1.Lines[FCurrentLine] + 'y';
             end;
        #0:  begin
               Memo1.Lines[FCurrentLine] := Memo1.Lines[FCurrentLine] + 'z';
             end;
        else
        begin
          Memo1.Lines[FCurrentLine] := Memo1.Lines[FCurrentLine] + Buffer[P];
          Memo1.Refresh;
        end;
      end;}
    end;
end;

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
     Close;
end;

procedure TForm1.ConButtonClick(Sender: TObject);
var Bufs : string;
begin
     ConButton.Enabled := false;
     bufs := 'ATDT' + Edit2.text + chr(13) +chr(10);
     Comm1.write(bufs[1],length(bufs));
     Timer1.Enabled := True;
end;

procedure TForm1.Ch1ButtonClick(Sender: TObject);
var S : string;
begin
     S := ':&C1';
     Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch2ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C2';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch3ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C3';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch4ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C4';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch5ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C5';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch6ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C6';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch7ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C7';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.Ch8ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C8';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.DC1ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C9';
  Comm1.write(S[1],Length(S));
end;

procedure TForm1.DC2ButtonClick(Sender: TObject);
var S : string;
begin
  S := ':&C0';
  Comm1.write(S[1],Length(S));
end;
procedure TForm1.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
     if (openx) then
          Comm1.Write(Key,1);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     if (Label5.Visible) then Label5.Visible := False
     else Label5.Visible := True;
end;

procedure TForm1.Comm1Ring(Sender: TObject);
begin
//     Edit10.text := 'Ring';
     Timer1.Enabled := True;
     ConButton.Enabled := False;
//       ConButton.Enabled := False;
end;

procedure TForm1.Comm1Dsr(Sender: TObject);
begin
//      Edit10.text := 'Dsr';
end;

procedure TForm1.Comm1Cts(Sender: TObject);
begin
//     Edit10.Text := 'Cls';
end;

procedure TForm1.Comm1Break(Sender: TObject);
begin
//     Edit10.Text := 'Break';
end;

procedure TForm1.Comm1Error(Sender: TObject; Errors: Integer);
begin
//     Edit10.text := 'Error';
end;

procedure TForm1.SetButtonClick(Sender: TObject);
begin
     Form2.Visible := True;
     Form1.Enabled := False;
end;

procedure TForm1.Comm1Rlsd(Sender: TObject);
var S : string;
begin
 //      Edit10.text := 'Rlsd';
       S := ':&P';
       Comm1.write(S[1],Length(S));
       Form3.edit1.Text := '';
       Form3.Visible := True;
       Form1.Enabled := False;

{     with Form1 do
     begin
       Ch1Button.Enabled := True;
       Ch2Button.Enabled := True;
       Ch3Button.Enabled := True;
       Ch4Button.Enabled := True;
       Ch5Button.Enabled := True;
       Ch6Button.Enabled := True;
       Ch7Button.Enabled := True;
       Ch8Button.Enabled := True;
       DC1Button.Enabled := True;
       DC2Button.Enabled := True;
       SetT1Button.Enabled := True;
       SetT2Button.Enabled := True;
       SetT3Button.Enabled := True;

       Timer1.Enabled := False;
       Label5.Visible := False;
       ConButton.Enabled := False;
       S := ':&Y';
       Comm1.write(S[1],Length(S));
       Ch1Button.SetFocus;
     end;}
  
end;

procedure TForm1.Comm1RxFlag(Sender: TObject);
begin
//     Edit10.text := 'RxFlag';
end;

procedure TForm1.Comm1TxEmpty(Sender: TObject);
begin
//     Edit10.Text := 'TxEmpty';
end;

procedure TForm1.SetT1ButtonClick(Sender: TObject);
var S : string;
begin
     S := ':&S1' + chr(strtoint(Edit16.text) *2);
     Comm1.write(S[1],Length(S));
end;

procedure TForm1.SetT2ButtonClick(Sender: TObject);
var S : string;
begin
     S := ':&S2' + chr(strtoint(Edit17.text) *2);
     Comm1.write(S[1],Length(S));
end;

procedure TForm1.SetT3ButtonClick(Sender: TObject);
var S : string;
begin
     S := ':&S3' + chr(strtoint(Edit18.text) *2);
     Comm1.write(S[1],Length(S));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     head := 0;
     tail := 0;
     tstage := 0;
     tline := 0;
     pp := 0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var data : char;
    temp,bytesx : shortint;
begin
     if not (head = tail) then
     begin
       if (tail = 4096) then tail := 0 else inc(tail);
         data := QBuffer[tail];
       Qbuffer[tail] := #0;
//       memo1.Lines[tline] := memo1.Lines[tline] + data;
       case tstage  of
         0 : if (data = ':') then tstage := 1;
         1 : if (data = '@') then tstage := 2 else begin tstage := 0; end;
         2 : case data of
               'K' : tstage := 3;
               'E' : tstage := 5;
               'T' : tstage := 7;
               'X' : tstage := 11;
               'S' : tstage := 15;
               'B' : tstage := 23;
               'p' : begin tstage := 24; pp := 0; end; 
               'Z' : begin tstage := 0; Label1.Visible := True; end;
               else begin tstage := 0; end;
             end;
         3 : begin
               if (data = #0) then tstage := 19 else
               if (data = '2') then tstage := 20 else
               begin
                 bytesx := byte(data);
                 temp := bytesx and 1;
                 if (temp <> 0) then Edit1.Text := 'ON' else Edit1.Text := 'OFF';
                 temp := bytesx and 2;
                 if (temp <> 0) then Edit3.Text := 'ON' else Edit3.Text := 'OFF';
                 temp := bytesx and 4;
                 if (temp <> 0) then Edit4.Text := 'ON' else Edit4.Text := 'OFF';
                 temp := bytesx and 8;
                 if (temp <> 0) then Edit5.Text := 'ON' else Edit5.Text := 'OFF';
                 temp := bytesx and 16;
                 if (temp <> 0) then Edit6.Text := 'ON' else Edit6.Text := 'OFF';
                 temp := bytesx and 32;
                 if (temp <> 0) then Edit7.Text := 'ON' else Edit7.Text := 'OFF';
                 temp := bytesx and 64;
                 if (temp <> 0) then Edit8.Text := 'ON' else Edit8.Text := 'OFF';
                 temp := bytesx and 128;
                 if (temp <> 0) then Edit9.Text := 'ON' else Edit9.Text := 'OFF';
                 if (bytesx = 0) then
                 begin
                   label6.Visible := False;
                   label7.Visible := False;
                   label8.Visible := False;
                   label9.Visible := False;
                   label10.Visible := False;
                   label11.Visible := False;
                   label12.Visible := False;
                   label13.Visible := False;
                 end;
                 tstage := 4;
               end;
             end;
         4 : begin
               bytesx := byte(data);
               temp := bytesx and 1;
               if (temp <> 0) then Edit11.Text := 'ON' else Edit11.Text := 'OFF';
               temp := bytesx and 2;
               if (temp <> 0) then Edit12.Text := 'ON' else Edit12.Text := 'OFF';
               begin tstage := 0; end;
             end;
         5 : begin
               if (data = #0) then tstage := 21 else
               if (data = '2') then tstage := 22 else
               begin
               tstage := 6;
               bytesx := byte(data);
               temp := bytesx and 1;
               Label6.Visible := temp <> 0;
               temp := bytesx and 2;
               Label7.Visible := temp <> 0;
               temp := bytesx and 4;
               Label8.Visible := temp <> 0;
               temp := bytesx and 8;
               Label9.Visible := temp <> 0;
               temp := bytesx and 16;
               Label10.Visible := temp <> 0;
               temp := bytesx and 32;
               Label11.Visible := temp <> 0;
               temp := bytesx and 64;
               Label12.Visible := temp <> 0;
               temp := bytesx and 128;
               Label13.Visible := temp <> 0;
               end;
             end;
         6 : begin tstage := 0; end;
         7 : case data of
               '1' : tstage := 8;
               '2' : tstage := 9;
               '3' : tstage := 10;
               else tstage := 7;
             end;
         8 : begin
               temp := byte(data) div 2;
               bytesx := byte(data) and 1;
               Edit13.Font.Color := clBlack;
               if (bytesx = 0) then
                 Edit13.Text := inttostr(temp)+'.0'
               else
                 Edit13.Text := inttostr(temp)+'.5';
               tstage := 0;
             end;
         9 : begin
               temp := byte(data) div 2;
               bytesx := byte(data) and 1;
               Edit14.Font.Color := clBlack;
               if (bytesx = 0) then
                 Edit14.Text := inttostr(temp)+'.0'
               else
                 Edit14.Text := inttostr(temp)+'.5';
               tstage := 0;
             end ;
         10 : begin
                temp := byte(data) div 2;
                bytesx := byte(data) and 1;
                Edit15.Font.Color := clBlack;
                if (bytesx = 0) then
                  Edit15.Text := inttostr(temp)+'.0'
                else
                  Edit15.Text := inttostr(temp)+'.5';
                tstage := 0;
             end ;
         11 : case data of
                '1' : tstage := 12;
                '2' : tstage := 13;
                '3' : tstage := 14;
                else tstage := 11;
              end;
         12 : begin
                temp := byte(data) div 2;
                bytesx := byte(data) and 1;
                Edit13.Font.Color := clRed;
                if (bytesx = 0) then
                  Edit13.Text := inttostr(temp)+'.0'
                else
                  Edit13.Text := inttostr(temp)+'.5';
                tstage := 0;
              end ;
         13 : begin
                temp := byte(data) div 2;
                bytesx := byte(data) and 1;
                Edit14.Font.Color := clRed;
                if (bytesx = 0) then
                  Edit14.Text := inttostr(temp)+'.0'
                else
                  Edit14.Text := inttostr(temp)+'.5';
                tstage := 0;
              end ;
         14 : begin
                temp := byte(data) div 2;
                bytesx := byte(data) and 1;
                Edit15.Font.Color := clRed;
                if (bytesx = 0) then
                  Edit15.Text := inttostr(temp)+'.0'
                else
                  Edit15.Text := inttostr(temp)+'.5';
                tstage := 0;  
              end ;
         15 : begin
                case data of
                  '1' : tstage := 16;
                  '2' : tstage := 17;
                  '3' : tstage := 18;
                  else tstage := 15;
                end;
              end;
         16 : begin
               if (data <> #0) then begin
                 temp := byte(data) div 2;
                 UpDown1.Position := temp;
                 Edit16.text := inttostr(temp);
                 tstage := 0;
               end;
              end;
         17 : begin
               if (data <> #0) then begin
                 temp := byte(data) div 2;
                 UpDown2.Position := temp;
                 Edit17.text := inttostr(temp);
                 tstage := 0;
               end;
              end;
         18 : begin
               if (data <> #0) then begin
                 temp := byte(data) div 2;
                 UpDown3.Position := temp;
                 Edit18.text := inttostr(temp);
                 tstage := 0;
               end;
             end;
         19: begin
               if (data = '2') then tstage := 20 else
                 begin
                 bytesx := byte(data);
                 temp := bytesx and 1;
                 if (temp <> 0) then Edit1.Text := 'ON' else Edit1.Text := 'OFF';
                 temp := bytesx and 2;
                 if (temp <> 0) then Edit3.Text := 'ON' else Edit3.Text := 'OFF';
                 temp := bytesx and 4;
                 if (temp <> 0) then Edit4.Text := 'ON' else Edit4.Text := 'OFF';
                 temp := bytesx and 8;
                 if (temp <> 0) then Edit5.Text := 'ON' else Edit5.Text := 'OFF';
                 temp := bytesx and 16;
                 if (temp <> 0) then Edit6.Text := 'ON' else Edit6.Text := 'OFF';
                 temp := bytesx and 32;
                 if (temp <> 0) then Edit7.Text := 'ON' else Edit7.Text := 'OFF';
                 temp := bytesx and 64;
                 if (temp <> 0) then Edit8.Text := 'ON' else Edit8.Text := 'OFF';
                 temp := bytesx and 128;
                 if (temp <> 0) then Edit9.Text := 'ON' else Edit9.Text := 'OFF';
                 if (bytesx = 0) then
                 begin
                   label6.Visible := False;
                   label7.Visible := False;
                   label8.Visible := False;
                   label9.Visible := False;
                   label10.Visible := False;
                   label11.Visible := False;
                   label12.Visible := False;
                   label13.Visible := False;
                 end;
                 tstage := 4;
                 end;
               end;
         20: begin
               if (data = '1') then data := #17;
               if (data = '3') then data := #19;
                 bytesx := byte(data);
                 temp := bytesx and 1;
                 if (temp <> 0) then Edit1.Text := 'ON' else Edit1.Text := 'OFF';
                 temp := bytesx and 2;
                 if (temp <> 0) then Edit3.Text := 'ON' else Edit3.Text := 'OFF';
                 temp := bytesx and 4;
                 if (temp <> 0) then Edit4.Text := 'ON' else Edit4.Text := 'OFF';
                 temp := bytesx and 8;
                 if (temp <> 0) then Edit5.Text := 'ON' else Edit5.Text := 'OFF';
                 temp := bytesx and 16;
                 if (temp <> 0) then Edit6.Text := 'ON' else Edit6.Text := 'OFF';
                 temp := bytesx and 32;
                 if (temp <> 0) then Edit7.Text := 'ON' else Edit7.Text := 'OFF';
                 temp := bytesx and 64;
                 if (temp <> 0) then Edit8.Text := 'ON' else Edit8.Text := 'OFF';
                 temp := bytesx and 128;
                 if (temp <> 0) then Edit9.Text := 'ON' else Edit9.Text := 'OFF';
                 if (bytesx = 0) then
                 begin
                   label6.Visible := False;
                   label7.Visible := False;
                   label8.Visible := False;
                   label9.Visible := False;
                   label10.Visible := False;
                   label11.Visible := False;
                   label12.Visible := False;
                   label13.Visible := False;
                 end;
                 tstage := 4;
              end;
         21 : if (data = '2') then tstage := 22 else
              begin
               tstage := 6;
               bytesx := byte(data);
               temp := bytesx and 1;
               Label6.Visible := temp <> 0;
               temp := bytesx and 2;
               Label7.Visible := temp <> 0;
               temp := bytesx and 4;
               Label8.Visible := temp <> 0;
               temp := bytesx and 8;
               Label9.Visible := temp <> 0;
               temp := bytesx and 16;
               Label10.Visible := temp <> 0;
               temp := bytesx and 32;
               Label11.Visible := temp <> 0;
               temp := bytesx and 64;
               Label12.Visible := temp <> 0;
               temp := bytesx and 128;
               Label13.Visible := temp <> 0;
              end;
         22 : begin
                if (data = '1') then data := #17;
                if (data = '3') then data := #19;
                tstage := 6;
                bytesx := byte(data);
                temp := bytesx and 1;
                Label6.Visible := temp <> 0;
                temp := bytesx and 2;
                Label7.Visible := temp <> 0;
                temp := bytesx and 4;
                Label8.Visible := temp <> 0;
                temp := bytesx and 8;
                Label9.Visible := temp <> 0;
                temp := bytesx and 16;
                Label10.Visible := temp <> 0;
                temp := bytesx and 32;
                Label11.Visible := temp <> 0;
                temp := bytesx and 64;
                Label12.Visible := temp <> 0;
                temp := bytesx and 128;
                Label13.Visible := temp <> 0;
               end;

         23: begin Edit10.text := char(data); tstage := 0; end;
         24 : begin
                if (data = #0) then begin tstage := 0; Edit22.text := Pass; end;
                  Pass[pp] := data;
                  inc(pp);
              end;

       end;
       Edit19.text := inttostr(head);
       Edit20.text := inttostr(tail);
       Edit21.text := inttostr(head - tail);
     end;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
     Edit16.Text := inttostr(UpDown1.position);
end;

procedure TForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
     Edit17.Text := inttostr(UpDown2.position);
end;

procedure TForm1.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
     Edit18.Text := inttostr(UpDown3.position);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
 //    if (Label1.Visible) then Label1.Visible := False
 //    else Label1.Visible := True;
 Label1.Visible := False;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
     Timer3.Enabled := False;
end;

end.
