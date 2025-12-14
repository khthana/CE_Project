unit AttrEnter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAttrEnterForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    GeneralButton: TButton;
    RetrieveButton: TButton;
    ExitButton: TButton;
    StomachButton: TButton;
    HistoryButton: TButton;
    UrineButton: TButton;
    SkinButton: TButton;
    HeadButton: TButton;
    FemaleButton: TButton;
    FaceButton: TButton;
    HeartButton: TButton;
    EarButton: TButton;
    ClearButton: TButton;
    procedure GeneralButtonClick(Sender: TObject);
    procedure RetrieveButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure HeadButtonClick(Sender: TObject);
    procedure StomachButtonClick(Sender: TObject);
    procedure EarButtonClick(Sender: TObject);
    procedure FaceButtonClick(Sender: TObject);
    procedure SkinButtonClick(Sender: TObject);
    procedure HeartButtonClick(Sender: TObject);
    procedure HistoryButtonClick(Sender: TObject);
    procedure UrineButtonClick(Sender: TObject);
    procedure FemaleButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
    ProbPtr = ^ProbRecord;
    ProbRecord = record
                 Feat : Word;
                 Attr : byte;
                 Next : ProbPtr;
                 end;

    ResultPtr = ^ResultRecord;
    ResultRecord = record
                   CaseNo : Word;
                   Match : Real;
                   Next : ResultPtr;
                   end;
var
  AttrEnterForm: TAttrEnterForm;
  Situation : ProbPtr;
  Shead,Stail : ProbPtr;
  Rhead,Rtail : ResultPtr;
  BHead,BTail : ResultPtr;

implementation

uses General, ResultTest, SelectFile, MainScreen, Head, Stomach, Ear, Face,
  Skin, Heart, History, Urine, Female, Result;

{$R *.DFM}

procedure ClearBest;
begin
     Btail := Bhead;
     While Btail <> Nil do
     begin
          Btail := Btail^.Next;
          dispose(Bhead);
          Bhead := Btail;
     end;
     Bhead := Nil;
     Btail := Nil;
end;
procedure ClearProblem;
begin
     Stail := Shead;
     While Stail <> Nil do
     begin
          Stail := Stail^.Next;
          dispose(Shead);
          Shead := Stail;
     end;
end;

procedure ClearSolution;
begin
     Rtail := Rhead;
     While Rtail <> Nil do
     begin
          Rtail := Rtail^.Next;
          dispose(Rhead);
          Rhead := Rtail;
     end;
end;

procedure TAttrEnterForm.GeneralButtonClick(Sender: TObject);
begin
     GeneralForm.Feat00107.Checked := false;
     GeneralForm.Feat00011.Checked := false;
     GeneralForm.Feat00012.Checked := false;
     GeneralForm.Feat00015.Checked := false;
     GeneralForm.Feat00017.Checked := false;
     GeneralForm.Feat000110.Checked := false;
     GeneralForm.Feat001010.Checked := false;
     GeneralForm.Feat1010.Checked := false;
     GeneralForm.Feat10101.Checked := true;
     GeneralForm.Feat10102.Checked := false;
     GeneralForm.FeverGroup.Enabled := false;
     GeneralForm.Feat1010Group.Enabled := false;

     GeneralForm.Feat00027.Checked := false;
     GeneralForm.Feat000210.Checked := false;
     GeneralForm.Feat10691.Checked := false;
     GeneralForm.Feat1070.Checked := false;
     GeneralForm.Feat10680.Checked := true;
     GeneralForm.Feat10681.Checked := false;
     GeneralForm.Feat10682.Checked := false;
     GeneralForm.Feat0002Group.Enabled := false;

     GeneralForm.Feat00090.Checked := true;
     GeneralForm.Feat00097.Checked := false;
     GeneralForm.Feat000910.Checked := false;
     GeneralForm.Feat1116.Checked := false;

     GeneralForm.Feat00080.Checked := true;
     GeneralForm.Feat00087.Checked := false;
     GeneralForm.Feat000810.Checked := false;

     GeneralForm.Feat10710.Checked := true;
     GeneralForm.Feat10711.Checked := false;

     GeneralForm.Feat1072.Checked := false;
     GeneralForm.Feat1075.Checked := false;
     GeneralForm.Feat1073.Checked := false;
     GeneralForm.Feat1074.Checked := false;
     GeneralForm.Feat1083.Checked := false;
     GeneralForm.Feat1078.Checked := false;
     GeneralForm.Feat1081.Checked := false;
     GeneralForm.Feat1079.Checked := false;
     GeneralForm.Feat1124.Checked := false;

     GeneralForm.Feat00060.Checked := true;
     GeneralForm.Feat00067.Checked := false;
     GeneralForm.Feat000610.Checked := false;

     GeneralForm.Feat1080.Checked := false;
     GeneralForm.Feat10801.Checked := false;
     GeneralForm.Feat10802.Checked := true;
     GeneralForm.Feat1080Group.Enabled := false;

     GeneralForm.Feat10820.Checked := true;
     GeneralForm.Feat10821.Checked := false;
     GeneralForm.Feat10822.Checked := false;
     GeneralForm.Feat10823.Checked := false;

     GeneralForm.Feat10760.Checked := true;
     GeneralForm.Feat10761.Checked := false;
     GeneralForm.Feat10762.Checked := false;


     GeneralForm.show;
     AttrEnterForm.hide;
end;

procedure TAttrEnterForm.RetrieveButtonClick(Sender: TObject);
var
   TempPtr : ProbPtr;
   i : word;
   NumFeat : byte;
   AndNode : AndPtr;
   OrNode : OrPtr;
   MatchVal : Real;
   MaxMatch : Real;
   AllMatch : Real;
   NumDimension : byte;
   NumMatchFeat : byte;
   Divider : byte;
   TempStr : String;
begin
     If Shead <> Stail then
     begin
          TempPtr := Shead;
          While TempPtr^.Next <> Stail do
                TempPtr := TempPtr^.Next;
          dispose(Stail);
          TempPtr^.Next := Nil;

          ClearSolution;
          new(Rhead);
          Rtail := Rhead;
          Rtail^.Next := nil;

          NumFeat := 0;
          Stail := Shead;
          While Stail <> Nil do
          begin
               Stail := Stail^.Next;
               Inc(NumFeat);
          end;

          For i := 1 to NumCase do
          begin
               NumMatchFeat := 0;
               NumDimension := 0;
               AndNode := CaseLib[i].Feature;
               AllMatch := 0;
               While AndNode <> Nil do
               begin
                    OrNode := AndNode^.OrGroup;
                    MaxMatch := 0;
                    While OrNode <> Nil do
                    begin
                         Stail := Shead;
                         While Stail <> Nil do
                         begin
                              MatchVal := 0;
                              If (Stail^.Feat = OrNode^.Feat) then
//                                 If (Stail^.Feat < 1000) then
//                                 begin
//                                    MatchVal := 1-abs((Stail^.Attr-OrNode^.Feat)/10);
//                                    If MatchVal > 0 then Inc(NumMatchFeat)
//                                 end
                                 {Else} If Stail^.Attr = OrNode^.Attr then
                                 begin
                                    MatchVal := 1;
                                    Inc(NumMatchFeat);
                                 end
                              Else MatchVal := 0;
                              If MatchVal > MaxMatch then
                                 MaxMatch := MatchVal;
                              Stail := Stail^.Next;
                         end;
                         OrNode := OrNode^.NextOr;
                    end;
                    If MaxMatch > 0 then
                         AllMatch := AllMatch + MaxMatch;
                    Inc(NumDimension);
                    AndNode := AndNode^.NextAnd;
               end;
               Divider := (NumFeat - NumMatchFeat) + NumDimension;
               AllMatch := AllMatch/Divider;
               If AllMatch > 0 then
               begin
                    new(Rtail^.Next);
                    Rtail := Rtail^.Next;
                    Rtail^.CaseNo := i;
                    Rtail^.Match := AllMatch;
                    Rtail^.Next := Nil;
               end;
          end;
          Rtail := Rhead;
          Rhead := Rhead^.Next;
          dispose(Rtail);
          Rtail := Rhead;
          MaxMatch := 0;
          i := 0;
          While Rtail <> Nil do
          begin
               If Rtail^.Match > MaxMatch then
               begin
                  MaxMatch := Rtail^.Match;
                  ClearBest;
                  new(Bhead);
                  Btail := Bhead;
                  Btail^.CaseNo := Rtail^.CaseNo;
                  Btail^.Match := Rtail^.Match;
                  Btail^.Next := nil;
               end
               Else If Rtail^.Match = MaxMatch then
               begin
                    new(Btail^.Next);
                    Btail := Btail^.Next;
                    Btail^.CaseNo := Rtail^.CaseNo;
                    Btail^.Match := Rtail^.Match;
                    Btail^.Next := nil;
               end;
               Rtail := Rtail^.Next;
               Inc(i);
          end;
          Str(i,TempStr);
          ResultForm.NoAllMatch.Text := TempStr;
          ResultForm.BestList.Clear;

          Btail := Bhead;
          Str(Btail^.Match:0:5,TempStr);
          ResultForm.MatchVal.Text := TempStr;
          i := 0;
          While Btail <> nil  do
          begin
               ResultForm.BestList.Items.Add(
               SolLib[CaseLib[Btail^.CaseNo].SolNo].SolName);
               Btail := Btail^.Next;
               Inc(i);
          end;
          Str(i,TempStr);
          ResultForm.NoBestMatch.Text := TempStr;

          ResultForm.show;
          AttrEnterForm.hide;
     end;
end;

procedure TAttrEnterForm.ExitButtonClick(Sender: TObject);
begin
     ClearProblem;
     ClearSolution;
     ClearBest;
     AttrEnterForm.close;
     MainScreenForm.show;
end;










procedure TAttrEnterForm.ClearButtonClick(Sender: TObject);
begin
     ClearSolution;
     ClearProblem;
     ClearBest;
     new(Shead);
     Stail := Shead;
     Stail^.Feat := 0;
     Stail^.Attr := 0;
     Stail^.Next := nil;
     new(Rhead);
     Rtail := Rhead;
     Rtail^.Next := Nil;

     GeneralButton.Enabled := true;
     HeadButton.Enabled := true;
     StomachButton.Enabled := true;
     EarButton.Enabled := true;
     FaceButton.Enabled := true;
     SkinButton.Enabled := true;
     HeartButton.Enabled := true;
     HistoryButton.Enabled := true;
     UrineButton.Enabled := true;
     FemaleButton.Enabled := true;
end;

procedure TAttrEnterForm.HeadButtonClick(Sender: TObject);
begin
     HeadForm.Feat00030.Checked := true;
     HeadForm.Feat00037.Checked := false;
     HeadForm.Feat000310.Checked := false;

     HeadForm.Feat10250.Checked := true;
     HeadForm.Feat10251.Checked := false;
     HeadForm.Feat10252.Checked := false;

     HeadForm.Feat1084.Checked := false;
     HeadForm.Feat1090.Checked := false;
     HeadForm.Feat1091.Checked := false;
     HeadForm.Feat1092.Checked := false;
     HeadForm.Feat1096.Checked := false;

     HeadForm.show;
     AttrEnterForm.hide;
end;

procedure TAttrEnterForm.StomachButtonClick(Sender: TObject);
begin
     StomachForm.Feat00110.Checked := true;
     StomachForm.Feat00117.Checked := false;
     StomachForm.Feat001110.Checked := false;
     stomachForm.Feat0011SubGroup.Enabled := false;
     StomachForm.Feat1062.Checked := false;
     StomachForm.Feat1107.Checked := false;
     StomachForm.Feat1109.Checked := false;
     StomachForm.Feat1111.Checked := false;
     StomachForm.Feat1108.Checked := false;
     StomachForm.Feat1106.Checked := false;
     StomachForm.Feat1104.Checked := false;
     StomachForm.Feat1101.Checked := false;

     StomachForm.Feat00120.Checked := true;
     StomachForm.Feat00127.Checked := false;
     StomachForm.Feat001210.Checked := false;
     StomachForm.Feat0012SubGroup.Enabled := false;
     StomachForm.Feat1113.Checked := false;
     StomachForm.Feat1125.Checked := false;
     StomachForm.Feat1126.Checked := false;
     StomachForm.Feat1128.Checked := false;
     StomachForm.Feat1129.Checked := false;

     StomachForm.Feat10610.Checked := true;
     StomachForm.Feat10611.Checked := false;
     StomachForm.Feat10612.Checked := false;

     StomachForm.Feat11020.Checked := true;
     StomachForm.Feat11021.Checked := false;
     StomachForm.Feat11022.Checked := false;

     StomachForm.Feat11030.Checked := true;
     StomachForm.Feat11031.Checked := false;
     StomachForm.Feat11032.Checked := false;

     StomachForm.Feat1057.Checked := false;
     StomachForm.Feat1057Group.Enabled := false;
     StomachForm.Feat10571.Checked := false;
     StomachForm.Feat10572.Checked := false;
     StomachForm.Feat10573.Checked := false;
     StomachForm.Feat10574.Checked := false;
     StomachForm.Feat10575.Checked := false;
     StomachForm.Feat10576.Checked := false;
     StomachForm.Feat10577.Checked := false;
     StomachForm.Feat10578.Checked := false;
     StomachForm.Feat10579.Checked := false;

     StomachForm.Feat1058.Checked := false;
     StomachForm.Feat1059.Checked := false;
     StomachForm.Feat1060.Checked := false;
     StomachForm.Feat1100.Checked := false;
     StomachForm.Feat1112.Checked := false;
     StomachForm.Feat1131.Checked := false;
     StomachForm.Feat1056.Checked := false;

     StomachForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.EarButtonClick(Sender: TObject);
begin
     EarForm.Feat10390.Checked := true;
     EarForm.Feat10391.Checked := false;
     EarForm.Feat10392.Checked := false;
     EarForm.Feat10380.Checked := true;
     EarForm.Feat10381.Checked := false;
     EarForm.Feat10370.Checked := true;
     EarForm.Feat10371.Checked := false;
     EarForm.Feat10372.Checked := false;
     EarForm.Feat00040.Checked := true;
     EarForm.Feat00047.Checked := false;
     EarForm.Feat000410.Checked := false;
     EarForm.Feat1040.Checked := false;
     EarForm.Feat1088.Checked := false;
     EarForm.Feat1094.Checked := false;
     EarForm.Feat1095.Checked := false;

     EarForm.Feat10410.Checked := true;
     EarForm.Feat10411.Checked := false;
     EarForm.Feat10412.Checked := false;
     EarForm.Feat1042.Enabled := false;
     EarForm.Feat10421.Checked := false;
     EarForm.Feat10422.Checked := false;
     EarForm.Feat10423.Checked := false;

     EarForm.Feat1043.Checked := false;
     EarForm.Feat1044.Checked := false;

     EarForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.FaceButtonClick(Sender: TObject);
begin
     FaceForm.Feat10480.Checked := true;
     FaceForm.Feat10481.Checked := false;
     FaceForm.Feat10482.Checked := false;
     FaceForm.Feat10500.Checked := true;
     FaceForm.Feat10501.Checked := false;
     FaceForm.Feat10502.Checked := false;
     FaceForm.Feat10530.Checked := true;
     FaceForm.Feat10531.Checked := false;
     FaceForm.Feat10532.Checked := false;
     FaceForm.Feat1051.Checked := false;
     FaceForm.Feat1049.Checked := false;
     FaceForm.Feat1097.Checked := false;
     FaceForm.Feat1054.Checked := false;
     FaceForm.Feat1052.Checked := false;
     FaceForm.Feat1099.Checked := false;

     FaceForm.Feat10340.Checked := true;
     FaceForm.Feat10341.Checked := false;
     FaceForm.Feat10342.Checked := false;
     FaceForm.Feat10343.Checked := false;
     FaceForm.Feat1035.Checked := false;
     FaceForm.Feat1036.Checked := false;
     FaceForm.Feat1093.Checked := false;

     FaceForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.SkinButtonClick(Sender: TObject);
begin
     SkinForm.Feat10260.Checked := true;
     SkinForm.Feat10261.Checked := false;
     SkinForm.Feat10262.Checked := false;
     SkinForm.Feat10262.Checked := false;
     SkinForm.Feat10263.Checked := false;
     SkinForm.Feat10264.Checked := false;
     SkinForm.Feat10265.Checked := false;
     SkinForm.Feat10266.Checked := false;

     SkinForm.Feat10270.Checked := true;
     SkinForm.Feat10271.Checked := false;
     SkinForm.Feat10272.Checked := false;
     SkinForm.Feat10273.Checked := false;
     SkinForm.Feat10274.Checked := false;

     SkinForm.Feat10290.Checked := true;
     SkinForm.Feat10291.Checked := false;
     SkinForm.Feat10292.Checked := false;

     SkinForm.Feat10280.Checked := true;
     SkinForm.Feat10281.Checked := false;
     SkinForm.Feat10282.Checked := false;
     SkinForm.Feat10283.Checked := false;

     SkinForm.Feat10330.Checked := true;
     SkinForm.Feat10331.Checked := false;
     SkinForm.Feat10332.Checked := false;

     SkinForm.Feat10300.Checked := true;
     SkinForm.Feat10301.Checked := false;
     SkinForm.Feat10302.Checked := false;

     SkinForm.Feat10320.Checked := true;
     SkinForm.Feat10321.Checked := false;
     SkinForm.Feat10322.Checked := false;
     SkinForm.Feat10323.Checked := false;

     SkinForm.Feat1031.Checked := false;

     SkinForm.Feat1063.Checked := false;
     SkinForm.Feat1064.Checked := false;
     SkinForm.Feat1098.Checked := false;
     SkinForm.Feat1127.Checked := false;

     SkinForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.HeartButtonClick(Sender: TObject);
begin
     HeartForm.Feat1055.Checked := false;

     HeartForm.Feat1045.Checked := false;
     HeartForm.Feat10460.Checked := true;
     HeartForm.Feat10461.Checked := false;
     HeartForm.Feat10462.Checked := false;
     HeartForm.Feat00050.Checked := true;
     HeartForm.Feat00057.Checked := false;
     HeartForm.Feat000510.Checked := false;
     HeartForm.Feat10470.Checked := true;
     HeartForm.Feat10471.Checked := false;
     HeartForm.Feat10472.Checked := false;
     HeartForm.Feat10473.Checked := false;
     HeartForm.Feat10474.Checked := false;
     HeartForm.Feat10475.Checked := false;
     HeartForm.Feat10476.Checked := false;


     HeartForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.HistoryButtonClick(Sender: TObject);
begin
     HistoryForm.Feat10010.Checked := true;
     HistoryForm.Feat10011.Checked := false;
     HistoryForm.Feat10012.Checked := false;

     HistoryForm.Feat10140.Checked := true;
     HistoryForm.Feat10141.Checked := false;
     HistoryForm.Feat10142.Checked := false;

     HistoryForm.Feat10190.Checked := true;
     HistoryForm.Feat10191.Checked := false;
     HistoryForm.Feat10192.Checked := false;

     HistoryForm.Feat1002.Checked := false;
     HistoryForm.Feat1003.Checked := false;
     HistoryForm.Feat1004.Checked := false;
     HistoryForm.Feat1005.Checked := false;
     HistoryForm.Feat1005.Checked := false;
     HistoryForm.Feat1006.Checked := false;
     HistoryForm.Feat1007.Checked := false;
     HistoryForm.Feat1023.Checked := false;
     HistoryForm.Feat1024.Checked := false;
     HistoryForm.Feat1087.Checked := false;
     HistoryForm.Feat1008.Checked := false;
     HistoryForm.Feat1009.Checked := false;
     HistoryForm.Feat1011.Checked := false;
     HistoryForm.Feat1012.Checked := false;
     HistoryForm.Feat1013.Checked := false;
     HistoryForm.Feat1015.Checked := false;
     HistoryForm.Feat1085.Checked := false;
     HistoryForm.Feat1089.Checked := false;
     HistoryForm.Feat1016.Checked := false;
     HistoryForm.Feat1017.Checked := false;
     HistoryForm.Feat1018.Checked := false;
     HistoryForm.Feat1020.Checked := false;
     HistoryForm.Feat1021.Checked := false;
     HistoryForm.Feat1022.Checked := false;
     HistoryForm.Feat1086.Checked := false;
     HistoryForm.Feat1117.Checked := false;

     HistoryForm.show;
     AttrEnterForm.Hide;
end;

procedure TAttrEnterForm.UrineButtonClick(Sender: TObject);
begin
     UrineForm.Feat10650.Checked := true;
     UrineForm.Feat10651.Checked := false;

     UrineForm.Feat00070.Checked := true;
     UrineForm.Feat00072.Checked := false;
     UrineForm.Feat00074.Checked := false;
     UrineForm.Feat00076.Checked := false;
     UrineForm.Feat00078.Checked := false;
     UrineForm.Feat000710.Checked := false;

     UrineForm.Feat1110.Checked := false;

     UrineForm.Feat10660.Checked := true;
     UrineForm.Feat10661.Checked := false;
     UrineForm.Feat10662.Checked := false;

     UrineForm.Feat1067.Checked := false;
     UrineForm.Feat1115.Checked := false;

     UrineForm.Show;
     AttrEnterForm.Close;
end;

procedure TAttrEnterForm.FemaleButtonClick(Sender: TObject);
begin
     FemaleForm.Feat1123.Checked := false;
     FemaleForm.Feat1119.Checked := false;
     FemaleForm.Feat1105.Checked := false;
     FemaleForm.Feat1122.Checked := false;
     FemaleForm.Feat1118.Checked := false;
     FemaleForm.Feat1120.Checked := false;
     FemaleForm.Feat1114.Checked := false;
     FemaleForm.Feat11211.Checked := true;
     FemaleForm.Feat11212.Checked := false;

     FemaleForm.show;
     AttrEnterForm.hide;
end;

end.
