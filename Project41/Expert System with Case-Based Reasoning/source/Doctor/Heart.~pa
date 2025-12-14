unit Heart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  THeartForm = class(TForm)
    HeartGroup: TGroupBox;
    Feat1055: TCheckBox;
    LungGroup: TGroupBox;
    OkButton: TButton;
    CancelButton: TButton;
    Feat1045: TCheckBox;
    Feat1046: TGroupBox;
    Feat10461: TRadioButton;
    Feat10460: TRadioButton;
    Feat10462: TRadioButton;
    Feat1047: TGroupBox;
    Feat10471: TRadioButton;
    Feat10472: TRadioButton;
    Feat10470: TRadioButton;
    Feat10473: TRadioButton;
    Feat10474: TRadioButton;
    Feat10475: TRadioButton;
    Feat10476: TRadioButton;
    Feat0005: TGroupBox;
    Feat00050: TRadioButton;
    Feat00057: TRadioButton;
    Feat000510: TRadioButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HeartForm: THeartForm;

implementation

uses AttrEnter;

{$R *.DFM}


procedure THeartForm.CancelButtonClick(Sender: TObject);
begin
     HeartForm.close;
     AttrEnterForm.show;
end;

procedure THeartForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If (Feat1055.Checked = true) then
     begin
          Stail^.Feat := 1055;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1045.Checked = true) then
     begin
          Stail^.Feat := 1045;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10460.Checked = true) then
     begin
          Stail^.Feat := 1046;
          If (Feat10461.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10462.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10470.Checked = true) then
     begin
          Stail^.Feat := 1047;
          If (Feat10471.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10472.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10473.Checked = true) then
               Stail^.Attr := 3
          Else If (Feat10474.Checked = true) then
               Stail^.Attr := 4
          Else If (Feat10475.Checked = true) then
               Stail^.Attr := 5
          Else If (Feat10476.Checked = true) then
               Stail^.Attr := 6;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat00050.Checked = true) then
     begin
          Stail^.Feat := 5;
          If (Feat00057.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000510.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          HeartForm.close;
          AttrEnterForm.show;
          AttrEnterForm.HeartButton.Enabled := False;
     end;
end;

end.
