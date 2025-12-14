unit SaveLib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSaveForm = class(TForm)
    Label2: TLabel;
    FileName: TEdit;
    SaveButton: TButton;
    CancelButton: TButton;
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveForm: TSaveForm;

implementation

uses AttrMain;

{$R *.DFM}


procedure TSaveForm.SaveButtonClick(Sender: TObject);
var
   LibFile : File;
   Buffer : Array[1..102400] of Byte;
   Count : LongInt;
   CaseNo : Word;
   NumAnd : byte;
   NumOr : byte;
   AndPtr : AndFeat;
   OrPtr : OrFeat;
   TempPtr : OrFeat;

begin
     If FileName.Text <> '' then
     begin
          Count := 1;
          Buffer[Count] := (Index-1) div 256;
          Buffer[Count+1] := (Index-1) mod 256;
          Count := Count + 2;
          For CaseNo := 1 to (Index-1) do
          begin
               Buffer[Count] := CaseLib[CaseNo].SolNo div 256;
               Buffer[Count+1] := CaseLib[CaseNo].SolNo mod 256;
               Count := Count + 2;
               AndPtr := CaseLib[CaseNo].Feature;
               NumAnd := 0;
               While AndPtr <> Nil do
               begin
                    AndPtr := AndPtr^.NextAnd;
                    Inc(NumAnd);
               end;
               Buffer[Count] := NumAnd;
               Inc(Count);

               AndPtr := CaseLib[CaseNo].Feature;
               While AndPtr <> Nil do
               begin
                    OrPtr := AndPtr^.GroupOr;
                    //TempPtr := OrPtr;
                    NumOr := 0;
                    While OrPtr <> Nil do
                    begin
                         OrPtr := OrPtr^.NextOr;
                         Inc(NumOr);
                    end;
                    Buffer[Count] := NumOr;
                    Inc(Count);

                    OrPtr := AndPtr^.GroupOr;
                    While OrPtr <> Nil do
                    begin
                         Buffer[Count] := OrPtr^.Feat div 256;
                         Buffer[Count+1] := OrPtr^.Feat mod 256;
                         Buffer[Count+2] := OrPtr^.Attr;
                         Count := Count + 3;
                         OrPtr := OrPtr^.NextOr;
                    end;

                    AndPtr := AndPtr^.NextAnd;
               end;
          end;
          AssignFile(LibFile,FileName.Text + '.cas');
          Rewrite(LibFile);
          BlockWrite(LibFile,Buffer,(Count div 128)+1);
          CloseFile(LibFile);
          SaveForm.close;
          AttrForm.show;
          AttrForm.SaveButton.Enabled := False;
          AttrForm.LoadButton.Enabled := False;
     end;

end;

procedure TSaveForm.CancelButtonClick(Sender: TObject);
begin
     AttrForm.show;
     SaveForm.Close;
end;

end.
