
unit human;

interface

uses hrdatamodule,Timer,SysUtils,Dialogs;

type

  TEmployee = class
  public
    ID : integer;
    payment : real;   // Salary and daypayrate
    otHours : real;
    total_ssmoney : real;
    total_taxpay : real;
    worker_type : string;
    married : boolean;
    ssmoney : real;
    constructor create(empid:integer);
    procedure SalaryPayment; virtual;
    function OTPayment:real; virtual;
    function TaxCalculation(Salary:real):real;
    function SocialSecurityMoney(salary:real):real;
  end;

  TOfficer = class(TEmployee)
  procedure SalaryPayment;override;
  function OTPayment:real;override;
  end;

  TDaylyWorker = class(TEmployee)
  procedure SalaryPayment;override;
  function OTPayment:real;override;
  end;

var
  Employee : TEmployee;
  Officer : TOfficer;
  DaylyWorker : TDaylyWorker;

implementation

constructor TEmployee.create(empid:integer);
var
  thismonth : string;
  worktypeString : string;
begin
  ID := empid;
  OTHours := 0;
  with DataModule1.QueryEmpinfo do
  begin
    close;
    unprepare;
    params[0].asinteger := ID;
    prepare;
    open;
  end;
  payment := DataModule1.QueryEmpinfoSALARY.AsInteger;
  if DataModule1.QueryEmpinfoMARRITAL_STATUS.AsString = 'แต่งงาน' then married := true
  else married := false;
  worktypestring := DataModule1.QueryEmpinfoWORKER_TYPE.AsString;
  if (worktypestring = 'Officer') or (worktypestring = 'พนักงานประจำ') then worker_type := 'Officer';
  if (worktypestring = 'กะเช้า') or (worktypestring = 'กะเย็น') then worker_type := 'dayly';
  with Datamodule1.querytotal do
  begin
    close;
    unprepare;
    params[0].AsInteger := ID;
    prepare;
    open;
    last;
  end;
  total_taxpay := DataModule1.QuerytotalTOTAL_TAX.AsFloat;
  total_ssmoney := DataModule1.QuerytotalTOTAL_SS_MONEY.AsFloat;
  thismonth := ServerDate.month+','+ServerDate.year ;
  with DataModule1.QueryOtHours do
  begin
    close;
    unprepare;
    params[0].AsInteger := ID;
    params[1].AsString := thismonth;
    prepare;
    open;
  end;
  while not DataModule1.QueryOtHours.Eof do
  begin
    OTHours := OTHours+DataModule1.QueryOtHoursHOURS.AsFloat;
    DataModule1.QueryOtHours.Next;
  end;
end;


procedure TEmployee.SalaryPayment;
var
  MonthlySalary : real;
  OTMoney : real;
  PayTax : real;
  MoneyPay : real;
  ssmoney : real;
  salary : real;
  daypay : TDateTime;
begin
  MonthlySalary := payment;
  OTMoney := OTPayment;
  salary := MonthlySalary+OTMoney;
  ssmoney := SocialSecurityMoney(salary);
  total_ssmoney := total_ssmoney+Employee.ssmoney;
  salary := salary-ssmoney;
  payTax := (TaxCalculation(salary))/12;
  total_taxpay := total_taxpay+payTax;
  MoneyPay := salary-payTax;
  Daypay := Now;
  with DataModule1.QueryInsertEarning do
  begin
    close;
    params[0].AsInteger := ID;
    params[1].AsDateTime := daypay;
    params[2].AsFloat := OTMoney;
    params[3].AsFloat := MonthlySalary;
    params[4].AsFloat := payTax;
    params[5].AsFloat := ssmoney;
    params[6].AsFloat := MoneyPay;
    params[7].AsFloat := total_taxpay;
    params[8].AsFloat := total_ssmoney;
    ExecSQL;
  end;
end;

function TEmployee.OTPayment:real;
var
  Multiplier : integer;
  HourPay : real;
  OTMoney : real;
begin
  HourPay := 200.0;
  DataModule1.QueryOTrate.open;
  Multiplier := DataModule1.QueryOTrateRATE.AsInteger;
  OTMoney := OTHours*(Multiplier*HourPay);
  result := OTMoney;
end;

function TEmployee.TaxCalculation(Salary:real):real;
var
  SalaryMoney : real;
  YearlyIncome : real;
  Expense_percent : real;
  max_expense : real;
  Expense_money : real;
  ToReduceMoney :real;
  Children_no : integer;  // number of childrens the employee has
  Children : real;  //multiplyer for 1 children
  children_money : real;  //money pay for childrens = children_no*children
  netMoney :real;
  netIncomefield : real;
  max_level : real;
  Tax : real;
  TaxRate : integer;
  fin : boolean;
  cond_text : string;
  n : integer;

begin
  Tax := 0;
  SalaryMoney := Salary;
  YearlyIncome := SalaryMoney*12;
  for n := 0 to 3 do
  begin
    if n = 0 then cond_text := 'expenses_percent';
    if n = 1 then cond_text := 'max_expense';
    if n = 2 then cond_text := 'decrease_money';
    if n = 3 then cond_text := 'children';
    with DataModule1.QueryTaxreduce do
    begin
      close;
      unprepare;
      params[0].asstring := cond_text;
      prepare;
      open;
    end;
    if n = 0 then Expense_percent := DataModule1.QueryTaxreduceREDUCEVALUE.AsFloat;
    if n = 1 then max_expense := DataModule1.QueryTaxreduceREDUCEVALUE.AsFloat;
    if n = 2 then ToReduceMoney := DataModule1.QueryTaxreduceREDUCEVALUE.AsFloat;
    if n = 3 then Children := DataModule1.QueryTaxreduceREDUCEVALUE.AsFloat;
  end;
  Expense_money := YearlyIncome*Expense_percent;
  if Expense_money > max_expense then
    Expense_money := max_expense;
  // children_no get from sql_statement count* from employee.children
  with DataModule1.QuerychildNo do
  begin
    close;
    unprepare;
    Params[0].asInteger := ID;
    prepare;
    open;
  end;
  children_no := Datamodule1.QuerychildNoCOUNT.AsInteger;
  children_money := children*children_no;
  netMoney := YearlyIncome-Expense_Money-ToReduceMoney-children_money;
  fin := not true;
  while not fin do
  begin
  if netMoney<=100000.0 then
    netIncomefield := 100000;
  if (netMoney>100000.0) and (netMoney<500000.0) then
    netIncomefield := 500000;
  if (netMoney>500000.0) and (netMoney<1000000.0) then
    netIncomefield := 1000000;
  if (netMoney>1000000.0) and (netMoney<4000000.0) then
    netIncomefield := 4000000;
  if (netMoney>4000000.0) then
    netIncomefield := 4000001;
  with DataModule1.TaxQuery do
  begin
    close;
    unprepare;
    params[0].asfloat := netIncomefield;
    prepare;
    open;
  end;
  max_level := DataModule1.TaxQueryMAXNETINCOME.Value;
  if netMoney >= max_level then
  begin
    if netMoney = DataModule1.TaxQueryNETINCOME.Value then
      begin
      Tax := Tax+DataModule1.TaxQueryMAXTAX.Value;
      netMoney := 0;
      end
    else
      begin
      Tax := Tax+DataModule1.TaxQueryTAXFROMMAX.Value;
      netMoney := netMoney-max_level;
      end;
  end
  else
    begin
    TaxRate := DataModule1.TaxQueryRATE.AsInteger;
    Tax := Tax+((netMoney*taxRate)/100);
    netMoney := 0;
    end;
  if netMoney = 0 then fin:= true;
  end;
  Result := Tax;
end;

function TEmployee.SocialSecurityMoney(salary:real):real;
var
  Worker_Salary : real;
  CompanyPay : real;
  EmployeePay : real;
  SSMoney : real;
  SSEmpPay : real;
  SSCompPay : real;
  n : integer;
begin
  Worker_Salary := salary;
  n := 0;
  for n := 0 to 1 do
  begin
    with DataModule1.QuerySS do
    begin
      close;
      unprepare;
      if n = 0 then Params[0].asstring := 'EMPLOYEE'
      else Params[0].asstring := 'COMPANY';
      prepare;
      open;
    end;
    if n = 0 then EmployeePay := DataModule1.QuerySSRATE.AsFloat
    else CompanyPay := DataModule1.QuerySSRATE.AsFloat;
  end;
  SSEmpPay := (Worker_salary*EmployeePay)/100;
  SSCompPay := (Worker_salary*CompanyPay)/100;
  SSMoney := SSEmpPay+SSCompPay;
  Employee.ssmoney := SSMoney;
  result := SSEmpPay;
end;

procedure TOfficer.SalaryPayment;
var
  MonthlySalary : real;
  OTMoney : real;
  PayTax : real;
  MoneyPay : real;
  tmp : integer;
  salary : real;
  ssmoney : real;
begin
  inherited;
{  MonthlySalary := payment;
  OTMoney := OTPayment;
  salary := MonthlySalary+OTMoney;
  ssmoney := SocialSecurityMoney(Salary);
  PayTax := (TaxCalculation(salary))/12;
  MoneyPay := salary - PayTax;}
//  showmessage(FloatToStr(monthlysalary)+','+FloatToStr(OTMoney)+','+FloatToStr(ssmoney)+','+FloatTostr(paytax)+','+FloatToStr(moneyPay));
end;

function TOfficer.OTPayment:real;
var
  Multiplier : integer;
  HourPay : real;
  OTMoney : real;
begin
  DataModule1.QueryOTrate.open;
  Multiplier := DataModule1.QueryOTrateRATE.AsInteger;
  HourPay := payment/(30*8);
  OTMoney := HourPay*Multiplier*OTHours;
  result := OTMoney;
end;

procedure TDaylyWorker.SalaryPayment;
var
  MonthlySalary : real;
  OTMoney : real;
  PayTax : real;
  MoneyPay : real;
  Days : integer;
  tmp : integer;
  salary : real;  // OTMoney + montylySalary
  ssmoney : real;
  monthrange : string;
begin
  monthrange := ServerDate.month+','+ServerDate.year;
  with DataModule1.QueryCountdaywork do
  begin
    close;
    unprepare;
    params[0].AsString := monthrange;
    params[1].AsInteger := ID;
    prepare;
    open;
  end;
  days := DataModule1.QueryCountdayworkCOUNT.AsInteger;
  payment := payment*Days;
  inherited;
end;

function TDaylyWorker.OTPayment:real;
var
  Multiplier : integer;
  HourPay : real;
  OTMoney : real;
begin
  DataModule1.QueryOTrate.open;
  Multiplier := DataModule1.QueryOTrateRATE.AsInteger;
  HourPay := payment/8;
  OTMoney := HourPay*OTHours*Multiplier;
  result := OTMoney;
end;


initialization


end.
