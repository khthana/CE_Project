unit MainScreen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMainScreenForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
    OrPtr = ^SubFeature;
    SubFeature = record
                 Feat : Word;
            	 Attr : byte;
              	 NextOr : OrPtr;
              	 end;

    AndPtr = ^SubGroup;
    SubGroup = record
               OrGroup: OrPtr;
               NextAnd : AndPtr;
               end;

    CaseRecord = record
                 SolNo : Word;
                 Feature : AndPtr;
                 end;
    CaseLibrary = Array[1..300] of CaseRecord;

    SolutionRecord = record
                     //SolNo : Word;
                     SolName : String[30];
                     Suggestion : String[255];
                     Day : byte;
                     Med : Array[1..5] of byte;
                     end;
    SolutionLibrary = Array[1..255] of SolutionRecord;

    MedicineRecord = record
                     MedNo : byte;
                     MedName : String[30];
                     MedDetail : String[255];
                     MedAdult : String[255];
                     MedYouth : String[255];
                     end;
    MedicineLibrary = Array[1..255] of MedicineRecord;
var
  MainScreenForm: TMainScreenForm;
  CaseLib : CaseLibrary;
  NumCase : Word;
  SolLib : SolutionLibrary;
  NumSol : Word;
  MedLib : MedicineLibrary;
  NumMed : byte;


implementation

uses AttrEnter, SelectFile;

{$R *.DFM}

procedure FreeAll;
var
   i : Word;
   AndNode,TempAnd : AndPtr;
   OrNode,TempOr : OrPtr;
begin
     For i := 1 to NumCase do
     begin
          AndNode := CaseLib[i].Feature;
          While AndNode <> Nil do
          begin
               OrNode := AndNode^.OrGroup;
               While OrNode <> Nil do
               begin
                    TempOr := OrNode;
                    OrNode := OrNode^.NextOr;
                    dispose(TempOr);
               end;
               TempAnd := AndNode;
               AndNode := AndNode^.NextAnd;
               dispose(TempAnd);
          end;
     end;
end;



procedure TMainScreenForm.Button1Click(Sender: TObject);
begin
     new(Shead);
     Stail := Shead;
     Stail^.Feat := 0;
     Stail^.Attr := 0;
     Stail^.Next := nil;
     new(Rhead);
     Rtail := Rhead;
     Rtail^.Next := Nil;
     AttrEnterForm.show;
     MainScreenForm.hide;
end;

procedure TMainScreenForm.Button2Click(Sender: TObject);
begin
     FreeAll;
     SelectFileForm.close;
     MainScreenForm.close;
end;

end.
