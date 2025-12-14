unit Skin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSkinForm = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    SkinGroup: TGroupBox;
    Feat1026: TGroupBox;
    Feat10260: TRadioButton;
    Feat10261: TRadioButton;
    Feat10262: TRadioButton;
    Feat10263: TRadioButton;
    Feat10264: TRadioButton;
    Feat10265: TRadioButton;
    Feat10266: TRadioButton;
    Feat1027: TGroupBox;
    Feat10270: TRadioButton;
    Feat10271: TRadioButton;
    Feat10272: TRadioButton;
    Feat10273: TRadioButton;
    Feat10274: TRadioButton;
    Feat1028: TGroupBox;
    Feat10280: TRadioButton;
    Feat10281: TRadioButton;
    Feat10282: TRadioButton;
    Feat10283: TRadioButton;
    Feat1029: TGroupBox;
    Feat10290: TRadioButton;
    Feat10291: TRadioButton;
    Feat10292: TRadioButton;
    Feat1030: TGroupBox;
    Label1: TLabel;
    Feat10300: TRadioButton;
    Feat10301: TRadioButton;
    Feat10302: TRadioButton;
    Feat1032: TGroupBox;
    Feat10320: TRadioButton;
    Feat10321: TRadioButton;
    Feat10322: TRadioButton;
    Feat10323: TRadioButton;
    Feat1033: TGroupBox;
    Feat10330: TRadioButton;
    Feat10331: TRadioButton;
    Feat10332: TRadioButton;
    Feat1031: TCheckBox;
    GroupBox1: TGroupBox;
    Feat1063: TCheckBox;
    Feat1064: TCheckBox;
    Feat1098: TCheckBox;
    Feat1127: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SkinForm: TSkinForm;

implementation

uses AttrEnter;

{$R *.DFM}


procedure TSkinForm.CancelButtonClick(Sender: TObject);
begin
     SkinForm.Close;
     AttrEnterForm.show;
end;

procedure TSkinForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat10260.Checked = true) then
     begin
          Stail^.Feat := 1026;
          If (Feat10261.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10262.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10263.Checked = true) then
               Stail^.Attr := 3
          Else If (Feat10264.Checked = true) then
               Stail^.Attr := 4
          Else If (Feat10265.Checked = true) then
               Stail^.Attr := 5
          Else If (Feat10266.Checked = true) then
               Stail^.Attr := 6;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10270.Checked = true) then
     begin
           Stail^.Feat := 1027;
           If (Feat10271.Checked = true) then
              Stail^.Attr := 1
           Else If (Feat10272.Checked = true) then
                Stail^.Attr := 2
           Else If (Feat10273.Checked = true) then
                Stail^.Attr := 3
           Else If (Feat10274.Checked = true) then
                Stail^.Attr := 4;
           new(Stail^.Next);
           Stail := Stail^.Next;
     end;

     If not(Feat10280.Checked = true) then
     begin
          Stail^.Feat := 1028;
          If (Feat10281.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10282.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10283.Checked = true) then
               Stail^.Attr := 3;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10290.Checked = true) then
     begin
          Stail^.Feat := 1029;
          If (Feat10291.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10292.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10300.Checked = true) then
     begin
          Stail^.Feat := 1030;
          If (Feat10301.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10302.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1031.Checked = true) then
     begin
          Stail^.Feat := 1031;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10320.Checked = true) then
     begin
          Stail^.Feat := 1032;
          If (Feat10321.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10322.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10323.Checked = true) then
               Stail^.Attr := 3;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10330.Checked = true) then
     begin
          Stail^.Feat := 1033;
          If (Feat10331.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10332.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1063.Checked = true) then
     begin
          Stail^.Feat := 1063;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1064.Checked = true) then
     begin
          Stail^.Feat := 1064;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1098.Checked = true) then
     begin
          Stail^.Feat := 1098;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1127.Checked = true) then
     begin
          Stail^.Feat := 1127;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          SkinForm.close;
          AttrEnterForm.show;
          AttrEnterForm.SkinButton.Enabled := False;
     end;
end;


end.
