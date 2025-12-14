unit Female;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFemaleForm = class(TForm)
    Feat1105: TCheckBox;
    Feat1114: TCheckBox;
    Feat1118: TCheckBox;
    Feat1122: TCheckBox;
    Feat1120: TCheckBox;
    Feat1121: TGroupBox;
    Feat11211: TRadioButton;
    Feat11212: TRadioButton;
    Feat1119: TCheckBox;
    Feat1123: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure Feat1119Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FemaleForm: TFemaleForm;

implementation

uses AttrEnter;

{$R *.DFM}








procedure TFemaleForm.CancelButtonClick(Sender: TObject);
begin
     FemaleForm.close;
     AttrEnterForm.show;
end;

procedure TFemaleForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If (Feat1105.Checked = true) then
     begin
          Stail^.Feat := 1105;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;          

     If (Feat1114.Checked = true) then
     begin
          Stail^.Feat := 1114;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1118.Checked = true) then
     begin
          Stail^.Feat := 1118;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1119.Checked = true) then
     begin
          Stail^.Feat := 1105;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;

          Stail^.Feat := 1121;
          If (Feat11211.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat11212.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1120.Checked = true) then
     begin
          Stail^.Feat := 1120;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1122.Checked = true) then
     begin
          Stail^.Feat := 1122;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1123.Checked = true) then
     begin
          Stail^.Feat := 1123;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          FemaleForm.close;
          AttrEnterForm.show;
          AttrEnterForm.FemaleButton.Enabled := False;
     end;
end;

procedure TFemaleForm.Feat1119Click(Sender: TObject);
begin
     Feat1121.Enabled := not(Feat1121.Enabled);
end;

end.
