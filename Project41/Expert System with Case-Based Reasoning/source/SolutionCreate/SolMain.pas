unit SolMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
    SolutionRec = record
                  Name : String[30];
                  Suggestion : String[255];
                  Day : byte;
                  Med : Array[1..5] of byte;
                  End;

  TSolForm = class(TForm)
    SolNoLabel: TLabel;
    NameLabel: TLabel;
    SuggestLabel: TLabel;
    CriticLabel: TLabel;
    DayLabel: TLabel;
    MedicineLabel: TLabel;
    Day: TEdit;
    Suggestion: TEdit;
    Name: TEdit;
    No: TEdit;
    Med1: TEdit;
    Med4: TEdit;
    Med2: TEdit;
    Med5: TEdit;
    Med3: TEdit;
    EnterButton: TButton;
    SaveButton: TButton;
    ViewButton: TButton;
    ClearButton: TButton;
    LoadButton: TButton;
    ExitButton: TButton;
    PreviousButton: TButton;
    NextButton: TButton;
    procedure ExitButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ViewButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SolForm: TSolForm;
  SolLib : Array[1..200] of SolutionRec;
  Index : byte;

implementation

uses LoadSol, SaveSol;

{$R *.DFM}

procedure ShowSolution(SolNo : byte);
var
   TempStr : String;

begin
     If SolNo <= Index then
     begin
          Str(SolNo,TempStr);
          SolForm.No.text := TempStr;
          SolForm.Name.Text := SolLib[SolNo].Name;
          SolForm.Suggestion.Text := SolLib[SolNo].Suggestion;
          Str(SolLib[SolNo].Day,TempStr);
          SolForm.Day.Text := TempStr;
          Str(SolLib[SolNo].Med[1],TempStr);
          SolForm.Med1.Text := TempStr;
          Str(SolLib[SolNo].Med[2],TempStr);
          SolForm.Med2.Text := TempStr;
          Str(SolLib[SolNo].Med[3],TempStr);
          SolForm.Med3.Text := TempStr;
          Str(SolLib[SolNo].Med[4],TempStr);
          SolForm.Med4.Text := TempStr;
          Str(SolLib[SolNo].Med[5],TempStr);
          SolForm.Med5.Text := TempStr;
     end;

end;

procedure TSolForm.ExitButtonClick(Sender: TObject);
begin
     SolForm.close;
end;

procedure TSolForm.EnterButtonClick(Sender: TObject);
var
   SolNo : byte;
   Error : Integer;
   TempStr : String;
begin
     If (No.text <> '') and (Name.text <> '') then
        begin
             Val(No.text,SolNo,Error);
             SolLib[SolNo].Name := Name.Text;
             //If Suggestion.Text <> '' then
                SolLib[SolNo].Suggestion := Suggestion.Text;
             If Day.text <> '' then
                Val(Day.text,SolLib[SolNo].Day,Error)
             Else
                 SolLib[SolNo].Day := 0;
             If Med1.Text <> '' then
                Val(Med1.text,SolLib[SolNo].Med[1],Error)
             Else
                 SolLib[SolNo].Med[1] := 0;
             If Med2.Text <> '' then
                Val(Med2.text,SolLib[SolNo].Med[2],Error)
             Else
                 SolLib[SolNo].Med[2] := 0;
             If Med3.Text <> '' then
                Val(Med3.text,SolLib[SolNo].Med[3],Error)
             Else
                 SolLib[SolNo].Med[3] := 0;
             If Med4.Text <> '' then
                Val(Med4.text,SolLib[SolNo].Med[4],Error)
             Else
                 SolLib[SolNo].Med[4] := 0;
             If Med5.Text <> '' then
                Val(Med5.text,SolLib[SolNo].Med[5],Error)
             Else
                 SolLib[SolNo].Med[5] := 0;

             If SolNo = Index then
                Inc(Index);
             Str(Index,TempStr);
             No.text := TempStr;
             Name.Text := '';
             Suggestion.Text := '';
             Day.Text := '';
             Med1.Text := '';
             Med2.Text := '';
             Med3.Text := '';
             Med4.Text := '';
             Med5.Text := '';
        end;
end;

procedure TSolForm.FormCreate(Sender: TObject);
begin
     Index := 1;
     No.text := '1';
end;

procedure TSolForm.ViewButtonClick(Sender: TObject);
var
   SolNo : byte;
   Error : Integer;
begin
     Val(No.text,SolNo,Error);
     If Error = 0 then
        ShowSolution(SolNo);
end;

procedure TSolForm.ClearButtonClick(Sender: TObject);
begin
     Name.text := '';
     Suggestion.text := '';
     Day.Text := '';
     Med1.text := '';
     Med2.text := '';
     Med3.text := '';
     Med4.text := '';
     Med5.text := '';
end;

procedure TSolForm.LoadButtonClick(Sender: TObject);
begin
     LoadForm.show;
     SolForm.hide;
end;

procedure TSolForm.SaveButtonClick(Sender: TObject);
begin
     SaveForm.show;
     SolForm.hide;
end;


procedure TSolForm.PreviousButtonClick(Sender: TObject);
var
   SolNo : byte;
   Error : Integer;
begin
     Val(No.Text,SolNo,Error);
     Dec(SolNo);
     If (SolNo >= 1) and (Error = 0) then
        ShowSolution(SolNo);
end;

procedure TSolForm.NextButtonClick(Sender: TObject);
var
   SolNo : byte;
   Error : Integer;
begin
     Val(No.Text,SolNo,Error);
     Inc(SolNo);
     If (SolNo <= Index) and (Error = 0) then
        ShowSolution(SolNo);
end;

end.
