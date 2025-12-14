unit SelectFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSelectFileForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CaseFileName: TEdit;
    SolutionFileName: TEdit;
    MedicineFileName: TEdit;
    LoadButton: TButton;
    DefaultButton: TButton;
    procedure LoadButtonClick(Sender: TObject);
    procedure DefaultButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectFileForm: TSelectFileForm;
  CaseFileName : String;
  SolutionFileName : String;
  MedicineFileName : String;

implementation

uses MainScreen;

{$R *.DFM}


procedure LoadFileLibrary;
var
   CaseFile : File;
   Buffer : Array[1..102400] of byte;
   Count : Longint;
   numread : integer;
   NumCase : Word;
   NumAnd : byte;
   NumOr : byte;
   i : Word;
   j,k : byte;
   AndNode : AndPtr;
   OrNode : OrPtr;

   SolutionFile : File of SolutionRecord;
   MedicineFile : File of MedicineRecord;
begin
     AssignFile(CaseFile,SelectFile.CaseFileName);
     Reset(CaseFile,1);
     BlockRead(CaseFile,Buffer,sizeOf(Buffer),numread);
     Close(CaseFile);

     Count := 1;
     NumCase := (Buffer[Count]*256) + Buffer[Count+1];
     Count := Count + 2;
     MainScreen.NumCase := NumCase;

     For i := 1 to NumCase do
     begin
          CaseLib[i].SolNo := (Buffer[Count]*256)+Buffer[Count+1];
          Count := Count + 2;
          New(CaseLib[i].Feature);
          AndNode := CaseLib[i].Feature;
          AndNode^.NextAnd := nil;

          NumAnd := Buffer[Count];
          Inc(Count);

          For j := 1 to NumAnd do
          begin
               NumOr := Buffer[Count];
               Inc(Count);
               New(AndNode^.OrGroup);
               AndNode^.NextAnd := Nil;
               OrNode := AndNode^.OrGroup;
               OrNode^.NextOr := nil;
               For k := 1 to NumOr do
               begin
                    OrNode^.Feat := (Buffer[Count]*256)+Buffer[Count+1];
                    OrNode^.Attr := Buffer[Count+2];
                    count := count + 3;
                    If k = NumOr then
                       OrNode^.NextOr := Nil
                    Else
                    begin
                        New(OrNode^.NextOr);
                        OrNode := OrNode^.NextOr;
                    end

               end;
               If j = NumAnd then
                    AndNode^.NextAnd := nil
               Else
               begin
                   New(AndNode^.NextAnd);
                   AndNode := AndNode^.NextAnd;
               end;
          end;
     end;


     AssignFile(SolutionFile,SelectFile.SolutionFileName);
     Reset(SolutionFile);
     i := 1;
     While not(EOF(SolutionFile)) do
     begin
          Read(SolutionFile,SolLib[i]);
          Inc(i);
     end;
     MainScreen.NumSol := i-1;
     Close(SolutionFile);

     AssignFile(MedicineFile,SelectFile.MedicineFileName);
     Reset(MedicineFile);
     j := 1;
     While not(EOF(MedicineFile)) do
     begin
          Read(MedicineFile,MedLib[j]);
          Inc(j);
     end;
     MainScreen.NumMed := j-1;
     Close(MedicineFile);
end;




procedure TSelectFileForm.LoadButtonClick(Sender: TObject);
begin
     If (CaseFileName.Text <> '') and
        (SolutionFileName.Text <> '') and
        (MedicineFileName.Text <> '') then
     begin
     SelectFileForm.Hide;
     MainScreenForm.Show;
     SelectFile.CaseFileName := CaseFileName.Text + '.cas';
     SelectFile.SolutionFileName := SolutionFileName.Text + '.sol';
     SelectFile.MedicineFileName := MedicineFileName.Text + '.med';
     LoadFileLibrary;
     end;
end;

procedure TSelectFileForm.DefaultButtonClick(Sender: TObject);
begin
     SelectFileForm.Hide;
     MainScreenForm.Show;
     SelectFile.CaseFileName := 'CaseLib.cas';
     SelectFile.SolutionFileName := 'CaseLib.sol';
     SelectFile.MedicineFileName := 'CaseLib.med';
     LoadFileLibrary;
end;

end.
