unit History;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  THistoryForm = class(TForm)
    Feat1001: TGroupBox;
    Feat10011: TRadioButton;
    Feat10012: TRadioButton;
    Feat10010: TRadioButton;
    Feat1013: TCheckBox;
    Feat1003: TCheckBox;
    Feat1004: TCheckBox;
    Feat1005: TCheckBox;
    Feat1006: TCheckBox;
    Feat1007: TCheckBox;
    Feat1008: TCheckBox;
    Feat1009: TCheckBox;
    Feat1011: TCheckBox;
    Feat1012: TCheckBox;
    Feat1002: TCheckBox;
    Feat1014: TGroupBox;
    Feat10141: TRadioButton;
    Feat10140: TRadioButton;
    Feat10142: TRadioButton;
    Feat1015: TCheckBox;
    Feat1016: TCheckBox;
    Feat1017: TCheckBox;
    Feat1018: TCheckBox;
    Feat1020: TCheckBox;
    Feat1019: TGroupBox;
    Feat10191: TRadioButton;
    Feat10192: TRadioButton;
    Feat10190: TRadioButton;
    Feat1021: TCheckBox;
    Feat1022: TCheckBox;
    Feat1023: TCheckBox;
    Feat1024: TCheckBox;
    Feat1089: TCheckBox;
    Feat1086: TCheckBox;
    Feat1087: TCheckBox;
    Feat1085: TCheckBox;
    Feat1117: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HistoryForm: THistoryForm;

implementation

uses AttrEnter;

{$R *.DFM}






















procedure THistoryForm.CancelButtonClick(Sender: TObject);
begin
     HistoryForm.Hide;
     AttrEnterForm.Show;
end;

procedure THistoryForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat10010.Checked = true) then
     begin
          Stail^.Feat := 1001;
          If (Feat10011.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10012.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1002.Checked = true) then
     begin
          Stail^.Feat := 1002;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1003.Checked = true) then
     begin
          Stail^.Feat := 1003;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1004.Checked = true) then
     begin
          Stail^.Feat := 1004;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1005.Checked = true) then
     begin
          Stail^.Feat := 1005;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1006.Checked = true) then
     begin
          Stail^.Feat := 1006;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1007.Checked = true) then
     begin
          Stail^.Feat := 1007;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1008.Checked = true) then
     begin
          Stail^.Feat := 1008;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1009.Checked = true) then
     begin
          Stail^.Feat := 1009;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1011.Checked = true) then
     begin
          Stail^.Feat := 1011;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1012.Checked = true) then
     begin
          Stail^.Feat := 1012;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1013.Checked = true) then
     begin
          Stail^.Feat := 1013;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10140.Checked = true) then
     begin
          Stail^.Feat := 1014;
          If (Feat10141.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10142.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1015.Checked = true) then
     begin
          Stail^.Feat := 1015;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1016.Checked = true) then
     begin
          Stail^.Feat := 1016;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1017.Checked = true) then
     begin
          Stail^.Feat := 1017;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1018.Checked = true) then
     begin
          Stail^.Feat := 1018;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10190.Checked = true) then
     begin
          Stail^.Feat := 1019;
          If (Feat10191.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10192.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1020.Checked = true) then
     begin
          Stail^.Feat := 1020;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1021.Checked = true) then
     begin
          Stail^.Feat := 1021;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1022.Checked = true) then
     begin
          Stail^.Feat := 1022;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1023.Checked = true) then
     begin
          Stail^.Feat := 1023;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1024.Checked = true) then
     begin
          Stail^.Feat := 1024;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1085.Checked = true) then
     begin
          Stail^.Feat := 1085;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1086.Checked = true) then
     begin
          Stail^.Feat := 1086;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1087.Checked = true) then
     begin
          Stail^.Feat := 1087;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1089.Checked = true) then
     begin
          Stail^.Feat := 1089;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1117.Checked = true) then
     begin
          Stail^.Feat := 1117;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          HistoryForm.close;
          AttrEnterForm.show;
          AttrEnterForm.HistoryButton.Enabled := False;
     end;
end;

end.
