unit CreateCase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TCreateCaseForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SolutionBox: TComboBox;
    RecordButton: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateCaseForm: TCreateCaseForm;

implementation

uses Result,MainScreen,AttrEnter,SelectFile, CreateSol;

{$R *.DFM}

procedure SaveCaseFile;
var
   CaseFile : File;
   Buffer : Array[1..102400] of byte;
   Count : Longint;
   i : word;
   AndNode : AndPtr;
   OrNode : OrPtr;
   Num : byte;
begin
     Count := 1;
     Buffer[Count] := MainScreen.NumCase div 256;
     Buffer[Count+1] := MainScreen.NumCase mod 256;
     Count := Count + 2;

     For i := 1 to MainScreen.NumCase do
     begin
          Buffer[Count] := CaseLib[i].SolNo div 256;
          Buffer[Count+1] := CaseLib[i].SolNo mod 256;
          Count := Count + 2;

          AndNode := CaseLib[i].Feature;
          Num := 0;
          While AndNode <> nil do
          begin
               Inc(Num);
               AndNode := AndNode^.NextAnd;
          end;
          Buffer[Count] := Num;
          Inc(Count);
          AndNode := CaseLib[i].Feature;
          While AndNode <> Nil do
          begin
                OrNode := AndNode^.OrGroup;
                Num := 0;
                While OrNode <> Nil do
                begin
                     Inc(Num);
                     OrNode := OrNode^.NextOr;
                end;
                Buffer[Count] := Num;
                Inc(Count);
                OrNode := AndNode^.OrGroup;
                While OrNode <> Nil do
                begin
                     Buffer[Count] := OrNode^.Feat div 256;
                     Buffer[Count+1] := OrNode^.Feat mod 256;
                     Buffer[Count+2] := OrNode^.Attr;
                     Count := Count+3;
                     OrNode := OrNode^.NextOr;
                end;
                AndNode := AndNode^.NextAnd;
          end;
     end;
     AssignFile(CaseFile,CaseFileName);
     Rewrite(CaseFile);
     BlockWrite(CaseFile,Buffer,((Count-1)div 128)+ 1);
     Close(CaseFile);
end;


procedure TCreateCaseForm.Button2Click(Sender: TObject);
begin
     CreateCaseForm.close;
     ResultForm.show;
end;

procedure TCreateCaseForm.FormShow(Sender: TObject);
var
   i : Word;
begin
     For i := 1 to NumSol do
          CreateCaseForm.SolutionBox.Items.Add(SolLib[i].SolName);
     SolutionBox.Text := SolLib[1].SolName;
end;

procedure TCreateCaseForm.RecordButtonClick(Sender: TObject);
var
   i : word;
   AndNode : AndPtr;
   OrNode : OrPtr;
begin
     i := 1;
     While (SolutionBox.Text <> SolLib[i].SolName) do
           Inc(i);
     Inc(MainScreen.NumCase);
     CaseLib[MainScreen.NumCase].SolNo := i;
     Stail := Shead;
     new(CaseLib[MainScreen.NumCase].Feature);
     AndNode := CaseLib[MainScreen.NumCase].Feature;
     While Stail <> nil do
     begin
          new(AndNode^.OrGroup);
          OrNode := AndNode^.OrGroup;
          OrNode^.Feat := Stail^.Feat;
          OrNode^.Attr := Stail^.Attr;
          OrNode^.NextOr := nil;
          Stail := Stail^.Next;
          If Stail <> nil then
          begin
             new(AndNode^.NextAnd);
             AndNode := AndNode^.NextAnd;
          end
          Else
              AndNode^.NextAnd := nil;
     end;
     SaveCaseFile;
     CreateCaseForm.close;
     ResultForm.show;
end;

procedure TCreateCaseForm.Button3Click(Sender: TObject);
begin
     CreateSolForm.SolName.Text := '';
     CreateSolForm.Suggestion.Text := '';
     CreateCaseForm.hide;
     CreateSolForm.Show;
end;

end.
