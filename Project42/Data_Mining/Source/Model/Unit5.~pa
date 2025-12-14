unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, BPN, ComCtrls;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    Panel2: TPanel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label9: TLabel;
    StartTimeLabel: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    FinishTimeLabel: TLabel;
    Label12: TLabel;
    procedure ReadIP_TG(var IPArray, TGArray : array of real);
    procedure WriteTopology(BP: BPN.Backprop);// C: integer; ER: real);
    procedure TrainNeural;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  Cycles, Trained_Loops : integer;
          { Trained_Loops is used in TMainForm.ShowGraphBtnClick }
  Errors, LastError : real;
  InputFile, TargetFile, OutputFile, ErrorFile : TextFile;
implementation

uses Main, Unit1, Unit2, Unit3, Unit4;

{$R *.DFM}

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form5.Close;
  Form4.Close;
  Form3.Close;
  Form2.Close;
  Form1.Close;
end;

procedure TForm5.ReadIP_TG(var IPArray, TGArray : array of real);
var
  i : integer;
begin
  for i:=1 to BP.IPLayer.Num_Cell do
               Read(InputFile,IPArray[i]);
  for i:=1 to BP.OPLayer.Num_Cell do
               Read(TargetFile,TGArray[i]);
end;

procedure TForm5.WriteTopology(BP: BPN.Backprop);// C: integer; ER: real);
var
  i, j, k : integer;
begin
  AssignFile(OutputFile,Main.TopologyFileName);
  Rewrite(OutputFile);
  Writeln(OutputFile,BP.Num_HDLayer);
  Writeln(OutputFile,BP.IPLayer.Num_Cell);
  if BPN.HDCell_Type='Sigmoid function' then
     Writeln(OutputFile,BP.HDLayer[1].Num_Cell,'  ','0')
  else if BPN.HDCell_Type='Hyperbolic tangent function' then
          Writeln(OutputFile,BP.HDLayer[1].Num_Cell,'  ','1');
  for i:=2 to BP.Num_HDLayer do
     Writeln(OutputFile,BP.HDLayer[i].Num_Cell);
  if BPN.OPCell_Type='Sigmoid function' then
     Writeln(OutputFile,BP.OPLayer.Num_Cell,'  ','0')
  else if BPN.OPCell_Type='Hyperbolic tangent function' then
          Writeln(OutputFile,BP.OPLayer.Num_Cell,'  ','1');
  Writeln(OutputFile,BP.LearningRate:5:3);
  Writeln(OutputFile,BP.Momentum:5:3);

  for j:=1 to BP.HDLayer[1].Num_Cell do
  begin
    for k:=0 to BP.IPLayer.Num_Cell do
      Write(OutputFile,BP.HDLayer[1].HDCells[j].weights[k]:7:5,'  ');
    Writeln(OutputFile,'');
  end;
  for i:=2 to BP.Num_HDLayer do
    for j:=1 to BP.HDLayer[i].Num_Cell do
    begin
      for k:=0 to BP.HDLayer[i-1].Num_Cell do
        Write(OutputFile,BP.HDLayer[i].HDCells[j].weights[k]:7:5,'  ');
      Writeln(OutputFile,'');
    end;
  for j:=1 to BP.OPLayer.Num_Cell do
  begin
    for k:=0 to BP.HDLayer[BP.Num_HDLayer].Num_Cell do
      Write(OutputFile,BP.OPLayer.OPCells[j].weights[k]:7:5,'  ');
    Writeln(OutputFile,'');
  end;
//  Writeln(OutputFile,C);
//  Writeln(OutputFile,ER:12:9);
  CloseFile(OutputFile);
end;

procedure TForm5.TrainNeural;
var
  IP, TG : array of real;
  ER : real;
  C, i : integer;
begin
{ Init error file }
{ error file name = topology file name - '.txt' + '.err'}
  ERFile := Main.TopologyFileName;
  i := Pos('.',ERFile);
  Delete(ERFile,i,4);               { delete '.txt'}
  ERFile := Concat(ERFile,'.err');  { append '.err' to file name}
  AssignFile(ErrorFile,ERFile);
  Rewrite(ErrorFile);

  ER := Errors + 1;                 { ER = error in each loop }
  C := 0;                           { C  = number of trained cycles }

  SetLength(IP,Main.BP.IPLayer.Num_Cell+1);{IP and TG is input and target array}
  SetLength(TG,Main.BP.OPLayer.Num_Cell+1);
  ProgressBar1.Max := Cycles;
  {step 1. random weight}
  Main.BP.RandomWeight;

  while (C < Cycles) and (ER > Errors) do { Errors = acceptible error
                                            Cycles = max loop }
  begin
    AssignFile(InputFile,Main.InputFileName);
    Reset(InputFile);
    AssignFile(TargetFile,Main.TargetFileName);
    Reset(TargetFile);
    ER := 0;

    {------------------- 1 Cycle ------------------}
    while (not Eof(InputFile)) and
          (not Eof(TargetFile)) do
    begin
      ReadIP_TG(IP,TG);
      {step 2. Feed Forward}
      Main.BP.Feedforward(IP);
      {step 3. Backpropagation of error}
      Main.BP.Backward(TG);
      {step 4. Update weight}
      Main.BP.UpdateWeight;

      { Summation of squared error }
      for i:=1 to Main.BP.OPLayer.Num_Cell do
          ER := ER + sqr(TG[i]-Main.BP.OPLayer.OutputBuffer[i]);
    end;{while not Eof...}
    {-----------------------------------------------}

    ER := ER / 2;    {mean squared error}
    Write(ErrorFile,ER:12:9,' ');
    C := C + 1;
    CloseFile(InputFile);
    CloseFile(TargetFile);
    Progressbar1.StepIt;
    Form5.Refresh;
    MainForm.Refresh;
  end;{while C < Cycles...}

  CloseFile(ErrorFile);
  if C < Cycles then Progressbar1.Position := Cycles;
  Trained_Loops := C;
  LastError := ER;
  WriteTopology(BP);//,C,ER);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  StartTimeLabel.Caption := TimeToStr(Time);
  Button1.Enabled := false;
  Refresh;
  Main.BP := BPN.BackProp.Create;
  TrainNeural;
  Label9.Caption := 'Training completed.';
  Label9.Left := 188;
  Label11.Visible := true;
  FinishTimeLabel.Visible := true;
  FinishTimeLabel.Caption := TimeToStr(Time);
  Button2.Enabled := true;
  Button2.SetFocus;
end;


procedure TForm5.Button2Click(Sender: TObject);
var
{for GenPage}
  i : integer;
begin
{ GenPage Information }
  MainForm.TPFileNameLb.Caption := '''' + Main.TopologyFileName + '''';
  MainForm.HDLayerLb.Caption := IntToStr(BPN.Num_HD);
  MainForm.IPUnitLb.Caption := IntToStr(BPN.Cells[0]);
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
  MainForm.OPUnitLb.Caption := IntToStr(BPN.Cells[BPN.Num_HD+1]);
  MainForm.HDTypeLb.Caption := BPN.HDCell_Type;
  MainForm.OPTypeLb.Caption := BPN.OPCell_Type;
{ TrainPage Information }
  MainForm.FirstTrainLb.Caption := Form3.Label15.Caption;
  MainForm.LastTrainLb.Caption := Unit3.LastTRDate;
  MainForm.TrCountLb.Caption := IntToStr(Unit3.DataSize);
  MainForm.LRLb.Caption := Form4.Edit1.Text;
  MainForm.MoLb.Caption := Form4.Edit2.Text;
  MainForm.CyclesLb.Caption := IntToStr(Trained_Loops);
  MainForm.ErrLb.Caption := Form4.Edit4.Text;
  MainForm.ERLb.Caption := FloatToStr(LastError);
  MainForm.StartTimeLb.Caption := Form5.StartTimeLabel.Caption;
  MainForm.FinishTimeLb.Caption := Form5.FinishTimeLabel.Caption;
  MainForm.TRDateLb.Caption :=  DateToStr(Date);
{TestPage information}
  {Test Data}
  with MainForm.PRIZETABLE do
  begin
    IndexName := 'PRIZE_NO.';
    Setkey;
    FieldByName('PNUMBER').AsInteger := Unit3.DataSize;
    GotoKey;                            // Goto last train record
    IndexName := '';
  end;
  MainForm.PRIZETABLE.Next;
  MainForm.FirstTestLb.Caption := DateToStr(MainForm.PRIZETABLE['PDATE']);
  MainForm.LastTestLb.Caption := Form3.Label17.Caption;
  MainForm.TotalTestLb.Caption := IntToStr(Unit3.TotalData - Unit3.DataSize);
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
  with MainForm.Query1 do
  begin
    Close;
    ParamByName('TrainDataSize').AsInteger := Unit3.DataSize;
    Open;
  end;
  Form1.Close;
  Form2.Close;
  Form3.Close;
  Form4.Close;
  Main.Cycles := IntToStr(Trained_Loops);
  MainForm.ToolButton1.Enabled := False;  //cannot new
  MainForm.ToolButton8.Enabled := False;  //cannot open
  MainForm.ToolButton6.Enabled := True;   //can close
  MainForm.Caption := 'Model Creator : ' + Main.TopologyFileName;
  MainForm.PageControl1.ActivePage := MainForm.GenPage;
  MainForm.Color := clsilver;
  MainForm.PageControl1.Visible := True;
  Form5.Close;
end;

end.
