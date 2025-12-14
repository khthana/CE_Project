unit Stomach;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TStomachForm = class(TForm)
    Feat0011Group: TGroupBox;
    Feat00110: TRadioButton;
    Feat00117: TRadioButton;
    Feat001110: TRadioButton;
    Feat0012Group: TGroupBox;
    Feat00120: TRadioButton;
    Feat00127: TRadioButton;
    Feat001210: TRadioButton;
    Feat1056: TCheckBox;
    Feat1057Group: TGroupBox;
    Feat10571: TRadioButton;
    Feat10572: TRadioButton;
    Feat10573: TRadioButton;
    Feat10574: TRadioButton;
    Feat10575: TRadioButton;
    Feat10576: TRadioButton;
    Feat10577: TRadioButton;
    Feat10578: TRadioButton;
    Feat10579: TRadioButton;
    Feat1058: TCheckBox;
    Feat1059: TCheckBox;
    Feat1060: TCheckBox;
    Feat1061Group: TGroupBox;
    Feat10610: TRadioButton;
    Feat10611: TRadioButton;
    Feat10612: TRadioButton;
    Feat1100: TCheckBox;
    Feat1102Group: TGroupBox;
    Feat11020: TRadioButton;
    Feat11021: TRadioButton;
    Feat11022: TRadioButton;
    Feat1103Group: TGroupBox;
    Feat11030: TRadioButton;
    Feat11031: TRadioButton;
    Feat11032: TRadioButton;
    Feat0011SubGroup: TGroupBox;
    Feat1062: TCheckBox;
    Feat1104: TCheckBox;
    Feat1107: TCheckBox;
    Feat1109: TCheckBox;
    Feat1111: TCheckBox;
    Feat1108: TCheckBox;
    Feat1106: TCheckBox;
    Feat1101: TCheckBox;
    Feat1112: TCheckBox;
    Feat0012SubGroup: TGroupBox;
    Feat1113: TCheckBox;
    Feat1125: TCheckBox;
    Feat1126: TCheckBox;
    Feat1128: TCheckBox;
    Feat1129: TCheckBox;
    Label1: TLabel;
    Feat1131: TCheckBox;
    Label2: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    Feat1057: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure Feat00110Click(Sender: TObject);
    procedure Feat00117Click(Sender: TObject);
    procedure Feat001110Click(Sender: TObject);
    procedure Feat00120Click(Sender: TObject);
    procedure Feat00127Click(Sender: TObject);
    procedure Feat001210Click(Sender: TObject);
    procedure Feat1057Click(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StomachForm: TStomachForm;

implementation

uses AttrEnter, Head;

{$R *.DFM}















procedure TStomachForm.CancelButtonClick(Sender: TObject);
begin
     StomachForm.close;
     AttrEnterForm.show;
end;

procedure TStomachForm.Feat00110Click(Sender: TObject);
begin
     If Feat0011SubGroup.Enabled = true then
        Feat0011SubGroup.Enabled := false;
end;

procedure TStomachForm.Feat00117Click(Sender: TObject);
begin
     If Feat0011SubGroup.Enabled = false then
        Feat0011SubGroup.Enabled := true;
end;

procedure TStomachForm.Feat001110Click(Sender: TObject);
begin
     If Feat0011SubGroup.Enabled = false then
        Feat0011SubGroup.Enabled := true;
end;

procedure TStomachForm.Feat00120Click(Sender: TObject);
begin
     If Feat0012SubGroup.Enabled = true then
        Feat0012SubGroup.Enabled := false;
end;

procedure TStomachForm.Feat00127Click(Sender: TObject);
begin
     If Feat0012SubGroup.Enabled = false then
        Feat0012SubGroup.Enabled := true;
end;

procedure TStomachForm.Feat001210Click(Sender: TObject);
begin
     If Feat0012SubGroup.Enabled = false then
        Feat0012SubGroup.Enabled := true;
end;

procedure TStomachForm.Feat1057Click(Sender: TObject);
begin
     Feat1057Group.Enabled := not(Feat1057Group.Enabled);
end;

procedure TStomachForm.OkButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;

     If not(Feat00110.Checked = true) then
     begin
          Stail^.Feat := 11;
          If Feat00117.Checked = true then
             Stail^.Attr := 7
          Else If Feat001110.Checked = true then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;

          If (Feat1062.Checked = true) then
          begin
               Stail^.Feat := 1062;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1107.Checked = true) then
          begin
               Stail^.Feat := 1107;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1109.Checked = true) then
          begin
               Stail^.Feat := 1109;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1111.Checked = true) then
          begin
               Stail^.Feat := 1111;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1108.Checked = true) then
          begin
               Stail^.Feat := 1108;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1106.Checked = true) then
          begin
               Stail^.Feat := 1106;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1104.Checked = true) then
          begin
               Stail^.Feat := 1104;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1101.Checked = true) then
          begin
               Stail^.Feat := 1101;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
     end;

     If not(Feat00120.Checked = true) then
     begin
          Stail^.Feat := 12;
          If (Feat00127.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat001210.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;

          If (Feat1113.Checked = true) then
          begin
               Stail^.Feat := 1113;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1125.Checked = true) then
          begin
               Stail^.Feat := 1125;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1126.Checked = true) then
          begin
               Stail^.Feat := 1126;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1128.Checked = true) then
          begin
               Stail^.Feat := 1128;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1129.Checked = true) then
          begin
               Stail^.Feat := 1129;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
     end;

     If not(Feat10610.Checked = true) then
     begin
          Stail^.Feat := 1061;
          If Feat10611.Checked = true then
             Stail^.Attr := 1
          Else If Feat10612.Checked = true then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat11020.Checked = true) then
     begin
          Stail^.Feat := 1102;
          If Feat11021.Checked = true then
             Stail^.Attr := 1
          Else If Feat11022.Checked = true then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1058.Checked = true) then
     begin
          Stail^.Feat := 1058;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1060.Checked = true) then
     begin
          Stail^.Feat := 1060;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1059.Checked = true) then
     begin
          Stail^.Feat := 1059;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1131.Checked = true) then
     begin
          Stail^.Feat := 1131;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1056.Checked = true) then
     begin
          Stail^.Feat := 1056;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1100.Checked = true) then
     begin
          Stail^.Feat := 1100;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1112.Checked = true) then
     begin
          Stail^.Feat := 1112;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat11030.Checked = true) then
     begin
          Stail^.Feat := 1103;
          If Feat11031.Checked = true then
             Stail^.Attr := 1
          Else If Feat11032.Checked = true then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If Feat1057.Checked = true then
     begin
          Stail^.Feat := 1057;

     end;


     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          StomachForm.close;
          AttrEnterForm.show;
          AttrEnterForm.StomachButton.Enabled := False;
     end;
end;

end.
