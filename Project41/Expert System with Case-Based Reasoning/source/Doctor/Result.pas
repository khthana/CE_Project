unit Result;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TResultForm = class(TForm)
    BestList: TListBox;
    CloseButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    MatchVal: TEdit;
    Label4: TLabel;
    NoBestMatch: TEdit;
    Label5: TLabel;
    NoAllMatch: TEdit;
    Button2: TButton;
    Button3: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultForm: TResultForm;
  WriteAdaptMed : boolean;

implementation

uses AttrEnter, DetailResult,MainScreen, AllMatch, CreateCase;

{$R *.DFM}

procedure Adapt(Feat : Word;Attr : byte);
var
   count : Word;
   AndNode : AndPtr;
   OrNode : OrPtr;
   i : byte;
   TempStr : String;
   ResultStr : String;
begin
     For count := 1 to NumCase do
     begin
          AndNode := CaseLib[count].Feature;
          OrNode := AndNode^.OrGroup;
          If (AndNode^.NextAnd = nil) and (OrNode^.NextOr = nil)
          and (OrNode^.Feat = Feat) and (OrNode^.Attr = Attr) then
          begin
               If SolLib[CaseLib[count].SolNo].Suggestion <> '' then
               DetailResultForm.AdaptSuggestion.Lines.Add(
               SolLib[CaseLib[count].SolNo].Suggestion);
               For i := 1 to 5 do
               begin
                    If SolLib[CaseLib[count].SolNo].Med[i] <> 0 then
                    begin
                    Str(SolLib[CaseLib[count].SolNo].Med[i]:4,TempStr);
                    ResultStr := TempStr + ':' +
                    MedLib[SolLib[CaseLib[count].SolNo].Med[i]].MedName;
                    DetailResultForm.AdaptMedList.Items.Add(ResultStr);
                    If WriteAdaptMed = false then
                    begin
                         WriteAdaptMed := true;
                         DetailResultForm.AdaptMedList.Text := ResultStr;
                    end;
                    end;
               end;
               If SolLib[CaseLib[count].SolNo].Day = 255 then
               DetailResultForm.AdaptSuggestion.Lines.Add('¾ºá¾·Âì´èÇ¹');               
          end;
     end;
end;


procedure TResultForm.CloseButtonClick(Sender: TObject);
begin
     resultForm.Hide;
     AttrEnterForm.Show;
end;


procedure TResultForm.Button1Click(Sender: TObject);
var
   count : byte;
   i : byte;
   ShowNo : byte;
   ShowCase : Word;
   TempStr : String;
   AndNode : AndPtr;
   OrNode : OrPtr;
   Found : boolean;
begin
     count := 0;
     ShowNo := 0;
     Btail := Bhead;
     While Btail <> nil do
     begin
          Inc(count);
          Btail := Btail^.Next;
     end;
     For i := 0 to (count-1) do
         If (BestList.Selected[i]) = true then
         ShowNo := i+1;
     If ShowNo > 0 then
     begin
     Btail := Bhead;
     For i := 1 to (ShowNo-1) do
         Btail := Btail^.Next;
     ShowCase := Btail^.CaseNo;
     DetailResult.CurrentDisplay := ShowCase;

     DetailResultForm.Suggestion.Lines.Clear;
     DetailResultForm.SolName.Text :=
     SolLib[CaseLib[ShowCase].SolNo].SolName;
     If SolLib[CaseLib[ShowCase].SolNo].Suggestion <> '' then
     DetailResultForm.Suggestion.Lines.Add(
     SolLib[CaseLib[ShowCase].SolNo].Suggestion);

     i := SolLib[CaseLib[ShowCase].SolNo].Day;
     If i = 255 then
     DetailResultForm.Suggestion.Lines.Add('¾ºá¾·Âì´èÇ¹')
     Else If i = 0 then
          DetailResultForm.Day.Text := '-'
     Else
     begin
          Str(i,TempStr);
          DetailResultForm.Day.Text := TempStr;
     end;

     DetailResultForm.MedList.Clear;
     For i := 1 to 5 do
     If SolLib[CaseLib[ShowCase].SolNo].Med[i] <> 0 then
     begin
          Str(SolLib[CaseLib[ShowCase].SolNo].Med[i]:4,TempStr);
          DetailResultForm.MedList.Items.Add(TempStr + ':' +
          MedLib[SolLib[CaseLib[ShowCase].SolNo].Med[i]].MedName);
          If i = 1 then
          DetailResultForm.MedList.Text := TempStr + ':' +
          MedLib[SolLib[CaseLib[ShowCase].SolNo].Med[i]].MedName;
     end;

     DetailResultForm.AdaptSuggestion.Clear;
     DetailResultForm.AdaptMedList.Clear;
     Stail := Shead;
     WriteAdaptMed := false;
     While Stail <> nil do
     begin
          Found := false;
          AndNode := CaseLib[ShowCase].Feature;
          While AndNode <> nil do
          begin
                OrNode := AndNode^.OrGroup;
                While OrNode <> nil do
                begin
                     If (OrNode^.Feat < 1000) then
                        If OrNode^.Feat = Stail^.Feat then
                           Found := true
                     Else
                         If (OrNode^.Feat = Stail^.Feat) and
                         (OrNode^.Attr = Stail^.Attr) then
                                       Found := true;
                     OrNode := OrNode^.NextOr;
                end;
                AndNode := AndNode^.NextAnd;
          end;
          If Found = false then
             Adapt(Stail^.Feat,Stail^.Attr);
          Stail := Stail^.Next;
     end;

     DetailResultForm.show;
     ResultForm.Hide;
     end;
end;


procedure TResultForm.Button2Click(Sender: TObject);
begin
     AllMatchForm.show;
     ResultForm.hide;
end;

procedure TResultForm.Button3Click(Sender: TObject);
begin
     CreateCaseForm.show;
     ResultForm.hide;
end;

end.
