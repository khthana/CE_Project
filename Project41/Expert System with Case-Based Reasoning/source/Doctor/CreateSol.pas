unit CreateSol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TCreateSolForm = class(TForm)
    Label1: TLabel;
    SolName: TEdit;
    Label2: TLabel;
    Suggestion: TEdit;
    Label3: TLabel;
    Day: TEdit;
    Label4: TLabel;
    UrgentBox: TCheckBox;
    GroupBox1: TGroupBox;
    Med1: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Med2: TComboBox;
    Label7: TLabel;
    Med3: TComboBox;
    Label8: TLabel;
    Med4: TComboBox;
    Med5: TComboBox;
    Label9: TLabel;
    RecordButton: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateSolForm: TCreateSolForm;

implementation

uses CreateCase,MainScreen,SelectFile, CreateMed;

{$R *.DFM}

procedure SaveSolFile;
var
   SolFile : File of SolutionRecord;
   i : word;
begin
     AssignFile(SolFile,SolutionFileName);
     Rewrite(SolFile);
     For i := 1 to NumSol do
           Write(SolFile,SolLib[i]);
     Close(SolFile);
end;









procedure TCreateSolForm.Button3Click(Sender: TObject);
begin
     CreateSolForm.close;
     CreateCaseForm.show;
end;

procedure TCreateSolForm.FormShow(Sender: TObject);
var
   i : byte;
begin
     Med1.Clear;
     Med1.Text := 'None';
     Med1.Items.Add('None');
     Med2.Clear;
     Med2.Text := 'None';
     Med2.Items.Add('None');
     Med3.Clear;
     Med3.Text := 'None';
     Med3.Items.Add('None');
     Med4.Clear;
     Med4.Text := 'None';
     Med4.Items.Add('None');
     Med5.Clear;
     Med5.Text := 'None';
     Med5.Items.Add('None');

     For i := 1 to NumMed do
     begin
          Med1.Items.Add(MedLib[i].MedName);
          Med2.Items.Add(MedLib[i].MedName);
          Med3.Items.Add(MedLib[i].MedName);
          Med4.Items.Add(MedLib[i].MedName);
          Med5.Items.Add(MedLib[i].MedName);
     end;
end;

procedure TCreateSolForm.RecordButtonClick(Sender: TObject);
var
   TempSol : SolutionRecord;
   Error : integer;
   TempByte : byte;
   i : Word;
begin
     If SolName.Text <> '' then
     begin
          TempSol.SolName := SolName.Text;
          TempSol.Suggestion := Suggestion.Text;

          If UrgentBox.Checked = true then
             TempSol.Day := 255
          Else
          begin
               Val(Day.Text,TempByte,Error);
               If TempByte >= 0 then
                  TempSol.Day := TempByte;
          end;
          For i := 1 to 5 do
              TempSol.Med[i] := 0;
          For i := 1 to NumMed do
          begin
               If Med1.Text = MedLib[i].MedName then
                  TempSol.Med[1] := i;
               If Med2.Text = MedLib[i].MedName then
                  TempSol.Med[2] := i;
               If Med3.Text = MedLib[i].MedName then
                  TempSol.Med[3] := i;
               If Med4.Text = MedLib[i].MedName then
                  TempSol.Med[4] := i;
               If Med5.Text = MedLib[i].MedName then
                  TempSol.Med[1] := 5;
          end;
          Inc(NumSol);
          SolLib[NumSol]:= TempSol;
          SaveSolFile;
          CreateSolForm.close;
          CreateCaseForm.show;
     end;
end;

procedure TCreateSolForm.Button2Click(Sender: TObject);
begin
     CreateMedForm.MedName.Text := '';
     CreateMedForm.Detail.Text := '';
     CreateMedForm.Adult.Text := '';
     CreateMedForm.Youth.Text := '';
     CreateSolForm.hide;
     CreateMedForm.show;
end;

end.
