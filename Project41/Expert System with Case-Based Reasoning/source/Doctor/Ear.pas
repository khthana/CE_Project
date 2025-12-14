unit Ear;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TEarForm = class(TForm)
    EarGroup: TGroupBox;
    Feat1043: TCheckBox;
    Feat1044: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    EyeGroup: TGroupBox;
    Feat0004: TGroupBox;
    Feat00040: TRadioButton;
    Feat00047: TRadioButton;
    Feat000410: TRadioButton;
    Feat1037: TGroupBox;
    Feat10370: TRadioButton;
    Feat10371: TRadioButton;
    Feat10372: TRadioButton;
    Feat1038: TGroupBox;
    Feat10380: TRadioButton;
    Feat10381: TRadioButton;
    Feat1039: TGroupBox;
    Feat10390: TRadioButton;
    Feat10391: TRadioButton;
    Feat10392: TRadioButton;
    Feat1040: TCheckBox;
    Feat1088: TCheckBox;
    Feat1094: TCheckBox;
    Feat1095: TCheckBox;
    NoseGroup: TGroupBox;
    Feat1041: TGroupBox;
    Feat10410: TRadioButton;
    Feat10411: TRadioButton;
    Feat10412: TRadioButton;
    Feat1042: TGroupBox;
    Feat10421: TRadioButton;
    Feat10422: TRadioButton;
    Feat10423: TRadioButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure Feat10410Click(Sender: TObject);
    procedure Feat10411Click(Sender: TObject);
    procedure Feat10412Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EarForm: TEarForm;

implementation

uses AttrEnter, Head;

{$R *.DFM}


procedure TEarForm.CancelButtonClick(Sender: TObject);
begin
     AttrEnterForm.show;
     EarForm.Close;
end;

procedure TEarForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat10390.Checked = true) then
     begin
          Stail^.Feat := 1039;
          If (Feat10391.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10392.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat10381.Checked = true) then
     begin
          Stail^.Feat := 1038;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If not(Feat10370.Checked = true) then
     begin
          Stail^.Feat := 1037;
          If (Feat10371.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10372.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If not(Feat00040.Checked = true) then
     begin
          Stail^.Feat := 4;
          If (Feat00047.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000410.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1040.Checked = true) then
     begin
          Stail^.Feat := 1040;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1088.Checked = true) then
     begin
          Stail^.Feat := 1088;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1094.Checked = true) then
     begin
          Stail^.Feat := 1094;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1095.Checked = true) then
     begin
          Stail^.Feat := 1095;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10410.Checked = true) then
     begin
           Stail^.Feat := 1041;
           If (Feat10411.Checked = true) then
              Stail^.Attr := 1
           Else If (Feat10412.Checked = true) then
                Stail^.Attr := 2;
           new(Stail^.Next);
           Stail := Stail^.Next;

           Stail^.Feat := 1042;
           If (Feat10421.Checked = true) then
              Stail^.Attr := 1
           Else If (Feat10422.Checked = true) then
                Stail^.Attr := 2
           Else If (Feat10423.Checked = true) then
                Stail^.Attr := 3
           Else Stail^.Attr := 0;

           If Stail^.Attr <> 0 then
           begin
           new(Stail^.Next);
           Stail := Stail^.Next;
           end;
     end;

     If (Feat1043.Checked = true) then
     begin
          Stail^.Feat := 1043;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1044.Checked = true) then
     begin
          Stail^.Feat := 1044;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          EarForm.close;
          AttrEnterForm.show;
          AttrEnterForm.EarButton.Enabled := False;
     end;
end;

procedure TEarForm.Feat10410Click(Sender: TObject);
begin
     If Feat1042.Enabled = true then
        Feat1042.Enabled := false;
end;

procedure TEarForm.Feat10411Click(Sender: TObject);
begin
     If Feat1042.Enabled = false then
        Feat1042.Enabled := true;
end;

procedure TEarForm.Feat10412Click(Sender: TObject);
begin
     If Feat1042.Enabled = false then
        Feat1042.Enabled := true;
end;

procedure TEarForm.FormShow(Sender: TObject);
begin
     Feat10421.Checked := false;
     Feat10422.Checked := false;
     Feat10423.Checked := false;
end;

end.
