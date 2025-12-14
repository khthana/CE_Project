unit Reader;

interface

uses BPN;

type
  { !!! IMPORTANT
    BPN_Reader must be used ONLY in this order :
               - Call create method first
               - Call ReadTopology        (Open File for reading)
               - Call ReadWeights
               - Call ReadTestData
               - Call ReadTrainData       (Close File)
    if you use it in wrong order I/O error may be occur!}
  BPN_Reader = class
  public
    procedure ReadTopology;
    procedure ReadWeights(BP: BPN.Backprop);
    procedure ReadTestData;
    procedure ReadTrainData;
  end;

var
  TPFile : TextFile;
  TPFilename : string;

implementation

uses Main;

procedure BPN_Reader.ReadTopology;
{Read topology of ANN from file TPFilename to unit BPN's global variable}
var
  i, t : integer;
begin
  AssignFile(TPFile,TPFilename);
  Reset(TPFile);
  Readln(TPFile,BPN.Num_HD);
  SetLength(BPN.Cells,BPN.Num_HD+2);
  Readln(TPFile,BPN.Cells[0]);
  Read(TPFile,BPN.Cells[1]);
  Readln(TPFile,t);
  case t of
    0 : BPN.HDCell_Type := 'Sigmoid function'; //do not modify this name!!!
    1 : BPN.HDCell_Type := 'Hyperbolic tangent function';//do not modify this name
  end;
  for i:=2 to BPN.Num_HD do
    Readln(TPFile,BPN.Cells[i]);
  Read(TPFile,BPN.Cells[BPN.Num_HD+1]);
  Readln(TPFile,t);
  case t of
    0 : BPN.OPCell_Type := 'Sigmoid function';
    1 : BPN.OPCell_Type := 'Hyperbolic tangent function';
  end;
  Readln(TPFile,BPN.LR);
  Readln(TPFile,BPN.Mo);

end;

procedure BPN_Reader.ReadWeights(BP: BPN.Backprop);
var
  i, j, k : integer;
begin
  for k:=1 to BP.Num_HDLayer do
    if k=1 then
      for i:=1 to BP.HDLayer[k].Num_Cell do
        for j:=0 to BP.IPLayer.Num_Cell do
          Read(TPFile,BP.HDLayer[k].HDCells[i].Weights[j])
    else
      for i:=1 to BP.HDLayer[k].Num_Cell do
        for j:=0 to BP.HDLayer[k-1].Num_Cell do
          Read(TPFile,BP.HDLayer[k].HDCells[i].Weights[j]);
  for i:=1 to BP.OPLayer.Num_Cell do
    for j:=0 to BP.HDLayer[BP.Num_HDLayer].Num_Cell do
      Read(TPFile,BP.OPLayer.OPCells[i].Weights[j]);

end;

procedure BPN_Reader.ReadTestData;
var
  i : integer;
  s, tmp : string;
begin
  Readln(TPFile,TestLoops);
  Readln(TPFile,s);
  if s = 'Tested' then
  begin
    Test := True;
    SetLength(ERRORS,TestLoops+1);
    SetLength(Predict,TestLoops+1);
    for i:=1 to 5 do Read(TPFile,ACCURACY[i]);
    for i:=1 to TestLoops do Read(TPFile,Predict[i]);
    for i:=1 to TestLoops do Read(TPFile,ERRORS[i]);
    Readln(TPFile,tmp);
  end
  else Test := False;
  Readln(TPFile,FirstTest);
  Readln(TPFile,LastTest);
end;


procedure BPN_Reader.ReadTrainData;
begin
  Readln(TPFile,TrCount);
  Readln(TPFile,FirstTrain);
  Readln(TPFile,LastTrain);
  Readln(TPFile,Cycles);
  Readln(TPFile,Err);
  Readln(TPFile,ER);
  Readln(TPFile,TRDate);
  Readln(TPFile,StartTime);
  Readln(TPFile,FinishTime);
  CloseFile(TPFile);
end;

end.
