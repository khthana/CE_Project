unit LoadSol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TLoadForm = class(TForm)
    Label1: TLabel;
    FileName: TEdit;
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

uses SolMain;

{$R *.DFM}


procedure TLoadForm.CancelButtonClick(Sender: TObject);
begin
     LoadForm.close;
     SolForm.show;
end;

procedure TLoadForm.LoadButtonClick(Sender: TObject);
var
   SolutionFile : File of SolutionRec;
   TempStr : String;
begin
     If FileName.text <> '' then
     begin
          AssignFile(SolutionFile,FileName.Text + '.sol');
          Reset(SolutionFile);
          Index := 1;
          While not(EOF(SolutionFile)) do
          begin
               Read(SolutionFile,SolLib[Index]);
               Inc(Index);
          end;
          CloseFile(SolutionFile);
          Str(Index,TempStr);
          SolForm.No.Text := TempStr;
          SolForm.show;
          LoadForm.close;
     end;
end;

end.
