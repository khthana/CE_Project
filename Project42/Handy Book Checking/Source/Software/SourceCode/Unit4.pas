unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    RadioGroup1: TRadioGroup;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
     close ;
end;

procedure TForm4.Button1Click(Sender: TObject);
var STemp : string ;
    a : integer ;
begin
     a := 0 ;
     if edit1.Text <> '' then
     begin
        STemp := 'BKNAME = ' + '''' +edit1.text+''''  ;
        a := 1 ;
     end;
     if (edit2.Text <> '') and (a = 1) then
     begin
          STemp := STemp + ' and ' + 'BKCODE = ' + ''''+edit2.text+'''';
          a := 1 ;
     end
     else
     begin
          if (edit2.Text <> '') then
          begin
               STemp := STemp  + 'BKCODE = ' + ''''+edit2.text+'''' ;
               a := 1 ;
          end;
     end ;
     if (edit3.Text <> '') and (a=1) then
     begin
          STemp := STemp + ' and ' + 'BKCALL = ' + ''''+edit3.text+'''';
          a := 1 ;
     end
     else
     begin
          if (edit3.Text <> '') then
          begin
               STemp := STemp  + 'BKCALL = ' + ''''+edit3.text+'''' ;
               a := 1 ;
          end;
     end;
     if (edit4.Text <> '') and (a=1) then
     begin
          STemp := STemp + ' and ' + 'BKGROUP = ' + ''''+edit4.text+'''';
          a := 1 ;
     end
     else
     begin
          if (edit4.Text <> '') then
          begin
               STemp := STemp  + 'BKGROUP = ' + ''''+edit4.text+'''' ;
               a := 1 ;
          end;
     end;
     if (edit5.Text <> '') and (a=1) then
     begin
          STemp := STemp + ' and '+' YEAR_LOST = ' + ''''+edit5.text+'''';
          a := 1 ;
     end
     else
     begin
          if (edit5.Text <> '') then
          begin
               STemp := STemp  + 'YEAR_LOST = ' + ''''+edit5.text+'''' ;
               a := 1 ;
          end;
     end;
     if (radiogroup1.ItemIndex <> -1) and (a=1) then
     begin
          STemp := STemp + ' and '+'STATUS = ' + ''''+ InttoStr(radiogroup1.ItemIndex)+'''';
          a := 1 ;
     end
     else
     begin
          if (radiogroup1.ItemIndex <> -1) then
          begin
               STemp := STemp  + 'STATUS = ' + ''''+ InttoStr(radiogroup1.ItemIndex)+'''' ;
               a := 1 ;
          end;
     end;
     if (STemp <> '') then
     begin
          with datamodule1 do
          begin
               query1.Close ;
               query1.SQL.Clear ;
               query1.SQL.Add('Select * From LIBBK2 Where ' + STemp) ;
               query1.SQL.Add('order by BKCALL DESC') ;
               query1.ExecSQL ;
               query1.open ;
          end;
     end ;
     close ;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     action := cafree ;
end;

end.
