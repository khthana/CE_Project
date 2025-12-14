unit Massage;

interface

const
  OutputFile = 'temp.txt';
  Lines = 5;

type
  BufferArray = array of real;
  TManageFile = class
    public
      RFile, WFile: TextFile;
      NumIP: integer;
      constructor Create(Filename: string);
      destructor Destroy; override;
      procedure CountIP;
      procedure ReadFile(var Buffer: BufferArray;
                         var Count: integer);
      procedure WriteFile(Buffer: BufferArray;
                           Count: integer);
    end;

  TMassage = class
    private
      FMin: real;
      FMax: real;
      FLowBound: real;
      FUpBound: real;
      procedure SetMin(const Value: real);
      procedure SetMax(const Value: real);
      procedure SetLowBound(const Value: real);
      procedure SetUpBound(const Value: real);
    public
      MFilename: string;
      Count: integer;
      IPBuffer, OPBuffer: BufferArray;
      property Min: real read FMin write SetMin;
      property Max: real read FMax write SetMax;
      property LowBound: real read FLowBound write SetLowBound;
      property UpBound: real read FUpBound write SetUpBound;
      constructor Create(Filename: string;
                         Min, Max, UpBound, LowBound: real);
      procedure Massage(BufSize: integer; FileManage: TManageFile);  { BufSize = NumIP }
    end;
var
  EndFile : Boolean;

implementation

{ TMassage }

constructor TMassage.Create(Filename: string; Min, Max, UpBound,
  LowBound: real);
begin
  MFilename := Filename;
  Count := 0;
  SetMin(Min);
  SetMax(Max);
  SetUpBound(UpBound);
  SetLowBound(LowBound);
end;

procedure TMassage.Massage(BufSize: integer; FileManage: TManageFile);
var
  i: integer;
  range, diff, tmp: real;
begin
  i := BufSize * Lines;
  SetLength(IPBuffer,i+1);
  SetLength(OPBuffer,i+1);

  While not EndFile do  {EndFile is set to be True in TManageFile.ReadFile}
  begin
    FileManage.ReadFile(IPBuffer,Count);
    range := FUpBound - FLowBound;
    diff := FMax - FMin;
    for i:=1 to Count do
    begin
      tmp := (IPBuffer[i] - FMin)/diff;
      tmp := (tmp * range) + FLowBound;
      OPBuffer[i] := tmp;
    end;
    FileManage.WriteFile(OPBuffer,Count);
  end;

end;

procedure TMassage.SetLowBound(const Value: real);
begin
  FLowBound := Value;
end;

procedure TMassage.SetMax(const Value: real);
begin
  FMax := Value;
end;

procedure TMassage.SetMin(const Value: real);
begin
  FMin := Value;
end;

procedure TMassage.SetUpBound(const Value: real);
begin
  FUpBound := Value;
end;

{ TManageFile }

constructor TManageFile.Create(Filename: string);
begin
  AssignFile(RFile,Filename);
  ReSet(RFile);
  CountIP;
  CloseFile(RFile);
  AssignFile(RFile,Filename);
  ReSet(RFile);
  AssignFile(WFile,OutputFile);
  ReWrite(WFile);
end;

destructor TManageFile.Destroy;
begin
  CloseFile(RFile);
  CloseFile(WFile);
end;

procedure TManageFile.CountIP;
var
  tmp : real;
begin
  NumIP := 0;
  While not EoLn(RFile)do
  begin
    Read(RFile,tmp);
    NumIP := NumIP + 1;
  end;
end;

procedure TManageFile.ReadFile(var Buffer: BufferArray;
                               var Count: integer);
var
  i : integer;
begin
  i := NumIP * Lines;
  Count := 1;
  While (Count <= i) and (not Eof(RFile)) do
  begin
    Read(RFile,Buffer[Count]);
    Count := Count + 1;
  end;
  Count := Count - 1;
  if Eof(RFile) then EndFile := True;     
end;

procedure TManageFile.WriteFile(Buffer: BufferArray; Count: integer);
var
  i, j : integer;
begin
  i := 0;
  While i<Count do
  begin
    for j:=1 to NumIP do
      Write(WFile,Buffer[i+j]:5:3,' ');
    Writeln(WFile,'');
    i := i + NumIP;
  end;
end;

end.
