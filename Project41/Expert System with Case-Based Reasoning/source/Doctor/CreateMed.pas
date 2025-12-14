unit CreateMed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TCreateMedForm = class(TForm)
    Label1: TLabel;
    MedName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Detail: TEdit;
    Adult: TEdit;
    Youth: TEdit;
    RecordButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateMedForm: TCreateMedForm;

implementation

uses CreateSol,MainScreen,SelectFile;

{$R *.DFM}

procedure SaveMedFile;
var
   MedFile : File of MedicineRecord;
   i : byte;
begin
     AssignFile(MedFile,MedicineFileName);
     Rewrite(MedFile);
     For i := 1 to NumMed do
         write(MedFile,MedLib[i]);
     Close(MedFile);
end;





procedure TCreateMedForm.CancelButtonClick(Sender: TObject);
begin
     CreateSolForm.show;
     CreateMedForm.close;
end;

procedure TCreateMedForm.RecordButtonClick(Sender: TObject);
var
   TempMed : MedicineRecord;
begin
     If MedName.Text <> '' then
     begin
          TempMed.MedName := MedName.Text;
          TempMed.MedDetail := Detail.Text;
          TempMed.MedAdult := Adult.Text;
          TempMed.MedYouth := Youth.Text;
          Inc(NumMed);
          TempMed.MedNo := NumMed;
          MedLib[NumMed] := TempMed;
          SaveMedFile;
          CreateMedForm.close;
          CreateSolForm.show;
     end;
end;

end.
