unit empInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBClient, MConnect, StdCtrls;

type
  TForm7 = class(TForm)
    emp_DCOMConnection: TDCOMConnection;
    emp_ClientDataSet: TClientDataSet;
    emp_DataSource: TDataSource;
    emp_DBGrid: TDBGrid;
    Label1: TLabel;
    educated_Button: TButton;
    worked_Button: TButton;
    trained_Button: TButton;
    children_Button: TButton;
    absent_Button: TButton;
    DBGrid1: TDBGrid;
    worked_ClientDataSet: TClientDataSet;
    trained_ClientDataSet: TClientDataSet;
    absent_ClientDataSet: TClientDataSet;
    children_ClientDataSet: TClientDataSet;
    DataSource1: TDataSource;
    emp_ClientDataSetEMPLOYEEID: TFloatField;
    emp_ClientDataSetNAME: TStringField;
    emp_ClientDataSetSURNAME: TStringField;
    emp_ClientDataSetDEPARTMENTID: TFloatField;
    emp_ClientDataSetPOSITION: TStringField;
    emp_ClientDataSetCONTROLBY: TStringField;
    emp_ClientDataSetWORKER_TYPE: TStringField;
    emp_ClientDataSetBIRTH_DATE: TDateTimeField;
    emp_ClientDataSetMARRITAL_STATUS: TStringField;
    emp_ClientDataSetSALARY: TFloatField;
    emp_ClientDataSetNATIONALITY: TStringField;
    emp_ClientDataSetORIGIN: TStringField;
    emp_ClientDataSetRELIGION: TStringField;
    emp_ClientDataSetID_CARD_NO: TStringField;
    emp_ClientDataSetGENDER: TStringField;
    emp_ClientDataSetEMP_FAMILY: TDataSetField;
    emp_ClientDataSetEMP_WORKING: TDataSetField;
    emp_ClientDataSetEMP_ABSENT: TDataSetField;
    emp_ClientDataSetEMP_EARNING: TDataSetField;
    education_ClientDataset: TClientDataSet;
    education_ClientDatasetSCHOOL_UNIVERSITY: TStringField;
    education_ClientDatasetYEAR_BEGIN: TDateTimeField;
    education_ClientDatasetYEAR_SUCCESS: TDateTimeField;
    education_ClientDatasetDEGREE: TStringField;
    education_ClientDatasetMAJOR: TStringField;
    education_ClientDatasetGRADE: TFloatField;
    trained_ClientDataSetSUBJECT: TStringField;
    trained_ClientDataSetINSTITUTE: TStringField;
    trained_ClientDataSetSTART_TRAINING: TDateTimeField;
    trained_ClientDataSetSUCCESS_TRAINING: TDateTimeField;
    Label2: TLabel;
    Label3: TLabel;
    worked_ClientDataSetCOMPANY: TStringField;
    worked_ClientDataSetYEAR_BEGIN: TDateTimeField;
    worked_ClientDataSetYEAR_QUIT: TDateTimeField;
    worked_ClientDataSetFIRST_POSITION: TStringField;
    worked_ClientDataSetLAST_POSITION: TStringField;
    worked_ClientDataSetSTARTSALARY: TFloatField;
    worked_ClientDataSetLASTSALARY: TFloatField;
    worked_ClientDataSetCAUSEQUIT: TStringField;
    children_ClientDataSetNAME: TStringField;
    children_ClientDataSetBIRTHDATE: TDateTimeField;
    children_ClientDataSetGENDER: TStringField;
    children_ClientDataSetCAREER: TStringField;
    children_ClientDataSetWORK_PLACE: TStringField;
    children_ClientDataSetRELATIONSHIP: TStringField;
    procedure educated_ButtonClick(Sender: TObject);
    procedure worked_ButtonClick(Sender: TObject);
    procedure trained_ButtonClick(Sender: TObject);
    procedure absent_ButtonClick(Sender: TObject);
    procedure children_ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.DFM}

procedure TForm7.educated_ButtonClick(Sender: TObject);
var
  employeeid : integer;
begin
  Label3.Caption := 'ตารางแสดงประวัติการศึกษา';
  Label3.Visible := true;
  employeeid :=  emp_ClientDatasetEMPLOYEEID.AsInteger;
  education_ClientDataset.Close;
  education_ClientDataset.Params[0].asFloat := employeeid;
  education_ClientDataset.Open;
  education_ClientDataset.SendParams;
  DataSource1.DataSet := education_ClientDataSet;
  education_ClientDataset.Open;
end;

procedure TForm7.worked_ButtonClick(Sender: TObject);
var
  employeeid : integer;
begin
  employeeid := emp_ClientDatasetEMPLOYEEID.AsInteger;
  Label3.Caption := 'ประวัติการทำงาน';
  Label3.Visible := true;
  Worked_ClientDataset.Close;
  worked_clientdataset.Params[0].asInteger := employeeid;
  worked_ClientDataset.Open;
  worked_ClientDataset.SendParams;
  DataSource1.DataSet := worked_ClientDataset;
end;

procedure TForm7.trained_ButtonClick(Sender: TObject);
var
  employeeid : integer;
begin
  Label3.Caption := 'ประวัติการฝึกอบรม';
  Label3.Visible := true;
  employeeid := emp_ClientDatasetEMPLOYEEID.AsInteger;
  trained_ClientDataset.Close;
  trained_ClientDataset.Params[0].asFloat := employeeid;
  trained_ClientDataset.Open;
  trained_ClientDataset.SendParams;
  DataSource1.DataSet := trained_ClientDataset;
  trained_ClientDataset.Open;
end;

procedure TForm7.absent_ButtonClick(Sender: TObject);
begin
  Label3.Caption := 'สถิติการขาด ลา มาสาย';
  Label3.Visible := true;
  DataSource1.DataSet := absent_ClientDataset;
  absent_ClientDataset.Open;
end;

procedure TForm7.children_ButtonClick(Sender: TObject);
var
  employeeid : integer;
begin
  employeeid := emp_ClientDatasetEMPLOYEEID.AsInteger;
  Label3.Caption := 'แสดงรายชื่อบุตรและครอบครัว';
  Label3.Visible := true;
  children_ClientDataset.Close;
  children_ClientDataset.Params[0].asInteger := employeeid;
  children_ClientDataset.Open;
  children_ClientDataset.SendParams;
  DataSource1.DataSet := children_ClientDataset;
end;


end.
