unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ExtCtrls, Mask, DBCtrls, jpeg;

type
  TForm9 = class(TForm)
    Panel20: TPanel;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel10: TPanel;
    Image5: TImage;
    Panel11: TPanel;
    Image2: TImage;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    ControlBar2: TControlBar;
    Button2: TButton;
    ControlBar3: TControlBar;
    Button3: TButton;
    ControlBar4: TControlBar;
    Button4: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    ControlBar1: TControlBar;
    Button1: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Panel1: TPanel;
    Query1: TQuery;
    DataSource1: TDataSource;
    Query2: TQuery;
    Query3: TQuery;
    DataSource2: TDataSource;
    Query4: TQuery;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type      TArrayInt = array[1..20] of integer;
          TArrayStr = array[1..20] of string;
          TArrayTmp = array[1..20] of string;

var
          Form9: TForm9;
          MaxMovie : Integer;
          i,j,k,l  : Integer;
          CurRec   : integer;
          MovieTemp,MovieTemp2,ScreenTemp,ScreenTemp2,OrderTemp : TArrayInt;
          DayTemp,DayTemp2,TimeTemp : TArrayStr;
          SeatTemp : TarrayTmp;

implementation

uses Unit8, Unit1, Unit7;

{$R *.DFM}


procedure TForm9.Button2Click(Sender: TObject);

begin
          Panel1.Caption := '1';
          {* clear Temp *}
          For i := 1 to 10 do
          begin
               MovieTemp[i] := 0;
               MovieTemp2[i] := 0;
               ScreenTemp[i] := 0;
               ScreenTemp2[i] := 0;
               DayTemp[i]  := '';
               DayTemp2[i] := '';
               TimeTemp[i] := '';
               SeatTemp[i] := '';
               OrderTemp[i] := 0;
          end;

          j := 0;
          {* query data *}
          query1.close;
          query1.sql.clear;
          query1.Params.Clear;
          query1.sql.add('select Distinct(ID_MOVIE) from WEBAPP.TABLE8_VIEW where (ID_CUSTOMER = :Mypara) and ( PRINT = :MyPara2 )');
          query1.Params[0].asInteger := StrToInt(DBEdit1.Text);
          query1.Params[1].asString := 'false';
          query1.open;

          If query1.RecordCount >= 1 then
          begin
               query1.First;
               CurRec := 0;
               query1.MoveBy(CurRec);
               MaxMovie := query1.RecordCount;
               For i := 1 to query1.RecordCount do
               begin
                    MovieTemp[i] := query1.Fields[0].value;
                    {* check *}
                    with query4 do
                    begin
                         close;
                         sql.clear;
                         Params.clear;
                         sql.add('Select Distinct(ID_SCREEN) from WEBAPP.TABLE8_VIEW where (ID_CUSTOMER = :Para1) and (ID_MOVIE = :Para2)and (PRINT = :Para3)  ');
                         Params[0].asInteger := StrToInt(DBEdit1.Text);
                         Params[1].asInteger := MovieTemp[i];
                         Params[2].asString := 'false';
                         open;

                         query4.First;
                         CurRec := 0;
                         query4.MoveBy(CurRec);
                         For k := 1 to query4.RecordCount do
                         begin
                              j := j + 1;
                              MovieTemp2[j] := MovieTemp[i];
                              ScreenTemp[j] := query4.Fields[0].value;
                              query4.Next;
                         end;
                     end;
                     query1.Next;
               end;
               For i := 1 to j do MovieTemp[i] := MovieTemp2[i];
               l := j;

               j := 0;
               For i := 1 to l do
               begin
                    {* check *}
                    with query4 do
                    begin
                         close;
                         sql.clear;
                         Params.clear;
                         sql.add('Select Distinct(MDAY) from WEBAPP.TABLE8_VIEW where (ID_CUSTOMER = :1) and (ID_MOVIE = :Para) and (ID_SCREEN = :Para2)and (PRINT = :Para3)');
                         Params[0].asInteger := StrToInt(DBEdit1.Text);
                         Params[1].asInteger := MovieTemp[i];
                         Params[2].asInteger := ScreenTemp[i];
                         Params[3].asString := 'false';
                         open;

                         query4.First;
                         CurRec := 0;
                         query4.MoveBy(CurRec);
                         For k := 1 to query4.RecordCount do
                         begin
                              j := j + 1;
                              MovieTemp2[j] := MovieTemp[i];
                              ScreenTemp2[j] := ScreenTemp[i];
                              DayTemp[j] := query4.Fields[0].value;
                              query4.Next;
                         end;
                    end;
               end;
               For i := 1 to j do
               begin
                    MovieTemp[i] := MovieTemp2[i];
                    ScreenTemp[i] := ScreenTemp2[i];
               end;
               l := j;

               j := 0;
               For i := 1 to l do
               begin
                    {* check *}
                    with query4 do
                    begin
                         close;
                         sql.clear;
                         Params.clear;
                         sql.add(' select Distinct(MTIME) from WEBAPP.TABLE8_VIEW where (ID_CUSTOMER = :0) and (ID_MOVIE = :1) and (ID_SCREEN = :2) and (MDAY = :3) and (PRINT = :4) ');
                         Params[0].asInteger := StrToInt(DBEdit1.Text);
                         Params[1].asInteger := MovieTemp[i];
                         Params[2].asInteger := ScreenTemp[i];
                         Params[3].asString := DayTemp[i];
                         Params[4].asString := 'false';
                         open;

                         query4.First;
                         CurRec := 0;
                         query4.MoveBy(CurRec);
                         For k := 1 to query4.RecordCount do
                         begin
                              j := j + 1;
                              MovieTemp2[j] := MovieTemp[i];
                              ScreenTemp2[j] := ScreenTemp[i];
                              DayTemp2[j] := DayTemp[i];
                              TimeTemp[j] := query4.Fields[0].value;
                              query4.Next;
                         end;
                    end;
               end;
               For i := 1 to j do
               begin
                    MovieTemp[i] := MovieTemp2[i];
                    ScreenTemp[i] := ScreenTemp2[i];
                    DayTemp[i] := DayTemp2[i];
               end;
               MaxMovie := j;

               Edit4.Text := IntToStr(MovieTemp[1]);

          {* Query for screen,day,time *}
               query3.close;
               query3.Params[0].asInteger := StrToInt(DBEdit1.Text);
               query3.Params[1].asInteger := MovieTemp[1];
               query3.Params[2].asInteger := ScreenTemp[1];
               query3.Params[3].asString := DayTemp2[1];
               query3.Params[4].asString := TimeTemp[1];
               query3.open;

          {* Change ID_MOVIE to NAME *}
               query2.close;
               query2.Params[0].asInteger := StrToInt(Edit4.Text);
               query2.Open;

               ControlBar2.Hide;
               If MaxMovie  <> 0 then
               begin
                    If MaxMovie = 1 then
                    Button4.Enabled := false
                    else
                    Button4.Enabled := true;
               Panel1.Visible := True;
               ControlBar3.Visible := True;
               Button3.Enabled := false;
               ControlBar4.Visible := True;
               end;
          end
          else MessageDlg('ไม่พบรายการจองในของท่าน',mtWarning,[mbOK],0);
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
     ControlBar2.Visible := True;
     ControlBar3.hide;
     ControlBar4.hide;
     Form9.close;
     Form7.show;
end;

procedure TForm9.Panel1Click(Sender: TObject);
begin
     Form8.Show;
     Form8.Edit21.Text := DBEdit1.Text;
     Form8.EDit22.Text := Edit4.Text;
     Form8.Edit23.Text := DBEdit5.Text;
     Form8.Edit24.Text := DBEdit6.Text;
     Form8.Edit25.Text := DBEdit7.Text;
     ControlBar2.Visible := True;
     ControlBar3.Visible := False;
     ControlBar4.Visible := False;
     Form9.Close;
end;

procedure TForm9.Button3Click(Sender: TObject);
var  M : integer;
begin
     If  Panel1.Caption = '1' then
     Button3.Enabled := false
     else
         begin
         M := StrToInt(Panel1.Caption);
         dec(M);
         Panel1.Caption := IntToStr(M);
         Button4.Enabled := True;
         If Panel1.Caption = '1' then Button3.Enabled := false;
         end;

     Edit4.Text := IntToStr(MovieTemp[StrToInt(Panel1.Caption)]);

     {* Query for screen,day,time *}
     {* Change ID_MOVIE to NAME *}
     query2.close;
     query2.Params[0].asInteger := StrToInt(Edit4.Text);
     query2.Open;

     {* Query for screen,day,time *}
     query3.close;
     query3.Params[0].asInteger := StrToInt(DBEdit1.Text);
     query3.Params[1].asInteger := MovieTemp[M];
     query3.Params[2].asInteger := ScreenTemp[M];
     query3.Params[3].asString := DayTemp[M];
     query3.Params[4].asString := TimeTemp[M];
     query3.Open;

end;

procedure TForm9.Button4Click(Sender: TObject);
var      M : Integer;
begin
     If  Panel1.Caption = IntToStr(MaxMovie) then
     Button4.Enabled := false
     else
         begin
         M := StrToInt(Panel1.Caption);
         inc(M);
         Panel1.Caption := IntToStr(M);
         Button3.Enabled := True;
         If Panel1.Caption = IntToStr(MaxMovie) then Button4.Enabled := false;
         end;

     Edit4.Text := IntToStr(MovieTemp[StrToInt(Panel1.Caption)]);

     {* Query for screen,day,time *}

     {* Query for screen,day,time *}
     query3.close;
     query3.Params[0].asInteger := StrToInt(DBEdit1.Text);
     query3.Params[1].asInteger := MovieTemp[M];
     query3.Params[2].asInteger := ScreenTemp[M];
     query3.Params[3].asString := DayTemp[M];
     query3.Params[4].asString := TimeTemp[M];
     query3.Open;

     {* Change ID_MOVIE to NAME *}
     query2.close;
     query2.Params[0].asInteger := StrToInt(Edit4.Text);
     query2.Open;

end;

end.

