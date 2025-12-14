unit hrdatamodule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDataModule1 = class(TDataModule)
    QueryOTrate: TQuery;
    TaxQuery: TQuery;
    QueryTaxreduce: TQuery;
    QuerySS: TQuery;
    QueryOTrateRATE: TFloatField;
    TaxQueryNETINCOME: TFloatField;
    TaxQueryMAXNETINCOME: TFloatField;
    TaxQueryRATE: TFloatField;
    TaxQueryTAXFROMMAX: TFloatField;
    TaxQueryMAXTAX: TFloatField;
    QueryTaxreduceREDUCEVALUE: TFloatField;
    QuerySSRATE: TFloatField;
    QueryEmpinfo: TQuery;
    QueryEmpinfoSALARY: TFloatField;
    QueryOtHours: TQuery;
    QueryOtHoursEMPLOYEEID: TFloatField;
    QueryOtHoursDAYWORK_OT: TDateTimeField;
    QueryOtHoursHOURS: TFloatField;
    QueryWorkTime: TQuery;
    QueryWorkTimeTIME_IN: TStringField;
    QueryWorkTimeTIME_OUT: TStringField;
    QueryEarning: TQuery;
    TableEmployeeinfo: TTable;
    TableEmployeeinfoEMPLOYEEID: TFloatField;
    QuerychildNo: TQuery;
    QuerychildNoCOUNT: TFloatField;
    QueryComework: TQuery;
    QueryComeworkWORK_TYPE: TStringField;
    QueryEmpinfoWORKER_TYPE: TStringField;
    QueryWorkTimeWORK_TYPE: TStringField;
    QueryEmpWork: TQuery;
    QueryEmpWorkTIME_IN: TStringField;
    QueryEmpWorkTIME_OUT: TStringField;
    QueryEmpWorkWORK_TYPE: TStringField;
    QueryInsertOT: TQuery;
    QueryAbsentRec: TQuery;
    QueryAbsentRecCOUNT: TFloatField;
    QueryEmpinfoMARRITAL_STATUS: TStringField;
    Querytotal: TQuery;
    QuerytotalTOTAL_TAX: TFloatField;
    QuerytotalTOTAL_SS_MONEY: TFloatField;
    QueryInsertEarning: TQuery;
    QueryCountdaywork: TQuery;
    QueryCountdayworkCOUNT: TFloatField;
    QueryEmpinfoPREVIOUS_TOTAL_SSMONEY: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.DFM}

end.
