unit Head;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  THeadForm = class(TForm)
    Feat0003Group: TGroupBox;
    Feat00030: TRadioButton;
    Feat00037: TRadioButton;
    Feat000310: TRadioButton;
    Feat1025Group: TGroupBox;
    Feat10250: TRadioButton;
    Feat10252: TRadioButton;
    Feat10251: TRadioButton;
    Feat1084: TCheckBox;
    Feat1090: TCheckBox;
    Feat1091: TCheckBox;
    Feat1092: TCheckBox;
    Feat1096: TCheckBox;
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
  HeadForm: THeadForm;

implementation

uses AttrEnter;

{$R *.DFM}










procedure THeadForm.CancelButtonClick(Sender: TObject);
begin
     HeadForm.close;
     AttrEnterForm.show;
end;

procedure THeadForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;
     If not(Feat00030.Checked = true) then
     begin
          Stail^.Feat := 3;
          If (Feat00037.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000310.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10250.Checked = true) then
     begin
          Stail^.Feat := 1025;
          If (Feat10251.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10252.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1084.Checked = true) then
     begin
          Stail^.Feat := 1084;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1090.Checked = true) then
     begin
          Stail^.Feat := 1090;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1091.Checked = true) then
     begin
          Stail^.Feat := 1091;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1092.Checked = true) then
     begin
          Stail^.Feat := 1092;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1096.Checked = true) then
     begin
          Stail^.Feat := 1096;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          HeadForm.close;
          AttrEnterForm.show;
          AttrEnterForm.HeadButton.Enabled := False;
     end;
end;

end.
