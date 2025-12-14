unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ExtCtrls;

type
  TForm8 = class(TForm)
    Edit23: TEdit;
    Panel4: TPanel;
    Shape2: TShape;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Button52: TButton;
    Button53: TButton;
    Edit100: TEdit;
    Edit101: TEdit;
    Edit102: TEdit;
    Button51: TButton;
    Edit103: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button43: TButton;
    Button44: TButton;
    Button45: TButton;
    Button46: TButton;
    Button47: TButton;
    Button48: TButton;
    Button49: TButton;
    Button50: TButton;
    Panel7: TPanel;
    ControlBar2: TControlBar;
    Button102: TButton;
    Button103: TButton;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    ControlBar3: TControlBar;
    Button54: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Query4: TQuery;
    Query1: TQuery;
    Query2: TQuery;
    procedure Button104Click(Sender: TObject);
    procedure Button105Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure Button102Click(Sender: TObject);
    procedure Button103Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure Button41Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure Button46Click(Sender: TObject);
    procedure Button47Click(Sender: TObject);
    procedure Button48Click(Sender: TObject);
    procedure Button49Click(Sender: TObject);
    procedure Button50Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type TArrayTemp = Array [1..20] of string;
     TArrayInt = Array[1..20] of Integer;

var
   Form8: TForm8;
   SeatTemp,SelectTemp : TArrayTemp;
   OrderTemp : TArrayInt;
   i,j,k : integer;
   SeatCount,SelectCount : integer;

implementation

uses Unit6, Unit9;

{$R *.DFM}


procedure TForm8.Button105Click(Sender: TObject);
begin
     If Button1.Caption = 'S' then Button1.Caption := 'N';
     If Button2.Caption = 'S' then Button2.Caption := 'N';
     If Button3.Caption = 'S' then Button3.Caption := 'N';
     If Button4.Caption = 'S' then Button4.Caption := 'N';
     If Button5.Caption = 'S' then Button5.Caption := 'N';
     If Button6.Caption = 'S' then Button6.Caption := 'N';
     If Button7.Caption = 'S' then Button7.Caption := 'N';
     If Button8.Caption = 'S' then Button8.Caption := 'N';
     If Button9.Caption = 'S' then Button9.Caption := 'N';
     If Button10.Caption = 'S' then Button10.Caption := 'N';
     If Button11.Caption = 'S' then Button11.Caption := 'N';
     If Button12.Caption = 'S' then Button12.Caption := 'N';
     If Button13.Caption = 'S' then Button13.Caption := 'N';
     If Button14.Caption = 'S' then Button14.Caption := 'N';
     If Button15.Caption = 'S' then Button15.Caption := 'N';
     If Button16.Caption = 'S' then Button16.Caption := 'N';
     If Button17.Caption = 'S' then Button17.Caption := 'N';
     If Button18.Caption = 'S' then Button18.Caption := 'N';
     If Button19.Caption = 'S' then Button19.Caption := 'N';
     If Button20.Caption = 'S' then Button20.Caption := 'N';
     If Button21.Caption = 'S' then Button21.Caption := 'N';
     If Button22.Caption = 'S' then Button22.Caption := 'N';
     If Button23.Caption = 'S' then Button23.Caption := 'N';
     If Button24.Caption = 'S' then Button24.Caption := 'N';
     If Button25.Caption = 'S' then Button25.Caption := 'N';
     If Button26.Caption = 'S' then Button26.Caption := 'N';
     If Button27.Caption = 'S' then Button27.Caption := 'N';
     If Button28.Caption = 'S' then Button28.Caption := 'N';
     If Button29.Caption = 'S' then Button29.Caption := 'N';
     If Button30.Caption = 'S' then Button30.Caption := 'N';
     If Button31.Caption = 'S' then Button31.Caption := 'N';
     If Button32.Caption = 'S' then Button32.Caption := 'N';
     If Button33.Caption = 'S' then Button33.Caption := 'N';
     If Button34.Caption = 'S' then Button34.Caption := 'N';
     If Button35.Caption = 'S' then Button35.Caption := 'N';
     If Button36.Caption = 'S' then Button36.Caption := 'N';
     If Button37.Caption = 'S' then Button37.Caption := 'N';
     If Button38.Caption = 'S' then Button38.Caption := 'N';
     If Button39.Caption = 'S' then Button39.Caption := 'N';
     If Button40.Caption = 'S' then Button40.Caption := 'N';
     If Button41.Caption = 'S' then Button41.Caption := 'N';
     If Button42.Caption = 'S' then Button42.Caption := 'N';
     If Button43.Caption = 'S' then Button43.Caption := 'N';
     If Button44.Caption = 'S' then Button44.Caption := 'N';
     If Button45.Caption = 'S' then Button45.Caption := 'N';
     If Button46.Caption = 'S' then Button46.Caption := 'N';
     If Button47.Caption = 'S' then Button47.Caption := 'N';
     If Button48.Caption = 'S' then Button48.Caption := 'N';
     If Button49.Caption = 'S' then Button49.Caption := 'N';
     If Button50.Caption = 'S' then Button50.Caption := 'N';
end;

procedure TForm8.Button104Click(Sender: TObject);
begin
     If Button1.Caption = 'N' then Button1.Caption := 'S';
     If Button2.Caption = 'N' then Button2.Caption := 'S';
     If Button3.Caption = 'N' then Button3.Caption := 'S';
     If Button4.Caption = 'N' then Button4.Caption := 'S';
     If Button5.Caption = 'N' then Button5.Caption := 'S';
     If Button6.Caption = 'N' then Button6.Caption := 'S';
     If Button7.Caption = 'N' then Button7.Caption := 'S';
     If Button8.Caption = 'N' then Button8.Caption := 'S';
     If Button9.Caption = 'N' then Button9.Caption := 'S';
     If Button10.Caption = 'N' then Button10.Caption := 'S';
     If Button11.Caption = 'N' then Button11.Caption := 'S';
     If Button12.Caption = 'N' then Button12.Caption := 'S';
     If Button13.Caption = 'N' then Button13.Caption := 'S';
     If Button14.Caption = 'N' then Button14.Caption := 'S';
     If Button15.Caption = 'N' then Button15.Caption := 'S';
     If Button16.Caption = 'N' then Button16.Caption := 'S';
     If Button17.Caption = 'N' then Button17.Caption := 'S';
     If Button18.Caption = 'N' then Button18.Caption := 'S';
     If Button19.Caption = 'N' then Button19.Caption := 'S';
     If Button20.Caption = 'N' then Button20.Caption := 'S';
     If Button21.Caption = 'N' then Button21.Caption := 'S';
     If Button22.Caption = 'N' then Button22.Caption := 'S';
     If Button23.Caption = 'N' then Button23.Caption := 'S';
     If Button24.Caption = 'N' then Button24.Caption := 'S';
     If Button25.Caption = 'N' then Button25.Caption := 'S';
     If Button26.Caption = 'N' then Button26.Caption := 'S';
     If Button27.Caption = 'N' then Button27.Caption := 'S';
     If Button28.Caption = 'N' then Button28.Caption := 'S';
     If Button29.Caption = 'N' then Button29.Caption := 'S';
     If Button30.Caption = 'N' then Button30.Caption := 'S';
     If Button31.Caption = 'N' then Button31.Caption := 'S';
     If Button32.Caption = 'N' then Button32.Caption := 'S';
     If Button33.Caption = 'N' then Button33.Caption := 'S';
     If Button34.Caption = 'N' then Button34.Caption := 'S';
     If Button35.Caption = 'N' then Button35.Caption := 'S';
     If Button36.Caption = 'N' then Button36.Caption := 'S';
     If Button37.Caption = 'N' then Button37.Caption := 'S';
     If Button38.Caption = 'N' then Button38.Caption := 'S';
     If Button39.Caption = 'N' then Button39.Caption := 'S';
     If Button40.Caption = 'N' then Button40.Caption := 'S';
     If Button41.Caption = 'N' then Button41.Caption := 'S';
     If Button42.Caption = 'N' then Button42.Caption := 'S';
     If Button43.Caption = 'N' then Button43.Caption := 'S';
     If Button44.Caption = 'N' then Button44.Caption := 'S';
     If Button45.Caption = 'N' then Button45.Caption := 'S';
     If Button46.Caption = 'N' then Button46.Caption := 'S';
     If Button47.Caption = 'N' then Button47.Caption := 'S';
     If Button48.Caption = 'N' then Button48.Caption := 'S';
     If Button49.Caption = 'N' then Button49.Caption := 'S';
     If Button50.Caption = 'N' then Button50.Caption := 'S';
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
     If Button1.Caption = 'N'
     then begin
          Button1.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A0';
          until SelectTemp[j] = 'A0';
          inc(SeatCount);
          end
     else If Button1.Caption = 'S'
          then begin
               Button1.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A0'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
     If Button2.Caption = 'N'
     then begin
          Button2.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A1';
          until SelectTemp[j] = 'A1';
          inc(SeatCount);
          end
     else If Button2.Caption = 'S'
          then begin
               Button2.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A1'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
     If Button3.Caption = 'N'
     then begin
          Button3.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A2';
          until SelectTemp[j] = 'A2';
          inc(SeatCount);
          end
     else If Button3.Caption = 'S'
          then begin
               Button3.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A2'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button4Click(Sender: TObject);
begin
     If Button4.Caption = 'N'
     then begin
          Button4.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A3';
          until SelectTemp[j] = 'A3';
          inc(SeatCount);
          end
     else If Button4.Caption = 'S'
          then begin
               Button4.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A3'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button5Click(Sender: TObject);
begin
     If Button5.Caption = 'N'
     then begin
          Button5.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A4';
          until SelectTemp[j] = 'A4';
          inc(SeatCount);
          end
     else If Button5.Caption = 'S'
          then begin
               Button5.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A4'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button6Click(Sender: TObject);
begin
     If Button6.Caption = 'N'
     then begin
          Button6.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A5';
          until SelectTemp[j] = 'A5';
          inc(SeatCount);
          end
     else If Button6.Caption = 'S'
          then begin
               Button6.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A5'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button7Click(Sender: TObject);
begin
     If Button7.Caption = 'N'
     then begin
          Button7.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A6';
          until SelectTemp[j] = 'A6';
          inc(SeatCount);
          end
     else If Button7.Caption = 'S'
          then begin
               Button7.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A6'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button8Click(Sender: TObject);
begin
     If Button8.Caption = 'N'
     then begin
          Button8.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A7';
          until SelectTemp[j] = 'A7';
          inc(SeatCount);
          end
     else If Button8.Caption = 'S'
          then begin
               Button8.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A7'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button9Click(Sender: TObject);
begin
    If Button9.Caption = 'N'
     then begin
          Button9.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A8';
          until SelectTemp[j] = 'A8';
          inc(SeatCount);
          end
     else If Button9.Caption = 'S'
          then begin
               Button9.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A8'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button10Click(Sender: TObject);
begin
     If Button10.Caption = 'N'
     then begin
          Button10.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'A9';
          until SelectTemp[j] = 'A9';
          inc(SeatCount);
          end
     else If Button10.Caption = 'S'
          then begin
               Button10.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'A9'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button11Click(Sender: TObject);
begin
     If Button11.Caption = 'N'
     then begin
          Button11.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B0';
          until SelectTemp[j] = 'B0';
          inc(SeatCount);
          end
     else If Button11.Caption = 'S'
          then begin
               Button11.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B0'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button12Click(Sender: TObject);
begin
     If Button12.Caption = 'N'
     then begin
          Button12.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B1';
          until SelectTemp[j] = 'B1';
          inc(SeatCount);
          end
     else If Button12.Caption = 'S'
          then begin
               Button12.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B1'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button13Click(Sender: TObject);
begin
     If Button13.Caption = 'N'
     then begin
          Button13.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B2';
          until SelectTemp[j] = 'B2';
          inc(SeatCount);
          end
     else If Button13.Caption = 'S'
          then begin
               Button13.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B2'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button14Click(Sender: TObject);
begin
     If Button14.Caption = 'N'
     then begin
          Button14.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B3';
          until SelectTemp[j] = 'B3';
          inc(SeatCount);
          end
     else If Button14.Caption = 'S'
          then begin
               Button14.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B3'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button15Click(Sender: TObject);
begin
     If Button15.Caption = 'N'
     then begin
          Button15.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B4';
          until SelectTemp[j] = 'B4';
          inc(SeatCount);
          end
     else If Button15.Caption = 'S'
          then begin
               Button15.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B4'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button16Click(Sender: TObject);
begin
     If Button16.Caption = 'N'
     then begin
          Button16.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B5';
          until SelectTemp[j] = 'B5';
          inc(SeatCount);
          end
     else If Button16.Caption = 'S'
          then begin
               Button16.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B5'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button17Click(Sender: TObject);
begin
     If Button17.Caption = 'N'
     then begin
          Button17.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B6';
          until SelectTemp[j] = 'B6';
          inc(SeatCount);
          end
     else If Button17.Caption = 'S'
          then begin
               Button17.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B6'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button18Click(Sender: TObject);
begin
     If Button18.Caption = 'N'
     then begin
          Button18.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B7';
          until SelectTemp[j] = 'B7';
          inc(SeatCount);
          end
     else If Button18.Caption = 'S'
          then begin
               Button18.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B7'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button19Click(Sender: TObject);
begin
     If Button19.Caption = 'N'
     then begin
          Button19.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B8';
          until SelectTemp[j] = 'B8';
          inc(SeatCount);
          end
     else If Button19.Caption = 'S'
          then begin
               Button19.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B8'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button20Click(Sender: TObject);
begin
     If Button20.Caption = 'N'
     then begin
          Button20.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'B9';
          until SelectTemp[j] = 'B9';
          inc(SeatCount);
          end
     else If Button20.Caption = 'S'
          then begin
               Button20.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'B9'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button21Click(Sender: TObject);
begin
     If Button21.Caption = 'N'
     then begin
          Button21.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C0';
          until SelectTemp[j] = 'C0';
          inc(SeatCount);
          end
     else If Button21.Caption = 'S'
          then begin
               Button21.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C0'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button22Click(Sender: TObject);
begin
     If Button22.Caption = 'N'
     then begin
          Button22.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C1';
          until SelectTemp[j] = 'C1';
          inc(SeatCount);
          end
     else If Button22.Caption = 'S'
          then begin
               Button22.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C1'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button23Click(Sender: TObject);
begin
     If Button23.Caption = 'N'
     then begin
          Button23.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C2';
          until SelectTemp[j] = 'C2';
          inc(SeatCount);
          end
     else If Button23.Caption = 'S'
          then begin
               Button23.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C2'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button24Click(Sender: TObject);
begin
     If Button24.Caption = 'N'
     then begin
          Button24.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C3';
          until SelectTemp[j] = 'C3';
          inc(SeatCount);
          end
     else If Button24.Caption = 'S'
          then begin
               Button24.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C3'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button25Click(Sender: TObject);
begin
     If Button25.Caption = 'N'
     then begin
          Button25.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C4';
          until SelectTemp[j] = 'C4';
          inc(SeatCount);
          end
     else If Button25.Caption = 'S'
          then begin
               Button25.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C4'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button26Click(Sender: TObject);
begin
     If Button26.Caption = 'N'
     then begin
          Button26.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C5';
          until SelectTemp[j] = 'C5';
          inc(SeatCount);
          end
     else If Button26.Caption = 'S'
          then begin
               Button26.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C5'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button27Click(Sender: TObject);
begin
     If Button27.Caption = 'N'
     then begin
          Button27.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C6';
          until SelectTemp[j] = 'C6';
          inc(SeatCount);
          end
     else If Button27.Caption = 'S'
          then begin
               Button27.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C6'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button28Click(Sender: TObject);
begin
     If Button28.Caption = 'N'
     then begin
          Button28.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C7';
          until SelectTemp[j] = 'C7';
          inc(SeatCount);
          end
     else If Button28.Caption = 'S'
          then begin
               Button28.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C7'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button29Click(Sender: TObject);
begin
     If Button29.Caption = 'N'
     then begin
          Button29.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C8';
          until SelectTemp[j] = 'C8';
          inc(SeatCount);
          end
     else If Button29.Caption = 'S'
          then begin
               Button29.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C8'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button30Click(Sender: TObject);
begin
     If Button30.Caption = 'N'
     then begin
          Button30.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'C9';
          until SelectTemp[j] = 'C9';
          inc(SeatCount);
          end
     else If Button30.Caption = 'S'
          then begin
               Button30.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'C9'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button31Click(Sender: TObject);
begin
     If Button31.Caption = 'N'
     then begin
          Button31.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D0';
          until SelectTemp[j] = 'D0';
          inc(SeatCount);
          end
     else If Button31.Caption = 'S'
          then begin
               Button31.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D0'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button32Click(Sender: TObject);
begin
     If Button32.Caption = 'N'
     then begin
          Button32.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D1';
          until SelectTemp[j] = 'D1';
          inc(SeatCount);
          end
     else If Button32.Caption = 'S'
          then begin
               Button32.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D1'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button33Click(Sender: TObject);
begin
     If Button33.Caption = 'N'
     then begin
          Button33.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D2';
          until SelectTemp[j] = 'D2';
          inc(SeatCount);
          end
     else If Button33.Caption = 'S'
          then begin
               Button33.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D2'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button34Click(Sender: TObject);
begin
     If Button34.Caption = 'N'
     then begin
          Button34.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D3';
          until SelectTemp[j] = 'D3';
          inc(SeatCount);
          end
     else If Button34.Caption = 'S'
          then begin
               Button34.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D3'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button35Click(Sender: TObject);
begin
     If Button35.Caption = 'N'
     then begin
          Button35.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D4';
          until SelectTemp[j] = 'D4';
          inc(SeatCount);
          end
     else If Button35.Caption = 'S'
          then begin
               Button35.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D4'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button36Click(Sender: TObject);
begin
     If Button36.Caption = 'N'
     then begin
          Button36.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D5';
          until SelectTemp[j] = 'D5';
          inc(SeatCount);
          end
     else If Button36.Caption = 'S'
          then begin
               Button36.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D5'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button37Click(Sender: TObject);
begin
     If Button37.Caption = 'N'
     then begin
          Button37.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D6';
          until SelectTemp[j] = 'D6';
          inc(SeatCount);
          end
     else If Button37.Caption = 'S'
          then begin
               Button37.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D6'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button38Click(Sender: TObject);
begin
     If Button38.Caption = 'N'
     then begin
          Button38.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D7';
          until SelectTemp[j] = 'D7';
          inc(SeatCount);
          end
     else If Button38.Caption = 'S'
          then begin
               Button38.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D7'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button39Click(Sender: TObject);
begin
     If Button39.Caption = 'N'
     then begin
          Button39.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D8';
          until SelectTemp[j] = 'D8';
          inc(SeatCount);
          end
     else If Button39.Caption = 'S'
          then begin
               Button39.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D8'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button40Click(Sender: TObject);
begin
     If Button40.Caption = 'N'
     then begin
          Button40.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'D9';
          until SelectTemp[j] = 'D9';
          inc(SeatCount);
          end
     else If Button40.Caption = 'S'
          then begin
               Button40.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'D9'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button41Click(Sender: TObject);
begin
     If Button41.Caption = 'N'
     then begin
          Button41.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E0';
          until SelectTemp[j] = 'E0';
          inc(SeatCount);
          end
     else If Button41.Caption = 'S'
          then begin
               Button41.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E0'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button42Click(Sender: TObject);
begin
     If Button42.Caption = 'N'
     then begin
          Button42.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E1';
          until SelectTemp[j] = 'E1';
          inc(SeatCount);
          end
     else If Button42.Caption = 'S'
          then begin
               Button42.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E1'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button43Click(Sender: TObject);
begin
     If Button43.Caption = 'N'
     then begin
          Button43.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E2';
          until SelectTemp[j] = 'E2';
          inc(SeatCount);
          end
     else If Button43.Caption = 'S'
          then begin
               Button43.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E2'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button44Click(Sender: TObject);
begin
     If Button44.Caption = 'N'
     then begin
          Button44.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E3';
          until SelectTemp[j] = 'E3';
          inc(SeatCount);
          end
     else If Button44.Caption = 'S'
          then begin
               Button44.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E3'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button45Click(Sender: TObject);
begin
     If Button45.Caption = 'N'
     then begin
          Button45.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E4';
          until SelectTemp[j] = 'E4';
          inc(SeatCount);
          end
     else If Button45.Caption = 'S'
          then begin
               Button45.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E4'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button46Click(Sender: TObject);
begin
     If Button46.Caption = 'N'
     then begin
          Button46.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E5';
          until SelectTemp[j] = 'E5';
          inc(SeatCount);
          end
     else If Button46.Caption = 'S'
          then begin
               Button46.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E5'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button47Click(Sender: TObject);
begin
     If Button47.Caption = 'N'
     then begin
          Button47.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E6';
          until SelectTemp[j] = 'E6';
          inc(SeatCount);
          end
     else If Button47.Caption = 'S'
          then begin
               Button47.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E6'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button48Click(Sender: TObject);
begin
     If Button48.Caption = 'N'
     then begin
          Button48.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E7';
          until SelectTemp[j] = 'E7';
          inc(SeatCount);
          end
     else If Button48.Caption = 'S'
          then begin
               Button48.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E7'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button49Click(Sender: TObject);
begin
     If Button49.Caption = 'N'
     then begin
          Button49.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E8';
          until SelectTemp[j] = 'E8';
          inc(SeatCount);
          end
     else If Button49.Caption = 'S'
          then begin
               Button49.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E8'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button50Click(Sender: TObject);
begin
     If Button50.Caption = 'N'
     then begin
          Button50.Caption := 'S';
          j := 0;
          Repeat
          inc(j);
          If SelectTemp[j] = ''
          then SelectTemp[j] := 'E9';
          until SelectTemp[j] = 'E9';
          inc(SeatCount);
          end
     else If Button50.Caption = 'S'
          then begin
               Button50.Caption := 'N';
               j := 0;
               Repeat
               inc(j);
               If SelectTemp[j] = 'E9'
               then SelectTemp[j] := '';
               until SelectTemp[j] = '';
               dec(SeatCount);
               end;
end;

procedure TForm8.Button54Click(Sender: TObject);
var  CurRec : integer;
begin
     SeatCount := 0;
     For i := 1 to 20 do
     begin
          SeatTemp[i] := '';
          SelectTemp[i] := '';
          OrderTemp[i] := 0;
     end;
     with query4 do
     begin
          close;
          Params[0].asInteger := StrToInt(Edit21.Text);
          Params[1].asInteger := StrToInt(Edit22.Text);
          Params[2].asInteger := StrToInt(Edit23.Text);
          Params[3].asString := Edit24.Text;
          Params[4].asString := Edit25.Text;
          Params[5].asString := 'false';
          open;

          First;
          CurRec := 0;
          MoveBy(CurRec);
          For i := 1 to RecordCount do
          begin
          SeatTemp[i] := Fields[0].value;
          Next;
          end;
     end;
     ControlBar3.Visible := false;
     //ControlBar1.Visible := True;
     For i := 1 to query4.RecordCount do
     If SeatTemp[i] = 'A0' then Button1.Caption := 'N'
     else If SeatTemp[i] = 'A1' then Button2.Caption := 'N'
     else If SeatTemp[i] = 'A2' then Button3.Caption := 'N'
     else If SeatTemp[i] = 'A3' then Button4.Caption := 'N'
     else If SeatTemp[i] = 'A4' then Button5.Caption := 'N'
     else If SeatTemp[i] = 'A5' then Button6.Caption := 'N'
     else If SeatTemp[i] = 'A6' then Button7.Caption := 'N'
     else If SeatTemp[i] = 'A7' then Button8.Caption := 'N'
     else If SeatTemp[i] = 'A8' then Button9.Caption := 'N'
     else If SeatTemp[i] = 'A9' then Button10.Caption := 'N'
     else If SeatTemp[i] = 'B0' then Button11.Caption := 'N'
     else If SeatTemp[i] = 'B1' then Button12.Caption := 'N'
     else If SeatTemp[i] = 'B2' then Button13.Caption := 'N'
     else If SeatTemp[i] = 'B3' then Button14.Caption := 'N'
     else If SeatTemp[i] = 'B4' then Button15.Caption := 'N'
     else If SeatTemp[i] = 'B5' then Button16.Caption := 'N'
     else If SeatTemp[i] = 'B6' then Button17.Caption := 'N'
     else If SeatTemp[i] = 'B7' then Button18.Caption := 'N'
     else If SeatTemp[i] = 'B8' then Button19.Caption := 'N'
     else If SeatTemp[i] = 'B9' then Button20.Caption := 'N'
     else If SeatTemp[i] = 'C0' then Button21.Caption := 'N'
     else If SeatTemp[i] = 'C1' then Button22.Caption := 'N'
     else If SeatTemp[i] = 'C2' then Button23.Caption := 'N'
     else If SeatTemp[i] = 'C3' then Button24.Caption := 'N'
     else If SeatTemp[i] = 'C4' then Button25.Caption := 'N'
     else If SeatTemp[i] = 'C5' then Button26.Caption := 'N'
     else If SeatTemp[i] = 'C6' then Button27.Caption := 'N'
     else If SeatTemp[i] = 'C7' then Button28.Caption := 'N'
     else If SeatTemp[i] = 'C8' then Button29.Caption := 'N'
     else If SeatTemp[i] = 'C9' then Button30.Caption := 'N'
     else If SeatTemp[i] = 'D0' then Button31.Caption := 'N'
     else If SeatTemp[i] = 'D1' then Button32.Caption := 'N'
     else If SeatTemp[i] = 'D2' then Button33.Caption := 'N'
     else If SeatTemp[i] = 'D3' then Button34.Caption := 'N'
     else If SeatTemp[i] = 'D4' then Button35.Caption := 'N'
     else If SeatTemp[i] = 'D5' then Button36.Caption := 'N'
     else If SeatTemp[i] = 'D6' then Button37.Caption := 'N'
     else If SeatTemp[i] = 'D7' then Button38.Caption := 'N'
     else If SeatTemp[i] = 'D8' then Button39.Caption := 'N'
     else If SeatTemp[i] = 'D9' then Button40.Caption := 'N'
     else If SeatTemp[i] = 'E0' then Button41.Caption := 'N'
     else If SeatTemp[i] = 'E1' then Button42.Caption := 'N'
     else If SeatTemp[i] = 'E2' then Button43.Caption := 'N'
     else If SeatTemp[i] = 'E3' then Button44.Caption := 'N'
     else If SeatTemp[i] = 'E4' then Button45.Caption := 'N'
     else If SeatTemp[i] = 'E5' then Button46.Caption := 'N'
     else If SeatTemp[i] = 'E6' then Button47.Caption := 'N'
     else If SeatTemp[i] = 'E7' then Button48.Caption := 'N'
     else If SeatTemp[i] = 'E8' then Button49.Caption := 'N'
     else If SeatTemp[i] = 'E9' then Button50.Caption := 'N';
     //Edit26.Text := SeatTemp[1];
     //Edit27.Text := SeatTemp[2];
     //Edit28.Text := SeatTemp[3];
end;

procedure TForm8.Button102Click(Sender: TObject);
begin
     For i := 1 to 20 do
     begin
          SeatTemp[i] := '';
          SelectTemp[i] := '';
          OrderTemp[i] := 0;
     end;
     Memo1.Lines.Clear;
     ControlBar3.Visible := True;
     Button1.Caption := '';
     Button2.Caption := '';
     Button3.Caption := '';
     Button4.Caption := '';
     Button5.Caption := '';
     Button6.Caption := '';
     Button7.Caption := '';
     Button8.Caption := '';
     Button9.Caption := '';
     Button10.Caption := '';
     Button11.Caption := '';
     Button12.Caption := '';
     Button13.Caption := '';
     Button14.Caption := '';
     Button15.Caption := '';
     Button16.Caption := '';
     Button17.Caption := '';
     Button18.Caption := '';
     Button19.Caption := '';
     Button20.Caption := '';
     Button21.Caption := '';
     Button22.Caption := '';
     Button23.Caption := '';
     Button24.Caption := '';
     Button25.Caption := '';
     Button26.Caption := '';
     Button27.Caption := '';
     Button28.Caption := '';
     Button29.Caption := '';
     Button30.Caption := '';
     Button31.Caption := '';
     Button32.Caption := '';
     Button33.Caption := '';
     Button34.Caption := '';
     Button35.Caption := '';
     Button36.Caption := '';
     Button37.Caption := '';
     Button38.Caption := '';
     Button39.Caption := '';
     Button40.Caption := '';
     Button41.Caption := '';
     Button42.Caption := '';
     Button43.Caption := '';
     Button44.Caption := '';
     Button45.Caption := '';
     Button46.Caption := '';
     Button47.Caption := '';
     Button48.Caption := '';
     Button49.Caption := '';
     Button50.Caption := '';
     Form8.close;
     Form9.show;
     //Form3.show;
end;

procedure TForm8.Button103Click(Sender: TObject);
begin

     {* Select order *}
     SelectCount := 0;
     memo1.lines.clear;
     memo1.lines.add('หมายเลขที่นั่งที่ท่านต้องการ : ');
     For i := 1 to 20 do
     If SelectTemp[i] <> '' then
     begin
          memo1.lines.add(SelectTemp[i]);
          inc(SelectCount);
     end;
     If SelectCount <> 0 then
     begin
          If MessageDlg('ท่านต้องการทำรายการนี้',mtConfirmation,[mbYES,mbNo],0)= mrYes then
          begin
               j := 0;
               with query1 do
               begin
                    Repeat
                    close;
                    sql.clear;
                    sql.add('Select ID_ORDER From WEBAPP.TABLE8_VIEW Where (ID_CUSTOMER = :Para1) and (ID_MOVIE = :Para2) and (ID_SCREEN = :Para3) and (MTIME = :Para4) and (MDAY = :Para5) and (ID_SEAT = :Para6)');
                    inc(j);
                    Params[0].asInteger := StrToInt(Edit21.Text);
                    Params[1].asInteger := StrToInt(Edit22.Text);
                    Params[2].asInteger := StrToInt(Edit23.Text);
                    Params[3].asString := Edit24.Text;
                    Params[4].asString := Edit25.Text;
                    Params[5].asString := SelectTemp[j];
                    open;
                    OrderTemp[j]:= Fields[0].Value;
                    until j = SeatCount;
               end;

               {* Update Print *}
               j := 0;
               with query2 do
               begin
                    close;
                    sql.clear;
                    sql.Add('Update WEBAPP.TABLE8_VIEW Set PRINT = :Mypara Where ID_ORDER = :Para1');
                    Repeat
                    inc(j);
                    close;
                    Params[0].asstring := 'true';
                    Params[1].asInteger := OrderTemp[j];
                    ExecSQL;
                    until j = SeatCount;
               end;

               {* Print *}
               i := 0;
               with query1 do
               begin
                    Repeat
                    close;
                    sql.clear;
                    sql.add('Select ID_MOVIE,ID_SCREEN,MDAY,MTIME,ID_SEAT from WEBAPP.TABLE8_VIEW where ID_ORDER = :Para1 ');
                    inc(i);
                    close;
                    Params[0].asInteger := OrderTemp[i];
                    open;
                    Edit1.Text := IntToStr(Fields[0].value);
                    Form6.QrLabel9.caption := IntToStr(Fields[1].value);
                    Form6.QrLabel10.caption := Fields[4].value;
                    Form6.QrLabel11.caption := Fields[2].value;
                    Form6.QrLabel12.caption := Fields[3].value;

                    close;
                    sql.clear;
                    Params.Clear;
                    sql.add('Select NAME from WEBAPP.TABLE4 where ID_MOVIE = :Para1');
                    Params[0].asInteger := StrToInt(Edit1.Text);
                    open;

                    Memo1.Lines.Clear;
                    Button54.Visible := True;
                    Button1.Caption := '';
                    Button2.Caption := '';
                    Button3.Caption := '';
                    Button4.Caption := '';
                    Button5.Caption := '';
                    Button6.Caption := '';
                    Button7.Caption := '';
                    Button8.Caption := '';
                    Button9.Caption := '';
                    Button10.Caption := '';
                    Button11.Caption := '';
                    Button12.Caption := '';
                    Button13.Caption := '';
                    Button14.Caption := '';
                    Button15.Caption := '';
                    Button16.Caption := '';
                    Button17.Caption := '';
                    Button18.Caption := '';
                    Button19.Caption := '';
                    Button20.Caption := '';
                    Button21.Caption := '';
                    Button22.Caption := '';
                    Button23.Caption := '';
                    Button24.Caption := '';
                    Button25.Caption := '';
                    Button26.Caption := '';
     Button27.Caption := '';
     Button28.Caption := '';
     Button29.Caption := '';
     Button30.Caption := '';
     Button31.Caption := '';
     Button32.Caption := '';
     Button33.Caption := '';
     Button34.Caption := '';
     Button35.Caption := '';
     Button36.Caption := '';
     Button37.Caption := '';
     Button38.Caption := '';
     Button39.Caption := '';
     Button40.Caption := '';
     Button41.Caption := '';
     Button42.Caption := '';
     Button43.Caption := '';
     Button44.Caption := '';
     Button45.Caption := '';
     Button46.Caption := '';
     Button47.Caption := '';
     Button48.Caption := '';
     Button49.Caption := '';
     Button50.Caption := '';

                    Form6.QrLabel1.Caption := Fields[0].value;
                    //Form6.QuickREP1.Preview;
                    Form6.show;
                    Form6.QuickRep1.print;
                    Until i = SeatCount;
               end;
          end;
     end;
end;

end.

