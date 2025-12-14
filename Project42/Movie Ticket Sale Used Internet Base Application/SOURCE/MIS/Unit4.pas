unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, TeEngine, Series, TeeProcs, Chart;

type
  TForm4 = class(TForm)
    Chart2: TChart;
    BarSeries1: TBarSeries;
    BarSeries2: TBarSeries;
    BarSeries3: TBarSeries;
    ControlBar3: TControlBar;
    Button2: TButton;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel2: TPanel;
    Edit1: TEdit;
    ControlBar1: TControlBar;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    Memo1: TMemo;
    Label4: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm4.Button2Click(Sender: TObject);
begin
     Form4.Hide;
     Form1.show;
end;

{procedure TForm2.FormCreate(Sender: TObject);
begin
     Memo1.Lines.Clear;
     Memo1.Lines.add('***** ขอต้อนรับสู่เมนู ข้อมูลประจำวัน *****');
     Memo1.Lines.add('***** เลือกข้อมูลตามต้องการ และกดปุ่ม "แสดงข้อมูล" เพื่อดูผล *****');
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
     Form2.Hide;
     Form1.show;
end;

procedure TForm2.MonthCalendar1Click(Sender: TObject);
var  i,j,Temp2  : Integer;
     Temp,Temp1 : String;
begin
     For i := 0 to 5 do
     begin
          Chart1.Series[i].clear;
          Chart1.Series[i].active := false;
     end;
     Chart1.Series[0].active := true;
     Edit1.Text:= DateToStr(MonthCalendar1.Date);

     for i := 1 to 10 do TempA[i] := 0;


     Edit3.Text := IntToStr(DayofWeek(Monthcalendar1.date));
     If Edit3.Text = '1' then Edit3.Text := 'วันอาทิตย์ที่ '
     else If Edit3.Text = '2' then Edit3.Text := ' วันจันทร์ที่ '
     else If Edit3.Text = '3' then Edit3.Text := ' วันอังคารที่ '
     else If Edit3.Text = '4' then Edit3.Text := ' วันพุธที่ '
     else If Edit3.Text = '5' then Edit3.Text := ' วันพฤหัสบดีที่ '
     else If Edit3.Text = '6' then Edit3.Text := ' วันศุกร์ที่ '
     else If Edit3.Text = '7' then Edit3.Text := ' วันเสาร์ที่ ';


     i := 0;
     j := 0;
     Temp := '';
     Repeat
     inc(i);
     if Edit1.Text[i] <> '/' then  inc(j);
     until Edit1.Text[i] = '/';
     If j = 1 then
          begin
             Edit2.Text := '0'+ Edit1.Text[1]+ '/';
             Edit3.Text := Edit3.Text + ' ' + Edit1.Text[1];
          end
     else
          begin
             Edit2.Text := Edit1.Text[1]+Edit1.Text[2]+ '/';;
             Edit3.Text := Edit3.Text + ' ' + Edit1.Text[1] + Edit1.Text[2]
          end;


     Repeat
     inc(i);
     if Edit1.Text[i] <> '/' then  Temp := Temp + Edit1.Text[i];
     until Edit1.Text[i] = '/';
     If Temp = '1' then
        begin
          Temp  := 'Jan';
          Temp1 := '  เดือน มกราคม พ.ศ. ';
        end
     else
     If Temp = '2' then
        begin
          Temp  := 'Feb';
          Temp1 := '  เดือน กุมภาพันธ์ พ.ศ. ';
        end
     else
     If Temp = '3' then
        begin
          Temp  := 'Mar';
          Temp1 := '  เดือน มีนาคม พ.ศ. ';
        end
     else
     If Temp = '4' then
        begin
          Temp  := 'Apr';
          Temp1 := '  เดือน เมษายน พ.ศ. ';
        end
     else
     If Temp = '5' then
        begin
          Temp  := 'May';
          Temp1 := '  เดือน พฤษภาคม พ.ศ. ';
        end
     else
     If Temp = '6' then
        begin
          Temp  := 'Jun';
          Temp1 := '  เดือน มิถุนายน พ.ศ. ';
        end
     else
     If Temp = '7' then
        begin
          Temp  := 'Jul';
          Temp1 := '  เดือน กรกฎาคม พ.ศ. ';
        end
     else
     If Temp = '8' then
        begin
          Temp  := 'Aug';
          Temp1 := '  เดือน สิงหาคม พ.ศ. ';
        end
     else
     If Temp = '9' then
        begin
          Temp  := 'Sep';
          Temp1 := '  เดือน กันยายน พ.ศ. ';
        end
     else
     If Temp = '10' then
        begin
          Temp  := 'Oct';
          Temp1 := '  เดือน ตุลาคม พ.ศ. ';
        end
     else
     If Temp = '11' then
        begin
          Temp  := 'Nov';
          Temp1 := '  เดือน พฤษจิกายน พ.ศ. ';
        end
     else
     If Temp = '12' then
        begin
          Temp  := 'Dec';
          Temp1 := '  เดือน ธันวาคม พ.ศ. ';
        end;
     Edit2.Text := Edit2.Text + Temp + '/';
     Edit3.Text := Edit3.Text + Temp1;


     inc(i);
     If Edit1.Text[i] = '0' then
         begin
              Edit2.Text := Edit2.Text + '20'+ Edit1.Text[i]+ Edit1.Text[i+1];
              Temp2 := 2543 + StrToInt(Edit1.Text[i]+Edit1.Text[i+1]);
         end
     else
         begin
              Edit2.Text := Edit2.Text + '19' + Edit1.Text[i] + Edit1.Text[i+1];
              Temp2 := 2543 - (100 - StrToInt(Edit1.Text[i]+Edit1.Text[i+1]));
         end;
     Edit3.Text := Edit3.Text + ' ' + IntToStr(Temp2);

     Memo1.Lines.Clear;
     Chart1.Series[0].Clear;
     Chart1.Series[0].Active := true;
     query1.close;
     query1.sql.clear;
     query1.Params.Clear;
     query1.sql.add('select count(ID_ORDER) from webapp.table8_view where MDAY = :1');
     query1.Params[0].asstring := Edit2.Text;
     query1.open;
     Edit4.Text := query1.Fields[0].value;
     chart1.Series[0].add(query1.Fields[0].value,'Total ='+ Edit4.Text,chart1.series[0].seriescolor);
     Memo1.Lines.add('***** สรุปข้อมูลประจำวัน ' + Edit3.Text +' *****');
     Memo1.Lines.Add('***** จำนวนผู้เข้าชมภาพยนตร์ทั้งสิ้น '+ Edit4.Text + '  คน *****');
     query1.close;
     Button5.Enabled := false;
     Button4.Enabled := true;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
     Memo1.Lines.Clear;
     For i := 1 to 10 do
     Chart1.Series[0].Clear;
     Chart1.Series[0].Active := true;
     query1.close;
     query1.sql.clear;
     query1.Params.Clear;
     query1.sql.add(' Select count(ID_ORDER) from webapp.table8_view where MDay = :1 ');
     query1.Params[0].asstring := Edit1.Text;
     query1.open;
     //day := edit1.text;
     Edit2.Text := query1.Fields[0].value;
     chart1.Series[0].add(query1.Fields[0].value,'Total ='+ Edit2.Text,chart1.series[0].seriescolor);
     query1.close;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
     //Memo1.Lines.Clear;
     //Chart1.Series[0].Clear;
     //Chart1.Series[0].Active := true;
     For i := 0 to 5 do
     begin
          Chart1.Series[i].clear;
          Chart1.Series[i].active := false;
     end;

     For i := 1 to 10 do TempA[i] := 0;


     query1.close;
     query1.sql.clear;
     query1.Params.Clear;
     query1.sql.add(' Select Distinct(ID_MOVIE) from webapp.table8_view where MDay = :1 ');
     query1.Params[0].asstring := Edit2.Text;
     query1.open;

     query1.First;
     CurRec := 0;
     query1.MoveBy(CurRec);
     For i := 1 to query1.RecordCount do
     begin
          MovieTemp[i] := query1.Fields[0].value;
          query1.Next;
     end;

     For i := 1 to query1.RecordCount do
     begin
          query2.close;
          query2.SQL.clear;
          query2.Params.clear;
          query2.sql.add('Select NAME from webapp.Table4 Where ID_Movie = :1');
          query2.Params[0].asInteger := MovieTemp[i];
          query2.open;
          NameTemp[i] := query2.Fields[0].value;
     end;


     For i := 1 to query1.Recordcount do
     begin
          query2.close;
          query2.sql.clear;
          query2.Params.Clear;
          query2.sql.add(' Select count(ID_ORDER) from webapp.table8_view where (ID_MOVIE = :1) and (MDAY = :2) ');
          query2.Params[0].asInteger := MovieTemp[i];
          query2.Params[1].asString := Edit2.Text;
          query2.open;
          TempA[i] := query2.Fields[0].value;
    end;


    For i := 1 to query1.RecordCount do
    begin
          Chart1.Series[i-1].clear;
          chart1.Series[i-1].active := True;
          chart1.Series[i-1].add(TempA[i],NameTemp[i],chart1.series[i-1].seriescolor);
          Memo1.Lines.add('ผู้เข้าชมภาพยนตร์เรื่อง  ' + NameTemp[i] + '  จำนวน ' + IntToStr(TempA[i]) + ' คน ');
    end;
     Button4.Enabled := false;
     Button5.Enabled := true;

     query2.close;
     query1.close;
end;

procedure TForm2.Button5Click(Sender: TObject);
var  i,j,Temp2  : Integer;
     Temp,Temp1 : String;
begin
     For i := 0 to 5 do
     begin
          Chart1.Series[i].clear;
          Chart1.Series[i].active := false;
     end;
     Chart1.Series[0].active := true;
     Edit1.Text:= DateToStr(MonthCalendar1.Date);


     Edit3.Text := IntToStr(DayofWeek(Monthcalendar1.date));
     If Edit3.Text = '1' then Edit3.Text := 'วันอาทิตย์ที่ '
     else If Edit3.Text = '2' then Edit3.Text := ' วันจันทร์ที่ '
     else If Edit3.Text = '3' then Edit3.Text := ' วันอังคารที่ '
     else If Edit3.Text = '4' then Edit3.Text := ' วันพุธที่ '
     else If Edit3.Text = '5' then Edit3.Text := ' วันพฤหัสบดีที่ '
     else If Edit3.Text = '6' then Edit3.Text := ' วันศุกร์ที่ '
     else If Edit3.Text = '7' then Edit3.Text := ' วันเสาร์ที่ ';


     i := 0;
     j := 0;
     Temp := '';
     Repeat
     inc(i);
     if Edit1.Text[i] <> '/' then  inc(j);
     until Edit1.Text[i] = '/';
     If j = 1 then
          begin
             Edit2.Text := '0'+ Edit1.Text[1]+ '/';
             Edit3.Text := Edit3.Text + ' ' + Edit1.Text[1];
          end
     else
          begin
             Edit2.Text := Edit1.Text[1]+Edit1.Text[2]+ '/';;
             Edit3.Text := Edit3.Text + ' ' + Edit1.Text[1] + Edit1.Text[2]
          end;


     Repeat
     inc(i);
     if Edit1.Text[i] <> '/' then  Temp := Temp + Edit1.Text[i];
     until Edit1.Text[i] = '/';
     If Temp = '1' then
        begin
          Temp  := 'Jan';
          Temp1 := '  เดือน มกราคม พ.ศ. ';
        end
     else
     If Temp = '2' then
        begin
          Temp  := 'Feb';
          Temp1 := '  เดือน กุมภาพันธ์ พ.ศ. ';
        end
     else
     If Temp = '3' then
        begin
          Temp  := 'Mar';
          Temp1 := '  เดือน มีนาคม พ.ศ. ';
        end
     else
     If Temp = '4' then
        begin
          Temp  := 'Apr';
          Temp1 := '  เดือน เมษายน พ.ศ. ';
        end
     else
     If Temp = '5' then
        begin
          Temp  := 'May';
          Temp1 := '  เดือน พฤษภาคม พ.ศ. ';
        end
     else
     If Temp = '6' then
        begin
          Temp  := 'Jun';
          Temp1 := '  เดือน มิถุนายน พ.ศ. ';
        end
     else
     If Temp = '7' then
        begin
          Temp  := 'Jul';
          Temp1 := '  เดือน กรกฎาคม พ.ศ. ';
        end
     else
     If Temp = '8' then
        begin
          Temp  := 'Aug';
          Temp1 := '  เดือน สิงหาคม พ.ศ. ';
        end
     else
     If Temp = '9' then
        begin
          Temp  := 'Sep';
          Temp1 := '  เดือน กันยายน พ.ศ. ';
        end
     else
     If Temp = '10' then
        begin
          Temp  := 'Oct';
          Temp1 := '  เดือน ตุลาคม พ.ศ. ';
        end
     else
     If Temp = '11' then
        begin
          Temp  := 'Nov';
          Temp1 := '  เดือน พฤษจิกายน พ.ศ. ';
        end
     else
     If Temp = '12' then
        begin
          Temp  := 'Dec';
          Temp1 := '  เดือน ธันวาคม พ.ศ. ';
        end;
     Edit2.Text := Edit2.Text + Temp + '/';
     Edit3.Text := Edit3.Text + Temp1;


     inc(i);
     If Edit1.Text[i] = '0' then
         begin
              Edit2.Text := Edit2.Text + '20'+ Edit1.Text[i]+ Edit1.Text[i+1];
              Temp2 := 2543 + StrToInt(Edit1.Text[i]+Edit1.Text[i+1]);
         end
     else
         begin
              Edit2.Text := Edit2.Text + '19' + Edit1.Text[i] + Edit1.Text[i+1];
              Temp2 := 2543 - (100 - StrToInt(Edit1.Text[i]+Edit1.Text[i+1]));
         end;
     Edit3.Text := Edit3.Text + ' ' + IntToStr(Temp2);

     Memo1.Lines.Clear;
     Chart1.Series[0].Clear;
     Chart1.Series[0].Active := true;
     query1.close;
     query1.sql.clear;
     query1.Params.Clear;
     query1.sql.add('select count(ID_ORDER) from webapp.table8_view where MDAY = :1');
     query1.Params[0].asstring := Edit2.Text;
     query1.open;
     Edit4.Text := query1.Fields[0].value;
     chart1.Series[0].add(query1.Fields[0].value,'Total ='+ Edit4.Text,chart1.series[0].seriescolor);
     Memo1.Lines.add('***** สรุปข้อมูลประจำวัน ' + Edit3.Text +' *****');
     Memo1.Lines.Add('***** จำนวนผู้เข้าชมภาพยนตร์ทั้งสิ้น '+ Edit4.Text + '  คน *****');
     query1.close;
     Button5.Enabled := false;
     Button4.Enabled := true;

end; }
end.
