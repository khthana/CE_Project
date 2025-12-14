unit Timer;

interface

uses
  SysUtils;

type

  TDateTimeObject = class
    today  : TDateTime;
    date : integer;
    month : string;
    year : string;
    endmonth : boolean;
    constructor create;
    function EndOfMonth:boolean;
    procedure FilterDateMonth;
  end;

var
  ServerDate : TDateTimeObject;

implementation
constructor TDateTimeObject.create;
begin
  today := Now;
  month := '00';
  year := '00';
  date := 0;
end;

function TDateTimeObject.EndOfMonth:boolean;
var
  intmonth : integer;
  bdate : integer;
  tail : boolean;
begin
  tail := false;
  intmonth := StrToInt(month);
  bdate := date;
  case intmonth of
  1 : if bdate = 31 then tail := true;
  2 : if bdate = 28 then tail := true;
  3 : if bdate = 31 then tail := true;
  4 : if bdate = 30 then tail := true;
  5 : if bdate = 31 then tail := true;
  6 : if bdate = 30 then tail := true;
  7 : if bdate = 31 then tail := true;
  8 : if bdate = 31 then tail := true;
  9 : if bdate = 30 then tail := true;
  10: if bdate = 31 then tail := true;
  11: if bdate = 30 then tail := true;
  12: if bdate = 31 then tail := true;
  else tail := false;
  end;
  result := tail;
end;

procedure TDateTimeObject.FilterDateMonth;
var
  stringdate : string;
  monthBuffer : array[0..2] of char;
  yearBuffer : array[0..2] of char;
  LStr : integer;
  cntslash : integer;
  i,j,y : integer;
  onedigit : string;
  twodigit : string;
begin
  onedigit := '0';
  twodigit := '00';
  stringdate := DateToStr(today);
  Lstr := Length(stringdate);
  i := 1;
  j := 1;
  y := 1;
  cntSlash := 0;
  while i<=Lstr do
  begin
    if (cntslash = 1) and (j<3) then
      begin
        monthbuffer[j] := stringdate[i];
        j:=j+1;
      end;
    if (cntslash = 2) then
    begin
      yearBuffer[y] := stringdate[i];
      y := y+1;
    end;
    if stringdate[i]='/' then  cntslash := cntslash+1;
    i:=i+1;
  end;
  if monthbuffer[2]= '/' then
  begin
    month[1] := '0';
    month[2] := monthbuffer[1];
  end;
  if monthbuffer[2] <> '/' then
  begin
    month[1] := monthbuffer[1];
    month[2] := monthbuffer[2];
  end;
  if stringdate[2] <> '/' then
  begin
    twodigit[1] := stringdate[1];
    twodigit[2] := stringdate[2];
    date := StrToInt(twodigit);
  end
  else
    begin
      onedigit[1] := stringdate[1];
      date := StrToInt(onedigit);
    end;
  year[1] := yearbuffer[1];
  year[2] := yearbuffer[2];
end;

end.
 