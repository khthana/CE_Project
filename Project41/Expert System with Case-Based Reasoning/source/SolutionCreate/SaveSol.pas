unit SaveSol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
   TSaveForm = class(TForm)
    Label1: TLabel;
    FileName: TEdit;
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

uses SolMain;

{$R *.DFM}





procedure TSaveForm.CancelButtonClick(Sender: TObject);
begin
     SolForm.show;
     SaveForm.close;
end;

procedure TSaveForm.SaveButtonClick(Sender: TObject);
var
   SolutionFile : File of SolutionRec;
   Count : byte;
begin
     If FileName.Text <> '' then
     begin
     AssignFile(SolutionFile,FileName.Text + '.sol');
     Rewrite(SolutionFile);

     For Count := 1 to (Index - 1) do
          Write(SolutionFile,SolLib[Count]);

     CloseFile(SolutionFile);
     SaveForm.close;
     SolForm.Show;
     SolForm.Name.Text := '';
     SolForm.Suggestion.Text := '';
     SolForm.Day.Text := '';
     SolForm.Med1.Text := '';
     SolForm.Med2.Text := '';
     SolForm.Med3.Text := '';
     SolForm.Med4.Text := '';
     SolForm.Med5.Text := '';

     end;
end;

end.
