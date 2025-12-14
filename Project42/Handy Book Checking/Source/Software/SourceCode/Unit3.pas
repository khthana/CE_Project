unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OleCtrls, ExtCtrls, ComCtrls, Menus, CPort;

type
  TForm3 = class(TForm)
    Panel2: TPanel;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel3: TPanel;
    ProgressBar1: TProgressBar;
    Panel4: TPanel;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ComPort1: TComPort;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
//    procedure MSComm1Comm(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  countb : integer ;
  temp : string[7] ;

implementation
uses unit1,main ;

{$R *.DFM}

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     main.Func2 := False ;
     action := cafree ;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
     ProgressBar1.Position := 0 ;
     if ComPort1.Connected then
        ComPort1.Close
     else
     begin
          ComPort1.Open;
          countb := 0 ;
     end;
end;


procedure TForm3.Button2Click(Sender: TObject);
begin
     close ;
end;

procedure TForm3.N2Click(Sender: TObject);
var dtemp : string[8] ;
//    i : integer ;
begin
        ProgressBar1.Position := 0 ;
     datamodule1.table1.Open ;
          datamodule1.table1.First ;
          dtemp := datetostr(date) ;
          dtemp := dtemp[length(dtemp)-1] + dtemp[length(dtemp)];
          while not datamodule1.table1.EOF do
          begin
               if datamodule1.table1.FieldValues['STATUS'] = 0 then
               begin
                    datamodule1.table1.Edit ;
                    datamodule1.table1.FieldValues['STATUS'] := 1 ;
                    datamodule1.table1.FieldValues['YEAR_LOST'] := 2000 + strtoint(dtemp);
               end ;
               datamodule1.table1.Next ;
               ProgressBar1.Position := ProgressBar1.Position + 1 ;
          end ;
          datamodule1.table1.Close ;
          
end;

procedure TForm3.N3Click(Sender: TObject);
begin
     comport1.ShowSetupDialog ;
end;

procedure TForm3.ComPort1RxChar(Sender: TObject; Count: Integer);
var i : integer ;
    str : string ;
begin
     if countb = 0 then
     begin
          comport1.ReadStr(str,count);
          temp := str ;
          progressbar1.Max := (strtoint(temp)*2) - 2 ;
          listbox1.Items.Add(temp) ;
          inc(countb) ;
     end
     else
     begin
          inc(countb) ;
          comport1.ReadStr(str,count);
          listbox1.Items.Add(str) ;
          ProgressBar1.Position := ProgressBar1.Position + 1 ;
     end;
     if countb = strtoint(temp) then
     begin
//          ComPort1.Close ;
          countb := 0 ;
          listbox2.Items.Add('จำนวนข้อมูลที่รับได้ :');
          i := strtoint(temp) - 1 ;
          listbox2.Items.Add(inttostr(i));
          listbox2.Items.Add('ข้อมูลที่หาไม่พบในฐานข้อมูล');
          datamodule1.Table1.IndexFieldNames := 'BKCODE' ;
          for i := 1 to strtoint(temp)-1 do
          begin
               datamodule1.table1.Open ;
               if datamodule1.Table1.FindKey([listbox1.Items[i]]) then
               begin
                    datamodule1.table1.Edit ;
                    datamodule1.Table1.FieldValues['STATUS'] := 0 ;
                    datamodule1.table1.FieldValues['YEAR_LOST'] := 0 ;
                    datamodule1.table1.post ;
                    ProgressBar1.Position := ProgressBar1.Position + 1 ;
               end
               else
               begin
                    listbox2.Items.Add(listbox1.Items[i]);
                    ProgressBar1.Position := ProgressBar1.Position + 1 ;
               end;
          end;


     end;
end;

end.
