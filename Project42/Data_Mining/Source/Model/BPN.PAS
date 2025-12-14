{ Backpropagation Neural Network }

unit BPN;

interface

type
  Buffer = array of real;

  Cell = class
    public
      constructor Create;
      destructor Destroy; override;
  end;

  NoCompute_Cell = class(Cell)
    public
      function WeightedSum : real;
      function Transfer : real;
    end;

  Compute_Cell = class(Cell)
    public
      Weights : Buffer;
      Prev_Weights : Buffer;
      UpdateTerms : Buffer;
      function WeightedSum(X: Buffer; Num_Cell: integer): real; virtual;
      function Transfer(x: real): real; virtual;
      function Transfer_Diff(x: real): real; virtual;
    end;

  Sigmoid_Cell = class(Compute_Cell)
    public
      function Transfer(x: real): real; override;
      function Transfer_Diff(f_x: real): real; override;
    end;

  Tanh_Cell = class(Compute_Cell)
    public
      function Transfer(x: real): real; override;
      function Transfer_Diff(f_x: real): real; override;
    end;

  Layer = class
    public
      Num_Cell :integer;
      OutputBuffer :Buffer;
      constructor Create; overload; virtual;
      destructor Destroy; override;
  end;

  InputLayer = class(Layer)
    public
      IPCells :array of NoCompute_Cell;
      constructor Create; override;
    end;

  HiddenLayer = class(Layer)
    public
      DeltaBuffer :Buffer;
      HDCells :array of Compute_Cell;
      constructor Create(index: integer; Cell_Type: String); reintroduce; overload;
    end;

  OutputLayer = class(Layer)
    public
      OPCells :array of Compute_Cell;
      constructor Create(Cell_Type: String); reintroduce; overload;
    end;

  BackProp = class
    public
      LearningRate: real;
      Momentum: real;
      Num_HDLayer: integer;
      MaxRandom: integer;
      IPLayer: InputLayer;
      HDLayer: array of HiddenLayer;
      OPLayer: OutputLayer;
      constructor Create;
      destructor Destroy; override;
      procedure Feedforward(InputData : array of real);
      procedure Backward(Target : array of real);
      procedure UpdateWeight;
      procedure RandomWeight;
      function RandomRange : real;
  end;

var
  LR, Mo : real;
  Num_HD :integer;
  Cells : array of integer;
          {number of cells in each layer is kept in this array}
  HDCell_Type, OPCell_Type : string;
implementation

{ Cell }

constructor Cell.Create;
begin
  inherited;
end;

destructor Cell.Destroy;
begin
  inherited;
end;


{ NoCompute_Cell }

procedure NoCompute_Cell.WeightedSum;
begin

end;

procedure NoCompute_Cell.Transfer;
begin

end;


{ Compute_Cell }

function Compute_Cell.WeightedSum(X: Buffer; Num_Cell: integer): real;
{ X is OutputBuffer of the immediate beneath layer.
  Num_Cell is amount of cells in the immediate beneath layer.}
var
  sum : real;
  i : integer;
begin
  sum := 0;
  i := 0;
  while i <= Num_Cell do
    begin
      sum := sum + Weights[i]*X[i];
      i := i+1;
    end;
  WeightedSum := sum;
end;

function Compute_Cell.Transfer(x: real): real;
begin

end;

function Compute_Cell.Transfer_Diff(x: real): real;
begin

end;


{ Sigmoid_Cell }

function Sigmoid_Cell.Transfer(x: real): real;
begin
  Transfer := 1/(1+Exp(-1*x));
end;

function Sigmoid_Cell.Transfer_Diff(f_x: real): real;
begin
  Transfer_Diff :=  f_x * ( 1 - f_x );
end;


{ Tanh_Cell }

function Tanh_Cell.Transfer(x: real): real;
var
  E, E_minus: real;
begin
  E := Exp(x);
  E_minus := Exp(-1*x);
  Transfer := ( E - E_minus )/( E + E_minus );
end;

function Tanh_Cell.Transfer_Diff(f_x: real): real;
begin
  Transfer_Diff := 1 - Sqr(f_x);
end;


{ Layer }

constructor Layer.Create;
begin

end;

destructor Layer.Destroy;
begin

end;


{ InputLayer }

constructor InputLayer.Create;
var
  i : integer;
begin
  inherited;
  Num_Cell := Cells[0];
  setlength(IPCells,Num_Cell+1);
  for i:=1 to Num_Cell do
    IPCells[i] := NoCompute_Cell.Create;
end;


{ HiddenLayer }

constructor HiddenLayer.Create(index: integer; Cell_Type: String);
var
  i : integer;
begin
  inherited Create;
  Num_Cell := Cells[index];
  setlength(HDCells,Num_Cell+1);
  if Cell_Type = 'Sigmoid function' then
    for i:=1 to Num_Cell do
      HDCells[i] := Sigmoid_Cell.Create
  else
    if Cell_Type = 'Hyperbolic tangent function' then
      for i:=1 to Num_Cell do
        HDCells[i] := Tanh_Cell.Create;
end;


{ OutputLayer }

constructor OutputLayer.Create(Cell_Type: String);
var
  i : integer;
begin
  inherited Create;
  Num_Cell := Cells[Num_HD+1];
  setlength(OPCells,Num_Cell+1);
  if Cell_Type = 'Sigmoid function' then
    for i:=1 to Num_Cell do
      OPCells[i] := Sigmoid_Cell.Create
  else
    if Cell_Type = 'Hyperbolic tangent function' then
      for i:=1 to Num_Cell do
        OPCells[i] := Tanh_Cell.Create;

end;


{ BackProp }

constructor BackProp.Create;
var
  i, j : integer;
begin
  inherited;
  LearningRate := LR;
  Momentum := Mo;
  Num_HDLayer := Num_HD;
  MaxRandom := 1000;      {Boundary for Random weights}
  {********* Input Layer **********}
  IPLayer := InputLayer.Create;
  SetLength(IPLayer.OutputBuffer,IPLayer.Num_Cell+1);
  {********* Hidden Layer **********}
  SetLength(HDLayer,Num_HDLayer+1); //index 0 is not used
  for i:=1 to Num_HDLayer do
  begin
    HDLayer[i] := HiddenLayer.Create(i,HDCell_type);{i = layer no.}
    SetLength(HDLayer[i].OutputBuffer,HDLayer[i].Num_Cell+1);
    SetLength(HDLayer[i].DeltaBuffer,Cells[i+1]+1);
    for j:=1 to HDLayer[i].Num_Cell do
    begin
      SetLength(HDLayer[i].HDCells[j].Weights,Cells[i-1]+1);
      SetLength(HDLayer[i].HDCells[j].Prev_Weights,Cells[i-1]+1);
      SetLength(HDLayer[i].HDCells[j].UpdateTerms,Cells[i-1]+1);
    end;
  end;
  {********* Output Layer **********}
  OPLayer := OutputLayer.Create(OPCell_Type);
  SetLength(OPLayer.OutputBuffer,OPLayer.Num_Cell+1);
  for i:=1 to OPLayer.Num_Cell do
  begin
    SetLength(OPLayer.OPCells[i].Weights,Cells[Num_HDLayer]+1);
    SetLength(OPLayer.OPCells[i].Prev_weights,Cells[Num_HDLayer]+1);
    SetLength(OPLayer.OPCells[i].UpdateTerms,Cells[Num_HDLayer]+1);
  end;
end;

destructor BackProp.Destroy;
begin

end;

procedure BackProp.Feedforward(InputData: array of real);
var
  i, j : integer;
  combine : real;
begin
  {********* Input Layer **********}
  IPLayer.OutputBuffer[0] := 1;     //bias
  for i := 1 to IPLayer.Num_Cell do
    IPLayer.OutputBuffer[i] := InputData[i];

  {********* Hidden Layer **********}
  for i := 1 to Num_HDLayer do
    HDLayer[i].OutputBuffer[0] := 1; //bias
  {first hidden layer is next to input layer}
  for j := 1 to HDLayer[1].Num_Cell do
  begin
    //find weighted sum
    combine := HDLayer[1].HDCells[j].WeightedSum(IPLayer.OutputBuffer,
                                                 IPLayer.Num_Cell);
    //find transfer function
    HDLayer[1].OutputBuffer[j] := HDLayer[1].HDCells[j].Transfer(combine);
  end;

  for i := 2 to Num_HDLayer do
    for j := 1 to HDLayer[i].Num_Cell do
    begin
      //find weighted sum
      combine := HDLayer[i].HDCells[j].WeightedSum(HDLayer[i-1].OutputBuffer,
                                                   HDLayer[i-1].Num_Cell);
      //find transfer function
      HDLayer[i].OutputBuffer[j] := HDLayer[i].HDCells[j].Transfer(combine);
    end;

  {********* Output Layer **********}
  OPLayer.OutputBuffer[0] := 1; //bias
  for j := 1 to OPLayer.Num_Cell do
  begin
    //find weighted sum
    combine := OPLayer.OPCells[j].WeightedSum(HDLayer[Num_HDLayer].OutputBuffer,
                                              HDLayer[Num_HDLayer].Num_Cell);
    //find transfer function
    OPLayer.OutputBuffer[j] := OPLayer.OPCells[j].Transfer(combine);
  end;
end;

procedure BackProp.Backward(Target: array of real);
var
  i, j, k, z : integer;
  AlphaDelta, DeltaSum, HDDelta: real;
begin
  {********* Output Layer **********}
  for k := 1 to OPLayer.Num_Cell do
  begin
    HDLayer[Num_HDLayer].Deltabuffer[k] := (Target[k] - OPLayer.OutputBuffer[k])
                                            * OPLayer.OPCells[k].Transfer_Diff
                                              (OPLayer.OutputBuffer[k]);
    { delta(k) = (tk - yk) * yk' }
    AlphaDelta := LearningRate * HDLayer[Num_HDLayer].Deltabuffer[k];
    OPLayer.OPCells[k].UpdateTerms[0] := AlphaDelta;
    for j:= 1 to HDLayer[Num_HDLayer].Num_Cell do
      OPLayer.OPCells[k].UpdateTerms[j] := AlphaDelta *
                                           HDLayer[Num_HDLayer].OutputBuffer[j];
  end;
  {********* Hidden Layer **********}
  for j := 1 to HDLayer[Num_HDLayer].Num_Cell do
  begin
    DeltaSum := 0;
    for k := 1 to OPLayer.Num_Cell do
      DeltaSum := DeltaSum + (HDLayer[Num_HDLayer].DeltaBuffer[k] *
                                OPLayer.OPCells[k].Weights[j]);

     HDDelta := DeltaSum * HDLayer[Num_HDLayer].HDCells[j].
                        Transfer_Diff(HDLayer[Num_HDLayer].OutputBuffer[j]);

    AlphaDelta := LearningRate * HDDelta;
    HDLayer[Num_HDLayer].HDCells[j].UpdateTerms[0] := AlphaDelta;
    if Num_HDLayer = 1 then
      for i := 1 to IPLayer.Num_Cell do
        HDLayer[Num_HDLayer].HDCells[j].UpdateTerms[i] := AlphaDelta *
                                                          IPLayer.OutputBuffer[i]
    else
    begin
      HDLayer[Num_HDLayer-1].DeltaBuffer[j] := HDDelta;
      for i := 1 to HDLayer[Num_HDLayer-1].Num_Cell do
        HDLayer[Num_HDLayer].HDCells[j].UpdateTerms[i] := AlphaDelta *
                                                          HDLayer[Num_HDLayer-1].OutputBuffer[i];
    end;
  end;
  if Num_HDLayer > 1 then
  begin
    for k := Num_HDLayer-1 downto 2 do
    begin
      for j := 1 to HDLayer[k].Num_Cell do
      begin
        DeltaSum := 0;
        for i := 1 to HDLayer[k+1].Num_Cell do
          DeltaSum := HDLayer[k].DeltaBuffer[i] *
                              HDLayer[k+1].HDCells[i].Weights[j];

        HDDelta := DeltaSum * HDLayer[k].HDCells[j].Transfer_Diff
                                    (HDLayer[k].OutputBuffer[j]);

        AlphaDelta := LearningRate * HDDelta;

        HDLayer[k].HDCells[j].UpdateTerms[0] := AlphaDelta;
        for z := 1 to HDLayer[k-1].Num_Cell do
          HDLayer[k].HDCells[j].UpdateTerms[z] := AlphaDelta *
                                               HDLayer[k-1].OutputBuffer[z];

        HDLayer[k-1].DeltaBuffer[j] := HDDelta;
      end;
    end;
    {********for lowest hidden layer***********}
    for j := 1 to HDLayer[1].Num_Cell do
    begin
      DeltaSum := 0;
      for i := 1 to HDLayer[2].Num_Cell do
        DeltaSum := DeltaSum + HDLayer[1].DeltaBuffer[i] *
                          HDLayer[2].HDCells[i].Weights[j];

      HDDelta := DeltaSum * HDLayer[1].HDCells[j].Transfer_Diff
                                              (HDLayer[1].OutputBuffer[j]);

      AlphaDelta := LearningRate * HDDelta;
      HDLayer[1].HDCells[j].UpdateTerms[0] := AlphaDelta;
      for z := 1 to IPLayer.Num_Cell do
        HDLayer[1].HDCells[j].UpdateTerms[z] := AlphaDelta
                                                     * IPLayer.OutputBuffer[z];
    end;
  end;
end;

procedure BackProp.UpdateWeight;
var
  i, j, k : integer;
  Wn : real;
begin
  {******************* for output layer *******************}
  for i := 1 to OPLayer.Num_Cell do
    for j := 0 to HDLayer[Num_HDLayer].Num_Cell do
    begin
      Wn := OPLayer.OPCells[i].weights[j] + OPLayer.OPCells[i].UpdateTerms[j]
            + Momentum*(OPLayer.OPCells[i].weights[j]
                         - OPLayer.OPCells[i].Prev_weights[j]);
      OPLayer.OPCells[i].Prev_weights[j] := OPLayer.OPCells[i].weights[j];
      OPLayer.OPCells[i].weights[j] := Wn;
    end;
  {****************** for hidden layer *******************}
  for k := 2 to Num_HDLayer do
    for i := 1 to HDLayer[k].Num_Cell do
      for j := 0 to HDLayer[k-1].Num_Cell do
      begin
        Wn := HDLayer[k].HDCells[i].weights[j] + HDLayer[k].HDCells[i].UpdateTerms[j]
              + Momentum*(HDLayer[k].HDCells[i].weights[j]
                          - HDLayer[k].HDCells[i].Prev_weights[j]);
        HDLayer[k].HDCells[i].Prev_weights[j] := HDLayer[k].HDCells[i].weights[j];
        HDLayer[k].HDCells[i].weights[j] := Wn;
      end;
  // for first hidden layer
  for i := 1 to HDLayer[1].Num_Cell do
    for j := 0 to IPLayer.Num_Cell do
    begin
      Wn := HDLayer[1].HDCells[i].weights[j] + HDLayer[1].HDCells[i].UpdateTerms[j]
            + Momentum*(HDLayer[1].HDCells[i].weights[j]
                        - HDLayer[1].HDCells[i].Prev_weights[j]);
      HDLayer[1].HDCells[i].Prev_weights[j] := HDLayer[1].HDCells[i].weights[j];
      HDLayer[1].HDCells[i].weights[j] := Wn;
    end;
end;

function BackProp.RandomRange: real;
var value,sign:integer;
begin
  value := Random(MaxRandom);
  sign := Random(2);
  if sign=0 then RandomRange := value/1000
            else RandomRange := (0-value)/1000;
end;

procedure BackProp.RandomWeight;
var i,j,k : integer;
begin
  Randomize;
  with Self do
  begin
    for k:=1 to Num_HDLayer do
      if k=1 then
        for i:=1 to HDLayer[k].Num_Cell do
          for j:=0 to IPLayer.Num_Cell do
            HDLayer[k].HDCells[i].Weights[j] := RandomRange
      else
        for i:=1 to HDLayer[k].Num_Cell do
          for j:=0 to HDLayer[k-1].Num_Cell do
            HDLayer[k].HDCells[i].Weights[j] := RandomRange;

    for i:=1 to OPLayer.Num_Cell do
      for j:=0 to HDLayer[Num_HDLayer].Num_Cell do
        OPLayer.OPCells[i].Weights[j] := RandomRange;
  end;
end;

end.
