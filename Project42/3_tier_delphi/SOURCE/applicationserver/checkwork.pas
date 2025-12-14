unit checkwork;

interface

uses hrdatamodule,SysUtils,Timer,Dialogs;

type
  Working = class
  public
    ID : integer;
    workertype : string;
    time_in : real;
    time_out : real;
    ot_in : real;
    ot_out : real;
    DayWork : TDateTime;
    Hours : real;
    otHours : real;
    due_in : real;
    due_out : real;
    Late : boolean;
    Dayoff : boolean;
    Absent : boolean;
    comework : boolean;
    absentrec : boolean;  // has record for absent
    workot : boolean;     // has work ot in this day
    constructor create(empid:integer);
    procedure checkAbsent;
    procedure checkOTWorktime;
    procedure checkWorkTime;
    procedure checkDueTime;
  end;

var
  empworking : Working;

implementation

constructor Working.create(empid:integer);
var
  empworktype : string;
  date : integer;
  day,month,year : string;
  yesterday : string;
begin
  ID := empid;
  with DataModule1.QueryEmpinfo do
  begin
    close;
    unprepare;
    params[0].asInteger := ID;
    prepare;
    open;
  end;
  empworktype := DataModule1.QueryEmpinfoWORKER_TYPE.AsString;
  if empworktype = 'กะเช้า' then workertype := 'daywork/daytime';
  if empworktype = 'กะเย็น' then workertype := 'daywork/noon';
  if (empworktype = 'Officer') or (empworktype = 'พนักงานประจำ') then workertype := 'official';
// get yesterday  daywork= yesterday
  date := ServerDate.Date;
  date := date-1;
  day := IntToStr(date);
  month := ServerDate.month;
  year := ServerDate.year;
  yesterday := day+'/'+month+'/'+year;
  daywork := StrToDate(yesterday);
  checkDueTime;
  checkworkTime;
  Late := false;
  Dayoff := false;
  Absent := false;
  comework := false;
  absentrec := false;
  workot := false;
  checkAbsent;
  checkOTWorkTime;
end;

procedure Working.checkAbsent;
begin
  with DataModule1.QueryAbsentRec do
  begin
    close;
    unprepare;
    params[0].asInteger := ID;
    params[1].AsDateTime := dayWork;
    prepare;
    open;
  end;
  if DataModule1.QueryAbsentRecCOUNT.AsInteger >=1 then absentrec := true
  else absentrec := false;
  with Datamodule1.QueryComework do
  begin
    close;
    unprepare;
    params[0].AsInteger := ID;
    params[1].AsDate := daywork;
    prepare;
    open;
  end;
  while not Datamodule1.QueryComework.Eof do
  begin
    if Datamodule1.QueryComeworkWORK_TYPE.AsString = 'OT' then
    begin
      comework := true;
      workot := true;
    end;
    Datamodule1.QueryComework.Next;
  end;
  // check he/she is come to work and not late
  if comework then
    begin
    if time_in > due_in+15 then
      begin
        if not absentrec then
        Late := true;
      end
    else Late := false;
    end;
  if not comework and absentrec then
    begin
    absent := true;
    dayoff := false;
    late := false;
    end;
  if not comework and not absentrec then
    begin
    absent := false;
    dayoff := true;
    late := false;
    end;
end;

procedure Working.checkOTWorktime;
begin
  if workot = true then
  begin
    if workertype = 'official' then
    begin
      if ot_in >= 17.0 then
        otHours := ot_out-ot_in;
    end;
    if workertype = 'daywork/daytime' then
    begin
      if ot_in >= 16.0 then
        otHours := ot_out-ot_in;
    end;
    if workertype = 'daywork/noon' then
    begin
      if ot_in < 16.0 then
        otHours := ot_out-ot_in;
    end;
    with DataModule1.QueryInsertOT do
    begin
      close;
      params[0].AsInteger := ID;
      params[1].AsDateTime := daywork;
      params[2].AsFloat := otHours;
      ExecSQL;
    end;
  end;
end;

procedure Working.checkWorkTime;
var
  timeinbuff,timeoutbuff : real;
  otinbuff,otoutbuff : real;
begin
  timeinbuff := 0;
  timeoutbuff := 0;
  otinbuff := 0;
  otoutbuff := 0;
  with DataModule1.QueryEmpWork do
  begin
    close;
    unprepare;
    params[0].AsInteger := ID;
    params[1].AsDateTime := DayWork;
    prepare;
    open;
  end;
  while not Datamodule1.QueryEmpWork.Eof do
  begin
    if Datamodule1.QueryEmpWorkWORK_TYPE.AsString = 'งานประจำ' then
    begin
      timeinbuff := datamodule1.QueryEmpWorkTIME_IN.AsFloat;
      timeoutbuff := datamodule1.QueryEmpWorkTIME_OUT.AsFloat;
      datamodule1.QueryEmpWork.Next;
    end;
    if Datamodule1.QueryEmpWorkWORK_TYPE.AsString = 'OT' then
    begin
      otinbuff := datamodule1.QueryEmpWorkTIME_IN.AsFloat;
      otoutbuff := datamodule1.QueryEmpWorkTIME_OUT.AsFloat;
      datamodule1.QueryEmpWork.Next;
    end;
  end;
  // ***************************
  // set time to real
  time_in := trunc(timeinbuff);
  timeinbuff := timeinbuff-time_in;
  timeinbuff := timeinbuff/0.6;
  time_in := time_in+timeinbuff;

  time_out := trunc(timeoutbuff);
  timeoutbuff := timeoutbuff-time_out;
  timeoutbuff := timeoutbuff/0.6;
  time_out := time_out+timeoutbuff;

  ot_in := trunc(otinbuff);
  otinbuff := otinbuff-ot_in;
  otinbuff := otinbuff/0.6;
  ot_in := ot_in+otinbuff;

  ot_out := trunc(otoutbuff);
  otoutbuff := otoutbuff-ot_out;
  otoutbuff := otoutbuff/0.6;
  ot_out := ot_out+otoutbuff;
  //  ****************************
end;

procedure Working.checkDueTime;
begin
  if workertype = 'official' then
  begin
    due_in := 8.0;
    due_out := 17.0;
  end;
  if workertype = 'daywork/daytime' then
  begin
    due_in := 8.0;
    due_out := 16.0;
  end;
  if workertype = 'daywork/noon' then
  begin
    due_in := 16.0;
    due_out := 24.0;
  end;
end;

end.
