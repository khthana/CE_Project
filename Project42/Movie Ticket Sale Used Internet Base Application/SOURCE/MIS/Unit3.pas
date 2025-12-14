unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, Db, DBTables;

type
  TForm3 = class(TForm)
    ControlBar3: TControlBar;
    Button2: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    ControlBar1: TControlBar;
    ComboBox1: TComboBox;
    Chart2: TChart;
    BarSeries1: TBarSeries;
    BarSeries2: TBarSeries;
    BarSeries3: TBarSeries;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Series5: TBarSeries;
    Series6: TBarSeries;
    Series7: TBarSeries;
    Series8: TBarSeries;
    Series9: TBarSeries;
    Button4: TButton;
    Button3: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Query1: TQuery;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type  TArrayStr = Array [1..20] of String;
      TArrayInt = Array [1..20] of Integer;

var
  Form3: TForm3;
  i,j,k : integer;
  CurRec : integer;
  Total : integer;
  Temp : String;
  MovieTemp : TArrayInt;
  CountTemp : TArrayInt;
  MovieName : TArrayStr;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
begin
     Form3.Hide;
     Form1.show;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
          Edit2.text := ComboBox1.Text;
          Memo1.Lines.clear;
          Memo1.Lines.Add('***** ข้อมูลปี 2543 *****');
end;

procedure TForm3.Edit2Change(Sender: TObject);
begin
          If Edit2.Text = 'มกราคม' then Edit3.Text := 'Jan'
          else If Edit2.Text = 'กุมภาพันธ์' then Edit3.Text := 'Feb'
          else If Edit2.Text = 'มีนาคม' then Edit3.Text := 'Mar'
          else If Edit2.Text = 'เมษายน' then Edit3.Text := 'Apr'
          else If Edit2.Text = 'พฤษภาคม' then Edit3.Text := 'May'
          else If Edit2.Text = 'มิถุนายน' then Edit3.Text := 'Jun'
          else If Edit2.Text = 'กรกฎาคม' then Edit3.Text := 'Jul'
          else If Edit2.Text = 'สิงหาคม' then Edit3.Text := 'Aug'
          else If Edit2.Text = 'กันยายน' then Edit3.Text := 'Sep'
          else If Edit2.Text = 'ตุลาคม' then Edit3.Text := 'Oct'
          else If Edit2.Text = 'พฤษจิกายน' then Edit3.Text := 'Nov'
          else If Edit2.Text = 'ธันวาคม' then Edit3.Text := 'Dec' ;

          Button3.Visible := true;
          Button4.Visible := true;
end;

procedure TForm3.Button4Click(Sender: TObject);
var       SetV : boolean;
begin
     For i := 0 to 11 do
     begin
          Chart2.Series[i].clear;
          Chart2.Series[i].active := false;
     end;
     Chart2.Series[0].active := true;

     For i := 1 to 20 do
     begin
          MovieTemp[i] := 0;
          CountTemp[i] := 0;
     end;

     with query1 do
     begin
          close;
          sql.clear;
          Params.Clear;
          sql.add('select MDAY,ID_MOVIE from webapp.table8_view ');
          open;

          Total := 0;
          First;
          CurRec := 0;
          MoveBy(CurRec);
          For i := 1 to RecordCount do
          begin
               Edit4.Text := Fields[0].value;
               j := 0;
               Repeat
               inc(j);
               If Edit4.Text[j] = '/' then Temp := Edit4.Text[j+1]+Edit4.Text[j+2]+Edit4.Text[j+3];
               Until Edit4.Text[j] = '/';
               If Temp = Edit3.Text then
               begin
                    SetV := false;
                    k := 0;
                    Repeat
                    inc(k);
                    If MovieTemp[k] = 0 then
                    begin
                         MovieTemp[k] := Fields[1].value;
                         inc(CountTemp[k]);
                         SetV := true;
                    end else
                        If MovieTemp[k] = Fields[1].value then
                        begin
                             inc(CountTemp[k]);
                             SetV := true;
                        end
                    Until SetV = true;
               end;
               Next;
          end;
     end;
     Memo1.Lines.clear;
     Memo1.Lines.Add('***** ข้อมูลปี 2543 *****');
     Memo1.Lines.add('***** ประจำเดือน '+ Edit2.Text+' *****');

     For i := 1 to k do
     begin
          query1.sql.clear;
          query1.Params.clear;
          query1.sql.Add('Select NAME from webapp.Table4 where ID_MOVIE =:1');
          query1.Params[0].asInteger := MovieTemp[i];
          query1.open;
          MovieName[i] := query1.Fields[0].value;

          Chart2.Series[i-1].active := true;
          Chart2.Series[i-1].add(CountTemp[i],MovieName[i],Chart2.Series[i-1].SeriesColor);
          Memo1.Lines.add('***** ภาพยนตร์เรื่อง '+ MovieName[i] + ' จำนวน '+ IntToStr(CountTemp[i])+ ' ราย *****');
     end;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
     For i := 0 to 11 do
     begin
          Chart2.Series[i].clear;
          Chart2.Series[i].active := false;
     end;
     Chart2.Series[0].active := true;

     with query1 do
     begin
          close;
          sql.clear;
          Params.Clear;
          sql.add('select MDAY from webapp.table8_view ');
          open;

          Total := 0;
          First;
          CurRec := 0;
          MoveBy(CurRec);
          For i := 1 to RecordCount do
          begin
               Edit4.Text := Fields[0].value;
               j := 0;
               Repeat
               inc(j);
               If Edit4.Text[j] = '/' then Temp := Edit4.Text[j+1]+Edit4.Text[j+2]+Edit4.Text[j+3];
               Until Edit4.Text[j] = '/';
               If Temp = Edit3.Text then inc(Total);
               Next;
          end;
          Edit5.Text := IntToStr(Total);
     end;
     Chart2.Series[0].add(Total,'Total ='+ Edit5.Text,Chart2.Series[0].SeriesColor);
     Memo1.Lines.clear;
     Memo1.Lines.Add('***** ข้อมูลปี 2543 *****');
     Memo1.Lines.add('***** ประจำเดือน '+ Edit2.Text+' *****');
     Memo1.Lines.add('***** ผู้เข้าชมภาพยนตร์ทั้งหมด '+ IntToStr(Total) +' ราย *****');

end;

end.
procedure TForm3.FormCreate(Sender: TObject);
begin

end;


