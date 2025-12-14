unit LoadLib;

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

uses AttrMain;

{$R *.DFM}


procedure TLoadForm.CancelButtonClick(Sender: TObject);
begin
     AttrForm.show;
     LoadForm.Close;
end;

procedure TLoadForm.LoadButtonClick(Sender: TObject);
var
   LibFile : File;
   Buffer : Array[1..102400] of Byte;
   Count : LongInt;
   NoCase : Word;
   NumAnd : byte;
   NumOr : byte;
   AndPtr : AndFeat;
   OrPtr : OrFeat;
   Result : Integer;
   i,j : byte;
begin
     If FileName.text <> '' then
     begin
        AssignFile(LibFile,FileName.Text + '.cas');
        Reset(LibFile,1);
        BlockRead(LibFile,Buffer,SizeOf(Buffer),Result);
        CloseFile(LibFile);

        Count := 1;
        AttrMain.Index := (Buffer[Count]*256) + Buffer[Count+1] + 1;
        Count := Count + 2;
        For NoCase := 1 to (AttrMain.Index-1) do
        begin
             CaseLib[NoCase].SolNo := (Buffer[Count]*256) + Buffer[Count+1];
             Count := Count + 2;
             New(CaseLib[NoCase].Feature);
             AndPtr := CaseLib[NoCase].Feature;
             NumAnd := Buffer[Count];
             Inc(Count);

             For i := 1 to NumAnd do
             begin
                  New(AndPtr^.GroupOr);
                  AndPtr^.NextAnd := Nil;
                  OrPtr := AndPtr^.GroupOr;
                  NumOr := Buffer[Count];
                  Inc(Count);

                  For j := 1 to NumOr do
                  begin
                       OrPtr^.Feat := (Buffer[Count]*256) + Buffer[Count+1];
                       OrPtr^.Attr := Buffer[Count+2];
                       Count := Count + 3;
                       If j = NumOr then
                          OrPtr^.NextOr := Nil
                       Else
                       begin
                            New(OrPtr^.NextOr);
                            OrPtr := OrPtr^.NextOr;
                       end;
                  end;
                  If i = NumAnd then
                     AndPtr^.NextAnd := Nil
                  Else
                  begin
                       New(AndPtr^.NextAnd);
                       AndPtr := AndPtr^.NextAnd;
                  end;
             end;
        end;
        LoadForm.close;
        AttrForm.Show;
        AttrForm.LoadButton.Enabled := False;
     end;
end;

end.
