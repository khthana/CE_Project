unit SolDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSolDetailForm = class(TForm)
    Label1: TLabel;
    SolName: TEdit;
    Suggestion: TMemo;
    MedList: TComboBox;
    Label2: TLabel;
    DetailButton: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Day: TEdit;
    OkButton: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SolDetailForm: TSolDetailForm;
  SolNo : Word;

implementation
uses MainScreen, MedDetail;
{$R *.DFM}





procedure TSolDetailForm.OkButtonClick(Sender: TObject);
begin
     SolDetailForm.close;
end;

procedure TSolDetailForm.FormShow(Sender: TObject);
var
   TempStr : String;
   ResultStr : String;
   i : byte;
begin
     SolName.Text := SolLib[SolNo].SolName;
     Suggestion.Clear;

     If SolLib[SolNo].Suggestion <> '' then
     Suggestion.Lines.Add(SolLib[SolNo].Suggestion);

     MedList.Clear;
     For i := 1 to 5 do
         If SolLib[SolNo].Med[i] <> 0 then
         begin
              Str(SolLib[SolNo].Med[i]:4,TempStr);
              ResultStr := TempStr + ' : ' +
              MedLib[SolLib[SolNo].Med[i]].MedName;
              MedList.Items.Add(ResultStr);
              If i = 1 then
              MedList.Text := ResultStr;
         end;
     If SolLib[SolNo].Day = 255 then
        Suggestion.Lines.Add('¾ºá¾·Âì´èÇ¹')
     Else If SolLib[SolNo].Day = 0 then
          Day.Text := '-'
     Else
     begin
          Str(SolLib[SolNo].Day,TempStr);
          Day.Text := TempStr;
     end;
end;

procedure TSolDetailForm.DetailButtonClick(Sender: TObject);
var
   TempStr : String;
   TempByte : byte;
   Error : integer;
begin
     If MedList.Text <> '' then
     begin
     TempStr := copy(MedList.Text,1,4);
     Val(TempStr,TempByte,Error);
     MedDetail.MedNo := TempByte;
     MedDetailForm.show;
     end;
end;

end.
