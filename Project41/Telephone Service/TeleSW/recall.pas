unit recall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm4 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel4: TPanel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    Present: TDateTime;
    Year, Month, Day, Hour, Min, Sec, MSec: Word;
    Telstr:string;
    Telwav:string;
    procedure Tel;
    { Public declarations }
  end;

var
  Form4: TForm4;
  hm,hc:hwnd;

implementation

uses ai2, ts_1;

{$R *.DFM}

procedure Tform4.Tel;
begin
 ts1.sendint(cmand1);  // off hook
 ts1.sendint(cmand15); // ena sound in
 ts1.await;
 ts1.sendint(cmand7); // ena busy
 ts1.sendint(cmand10); //  ena ringb
 end;

procedure TForm4.SpeedButton2Click(Sender: TObject);
begin
 if SpeedButton2.Caption='Text' then
 begin

 SpeedButton2.Caption:='Close';
 winexec('f:\willowtalk\wiltalk.exe ',sw_show);
 hm:=findwindow(nil,'WillowTalk');
 hc:=childwindowfrompoint(hm,point(120,20));
 setforegroundwindow(hm);
 end
 else
 begin
 SpeedButton2.Caption:='Text';
 sendmessage(hm,wm_close,0,0);
 end;
end;

procedure TForm4.SpeedButton3Click(Sender: TObject);
var
wl:longint;
begin
wl:=makelong(11,12);
sendmessage(hc,wm_lbuttondown,0,wl);
sendmessage(hc,wm_lbuttonup,0,wl);
setforegroundwindow(hm);
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Speedbutton2.Caption='Close'then
  SpeedButton2click(self);
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
if Speedbutton2.Caption='Close'then
  SpeedButton2click(self);
end;

procedure TForm4.SpeedButton1Click(Sender: TObject);
begin
  Form2.Edit1.Text:=TS1.d+'\Recall\'+dbedit4.Text+'.wav';
  Form2.show;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  Panel1.Caption := 'Day ' + IntToStr(Day) + '/'
    + IntToStr(Month) + '/' + IntToStr(Year);
  DecodeTime(Present, Hour, Min, Sec, MSec);
  Panel2.Caption := 'Time ' + IntToStr(Hour) + ':'
    + IntToStr(Min)+':'+Inttostr(sec);
  // ******** Check Recall from DATABASE *******
  if TS1.tsmode='recall' then
  timer2.Enabled:=true
  else timer2.Enabled:=false;

end;

procedure TForm4.Timer2Timer(Sender: TObject);
var
  Years,Months,Days,Hours,Mins,temp:string;
  num:integer;
  Yearl, Monthl, Dayl, Hourl, Minl: Word;
  rcall:boolean;
begin
  Yearl:=Year;Monthl:=Month;Dayl:=Day;
  Hourl:=Hour;Minl:=Min;
  table1.First;
  while not table1.EOF do
   begin
   // GET DATE & TIME from database
   temp:=dbedit2.Text; // read date
   num:=pos('/',temp);
   Days:=copy(temp,1,num-1);
   temp:=copy(temp,num+1,length(temp));
   num:=pos('/',temp);
   Months:=copy(temp,1,num-1);
   Years:=copy(temp,num+1,length(temp));
   temp:=dbedit3.Text; // read time
   num:=pos(':',temp);
   Hours:=copy(temp,1,num-1);
   Mins:=copy(temp,num+1,length(temp));

   temp:=copy(Mins,1,1); // sol '00' = '0'
   if (temp='0')and(length(Mins)>1)then Mins:=copy(Mins,2,length(Mins));


   // TEST ALL
   rcall:=false;
   if Mins=inttostr(Minl) then
    begin
    if Hours='-' then rcall:=true;
    if Hours=inttostr(Hourl) then
     begin
     if Days='-' then rcall:=true;
     if Days=inttostr(Dayl) then
      begin
      if Months='-' then rcall:=true;
      if Months=inttostr(Monthl) then
       begin
       if Years='-' then rcall:=true;
       if Years=inttostr(Yearl) then
       rcall:=true;
       end;
      end;
     end;
    end;
   if rcall=true then
    begin
    Telstr:=dbedit5.Text;
    Telwav:=dbedit4.Text;
    Tel;
    end;
   table1.Next;
   end;
   table1.First;
end;

end.
