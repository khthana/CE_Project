unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, ToolWin, ImgList, Buttons, TeEngine,
  Series, TeeProcs, Chart, Db, DBTables, Grids, DBGrids, BPN, Reader;
const
  InputFileName = 'input.txt';
  TargetFileName = 'target.txt';
  PredictFileName = 'pattern.txt';
type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    PageControl1: TPageControl;
    GenPage: TTabSheet;
    Label1: TLabel;
    TPFileNameLb: TLabel;
    HDLayerLb: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IPUnitLb: TLabel;
    OPUnitLb: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    HDTypeLb: TLabel;
    OPTypeLb: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    TrainPage: TTabSheet;
    Label8: TLabel;
    Label10: TLabel;
    FirstTrainLb: TLabel;
    Label11: TLabel;
    LastTrainLb: TLabel;
    Label12: TLabel;
    TrCountLb: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LRLb: TLabel;
    MoLb: TLabel;
    CyclesLb: TLabel;
    ErrLb: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    TRDateLb: TLabel;
    Label22: TLabel;
    StartTimeLb: TLabel;
    Label23: TLabel;
    FinishTimeLb: TLabel;
    Label24: TLabel;
    ERLb: TLabel;
    GraphPage: TTabSheet;
    SaveBMPBtn: TBitBtn;
    SaveWMFBtn: TBitBtn;
    ShowGraphBtn: TBitBtn;
    Chart1: TChart;
    Series1: TFastLineSeries;
    TestPage: TTabSheet;
    BMPSaveDialog: TSaveDialog;
    WMFSaveDialog: TSaveDialog;
    Label17: TLabel;
    Label25: TLabel;
    FirstTestLb: TLabel;
    Label27: TLabel;
    LastTestLb: TLabel;
    Label29: TLabel;
    TotalTestLb: TLabel;
    Label31: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    TestBtn: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    StringGrid1: TStringGrid;
    PRIZETABLE: TTable;
    Query1: TQuery;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    SaveModel: TSaveDialog;
    ToolButton8: TToolButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ShowGraphBtnClick(Sender: TObject);
    procedure SaveBMPBtnClick(Sender: TObject);
    procedure SaveWMFBtnClick(Sender: TObject);
    procedure TestBtnClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  BP : BPN.BackProp;
  LB : array of TLabel;
  Predict, ERRORS : array of integer;
  TestLoops : integer;
  ACCURACY : array[1..5] of integer;
  Test, Open : Boolean;
  TopologyFileName, ERFile, CurDir,
  {Data for Open Model}
  FirstTest, LastTest, FirstTrain, LastTrain,
  TrCount, Cycles, Err, ER, TRDate, StartTime, FinishTime : string;

implementation

uses Unit1, Unit2, Unit3, Unit4, Unit5, About;

{$R *.DFM}

procedure BubbleSort(var Item : array of integer; Count : integer);
var
  i, j, X : integer;
begin
  for i:=2 to Count do   {outter loop}
  begin
    for j:=Count downto i do     {inner loop}
    if Item[j-1]>Item[j] then
    begin
      X :=Item[j-1];
      Item[j-1] := Item[j];
      Item[j] := X;
    end; {inner loop}
  end;   {outter loop}
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i : Byte;
  CurDir, DBName : string;
begin
{  GetDir(i,CurDir);
  DBName := CurDir;
  i := Pos('Model',CurDir);
  Delete(DBName,i,5);
  PRIZETABLE.Active := False;
  DBName := DBName + 'Lottery_Data';
  PRIZETABLE.DatabaseName := DBName;
  PRIZETABLE.TableName := 'PRIZE2.DB';
  PRIZETABLE.Active := True;
  Query1.Active := False;
  Query1.DatabaseName := DBName;
  Query1.Active := True;}
end;

procedure TMainForm.ToolButton1Click(Sender: TObject);   {New Model}
var
  i : integer;
begin
  Form1 := TForm1.Create(Application);
  Form2 := TForm2.Create(Application);
  Form3 := TForm3.Create(Application);
  Form4 := TForm4.Create(Application);
  Form5 := TForm5.Create(Application);
  Test := False;
  Open := False;
  { set to false to indicate that the model is not tested }
  GetDir(i,CurDir);
  TopologyFileName := CurDir + '\model1.neu';
  Form1.ShowModal;
end;

procedure TMainForm.ToolButton8Click(Sender: TObject);  {Open Model}
var
  RD : BPN_Reader;
  i : integer;
begin
  if OpenDialog1.Execute then
  begin
    Open := True;
    GetDir(i,CurDir);
    Reader.TPFilename := OpenDialog1.FileName;
    TopologyFileName := OpenDialog1.FileName;
    {GraphPage}
    ERFile := TopologyFileName;
    i := Pos('.',ERFile);
    Delete(ERFile,i,4);               { delete '.neu'}
    ERFile := Concat(ERFile,'.err');  { append '.err' to file name}
    {-Graph will be drawn when user click Show Graph Button-}
    {Create Backprop}
    RD := Reader.BPN_Reader.Create;
    RD.ReadTopology;
    BP := BPN.Backprop.Create;
    RD.ReadWeights(BP);
    RD.ReadTestData;
    RD.ReadTrainData;
    RD.Free;
{ GenPage Information }
   TPFileNameLb.Caption := '''' + TopologyFileName + '''';
   HDLayerLb.Caption := IntToStr(BPN.Num_HD);
   IPUnitLb.Caption := IntToStr(BPN.Cells[0]);
   SetLength(LB,BPN.Num_HD+1);
  for i:=1 to BPN.Num_HD do
  begin
    Main.LB[i] := TLabel.Create(MainForm);
    Main.LB[i].Parent := MainForm.GenPage;
    Main.LB[i].Caption := IntToStr(BPN.Cells[i]);
    Main.LB[i].Top := 185;
    Main.LB[i].Left := 440 + (i-1)*25;
    Main.LB[i].Font.Size := 12;
  end;
  OPUnitLb.Caption := IntToStr(BPN.Cells[BPN.Num_HD+1]);
  HDTypeLb.Caption := BPN.HDCell_Type;
  OPTypeLb.Caption := BPN.OPCell_Type;
{ TrainPage Information }
  FirstTrainLb.Caption := FirstTrain;
  LastTrainLb.Caption := LastTrain;
  TrCountLb.Caption := TrCount;
  LRLb.Caption := FloatToStr(BPN.LR);
  MoLb.Caption := FloatToStr(BPN.Mo);
  CyclesLb.Caption := Cycles;
  ErrLb.Caption := Err;
  ERLb.Caption := ER;
  StartTimeLb.Caption := StartTime;
  FinishTimeLb.Caption := FinishTime;
  TRDateLb.Caption :=  TRDate;
{Test Page Information}
  {Test Data}
  FirstTestLb.Caption := FirstTest;
  LastTestLb.Caption := LastTest;
  TotalTestLb.Caption := IntToStr(TestLoops);
  {Test Result Preparation}
  with MainForm.StringGrid1 do
  begin
    Cells[0,0] :=  '                      ACCURACY';
    Cells[1,0] :=  '                       ERRORS';
    Cells[0,1] :=  '                          90 %';
    Cells[0,2] :=  '                          80 %';
    Cells[0,3] :=  '                          70 %';
    Cells[0,4] :=  '                          60 %';
    Cells[0,5] :=  '                          50 %';
  end;
  with Query1 do
  begin
    Close;
    ParamByName('TrainDataSize').AsInteger :=  StrToInt(TrCount);
    Open;
  end;
  if Test = True then
  begin
    TestBtn.Enabled := False;
    Query1.Active := False;
    { Go to first target value of test set}
    with PRIZETABLE do
    begin
      IndexName := 'PRIZE_NO.';
      Setkey;
      FieldByName('PNUMBER').AsInteger := StrToInt(TrCount) + 1;
      GotoKey;
      IndexName := '';
    end;
    for i:=1 to TestLoops do
    begin
      PRIZETABLE.Edit;
      PRIZETABLE['PREDICT'] := Predict[i];
      PRIZETABLE['ERROR'] := ERRORS[i];
      PRIZETABLE.Post;
      PRIZETABLE.Next;
    end;
    DBGrid1.Columns[2].FieldName := 'PREDICT';
    DBGrid1.Columns[3].FieldName := 'ERROR';
    Query1.Active := True;
    Query1.Refresh;
    DBGrid1.Refresh;
    with StringGrid1 do
    begin
      Cells[1,1]  :=  '                               ' +
                      IntToStr(ACCURACY[1]);
      Cells[1,2]  :=  '                               ' +
                      IntToStr(ACCURACY[2]);
      Cells[1,3]  :=  '                               ' +
                      IntToStr(ACCURACY[3]);
      Cells[1,4]  :=  '                               ' +
                      IntToStr(ACCURACY[4]);
      Cells[1,5]  :=  '                               ' +
                      IntToStr(ACCURACY[5]);
    end;
  end { if Test = True }
  else TestBtn.Enabled := True;
  MainForm.ToolButton1.Enabled := False;  //cannot new
  MainForm.ToolButton8.Enabled := False;  //cannot open
  MainForm.ToolButton2.Enabled := True;   //can export
  MainForm.ToolButton6.Enabled := True;   //can close
  MainForm.ToolButton7.Enabled := False;   //cannot save
  MainForm.Caption := 'Model Creator : ' + Main.TopologyFileName;
  MainForm.PageControl1.ActivePage := MainForm.GenPage;
  MainForm.Color := clsilver;
  MainForm.PageControl1.Visible := True;
  end; {if OpenDialog1.Execute..}

end;

procedure TMainForm.ToolButton7Click(Sender: TObject); { Save Model }
var
  i : integer;
  F : TextFile;
  Memo : TMemo;
  TemplateFile : string;
begin
  if SaveModel.Execute then
  begin
  { Save Topology File }
    Memo := TMemo.Create(Application);
    Memo.Parent := MainForm;
    Memo.Visible := False;
    if Open = False then TemplateFile := CurDir + '\model1.neu'
       else TemplateFile := TopologyFileName;
    Memo.Lines.LoadFromFile(TemplateFile);
    Memo.Lines.SaveToFile(SaveModel.FileName);
    TopologyFileName := SaveModel.FileName;
  { Save err File }
  { GraphData --> *.err }
    Memo.Clear;
    Memo.Lines.LoadFromFile(ERFile);
    ERFile := TopologyFileName;
    i := Pos('.',ERFile);
    Delete(ERFile,i,4);               { delete '.neu'}
    ERFile := Concat(ERFile,'.err');  { append '.err' to file name}
    Memo.Lines.SaveToFile(ERFile);
    Memo.Destroy;
    if Open = False then
    begin
      AssignFile(F,TopologyFileName);
      Append(F);
    { Append Test Data }
      Writeln(F,TotalTestLb.Caption);        // total test
      if Test = True then
      begin
      {write model's error to TopologyFile}
        Writeln(F,'Tested');
        for i:=1 to 5 do Write(F,ACCURACY[i],' ');
        Writeln(F,'');
        for i:=1 to TestLoops do Write(F,Predict[i],' ');
        Writeln(F,'');
        for i:=1 to TestLoops do Write(F,ERRORS[i],' ');
        Writeln(F,'');
      end
      else Writeln(F,'Not Tested'); { Test = False }
      Writeln(F,FirstTestLb.Caption);
      Writeln(F,LastTestLb.Caption);
      { Append Train data }
      Writeln(F,TrCountLb.Caption);          // total train
      Writeln(F,FirstTrainLb.Caption);
      Writeln(F,LastTrainLb.Caption);
      Writeln(F,CyclesLb.Caption);
      Writeln(F,ErrLb.Caption);
      Writeln(F,ERLb.Caption);
      Writeln(F,TRDateLb.Caption);
      Writeln(F,StartTimeLb.Caption);
      Writeln(F,FinishTimeLb.Caption);
      CloseFile(F);
    end;{Open = False --> append}
  MainForm.Caption := 'Model Creator : ' + Main.TopologyFileName;
  MainForm.TPFileNameLb.Caption := Main.TopologyFileName;
  MainForm.ToolButton2.Enabled := True;  {now model can be exported}
  end; { Save file}
end;

procedure TMainForm.ToolButton2Click(Sender: TObject); { Export Model}
var
  Memo : TMemo;
  ExportFileName : string;
  i : integer;
begin
    i := Pos('\Model',CurDir);
    ExportFileName := CurDir;
    Delete(ExportFileName,i,6);
    ExportFileName := ExportFileName + '\Predictor\' + PredictFileName;
{Delete old model of Lottery Predictor}
    DeleteFile(PredictFileName);
    Memo := TMemo.Create(Application);
    Memo.Parent := MainForm;
    Memo.Lines.LoadFromFile(TopologyFileName);
    Memo.Lines.SaveToFile(ExportFileName);
    Memo.Destroy;
    MessageDlg('Topology file  ''' + TopologyFileName
                       + '''  has been exported to' + chr(10)+ ''''
                       + ExportFileName + '''' + chr(10)
                       + 'To predict lottery, please use Predictor.',
                       mtInformation, [mbOk],0);
end;

procedure TMainForm.ToolButton6Click(Sender: TObject); { Close Model}
var
  i, j : integer;
begin
  DeleteFile('model1.neu');              // delete temporary file
  DeleteFile('model1.err');
  for i:=1 to BP.Num_HDLayer do LB[i].Destroy;
  BP.Free;
  PageControl1.Visible := False;
  Series1.Clear;
  SaveWMFBtn.Enabled := False;
  SaveBMPBtn.Enabled := False;
  ShowGraphBtn.Enabled := True;
  DBGrid1.Columns[2].FieldName := '';
  DBGrid1.Columns[3].FieldName := '';
  for i:=0 to 2 do
    for j:=0 to 5 do
        StringGrid1.Cells[i,j] :=  '';
  TestBtn.Enabled := True;
  ToolButton7.Enabled := False;          //cannot save
  ToolButton6.Enabled := False;          //cannot close
  ToolButton2.Enabled := False;          //cannot export
  ToolButton1.Enabled := True;           //can new
  ToolButton8.Enabled := True;           //cannot open
  MainForm.Caption := 'Model Creator';
  MainForm.Color := clwhite;
end;

procedure TMainForm.ToolButton4Click(Sender: TObject); {Quit}
begin
  Application.Terminate;
end;

procedure TMainForm.ToolButton5Click(Sender: TObject); { About }
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.ShowGraphBtnClick(Sender: TObject);
var
{for Graph page}
  ERRORFile : TextFile;
  Error : real;
  i : integer;
begin
  ShowGraphBtn.Enabled := false;
  SaveWMFBtn.Enabled := True;
  SaveBMPBtn.Enabled := True;
  Refresh;
  Chart1.BottomAxis.Maximum := StrToInt(Cycles);
  { Read from error file }
  AssignFile(ERRORFile,ERFile);   {ERFile is error file name}
  Reset(ERRORFile);
  Series1.Add(0,'',clRed);
  for i:=1 to StrToInt(Cycles) do
  begin
    Read(ERRORFile,Error);
    Series1.Add(Error,'',clRed);
  end;
  CloseFile(ERRORFile);
end;

procedure TMainForm.SaveBMPBtnClick(Sender: TObject);
begin
  if BMPSaveDialog.Execute then  { <-- ask for a filename first }
     Chart1.SaveToBitmapFile(BMPSaveDialog.FileName);
end;

procedure TMainForm.SaveWMFBtnClick(Sender: TObject);
begin
  if WMFSaveDialog.Execute then  { <-- ask for a filename first }
    Chart1.SaveToMetafile(WMFSaveDialog.FileName);
end;

procedure TMainForm.TestBtnClick(Sender: TObject);
var
  SortedERRORS : array of integer;
  TestData : array of integer;
  IP : array of real;
  i, j, FirstTestDataIndex, TestDataCount,
  TG, Cut : integer;
begin
  TestBtn.Enabled := False;
  MainForm.ToolButton7.Enabled := True;   //can save
{Test Init}
  SetLength(ERRORS,TestLoops+1);
  SetLength(SortedERRORS,TestLoops+1);
  SetLength(Predict,TestLoops+1);
  TestDataCount := TestLoops + BP.IPLayer.Num_Cell;
  SetLength(TestData,TestDataCount + 1);
  FirstTestDataIndex := StrToInt(TrCountLb.Caption) - BP.IPLayer.Num_Cell + 1;
  {Find First Test Data}
  with PRIZETABLE do
  begin
    IndexName := 'PRIZE_NO.';
    Setkey;
    FieldByName('PNUMBER').AsInteger := FirstTestDataIndex;
    GotoKey;
    IndexName := '';
  end;
  {copy test data from PRIZETABLE to TestData array}
  for i:=1 to TestDataCount do
  begin
    TestData[i] := PRIZETABLE['PRIZE'];
    PRIZETABLE.Next;
  end;
{Test... }
  { Go to first target value of test set.
  if we don't go to this record,
  the displayed values in DBGrid1 will be incorrect.}
  with PRIZETABLE do
  begin
    IndexName := 'PRIZE_NO.';
    Setkey;
    FieldByName('PNUMBER').AsInteger := StrToInt(TrCountLb.Caption) + 1;
    GotoKey;
    IndexName := '';
  end;
  Query1.Active := False;
  SetLength(IP,BP.IPLayer.Num_Cell+1);
  for i := 1 to TestLoops do
  begin
    for j:= 1 to BP.IPLayer.Num_Cell  do
           IP[j] := TestData[(i-1)+(BP.IPLayer.Num_Cell-j)+1]/99.0;
                                                 { divide by 99 to massage}
    TG := TestData[BP.IPLayer.Num_Cell+i];
    BP.FeedForward(IP);
    Predict[i] := Round(BP.OPLayer.OutputBuffer[1]*99.0);
                                            {multiply by 99 to unmassage}
    ERRORS[i] := ABS(TG - Predict[i]);
    PRIZETABLE.Edit;
    PRIZETABLE['PREDICT'] := Predict[i];
    PRIZETABLE['ERROR'] := ERRORS[i];
    PRIZETABLE.Post;
    PRIZETABLE.Next;
  end; {Test Loop}
{Show Result}
  DBGrid1.Columns[2].FieldName := 'PREDICT';
  DBGrid1.Columns[3].FieldName := 'ERROR';
  Query1.Active := True;
  DBGrid1.Refresh;

{find summary}
  for i:=1 to TestLoops do SortedERRORS[i] := ERRORS[i];
  BubbleSort(SortedERRORS,TestLoops);
  Cut := Round(0.1 * TestLoops);
  ACCURACY[1] := SortedERRORS[TestLoops-Cut];
  ACCURACY[2] := SortedERRORS[TestLoops-Cut*2];
  ACCURACY[3] := SortedERRORS[TestLoops-Cut*3];
  ACCURACY[4] := SortedERRORS[TestLoops-Cut*4];
  ACCURACY[5] := SortedERRORS[TestLoops-Cut*5];

  with StringGrid1 do
  begin
    Cells[1,1]  :=  '                               ' +
                    IntToStr(ACCURACY[1]);
    Cells[1,2]  :=  '                               ' +
                    IntToStr(ACCURACY[2]);
    Cells[1,3]  :=  '                               ' +
                    IntToStr(ACCURACY[3]);
    Cells[1,4]  :=  '                               ' +
                    IntToStr(ACCURACY[4]);
    Cells[1,5]  :=  '                               ' +
                    IntToStr(ACCURACY[5]);
  end;
  Test := True;     // model is tested
end;

end.
