unit DetailResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDetailResultForm = class(TForm)
    GroupBox1: TGroupBox;
    SolName: TEdit;
    Suggestion: TMemo;
    OkButton: TButton;
    Label1: TLabel;
    MedList: TComboBox;
    Label2: TLabel;
    Day: TEdit;
    Label3: TLabel;
    DetailButton: TButton;
    GroupBox2: TGroupBox;
    AdaptSuggestion: TMemo;
    AdaptMedList: TComboBox;
    Label4: TLabel;
    AdaptDetailButton: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure AdaptDetailButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DetailResultForm: TDetailResultForm;
  CurrentDisplay : Word;

implementation

uses Result, MedDetail;

{$R *.DFM}

procedure TDetailResultForm.OkButtonClick(Sender: TObject);
begin
     DetailResultForm.close;
     ResultForm.show;
end;


procedure TDetailResultForm.DetailButtonClick(Sender: TObject);
var
   TempStr : String;
   Error : integer;
   TempByte : byte;
begin
     If MedList.Text <> '' then
     begin
     TempStr := copy(MedList.Text,1,4);
     Val(TempStr,TempByte,Error);
     MedDetail.MedNo := TempByte;
     MedDetailForm.show;
     end;
end;

procedure TDetailResultForm.AdaptDetailButtonClick(Sender: TObject);
var
   TempStr : String;
   TempByte : byte;
   Error : integer;
begin
     If AdaptMedList.Text <> '' then
     begin
     TempStr := copy(AdaptMedList.Text,1,4);
     Val(TempStr,TempByte,Error);
     MedDetail.MedNo := TempByte;
     MedDetailForm.show;
     end;
end;

end.
