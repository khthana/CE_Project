unit welcome;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ComCtrls, StdCtrls,human,Timer,checkwork,hrdatamodule;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation


{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  empid : integer;
begin
  ServerDate := TDateTimeObject.create;
  ServerDate.FilterDateMonth;
  while not DataModule1.TableEmployeeinfo.Eof do
  begin
    empid := DataModule1.TableEmployeeinfoEMPLOYEEID.AsInteger;
    EmpWorking := Working.create(empid);
    DataModule1.TableEmployeeinfo.Next;
  end;
  if ServerDate.endmonth then
  begin
    DataModule1.TableEmployeeinfo.Open;
    while not DataModule1.TableEmployeeinfo.Eof do
    begin
      empid := DataModule1.TableEmployeeinfoEMPLOYEEID.AsInteger;
      Employee := TEmployee.create(empid);
      if Employee.worker_type = 'Officer' then
      begin
        Officer := TOfficer.create(empid);
        Employee := Officer;
      end;
      if Employee.worker_type = 'dayly' then
      begin
        DaylyWorker := TDaylyWorker.create(empid);
        Employee := DaylyWorker;
      end;
      Employee.SalaryPayment;
      DataModule1.TableEmployeeinfo.Next;
    end;
  end;
  //showmessage('จัดการรายงานเงินเดือนเรียบร้อยแล้ว');
end;


end.
