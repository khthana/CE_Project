unit Face;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFaceForm = class(TForm)
    FaceGroup: TGroupBox;
    Feat1034: TGroupBox;
    Feat10340: TRadioButton;
    Feat10341: TRadioButton;
    Feat10342: TRadioButton;
    Feat10343: TRadioButton;
    Feat1035: TCheckBox;
    Feat1036: TCheckBox;
    Feat1093: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    MouthGroup: TGroupBox;
    Feat1048: TGroupBox;
    Feat10480: TRadioButton;
    Feat10481: TRadioButton;
    Feat10482: TRadioButton;
    Feat1050: TGroupBox;
    Feat10500: TRadioButton;
    Feat1049: TCheckBox;
    Feat10501: TRadioButton;
    Feat10502: TRadioButton;
    Feat1051: TCheckBox;
    Feat1052: TCheckBox;
    Feat1053: TGroupBox;
    Feat10530: TRadioButton;
    Feat10531: TRadioButton;
    Feat10532: TRadioButton;
    Feat1054: TCheckBox;
    Feat1097: TCheckBox;
    Feat1099: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FaceForm: TFaceForm;

implementation

uses AttrEnter;

{$R *.DFM}


procedure TFaceForm.CancelButtonClick(Sender: TObject);
begin
     FaceForm.close;
     AttrEnterForm.show;
end;

procedure TFaceForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat10340.Checked = true) then
     begin
          Stail^.Feat := 1034;
          If (Feat10341.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10342.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10343.Checked = true) then
               Stail^.Attr := 3;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1035.Checked = true) then
     begin
          Stail^.Feat := 1035;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1036.Checked = true) then
     begin
          Stail^.Feat := 1036;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1093.Checked = true) then
     begin
          Stail^.Feat := 1093;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10480.Checked) then
     begin
          Stail^.Feat := 1048;
          If (Feat10481.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10482.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;     
     If not(Feat10500.Checked) then
     begin
          Stail^.Feat := 1050;
          If (Feat10530.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10530.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If not(Feat10530.Checked) then
     begin
          Stail^.Feat := 1053;
          If (Feat10531.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10532.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1049.Checked = true) then
     begin
          Stail^.Feat := 1049;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1051.Checked = true) then
     begin
          Stail^.Feat := 1051;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1054.Checked = true) then
     begin
          Stail^.Feat := 1054;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1097.Checked = true) then
     begin
          Stail^.Feat := 1097;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1052.Checked = true) then
     begin
          Stail^.Feat := 1052;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1099.Checked = true) then
     begin
          Stail^.Feat := 1099;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;



     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          FaceForm.close;
          AttrEnterForm.show;
          AttrEnterForm.FaceButton.Enabled := False;
     end;
end;

end.
