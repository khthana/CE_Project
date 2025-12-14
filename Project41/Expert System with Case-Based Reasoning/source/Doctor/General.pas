unit General;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TGeneralForm = class(TForm)
    Feat00107: TCheckBox;
    FeverGroup: TGroupBox;
    Feat0001: TGroupBox;
    Feat00011: TRadioButton;
    Feat00012: TRadioButton;
    Feat00015: TRadioButton;
    Feat00017: TRadioButton;
    Feat000110: TRadioButton;
    Feat001010: TCheckBox;
    Feat1010: TCheckBox;
    Feat10101: TRadioButton;
    Feat10102: TRadioButton;
    Feat00027: TCheckBox;
    Feat0002Group: TGroupBox;
    Feat000210: TCheckBox;
    Feat1068Group: TGroupBox;
    Feat10681: TRadioButton;
    Feat10682: TRadioButton;
    Feat10691: TCheckBox;
    Feat1070: TCheckBox;
    Feat1071Group: TGroupBox;
    Feat10710: TRadioButton;
    Feat10711: TRadioButton;
    Feat1072: TCheckBox;
    Feat1073: TCheckBox;
    Feat1074: TCheckBox;
    Feat1075: TCheckBox;
    Feat1078: TCheckBox;
    Feat1079: TCheckBox;
    Feat1080Group: TGroupBox;
    Feat1080: TCheckBox;
    Feat10802: TRadioButton;
    Feat10801: TRadioButton;
    Feat1081: TCheckBox;
    Feat1083: TCheckBox;
    Feat1082: TGroupBox;
    Feat10821: TRadioButton;
    Feat10822: TRadioButton;
    Feat10823: TRadioButton;
    Feat0009: TGroupBox;
    Feat00097: TRadioButton;
    Feat000910: TRadioButton;
    Feat00090: TRadioButton;
    Feat0008: TGroupBox;
    Feat00080: TRadioButton;
    Feat00087: TRadioButton;
    Feat000810: TRadioButton;
    Feat0006: TGroupBox;
    Feat00060: TRadioButton;
    Feat00067: TRadioButton;
    Feat000610: TRadioButton;
    Feat10820: TRadioButton;
    Button1: TButton;
    Button2: TButton;
    Feat10680: TRadioButton;
    Feat1010Group: TGroupBox;
    GroupBox1: TGroupBox;
    Feat10761: TRadioButton;
    Feat10760: TRadioButton;
    Feat10762: TRadioButton;
    Feat1116: TCheckBox;
    Feat1124: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Feat00107Click(Sender: TObject);
    procedure Feat1010Click(Sender: TObject);
    procedure Feat00027Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Feat1080Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneralForm: TGeneralForm;

implementation

uses AttrEnter;

{$R *.DFM}












procedure TGeneralForm.Button2Click(Sender: TObject);
begin
     GeneralForm.close;
     AttrEnterForm.show;
end;

procedure TGeneralForm.Feat00107Click(Sender: TObject);
begin
     FeverGroup.Enabled := not(FeverGroup.Enabled);
end;

procedure TGeneralForm.Feat1010Click(Sender: TObject);
begin
     Feat1010Group.Enabled := not(Feat1010Group.Enabled);
end;

procedure TGeneralForm.Feat00027Click(Sender: TObject);
begin
     Feat0002Group.Enabled := not(Feat0002Group.Enabled);
end;


procedure TGeneralForm.Button1Click(Sender: TObject);
var
   TempPtr : ProbPtr;
begin
     TempPtr := Stail;
     If (Feat00107.Checked = true) then
     begin
          Stail^.Feat := 10;
          If (Feat001010.Checked = true) then
              Stail^.Attr := 10
          else
              Stail^.Attr := 7;
          new(Stail^.Next);
          Stail := Stail^.Next;

          Stail^.Feat := 1;
          If (Feat00011.Checked = true) then
               Stail^.Attr := 1
          Else If (Feat00012.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat00015.Checked = true) then
               Stail^.Attr := 5
          Else If (Feat00017.Checked = true) then
               Stail^.Attr := 7
          Else If (Feat000110.Checked = true) then
               Stail^.Attr := 10
          Else Stail^.Feat := 0;
          If Stail^.Feat = 1 then
          begin
                    new(Stail^.Next);
                    Stail := Stail^.Next;
          end;

          If (Feat1010.Checked = true) then
          begin
               Stail^.Feat := 1010;
               If (Feat10101.Checked = true) then
                  Stail^.Attr := 1
               Else If (Feat10102.Checked = true) then
                    Stail^.Attr := 2;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
     end;
     If (Feat00027.Checked = true) then
     begin
          Stail^.Feat := 2;
          If (Feat000210.Checked = true) then
             Stail^.Attr := 10
          Else
              Stail^.Attr := 7;
          new(Stail^.Next);
          Stail := Stail^.Next;

          If (Feat10691.Checked = true) then
          begin
               Stail^.Feat := 1069;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
          If (Feat1070.Checked = true) then
          begin
               Stail^.Feat := 1070;
               Stail^.Attr := 1;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;

          If not(Feat10680.Checked = true) then
          begin
               Stail^.Feat := 1068;
               If (Feat10681.Checked = true) then
                  Stail^.Attr := 1
               Else If (Feat10682.Checked = true) then
                    Stail^.Attr := 2;
               new(Stail^.Next);
               Stail := Stail^.Next;
          end;
     end;
     If not(Feat00090.Checked = true) then
     begin
          Stail^.Feat := 9;
          If (Feat00097.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000910.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1116.Checked = true) then
     begin
          Stail^.Feat := 1116;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat00080.Checked = true) then
     begin
          Stail^.Feat := 8;
          If (Feat00087.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000810.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat10711.Checked = true) then
     begin
          Stail^.Feat := 1071;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1072.Checked = true) then
     begin
          Stail^.Feat := 1072;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1073.Checked = true) then
     begin
          Stail^.Feat := 1073;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1074.Checked = true) then
     begin
          Stail^.Feat := 1074;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1081.Checked = true) then
     begin
          Stail^.Feat := 1081;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1075.Checked = true) then
     begin
          Stail^.Feat := 1075;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1078.Checked = true) then
     begin
          Stail^.Feat := 1078;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1079.Checked = true) then
     begin
          Stail^.Feat := 1079;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1083.Checked = true) then
     begin
          Stail^.Feat := 1083;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If (Feat1124.Checked = true) then
     begin
          Stail^.Feat := 1083;
          Stail^.Attr := 1;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat00060.Checked = true) then
     begin
          Stail^.Feat := 6;
          If (Feat00067.Checked = true) then
             Stail^.Attr := 7
          Else If (Feat000610.Checked = true) then
               Stail^.Attr := 10;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If (Feat1080.Checked = true) then
     begin
          Stail^.Feat := 1080;
          If (Feat10801.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10802.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10820.Checked = true) then
     begin
          Stail^.Feat := 1082;
          If (Feat10821.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10822.Checked = true) then
               Stail^.Attr := 2
          Else If (Feat10823.Checked = true) then
               Stail^.Attr := 3;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;

     If not(Feat10760.Checked = true) then
     begin
          Stail^.Feat := 1076;
          If (Feat10761.Checked = true) then
             Stail^.Attr := 1
          Else If (Feat10762.Checked = true) then
               Stail^.Attr := 2;
          new(Stail^.Next);
          Stail := Stail^.Next;
     end;
     If TempPtr <> Stail then
     begin
          Stail^.Next := Nil;
          GeneralForm.close;
          AttrEnterForm.show;
          AttrEnterForm.GeneralButton.Enabled := False;
     end;
end;



procedure TGeneralForm.Feat1080Click(Sender: TObject);
begin
     Feat1080Group.Enabled := not(Feat1080Group.Enabled);     
end;

end.
