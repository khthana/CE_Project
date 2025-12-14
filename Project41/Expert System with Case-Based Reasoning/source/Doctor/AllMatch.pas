unit AllMatch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAllMatchForm = class(TForm)
    Label1: TLabel;
    MatchList: TListBox;
    CloseButton: TButton;
    ViewButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ViewButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AllMatchForm: TAllMatchForm;

implementation
uses AttrEnter,MainScreen, SolDetail, Result;
{$R *.DFM}

procedure TAllMatchForm.FormShow(Sender: TObject);
var
   TempStr : String;
   ResultStr : String;
begin
     MatchList.Clear;
     Rtail := Rhead;
     While Rtail <> nil do
     begin
          Str(Rtail^.Match:0:5,TempStr);
          ResultStr := TempStr + ' : ' +
          SolLib[CaseLib[Rtail^.CaseNo].SolNo].SolName;
          MatchList.Items.Add(ResultStr);
          Rtail := Rtail^.Next;
     end;
end;

procedure TAllMatchForm.CloseButtonClick(Sender: TObject);
begin
     AllMatchForm.close;
     ResultForm.show;
end;

procedure TAllMatchForm.ViewButtonClick(Sender: TObject);
var
   count : word;
   TempStr : String;
   i,j : byte;
   Num : byte;
begin
     Rtail := Rhead;
     Num := 0;
     While Rtail <> nil do
     begin
         Rtail := Rtail^.Next;
         Inc(Num);
     end;
     j := 0;
     For i := 0 to (Num-1) do
         If MatchList.Selected[i] = true then
         j := i;
     If (j+1) > 0 then
     begin
          TempStr := copy(MatchList.Items.Strings[j],11,30);
          count := 1;
          While TempStr <> SolLib[count].SolName do
                Inc(count);

          SolDetail.SolNo := count;
          SolDetailForm.show;
     end;
end;

end.
