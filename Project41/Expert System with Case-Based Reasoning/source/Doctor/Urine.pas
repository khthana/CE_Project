unit Urine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TUrineForm = class(TForm)
    UrineGroup: TGroupBox;
    Feat1065: TGroupBox;
    Feat10650: TRadioButton;
    Feat10651: TRadioButton;
    Feat1110: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    Feat0007: TGroupBox;
    Feat00070: TRadioButton;
    Feat00072: TRadioButton;
    Feat00074: TRadioButton;
    Feat00076: TRadioButton;
    Feat00078: TRadioButton;
    Feat000710: TRadioButton;
    Feat1066: TGroupBox;
    Feat10660: TRadioButton;
    Feat10661: TRadioButton;
    Feat10662: TRadioButton;
    Feat1067: TCheckBox;
    Feat1115: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UrineForm: TUrineForm;

implementation

uses AttrEnter;

{$R *.DFM}


procedure TUrineForm.CancelButtonClick(Sender: TObject);
begin
     UrineForm.Close;
     AttrEnterForm.Show;
end;

procedure TUrineForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat10650.Checked = true) then
     begin
          Stail^.Feat := 1065;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1110.Checked = true) then
     begin
          Stail^.Feat := 1110;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat00070.Checked = true) then
     begin
          Stail^.Feat := 7;
          If (Feat00072.Checked = true) then
             Stail^.Attr := 2
          Else If (Feat00074.Checked = true) then
               Stail^.Attr := 4
          Else If (Feat00076.Checked = true) then
               Stail^.Attr := 6
          Else If (Feat00078.Checked = true) then
               Stail^.Attr := 8
          Else If (Feat000710.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10660.Checked = true) then
     begin
          Stail^.Feat := 1066;
          If (Feat10661.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10662.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1067.Checked = true) then
     begin
          Stail^.Feat := 1067;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1115.Checked = true) then
     begin
          Stail^.Feat := 1115;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          UrineForm.close;
          AttrEnterForm.show;
          AttrEnterForm.UrineButton.Enabled := False;
     end;
end;

end.
