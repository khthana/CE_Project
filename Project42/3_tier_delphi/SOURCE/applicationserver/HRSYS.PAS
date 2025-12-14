unit hrsys;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComServ, ComObj, VCLCom, StdVcl, BdeProv, DataBkr, DBClient, hrproject_TLB,
  Provider, Db, DBTables;

type
  Thrserver = class(TRemoteDataModule, Ihrserver)
    tblEmployee: TTable;
    tblEmployeeEMPLOYEEID: TFloatField;
    tblEmployeeNAME: TStringField;
    tblEmployeeSURNAME: TStringField;
    tblEmployeeDEPARTMENTID: TFloatField;
    tblEmployeePOSITION: TStringField;
    tblEmployeeCONTROLBY: TStringField;
    tblEmployeeWORKER_TYPE: TStringField;
    tblEmployeeDAY_STARTWORK: TDateTimeField;
    tblEmployeeADDRESS_NO: TStringField;
    tblEmployeeADD_ROAD: TStringField;
    tblEmployeeDISTRICT: TStringField;
    tblEmployeeAMPHUR: TStringField;
    tblEmployeePROVINCE: TStringField;
    tblEmployeeZIPCODE: TStringField;
    tblEmployeePHONE_NO: TStringField;
    tblEmployeeBIRTH_DATE: TDateTimeField;
    tblEmployeeMARRITAL_STATUS: TStringField;
    tblEmployeeSALARY: TFloatField;
    tblEmployeeNATIONALITY: TStringField;
    tblEmployeeORIGIN: TStringField;
    tblEmployeeRELIGION: TStringField;
    tblEmployeeID_CARD_NO: TStringField;
    tblEmployeeSOCIAL_CARD_NO: TStringField;
    tblEmployeeDATE_BEGIN_SS: TDateTimeField;
    tblEmployeePREVIOUS_TOTAL_SSMONEY: TFloatField;
    tblEmployeeGENDER: TStringField;
    tblEmployeeBLOODTYPE: TStringField;
    tblEmployeeDISEASE: TStringField;
    tblEmployeeBANKACCOUNT: TStringField;
    tblEmployeeEMP_FAMILY: TDataSetField;
    tblEmployeeEMP_WORKING: TDataSetField;
    tblEmployeeEMP_ABSENT: TDataSetField;
    tblEmployeeEMP_EARNING: TDataSetField;
    ptblEmployee: TDataSetProvider;
    tblEducation: TTable;
    tblEducationSEQNO: TFloatField;
    tblEducationEMPLOYEEID: TFloatField;
    tblEducationSCHOOL_UNIVERSITY: TStringField;
    tblEducationYEAR_BEGIN: TDateTimeField;
    tblEducationYEAR_SUCCESS: TDateTimeField;
    tblEducationDEGREE: TStringField;
    tblEducationMAJOR: TStringField;
    tblEducationGRADE: TFloatField;
    tblTraining: TTable;
    tblTrainingSEQNO: TFloatField;
    tblTrainingEMPLOYEEID: TFloatField;
    tblTrainingSUBJECT: TStringField;
    tblTrainingINSTITUTE: TStringField;
    tblTrainingSTART_TRAINING: TDateTimeField;
    tblTrainingSUCCESS_TRAINING: TDateTimeField;
    tblAbsent: TTable;
    tblAbsentSEQNO: TFloatField;
    tblAbsentEMPLOYEEID: TFloatField;
    tblAbsentABSENTDATE: TDateTimeField;
    tblDayoff: TTable;
    tblDayoffSEQNO: TFloatField;
    tblDayoffEMPLOYEEID: TFloatField;
    tblDayoffDAYOFFDATE: TDateTimeField;
    tblLate: TTable;
    tblLateSEQNO: TFloatField;
    tblLateEMPLOYEEID: TFloatField;
    tblLateLATEDATE: TDateTimeField;
    tblDepartment: TTable;
    tblDepartmentDEPARTMENTID: TFloatField;
    tblDepartmentDEPARTMENTNAME: TStringField;
    tblDepartmentTOTALWORKER: TFloatField;
    tblDepartmentLOCATION: TStringField;
    tblOTWorktime: TTable;
    tblOTWorktimeEMPLOYEEID: TFloatField;
    tblOTWorktimeDAYWORK_OT: TDateTimeField;
    tblOTWorktimeHOURS: TFloatField;
    tblOTWorktimeHOURS_TYPE: TStringField;
    tblTimeenter: TTable;
    ptblEducation: TDataSetProvider;
    ptblTraining: TDataSetProvider;
    ptblAbsent: TDataSetProvider;
    ptblDayoff: TDataSetProvider;
    ptblLate: TDataSetProvider;
    ptblDepartment: TDataSetProvider;
    ptblOTWorktime: TDataSetProvider;
    ptblTimeenter: TDataSetProvider;
    qrEducation: TQuery;
    qrEducationSCHOOL_UNIVERSITY: TStringField;
    qrEducationYEAR_BEGIN: TDateTimeField;
    qrEducationYEAR_SUCCESS: TDateTimeField;
    qrEducationDEGREE: TStringField;
    qrEducationMAJOR: TStringField;
    qrEducationGRADE: TFloatField;
    qrTraining: TQuery;
    qrTrainingSUBJECT: TStringField;
    qrTrainingINSTITUTE: TStringField;
    qrTrainingSTART_TRAINING: TDateTimeField;
    qrTrainingSUCCESS_TRAINING: TDateTimeField;
    qrNamePersonal: TQuery;
    qrDeptEmp: TQuery;
    qrIdEmp: TQuery;
    qrIdEmpCOUNT: TFloatField;
    qrDeptName: TQuery;
    qrDeptNameDEPARTMENTNAME: TStringField;
    qrDeptId: TQuery;
    qrDeptIdDEPARTMENTID: TFloatField;
    qrseqTrain: TQuery;
    qrseqTrainCOUNT: TFloatField;
    qrSeqEdu: TQuery;
    qrSeqEduCOUNT: TFloatField;
    qrcntDept: TQuery;
    qrcntDeptCOUNT: TFloatField;
    pqrEducation: TDataSetProvider;
    pqrTraining: TDataSetProvider;
    pqrNamePersonal: TDataSetProvider;
    pqrDeptEmp: TDataSetProvider;
    qrDeptEmpEMPLOYEEID: TFloatField;
    qrDeptEmpNAME: TStringField;
    qrDeptEmpSURNAME: TStringField;
    qrDeptEmpPOSITION: TStringField;
    qrDeptEmpSALARY: TFloatField;
    qrNamePersonalADDRESS_NO: TStringField;
    qrNamePersonalADD_ROAD: TStringField;
    qrNamePersonalDISTRICT: TStringField;
    qrNamePersonalAMPHUR: TStringField;
    qrNamePersonalPROVINCE: TStringField;
    qrNamePersonalZIPCODE: TStringField;
    qrNamePersonalPHONE_NO: TStringField;
    qrNamePersonalBIRTH_DATE: TDateTimeField;
    qrNamePersonalRELIGION: TStringField;
    qrNamePersonalNATIONALITY: TStringField;
    qrNamePersonalORIGIN: TStringField;
    qrNamePersonalMARRITAL_STATUS: TStringField;
    qrNamePersonalID_CARD_NO: TStringField;
    qrNamePersonalBLOODTYPE: TStringField;
    qrNamePersonalDISEASE: TStringField;
    qrNamePersonalBANKACCOUNT: TStringField;
    qrempsurname: TQuery;
    qrempsurnameSURNAME: TStringField;
    tblTimeenterENTER_NO: TFloatField;
    tblTimeenterEMPLOYEEID: TFloatField;
    tblTimeenterDAY_WORK: TDateTimeField;
    tblTimeenterTIME_IN: TStringField;
    tblTimeenterTIME_OUT: TStringField;
    tblTimeenterWORK_TYPE: TStringField;
    qrinsertEmptbl: TQuery;
    Query1: TQuery;
    qrempid: TQuery;
    qrempidEMPLOYEEID: TFloatField;
    Query1NAME: TStringField;
    Query1BIRTHDATE: TDateTimeField;
    Query1GENDER: TStringField;
    Query1CAREER: TStringField;
    Query1WORK_PLACE: TStringField;
    Query1RELATIONSHIP: TStringField;
    qremp_worked: TQuery;
    qremp_workedCOMPANY: TStringField;
    qremp_workedYEAR_BEGIN: TDateTimeField;
    qremp_workedYEAR_QUIT: TDateTimeField;
    qremp_workedFIRST_POSITION: TStringField;
    qremp_workedLAST_POSITION: TStringField;
    qremp_workedSTARTSALARY: TFloatField;
    qremp_workedLASTSALARY: TFloatField;
    qremp_workedCAUSEQUIT: TStringField;
    qremp_earning: TQuery;
    qremp_earningPAY_MONTH: TDateTimeField;
    qremp_earningOT_MONEY: TFloatField;
    qremp_earningDEDUCT_MONEY: TFloatField;
    qremp_earningTAX_PAY: TFloatField;
    qremp_earningSS_MONEY_PAY: TFloatField;
    qremp_earningMONEY_PAY: TFloatField;
    qremp_earningTOTAL_TAX: TFloatField;
    qremp_earningTOTAL_SS_MONEY: TFloatField;
    ProviderInsertemp: TProvider;
    function ProviderInsertempDataRequest(Sender: TObject;
      Input: OleVariant): OleVariant;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function Get_ptblEmployee: IProvider; safecall;
    function Get_ptblEducation: IProvider; safecall;
    function Get_ptblTraining: IProvider; safecall;
    function Get_ptblAbsent: IProvider; safecall;
    function Get_ptblDayoff: IProvider; safecall;
    function Get_ptblLate: IProvider; safecall;
    function Get_ptblDepartment: IProvider; safecall;
    function Get_ptblOTWorktime: IProvider; safecall;
    function Get_ptblTimeenter: IProvider; safecall;
    function Get_pqrEducation: IProvider; safecall;
    function Get_pqrTraining: IProvider; safecall;
    function Get_pqrNamePersonal: IProvider; safecall;
    function Get_pqrDeptEmp: IProvider; safecall;
    function Get_qrDeptName: IProvider; safecall;
    function Get_qrDeptId: IProvider; safecall;
    function Get_qrseqTrain: IProvider; safecall;
    function Get_qrSeqEdu: IProvider; safecall;
    function Get_qrcntDept: IProvider; safecall;
    function Get_qrIdEmp: IProvider; safecall;
    function Get_qrempsurname: IProvider; safecall;
    function Get_Query1: IProvider; safecall;
    function Get_qrNamePersonal: IProvider; safecall;
    function Get_qrDeptEmp: IProvider; safecall;
    function Get_qrTraining: IProvider; safecall;
    function Get_qrEducation: IProvider; safecall;
    function Get_qrinsertEmptbl: IProvider; safecall;
    function Get_qrempid: IProvider; safecall;
    function Get_qremp_worked: IProvider; safecall;
    function Get_qremp_earning: IProvider; safecall;
    function Get_ProviderInsertemp: IProvider; safecall;
  end;

var
  hrserver: Thrserver;

implementation

{$R *.DFM}

function Thrserver.Get_ptblEmployee: IProvider;
begin
  Result := ptblEmployee.Provider;
end;

function Thrserver.Get_ptblEducation: IProvider;
begin
  Result := ptblEducation.Provider;
end;

function Thrserver.Get_ptblTraining: IProvider;
begin
  Result := ptblTraining.Provider;
end;

function Thrserver.Get_ptblAbsent: IProvider;
begin
  Result := ptblAbsent.Provider;
end;

function Thrserver.Get_ptblDayoff: IProvider;
begin
  Result := ptblDayoff.Provider;
end;

function Thrserver.Get_ptblLate: IProvider;
begin
  Result := ptblLate.Provider;
end;

function Thrserver.Get_ptblDepartment: IProvider;
begin
  Result := ptblDepartment.Provider;
end;

function Thrserver.Get_ptblOTWorktime: IProvider;
begin
  Result := ptblOTWorktime.Provider;
end;

function Thrserver.Get_ptblTimeenter: IProvider;
begin
  Result := ptblTimeenter.Provider;
end;

function Thrserver.Get_pqrEducation: IProvider;
begin
  Result := pqrEducation.Provider;
end;

function Thrserver.Get_pqrTraining: IProvider;
begin
  Result := pqrTraining.Provider;
end;

function Thrserver.Get_pqrNamePersonal: IProvider;
begin
  Result := pqrNamePersonal.Provider;
end;

function Thrserver.Get_pqrDeptEmp: IProvider;
begin
  Result := pqrDeptEmp.Provider;
end;

function Thrserver.Get_qrDeptName: IProvider;
begin
  Result := qrDeptName.Provider;
end;

function Thrserver.Get_qrDeptId: IProvider;
begin
  Result := qrDeptId.Provider;
end;

function Thrserver.Get_qrseqTrain: IProvider;
begin
  Result := qrseqTrain.Provider;
end;

function Thrserver.Get_qrSeqEdu: IProvider;
begin
  Result := qrSeqEdu.Provider;
end;

function Thrserver.Get_qrcntDept: IProvider;
begin
  Result := qrcntDept.Provider;
end;

function Thrserver.Get_qrIdEmp: IProvider;
begin
  Result := qrIdEmp.Provider;
end;

function Thrserver.Get_qrempsurname: IProvider;
begin
  Result := qrempsurname.Provider;
end;

function Thrserver.Get_Query1: IProvider;
begin
  Result := Query1.Provider;
end;

function Thrserver.Get_qrNamePersonal: IProvider;
begin
  Result := qrNamePersonal.Provider;
end;

function Thrserver.Get_qrDeptEmp: IProvider;
begin
  Result := qrDeptEmp.Provider;
end;

function Thrserver.Get_qrTraining: IProvider;
begin
  Result := qrTraining.Provider;
end;

function Thrserver.Get_qrEducation: IProvider;
begin
  Result := qrEducation.Provider;
end;

function Thrserver.Get_qrinsertEmptbl: IProvider;
begin
  Result := qrinsertEmptbl.Provider;
end;

function Thrserver.Get_qrempid: IProvider;
begin
  Result := qrempid.Provider;
end;

function Thrserver.Get_qremp_worked: IProvider;
begin
  Result := qremp_worked.Provider;
end;

function Thrserver.Get_qremp_earning: IProvider;
begin
  Result := qremp_earning.Provider;
end;

function Thrserver.ProviderInsertempDataRequest(Sender: TObject;
  Input: OleVariant): OleVariant;
begin
  qrInsertEmptbl.ExecSQL;
end;

function Thrserver.Get_ProviderInsertemp: IProvider;
begin
  Result := ProviderInsertemp.Provider;
end;

initialization
  TComponentFactory.Create(ComServer, Thrserver,
    Class_hrserver, ciMultiInstance, tmApartment);
end.
