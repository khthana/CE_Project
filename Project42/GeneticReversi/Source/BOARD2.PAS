unit board2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls,GA1 ;

type
  TForm1 = class(TForm)
    BoardImage1: TImage;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    New1: TMenuItem;
    Start1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Option1: TMenuItem;
    BlackLevel: TMenuItem;
    WhiteLevel: TMenuItem;
    N2: TMenuItem;
    BlackAlgorithm: TMenuItem;
    WhiteAlgorithm: TMenuItem;
    N3: TMenuItem;
    FirstPlayer: TMenuItem;
    Easy1: TMenuItem;
    Medium1: TMenuItem;
    Expert1: TMenuItem;
    Easy2: TMenuItem;
    Medium2: TMenuItem;
    Expert2: TMenuItem;
    Conventional1: TMenuItem;
    Human1: TMenuItem;
    Conventional2: TMenuItem;
    Genetic2: TMenuItem;
    Human2: TMenuItem;
    Black1: TMenuItem;
    White1: TMenuItem;
    Board1: TMenuItem;
    Reverse1: TMenuItem;
    Transpost1: TMenuItem;
    Help1: TMenuItem;
    Tutorials1: TMenuItem;
    About1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    N4: TMenuItem;
    N5: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    ImageList2: TImageList;
    Image3: TImage;
    GAParam: TMenuItem;
    Traning1: TMenuItem;
    procedure BoardImage1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Exit1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Easy1Click(Sender: TObject);
    procedure Medium1Click(Sender: TObject);
    procedure Expert1Click(Sender: TObject);
    procedure Easy2Click(Sender: TObject);
    procedure Medium2Click(Sender: TObject);
    procedure Expert2Click(Sender: TObject);
    procedure Conventional1Click(Sender: TObject);
    procedure Genetic1Click(Sender: TObject);
    procedure Human1Click(Sender: TObject);
    procedure Conventional2Click(Sender: TObject);
    procedure Genetic2Click(Sender: TObject);
    procedure Human2Click(Sender: TObject);
    procedure Black1Click(Sender: TObject);
    procedure White1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Reverse1Click(Sender: TObject);
    procedure Transpost1Click(Sender: TObject);
    procedure BoardImage1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Monitor1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Traning1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

       WeightObj = Object {weight of evaluate function}
                        W_CornerP1   : integer ;
                        W_CXSquareP1 : integer ;
                        W_FontierP1  : integer ;
                        W_MobilityP1 : integer ;
                        W_DifferP1   : integer ;

                        W_CornerP2   : integer ;
                        W_CXSquareP2 : integer ;
                        W_FontierP2  : integer ;
                        W_MobilityP2 : integer ;
                        W_DifferP2   : integer ;
                   end ;

Procedure ChromToWeight(var ChromS  : ChromType  ;
                        var WeightS : WeightObj) ;

var
  Form1 : TForm1;
  Weight1 : WeightObj ;

implementation

Uses  Reversi,Msg,GenMonitor,MonitorFrm ;

Const BlockSize = 20 ;
      Size      = 8  ;
      ParaFile  = 'P_Meter.gen' ;{parameter file}
      GenFile   = 'CurGen.gen' ; {Genetic file}
      GenRpt    = 'Report.txt' ; {Report file}
      
//      NumBit    = 5  ;

Type  LevelType = (Easy,Medium,Expert) ;
      AlgoType  = (Genetic,Convention,Human) ;

      ParaObjType = Object        {object of parameters}
                          Start : Boolean ;
                          BlackLev  : LevelType ;
                          WhiteLev  : LevelType ;
                          BlackAlgo : AlgoType  ;
                          WhiteAlgo : AlgoType  ;
                          First     : PlayerType ;
                          Weight    : WeightObj ;

                          Procedure Init ;
                          Procedure DisPlay ;
                          Procedure ReadFromFile(FName : String) ;
                          Procedure WriteToFile(FName  : String) ;
                     end ;

var   ParaMeter : ParaObjType ;
      Board     : TBoardBase  ;
      Pop1      : TPopulation ;
{$R *.DFM}


Function Bi2Dec(var BinStrg : String20 ; NumBit : integer) : integer ;
var Num,i,Len : integer ;
begin
     Num := 0 ;
     Len := NumBit-1 {Length(BinStrg)} ;
     //Len := Len-1 ;
     for i := 0 to Len-1 do
         begin
              if BinStrg[Len-i+1]='1' then Num := Num+trunc(exp(i*ln(2))) ;
         end ;
     //Bi2Dec := Num ;
    if BinStrg[1] = '0' then Bi2Dec := Num
     else Bi2Dec := -1*Num ;
end ;

Procedure ChromToWeight(var ChromS  : ChromType  ;
                        var WeightS : WeightObj) ;
var Temp : array[1..80] of String20 ;
    T    : String20 ;
    i,j,k,LChrom : integer ;
begin
     j := 1 ;
     k := 1 ;
     T := '' ;
     for i := 1 to MaxLength do
         begin
              {T[j] := ChromS[i] ;}
              T := T+ChromS[i] ;

              if (i mod Numbit) = 0 then
                 begin
                      Temp[k] := T ;
                      k := k+1 ;
                      j := 0   ;
                      T := '' ;
                 end ;
              j := j+1 ;
         end ;
     with WeightS do
          begin
               W_CornerP1   := Bi2Dec(Temp[1],NumBit) ;
               W_CXSquareP1 := Bi2Dec(Temp[2],NumBit) ;
               W_FontierP1  := Bi2Dec(Temp[3],NumBit) ;
               W_MobilityP1 := Bi2Dec(Temp[4],NumBit) ;
               W_DifferP1   := Bi2Dec(Temp[5],NumBit) ;

               W_CornerP2   := Bi2Dec(Temp[6],NumBit) ;
               W_CXSquareP2 := Bi2Dec(Temp[7],NumBit) ;
               W_FontierP2  := Bi2Dec(Temp[8],NumBit) ;
               W_MobilityP2 := Bi2Dec(Temp[9],NumBit) ;
               W_DifferP2   := Bi2Dec(Temp[10],NumBit) ;

          end ;
end ;

Function Level2Depth(Level : LevelType) : integer ;
begin
     case Level of
          Easy   : Level2Depth := 1 ;
          Medium : Level2Depth := 2 ;
          Expert : Level2Depth := 3 ;
     end ;
end ;

Function InBoard(X,Y : integer) : boolean ;
begin
     Inboard := false ;
     if ((X>=20)and(X<=180)) and ((Y>=20)and(Y<=180)) then
         InBoard := true ;
end ;

Procedure XY2RowCol(var X,Y,Row,Col : integer) ;
begin
     Row  := (Y div BlockSize) ;
     Col  := (X div BlockSize) ;
end ;

Procedure RowCol2XY(var X,Y,Row,Col : integer) ;
begin
     X := BlockSize*Col ;
     Y := BlockSize*Row ;
end ;

Procedure DisPlayBoard(Board1 : TBoardBase) ;
var  X,Y,Row,Col : integer ;
begin
     for Row := 1 to Side do
     for Col := 1 to Side do
      begin
        RowCol2XY(X,Y,Row,Col) ;
        case Board1.BoardObj[Row,Col] of
             PlayerS1 : Form1.ImageList1.Draw(Form1.BoardImage1.Canvas,X,Y,0);
             PlayerS2 : Form1.ImageList1.Draw(Form1.BoardImage1.Canvas,X,Y,1);
             Blank    : Form1.ImageList1.Draw(Form1.BoardImage1.Canvas,X,Y,2);
        end ;
      end ;

      case Board1.PlayerPlay of
           PlayerS1 : Form1.ImageList2.Draw(Form1.Image3.Canvas,0,0,0);
           PlayerS2 : Form1.ImageList2.Draw(Form1.Image3.Canvas,0,0,1);
      end ;
      Form1.Label1.Caption := IntToStr(Board1.NumBlack) ;
      Form1.Label2.Caption := IntToStr(Board1.NumWhite) ;

      Form1.Image3.Update  ;
      Form1.Image3.Refresh ;
      Form1.BoardImage1.Update  ;
      Form1.BoardImage1.Refresh ;
end ;

Procedure ParaObjType.Init ;
begin
     Start := false ;
     BlackLev :=  Easy ;
     WhiteLev :=  Easy ;
     BlackAlgo := Human ;
     WhiteAlgo := Convention ;
     First     := PlayerS2 ;

     Weight.W_CornerP1   := 50 ;
     Weight.W_CXSquareP1 := 20 ;
     Weight.W_FontierP1  := 30 ;
     Weight.W_MobilityP1 := 50 ;
     Weight.W_DifferP1   := -1000 ;

     Weight.W_CornerP2   := 50 ;
     Weight.W_CXSquareP2 := 20 ;
     Weight.W_FontierP2  := 30 ;
     Weight.W_MobilityP2 := 50 ;
     Weight.W_DifferP2   := -1000 ;

end ;

Procedure ParaObjType.DisPlay ;
begin
     Form1.Easy1.Checked   := false ;
     Form1.Medium1.Checked := false ;
     Form1.Expert1.Checked := false ;
     case ParaMeter.BlackLev of
          Easy   : Form1.Easy1.Checked   := true ;
          Medium : Form1.Medium1.Checked := true ;
          Expert : Form1.Expert1.Checked := true ;
     end ;

     Form1.Easy2.Checked   := false ;
     Form1.Medium2.Checked := false ;
     Form1.Expert2.Checked := false ;
     case ParaMeter.WhiteLev of
          Easy   : Form1.Easy2.Checked   := true ;
          Medium : Form1.Medium2.Checked := true ;
          Expert : Form1.Expert2.Checked := true ;
     end ;

     Form1.Black1.Checked := false ;
     Form1.White1.Checked := false ;
     case ParaMeter.First of
          PlayerS1 : Form1.Black1.Checked := true ;
          PlayerS2 : Form1.White1.Checked := true ;
     end ;

     Form1.Conventional1.Checked   := false ;

     Form1.Human1.Checked := false ;
     case ParaMeter.BlackAlgo of
          Convention : Form1.Conventional1.Checked := true ;
          //Genetic : Form1.Genetic1.Checked := true ;
          Human   : Form1.Human1.Checked := true ;
     end ;

     Form1.Conventional2.Checked := false ;
     Form1.Genetic2.Checked := false ;
     Form1.Human2.Checked := false ;
     case ParaMeter.WhiteAlgo of
          Convention : Form1.Conventional2.Checked := true ;
          Genetic : Form1.Genetic2.Checked := true ;
          Human   : Form1.Human2.Checked := true ;
     end ;

end ;

Procedure ParaObjType.ReadFromFile(FName : String) ;
var fp : file of ParaObjType ;
    TempPara : ParaObjType   ;
begin
     Assign(fp,ParaFile) ;
     Reset(fp) ;
     Read(fp,TempPara) ;

     Start :=     TempPara.Start  ;
     BlackLev :=  TempPara.BlackLev ;
     WhiteLev :=  TempPara.WhiteLev ;
     BlackAlgo := TempPara.BlackAlgo ;
     WhiteAlgo := TempPara.WhiteAlgo ;
     First  := TempPara.First         ;
     Weight := TempPara.Weight ;
     CloseFile(fp) ;
end ;

Procedure ParaObjType.WriteToFile(FName : String) ;
var  fp : file of ParaObjType ;
     TempPara : ParaObjType   ;
begin
     TempPara.Start     := Start ;
     TempPara.BlackLev  := BlackLev ;
     TempPara.WhiteLev  := WhiteLev ;
     TempPara.BlackAlgo := BlackAlgo ;
     TempPara.WhiteAlgo := WhiteAlgo ;
     TempPara.First     := First ;
     TempPara.Weight    := Weight ;
     Assign(fp,ParaFile) ;
     ReWrite(fp) ;
     Write(fp,TempPara) ;
     CloseFile(fp) ;
end ;

procedure TForm1.BoardImage1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Level,R1,C1,X1,Y1 : integer ;

begin
     XY2RowCol(X,Y,R1,C1) ;
     if ParaMeter.Start and
        InBoard(X,Y) and
        (Parameter.BlackAlgo = Human) and
        (Parameter.WhiteAlgo = Human) then
        begin
             if Board.ISCanput(R1,C1) then Board.ChangeBoard(R1,C1);
                DisPlayBoard(Board) ;
             if Board.IsGameOver then
                Form2.PrintMessage('Game Over') ;
        end ;

     if ParaMeter.Start and
        InBoard(X,Y) and
        (((ParaMeter.BlackAlgo = Human) and
         (ParaMeter.WhiteAlgo  = Convention)) or
        ((ParaMeter.BlackAlgo = Convention)  and
         (ParaMeter.WhiteAlgo  = Human))) then
             begin
                  if (Board.PlayerPlay=PlayerS1) and
                     (ParaMeter.BlackAlgo = Human) then
                     begin
                          if Board.IsCanPut(R1,C1) then
                             begin
                                  Board.ChangeBoard(R1,C1) ;
                                  DisplayBoard(Board) ;
                             end ;
                          if Board.PlayerPlay=PlayerS2 then {white}
                             begin
                                  Level := Level2Depth(ParaMeter.WhiteLev) ;
                                  BoardImage1.Cursor := CrHourGlass ;
                                  Board.ConventionMove(Level,Weight1) ;
                                  BoardImage1.Cursor := CrArrow ;
                             end ;
                          if Board.IsGameOver then
                             Form2.PrintMessage('Game Over') ;
                          DisplayBoard(Board) ;
                     end ;

                  if (Board.PlayerPlay=PlayerS2) and
                     (ParaMeter.WhiteAlgo = Human) then
                     begin
                          if Board.IsCanPut(R1,C1) then
                             begin
                                  Board.ChangeBoard(R1,C1) ;
                                  DisplayBoard(Board) ;
                             end ;
                          if Board.PlayerPlay=PlayerS1 then {black}
                             begin
                                  Level := Level2Depth(ParaMeter.BlackLev) ;
                                  BoardImage1.Cursor := CrHourGlass ;
                                  Board.ConventionMove(Level,Weight1) ;
                                  BoardImage1.Cursor := CrArrow ;
                             end ;
                          DisplayBoard(Board) ;
                          if Board.IsGameOver then
                             Form2.PrintMessage('Game Over') ;
                     end ;
             end ;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
     Close ;
     Parameter.Start := false ;
     Parameter.WriteToFile(ParaFile) ;
end;

procedure TForm1.Start1Click(Sender: TObject);
var temp : integer ;
begin
     ParaMeter.Start := not ParaMeter.Start ;
     Start1.Enabled  := false ;

     BlackAlgorithm.Enabled := not ParaMeter.Start ;
     WhiteAlgorithm.Enabled := not ParaMeter.Start ;
     FirstPlayer.Enabled := false ;

     if ((Board.PlayerPlay=PlayerS1) and
        (ParaMeter.BlackAlgo = Convention)) or
        ((Board.PlayerPlay=PlayerS2) and
        (ParaMeter.WhiteAlgo = Convention)) then
            begin
                 if ParaMeter.BlackAlgo = Convention then
                    temp := Level2Depth(ParaMeter.BlackLev) ;
                 if ParaMeter.WhiteAlgo = Convention then
                    temp := Level2Depth(ParaMeter.WhiteLev) ;
                 Board.ConventionMove(temp,Weight1) ;
                 DisplayBoard(Board) ;
            end ;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i : integer ;
begin
     Parameter.Init ;
     Parameter.ReadFromFile(ParaFile) ;
     Weight1 := ParaMeter.Weight ;

     Weight1.W_CornerP1   := 500 ;
     Weight1.W_CXSquareP1 := 400 ;
     Weight1.W_FontierP1  := -180 ;
     Weight1.W_MobilityP1 := 800 ;
     Weight1.W_DifferP1   := 100 ;

     Weight1.W_CornerP2   := -700 ;
     Weight1.W_CXSquareP2 := -400 ;
     Weight1.W_FontierP2  := 500 ;
     Weight1.W_MobilityP2 := -800 ;
     Weight1.W_DifferP2   := 1 ;

     Parameter.DisPlay ;
     Board.Init ;
     Board.PlayerPlay := Parameter.First ;
     DisPlayBoard(Board) ;
     Pop1.Init ;
//     Pop1.ReportToFile(GenRpt) ;
end;

procedure TForm1.Easy1Click(Sender: TObject);
begin
     ParaMeter.BlackLev := Easy ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Medium1Click(Sender: TObject);
begin
     ParaMeter.BlackLev := Medium ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Expert1Click(Sender: TObject);
begin
     ParaMeter.BlackLev := Expert ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Easy2Click(Sender: TObject);
begin
     ParaMeter.WhiteLev := Easy ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Medium2Click(Sender: TObject);
begin
     ParaMeter.WhiteLev := Medium ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Expert2Click(Sender: TObject);
begin
     ParaMeter.WhiteLev := Expert ;
     ParaMeter.DisPlay ;
end;

procedure TForm1.Conventional1Click(Sender: TObject);
begin
     Parameter.BlackAlgo := Convention ;
     Parameter.DisPlay ;
end;

procedure TForm1.Genetic1Click(Sender: TObject);
begin
     Parameter.BlackAlgo := Genetic ;
     Parameter.DisPlay ;
end;

procedure TForm1.Human1Click(Sender: TObject);
begin
     Parameter.BlackAlgo := Human ;
     Parameter.DisPlay ;
end;

procedure TForm1.Conventional2Click(Sender: TObject);
begin
     Parameter.WhiteAlgo := Convention ;
     Parameter.DisPlay ;
end;

procedure TForm1.Genetic2Click(Sender: TObject);
begin
     Parameter.WhiteAlgo := Genetic ;
     Parameter.DisPlay ;
end;

procedure TForm1.Human2Click(Sender: TObject);
begin
     Parameter.WhiteAlgo := Human ;
     Parameter.DisPlay ;
end;

procedure TForm1.Black1Click(Sender: TObject);
begin
     ParaMeter.First := PlayerS1 ;
     ParaMeter.DisPlay ;
     Board.PlayerPlay := PlayerS1 ;
     DisPlayBoard(Board) ;
end;

procedure TForm1.White1Click(Sender: TObject);
begin
     ParaMeter.First := PlayerS2 ;
     ParaMeter.DisPlay ;
     Board.PlayerPlay := PlayerS2 ;
     DisPlayBoard(Board) ;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
     ParaMeter.Start := false ;
     Start1.Enabled := true ;
     BlackAlgorithm.Enabled := not ParaMeter.Start ;
     WhiteAlgorithm.Enabled := not ParaMeter.Start ;
     FirstPlayer.Enabled := true ;

     Parameter.DisPlay ;
     Board.Init ;
     Board.PlayerPlay := Parameter.First ;
     DisPlayBoard(Board) ;
end;

procedure TForm1.Reverse1Click(Sender: TObject);
begin
     Board.Reversed ;
     DisplayBoard(Board) ;
end;

procedure TForm1.Transpost1Click(Sender: TObject);
begin
     Board.Transpose ;
     DisPlayBoard(Board) ;
end;

procedure TForm1.BoardImage1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var Row,Col : integer ;
begin
     if InBoard(X,Y) then
        begin
             XY2RowCol(X,Y,Row,Col) ;
             if Board.IsCanput(Row,Col) then
                BoardImage1.Cursor := CrCross
             else
                 BoardImage1.CurSor := CrDefault ;
        end ;
end;

procedure TForm1.Monitor1Click(Sender: TObject);
begin
     Form3.DisPlay ;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
    ShowMessagePos('¾Ñ²¹Òâ´Â Ê×º¾§Éì Á¹µìÊÒ (KMIT''L)',Form1.Left+50
                    ,Form1.Top+50) ;
end;

procedure TForm1.Traning1Click(Sender: TObject);
var  Temp1,Temp2,Temp : integer ;
     TextDisPlay : String  ;
     GeneticS    : TPopulation ;
     Weight2     : WeightObj ;
     S           : ChromType ;
begin

     Temp1 := 2 ;
     Temp2 := 3 ;
     Genetics.Init ;
Repeat
      Genetics.ReadFromFile(GenFile) ;
   //    Genetics.PMute  := 0.73 ;
  //   Genetics.Generation := 0 ;
  //   Genetics.CurPop := 0 ;
  //   Genetics.PCross := 0.25 ;
      Genetics.CurPop := Genetics.CurPop+1 ;

      Temp := Genetics.CurPop   ;
      Genetics.GetChrom(Temp,S) ;
      ChromToWeight(S,Weight2)  ;
      Form4.FormDisPlay(Genetics) ;

      repeat
            case Board.PlayerPlay of
                 PlayerS1 : begin
                                 Board.ConventionMove(Temp1,Weight2) ;
                                 DisPlayBoard(Board) ;
                            end ;
                 PlayerS2 : begin
                                 Board.ConventionMove(Temp2,Weight1) ;
                                 DisPlayBoard(Board) ;
                            end ;
            end ;
      until Board.IsGameOver ;

      Genetics.SetFitness(Temp,Board.FindFitness(PlayerS1)) ;
      TextDisPlay := 'Fitness  : '+FloatToStr(Board.FindFitness(PlayerS1)) ;
      Form4.Memo1.Lines.Add(TextDisPlay) ;
      Form4.Memo1.Lines.Add('-------------------------------------------') ;
//      ShowMessage(TextDisPlay) ;

      Board.Init ;
      Board.PlayerPlay := Parameter.First ;
      DisPlayBoard(Board) ;

      if Temp >= Genetics.PopSize then
         begin
              Form4.Memo1.Clear ;
              Genetics.CalSumFitness ;
              Genetics.ReportToFile(GenRpt) ;

              //Genetics.Selection ;
              //Genetics.CrossOver ;
              Genetics.Mutation  ;
              Genetics.CurPop := 0 ;
              Genetics.Generation := Genetics.Generation+1 ;
         end ;
      Genetics.WriteToFile(GenFile) ;
until Genetics.Generation > 1000 ;

end;

end.
