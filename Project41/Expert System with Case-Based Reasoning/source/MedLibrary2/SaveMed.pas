unit SaveMed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSaveForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    FileEnter: TEdit;
    SaveButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveForm: TSaveForm;

implementation

uses MainForm;

{$R *.DFM}




procedure TSaveForm.CancelButtonClick(Sender: TObject);
begin
     SaveForm.close;
     MedForm.show;
end;

procedure TSaveForm.SaveButtonClick(Sender: TObject);
var
   MedFile : File of MedicineRecord;
   count : byte;
begin
     If FileEnter.Text <> '' then
     begin
     AssignFile(MedFile,FileEnter.Text + '.med');
     Rewrite(MedFile);
     For count := 1 to (MedIndex-1) do
         Write(MedFile,MedLib[count]);
     CloseFile(MedFile);

     SaveForm.close;
     MedForm.show;
     end;
end;

end.
