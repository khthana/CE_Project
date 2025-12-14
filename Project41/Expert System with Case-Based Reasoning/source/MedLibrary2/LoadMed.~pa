unit LoadMed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TLoadForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    FileEnter: TEdit;
    LoadButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadForm: TLoadForm;


implementation

uses MainForm;

{$R *.DFM}



procedure TLoadForm.CancelButtonClick(Sender: TObject);
begin
     LoadForm.close;
     MedForm.show;
end;

procedure TLoadForm.LoadButtonClick(Sender: TObject);
var
     MedFile : File of MedicineRecord;
     count : byte;
begin
     If FileEnter.Text <> '' then
     begin
     AssignFile(MedFile,FileEnter.Text + '.med');
     Reset(MedFile);
     count := 1;
     While not(EOF(MedFile)) do
     begin
         Read(MedFile,MedLib[count]);
         Inc(count)
     end;
     MedIndex := count;
     CloseFile(MedFile);

     LoadForm.close;
     MedForm.Show;
     end;
end;

end.
