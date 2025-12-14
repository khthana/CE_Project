unit emp_dataEntry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, MConnect, StdCtrls, DBCtrls, Mask, ComCtrls, Grids, DBGrids,
  ExtCtrls;

type
  TForm2 = class(TForm)
    emp_DCOMConnection: TDCOMConnection;
    emp_DataSource: TDataSource;
    PageControl1: TPageControl;
    info_TabSheet: TTabSheet;
    add_no_DBEdit: TDBEdit;
    addRoad_DBEdit: TDBEdit;
    amphur_DBEdit: TDBEdit;
    province_DBEdit: TDBEdit;
    zipcode_DBEdit: TDBEdit;
    telno_DBEdit: TDBEdit;
    birthdate_DBEdit: TDBEdit;
    nationality_DBEdit: TDBEdit;
    religion_DBEdit: TDBEdit;
    idcard_DBEdit: TDBEdit;
    sscard_DBEdit: TDBEdit;
    beginss_DBEdit: TDBEdit;
    previoustotalss_DBEdit: TDBEdit;
    disease_DBEdit: TDBEdit;
    district_DBEdit: TDBEdit;
    origin_DBEdit: TDBEdit;
    gender_DBComboBox: TDBComboBox;
    bloodtype_DBComboBox: TDBComboBox;
    marrital_DBComboBox: TDBComboBox;
    empid_DBEdit: TDBEdit;
    empname_DBEdit: TDBEdit;
    position_DBEdit: TDBEdit;
    cntrlby_DBEdit: TDBEdit;
    daystartwork_DBEdit: TDBEdit;
    salary_DBEdit: TDBEdit;
    department_DBComboBox: TDBComboBox;
    workertype_DBComboBox: TDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    worked_TabSheet: TTabSheet;
    worked_DataSource: TDataSource;
    worked_ClientDataSet: TClientDataSet;
    trained_TabSheet: TTabSheet;
    educated_TabSheet: TTabSheet;
    children_TabSheet: TTabSheet;
    family_DataSource: TDataSource;
    worked_DBNavigator: TDBNavigator;
    children_DBNavigator: TDBNavigator;
    Label28: TLabel;
    emp_DBNavigator: TDBNavigator;
    EditEmp_Button: TButton;
    insertEmp_Button: TButton;
    empinsert_ClientDataSet: TClientDataSet;
    family_clientdataset: TClientDataSet;
    seqedu_ClientDataset: TClientDataSet;
    seqtrained_ClientDataSet: TClientDataSet;
    surname_DBEdit: TDBEdit;
    countid_ClientDataSet: TClientDataSet;
    seqtrained_ClientDataSetCOUNT: TFloatField;
    seqedu_ClientDatasetCOUNT: TFloatField;
    countid_ClientDataSetCOUNT: TFloatField;
    insert_workButton: TButton;
    edit_workButton: TButton;
    insert_familyButton: TButton;
    edit_familyButton: TButton;
    Label54: TLabel;
    qrDeptName_ClientDataSet: TClientDataSet;
    qrDeptName_ClientDataSetDEPARTMENTNAME: TStringField;
    department_ClientDataSet: TClientDataSet;
    department_ClientDataSetDEPARTMENTID: TFloatField;
    DBText1: TDBText;
    DataSource1: TDataSource;
    tblEducated_ClientDataSet: TClientDataSet;
    tblTrained_ClientDataSet: TClientDataSet;
    tblEducated_ClientDataSetSEQNO: TFloatField;
    tblEducated_ClientDataSetEMPLOYEEID: TFloatField;
    tblEducated_ClientDataSetSCHOOL_UNIVERSITY: TStringField;
    tblEducated_ClientDataSetYEAR_BEGIN: TDateTimeField;
    tblEducated_ClientDataSetYEAR_SUCCESS: TDateTimeField;
    tblEducated_ClientDataSetDEGREE: TStringField;
    tblEducated_ClientDataSetMAJOR: TStringField;
    tblEducated_ClientDataSetGRADE: TFloatField;
    tblTrained_ClientDataSetSEQNO: TFloatField;
    tblTrained_ClientDataSetEMPLOYEEID: TFloatField;
    tblTrained_ClientDataSetSUBJECT: TStringField;
    tblTrained_ClientDataSetINSTITUTE: TStringField;
    tblTrained_ClientDataSetSTART_TRAINING: TDateTimeField;
    tblTrained_ClientDataSetSUCCESS_TRAINING: TDateTimeField;
    tblEducated_Datasource: TDataSource;
    GroupBox1: TGroupBox;
    institute_DBEdit: TDBEdit;
    subject_DBEdit: TDBEdit;
    strtTrained_DBEdit: TDBEdit;
    succTrained_DBEdit: TDBEdit;
    Label51: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label37: TLabel;
    DBText2: TDBText;
    DBText3: TDBText;
    GroupBox2: TGroupBox;
    school_DBEdit: TDBEdit;
    major_DBEdit: TDBEdit;
    yrenter_DBEdit: TDBEdit;
    yrSuccess_DBEdit: TDBEdit;
    degree_DBEdit: TDBEdit;
    grade_DBEdit: TDBEdit;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    DBEdit1: TDBEdit;
    Label44: TLabel;
    Label45: TLabel;
    DBEdit2: TDBEdit;
    GroupBox3: TGroupBox;
    company_DBEdit: TDBEdit;
    yrBegin_DBEdit: TDBEdit;
    yrQuit_DBEdit: TDBEdit;
    fsPosition_DBEdit: TDBEdit;
    lstPosition_DBEdit: TDBEdit;
    strtSalary_DBEdit: TDBEdit;
    lstSalary_DBEdit: TDBEdit;
    csQuit_DBEdit: TDBEdit;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label46: TLabel;
    Label61: TLabel;
    deletework_Button: TButton;
    editTrained_Button: TButton;
    insertTrained_Button: TButton;
    deleteTrained_Button: TButton;
    Trained_DBNavigator: TDBNavigator;
    tblTrained_DataSource: TDataSource;
    editEducated_Button: TButton;
    insertEducated_Button: TButton;
    deleteEducated_Button: TButton;
    Educated_DBNavigator: TDBNavigator;
    GroupBox4: TGroupBox;
    deletefame_Button: TButton;
    famName_DBEdit: TDBEdit;
    famBrtDate_DBEdit: TDBEdit;
    famWorkPlace_DBEdit: TDBEdit;
    famcareer_DBEdit: TDBEdit;
    Label41: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label52: TLabel;
    famGender_DBComboBox: TDBComboBox;
    famrelated_DBComboBox: TDBComboBox;
    bnkaccount_DBEdit: TDBEdit;
    Label53: TLabel;
    DBEdit3: TDBEdit;
    Label62: TLabel;
    Label63: TLabel;
    DBEdit4: TDBEdit;
    emp_ClientDataSet: TClientDataSet;
    emp_ClientDataSetEMPLOYEEID: TFloatField;
    emp_ClientDataSetNAME: TStringField;
    emp_ClientDataSetSURNAME: TStringField;
    emp_ClientDataSetDEPARTMENTID: TFloatField;
    emp_ClientDataSetPOSITION: TStringField;
    emp_ClientDataSetCONTROLBY: TStringField;
    emp_ClientDataSetWORKER_TYPE: TStringField;
    emp_ClientDataSetDAY_STARTWORK: TDateTimeField;
    emp_ClientDataSetADDRESS_NO: TStringField;
    emp_ClientDataSetADD_ROAD: TStringField;
    emp_ClientDataSetDISTRICT: TStringField;
    emp_ClientDataSetAMPHUR: TStringField;
    emp_ClientDataSetPROVINCE: TStringField;
    emp_ClientDataSetZIPCODE: TStringField;
    emp_ClientDataSetPHONE_NO: TStringField;
    emp_ClientDataSetBIRTH_DATE: TDateTimeField;
    emp_ClientDataSetMARRITAL_STATUS: TStringField;
    emp_ClientDataSetSALARY: TFloatField;
    emp_ClientDataSetNATIONALITY: TStringField;
    emp_ClientDataSetORIGIN: TStringField;
    emp_ClientDataSetRELIGION: TStringField;
    emp_ClientDataSetID_CARD_NO: TStringField;
    emp_ClientDataSetSOCIAL_CARD_NO: TStringField;
    emp_ClientDataSetDATE_BEGIN_SS: TDateTimeField;
    emp_ClientDataSetPREVIOUS_TOTAL_SSMONEY: TFloatField;
    emp_ClientDataSetGENDER: TStringField;
    emp_ClientDataSetBLOODTYPE: TStringField;
    emp_ClientDataSetDISEASE: TStringField;
    emp_ClientDataSetBANKACCOUNT: TStringField;
    emp_ClientDataSetEMP_FAMILY: TDataSetField;
    emp_ClientDataSetEMP_WORKING: TDataSetField;
    emp_ClientDataSetEMP_ABSENT: TDataSetField;
    emp_ClientDataSetEMP_EARNING: TDataSetField;
    postwork_Button: TButton;
    fampostButton: TButton;
    postEducated_Button: TButton;
    postTrain_Button: TButton;
    procedure EditEmp_ButtonClick(Sender: TObject);
    procedure clearEdit;
    procedure setEmp_infoField;
    procedure setEmp_workedField;
    procedure setEmp_trainedField;
    procedure setEmp_educatedField;
    procedure setEmp_familyField;
    procedure postEmp_ButtonClick(Sender: TObject);
    procedure editworked_ButtonClick(Sender: TObject);
    procedure insertworked_ButtonClick(Sender: TObject);
    procedure postworked_ButtonClick(Sender: TObject);
    procedure edittrained_ButtonClick(Sender: TObject);
    procedure insertTrained_ButtonClick(Sender: TObject);
    procedure deleteTrained_ButtonClick(Sender: TObject);
    procedure editEducated_ButtonClick(Sender: TObject);
    procedure insertEducated_ButtonClick(Sender: TObject);
    procedure deleteEducated_ButtonClick(Sender: TObject);
    procedure editChildren_ButtonClick(Sender: TObject);
    procedure insertChildren_ButtonClick(Sender: TObject);
    procedure postChildren_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure insert_familyButtonClick(Sender: TObject);
    procedure edit_familyButtonClick(Sender: TObject);
    procedure insert_workButtonClick(Sender: TObject);
    procedure edit_workButtonClick(Sender: TObject);
    procedure department_DBComboBoxChange(Sender: TObject);
    procedure empinsert_ClientDataSetAfterScroll(DataSet: TDataSet);
    procedure deletework_ButtonClick(Sender: TObject);
    procedure deletefame_ButtonClick(Sender: TObject);
    procedure insertEmp_ButtonClick(Sender: TObject);
    procedure fampostButtonClick(Sender: TObject);
    procedure postwork_ButtonClick(Sender: TObject);
    procedure postEducated_ButtonClick(Sender: TObject);
    procedure postTrain_ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.EditEmp_ButtonClick(Sender: TObject);
begin
  emp_ClientDataset.Edit;
//  Emp_ClientDataset.FieldByName('employeeid').asInteger := StrToInt(empid_DBEdit.text);
  setEmp_infoField;
  emp_ClientDataset.Post;
  emp_ClientDataset.ApplyUpdates(100);
end;

procedure TForm2.postEmp_ButtonClick(Sender: TObject);
begin
  if (emp_clientdataset.State = dsEdit) or (emp_clientdataset.State = dsInsert) then
  begin
  emp_clientdataset.Post;
  emp_clientdataset.ApplyUpdates(10);
  end else
  abort;
end;

procedure TForm2.editworked_ButtonClick(Sender: TObject);
begin
  worked_clientdataset.Open;
  worked_clientdataset.Edit;
  setEmp_workedField;
end;

procedure TForm2.insertworked_ButtonClick(Sender: TObject);
begin
  worked_clientdataset.Open;
  worked_Clientdataset.Last;
  worked_clientdataset.edit;
  setEmp_workedField;
end;

procedure TForm2.postworked_ButtonClick(Sender: TObject);
begin
  if (worked_clientdataset.State = dsEdit) or (worked_clientdataset.State = dsInsert) then
  begin
  worked_clientdataset.Post;
  worked_clientdataset.ApplyUpdates(10);
  end else
  abort;
end;

procedure TForm2.edittrained_ButtonClick(Sender: TObject);
begin
  tbltrained_ClientDataset.Open;
  tbltrained_ClientDataSet.edit;
  setEmp_trainedField;
end;

procedure TForm2.insertTrained_ButtonClick(Sender: TObject);
var
  seqno : integer;
begin
  seqtrained_ClientDAtaset.Open;
  seqno := seqtrained_ClientDAtasetCOUNT.AsInteger;
  tbltrained_ClientDataset.Open;
  tbltrained_Clientdataset.Last;
  tbltrained_ClientDataSet.Insert;
  DBEdit2.Text := intToStr(seqno+1);
  DBEdit3.Text := empid_DBEdit.Text;
  setEmp_trainedField;
end;

procedure TForm2.deleteTrained_ButtonClick(Sender: TObject);
begin
  if MessageDlg('ต้องการลบ Record นี้',mtConfirmation,mbYesNoCancel,0)<>mrYes then
  Abort
  else
  begin
    tblTrained_ClientDataset.Edit;
    tblTrained_ClientDataset.Delete;
    tblTrained_ClientDataset.ApplyUpdates(10);
  end;
end;

procedure TForm2.editEducated_ButtonClick(Sender: TObject);
begin
  tbleducated_ClientDataset.Open;
  tbleducated_ClientDataSet.Edit;
  setEmp_educatedField;
end;

procedure TForm2.insertEducated_ButtonClick(Sender: TObject);
var
  seqno : integer;
begin
  seqedu_ClientDataset.Open;
  seqno := seqedu_ClientDatasetCOUNT.AsInteger;
  tbleducated_ClientDataset.Open;
  tbleducated_ClientDataset.Last;
  tbleducated_ClientDataSet.insert;
  DBEdit1.Text := intToStr(seqno+1);
  DBEdit4.Text := empid_DBEdit.Text;
  setEmp_educatedField;
end;

procedure TForm2.deleteEducated_ButtonClick(Sender: TObject);
begin
  if MessageDlg('ต้องการลบ Record นี้',mtConfirmation,mbYesNoCancel,0)<>mrYes then
  Abort
  else
  begin
    tblEducated_ClientDataset.Edit;
    tbleducated_ClientDataset.Delete;
    tblEducated_ClientDataset.ApplyUpdates(100);
  end;
end;

procedure TForm2.editChildren_ButtonClick(Sender: TObject);
begin
  family_ClientDataset.Open;
  family_ClientDataSet.edit;
  setEmp_familyField;
end;

procedure TForm2.insertChildren_ButtonClick(Sender: TObject);
begin
  family_ClientDataset.Open;
  family_ClientDataset.Last;
  family_ClientDataSet.insert;
  setEmp_familyField;
end;

procedure TForm2.postChildren_ButtonClick(Sender: TObject);
begin
  if (family_clientdataset.State = dsEdit) or (family_clientdataset.State = dsInsert) then
  begin
  family_clientdataset.Post;
  family_clientdataset.ApplyUpdates(10);
  end else
  abort;
end;

procedure TForm2.setEmp_infoField;
begin
  emp_ClientDataset.FieldByName('employeeid').asString := empid_DBEdit.text;
  emp_ClientDataSet.Fieldbyname('name').AsString := empname_DBEdit.Text;
  emp_ClientDataset.Fieldbyname('surname').AsString := surname_DBEdit.Text;
  //  get departmentid from department_DBCombobox
  emp_ClientDataSet.Fieldbyname('departmentid').AsString := department_DBComboBox.Text;
  emp_ClientDataSet.fieldbyname('position').AsString := Position_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('controlby').AsString := CntrlBy_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('worker_type').AsString := workerType_DBComboBox.Text;
//////////?????????????????????????////
  emp_ClientDataSet.Fieldbyname('day_startwork').AsString  := daystartwork_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('address_no').AsString := add_no_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('add_road').AsString := addRoad_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('district').AsString := district_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('amphur').AsString := amphur_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('province').AsString := province_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('zipcode').AsString := zipcode_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('phone_no').AsString := telno_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('birth_date').AsString  := birthdate_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('marrital_status').AsString := marrital_DBComboBox.Text;
  emp_ClientDataSet.Fieldbyname('salary').AsString :=  salary_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('nationality').AsString := nationality_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('origin').AsString := origin_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('religion').AsString := religion_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('id_card_no').AsString := idcard_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('social_card_no').AsString := sscard_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('date_begin_ss').AsString := beginss_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('previous_total_ssmoney').AsString := previoustotalss_DBEdit.Text;
  emp_ClientDataSet.Fieldbyname('gender').AsString := gender_DBComboBox.Text;
  emp_ClientDataSet.Fieldbyname('bloodtype').AsString := bloodtype_DBComboBox.Text;
  emp_ClientDataSet.Fieldbyname('disease').AsString := disease_DBEdit.Text;
  emp_ClientDataset.FieldByName('bankaccount').AsString := bnkaccount_DBEdit.Text;
end;

procedure TForm2.setEmp_workedField;
begin
  worked_ClientDataSet.FieldByName('company').AsString := company_DBEdit.Text;
  worked_ClientDataSet.fieldbyname('YEAR_BEGIN').AsString := yrBegin_DBEdit.text;
  worked_ClientDataSet.fieldbyname('YEAR_QUIT').AsString := yrQuit_DBEdit.text;
  worked_ClientDataSet.fieldbyname('FIRST_POSITION').AsString := fsPosition_DBEdit.text;
  worked_ClientDataSet.fieldbyname('LAST_POSITION').AsString := lstPosition_DBEdit.Text;
  worked_ClientDataSet.fieldbyname('STARTSALARY').AsString := strtSalary_DBEdit.text;
  worked_ClientDataSet.fieldbyname('LASTSALARY').AsString := lstSalary_DBEdit.text;
  worked_ClientDataSet.fieldbyname('CAUSEQUIT').AsString := csQuit_DBEdit.Text;
end;

procedure TForm2.setEmp_trainedField;
begin
  tbltrained_ClientDatasetSEQNO.AsString := DBEdit2.Text;
  tbltrained_ClientDatasetEMPLOYEEID.AsString := DBEdit3.Text;
  tbltrained_ClientDataSetSUBJECT.AsString := subject_DBEdit.Text;
  tbltrained_ClientDataSetINSTITUTE.AsString := institute_DBEdit.Text;
  tbltrained_ClientDataSetSTART_TRAINING.AsString := strtTrained_DBEdit.text;
  tbltrained_ClientDataSetSUCCESS_TRAINING.AsString := succTrained_DBEdit.text;
end;

procedure TForm2.setEmp_educatedField;
begin
  tbleducated_ClientDatasetSEQNO.AsString := DBEdit1.Text;
  tbleducated_ClientDatasetEMPLOYEEID.AsString := DBEdit4.text;
  tbleducated_ClientDataSetSCHOOL_UNIVERSITY.AsString := school_DBEdit.Text;
  tbleducated_ClientDataSetYEAR_BEGIN.AsString := yrenter_DBEdit.text;
  tbleducated_ClientDataSetYEAR_SUCCESS.AsString := yrSuccess_DBEdit.text;
  tbleducated_ClientDataSetDEGREE.AsString := degree_DBEdit.Text;
  tbleducated_ClientDataSetMAJOR.AsString := major_DBEdit.Text;
  tbleducated_ClientDataSetGRADE.AsString := grade_DBEdit.text;
end;

procedure TForm2.setEmp_familyField;
begin
  family_ClientDataset.FieldByName('Name').AsString := famName_DBEdit.Text;
  family_ClientDataset.fieldbyname('BIRTHDATE').AsString := famBrtDate_DBEdit.Text;
  family_clientdataset.fieldbyname('GENDER').AsString := famGender_DBComboBox.Text;
  family_clientdataset.fieldbyname('CAREER').AsString := famcareer_DBEdit.Text;
  family_clientdataset.fieldbyname('WORK_PLACE').AsString := famworkplace_DBEdit.Text;
  family_clientdataset.fieldbyname('RELATIONSHIP').AsString := famrelated_DBComboBox.Text;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  deptid : integer;
begin
  emp_DCOMConnection.Connected := true;
  department_ClientDataset.Open;
  while not department_ClientDataset.Eof do
  begin
    department_DBComboBox.Items.Add(department_ClientDatasetDEPARTMENTID.AsString);
    department_ClientDataset.Next;
  end;
  emp_ClientDataset.Open;
  family_clientdataset.Open;
  worked_clientdataset.Open;
  empid_DBEdit.Text := emp_ClientDatasetEMPLOYEEID.AsString;
  empname_DBEdit.Text := emp_ClientDatasetNAME.AsString;
  qrDeptName_ClientDataset.Close;
  deptid := strToInt(department_DBComboBox.text);
  qrDeptName_ClientDataset.Params[0].asInteger := deptid;
  qrDeptName_ClientDataset.Open;
  qrDeptName_ClientDataset.SendParams;

  tblEducated_ClientDataset.Open;
  tblTrained_ClientDataset.Open;
end;

procedure TForm2.insert_familyButtonClick(Sender: TObject);
begin
  family_ClientDataset.Open;
  family_ClientDataset.Last;
  family_ClientDataset.Insert;
  setEmp_FamilyField;
end;

procedure TForm2.edit_familyButtonClick(Sender: TObject);
begin
  family_ClientDataset.Open;
  family_ClientDataset.Edit;
  setEmp_familyField;
end;

procedure TForm2.insert_workButtonClick(Sender: TObject);
begin
  worked_ClientDataset.Open;
  worked_ClientDataset.Last;
  worked_ClientDataset.Insert;
  setEmp_workedField;
end;

procedure TForm2.edit_workButtonClick(Sender: TObject);
begin
  worked_clientDataset.Open;
  worked_clientDataset.Edit;
  setEmp_workedfield;
end;

procedure TForm2.department_DBComboBoxChange(Sender: TObject);
begin
  qrDeptName_ClientDataset.Close;
  qrDeptName_ClientDataset.Params[0].asInteger := strToInt(Department_DBComboBox.Text);
  qrDeptName_ClientDataset.Open;
  qrDeptName_clientDataset.SendParams;
end;

procedure TForm2.empinsert_ClientDataSetAfterScroll(DataSet: TDataSet);
begin
  qrDeptName_ClientDataset.Close;
  qrDeptName_ClientDataset.Params[0].asInteger := strToInt(Department_DBComboBox.Text);
  qrDeptName_ClientDataset.Open;
  qrDeptName_clientDataset.SendParams;

end;


procedure TForm2.deletework_ButtonClick(Sender: TObject);
begin
  if MessageDlg('ต้องการลบ Record นี้',mtConfirmation,mbYesNoCancel,0)<>mrYes then
  Abort
  else
  begin
{    emp_clientdataset.SetKey;
    emp_ClientDataset.FieldByName('employeeid').asString := empid_DBEdit.Text;
    emp_ClientDataset.GotoKey;}
    worked_ClientDataset.edit;
    Worked_ClientDataset.Delete;
    Emp_ClientDataset.ApplyUpdates(100);
  end;
end;

procedure TForm2.deletefame_ButtonClick(Sender: TObject);
begin
  if MessageDlg('ต้องการลบ Record นี้',mtConfirmation,mbYesNoCancel,0) <> mrYes then
  Abort
  else
  begin
{    emp_ClientDataset.SetKey;
    emp_ClientDAtaset.FieldByName('employeeid').asString := empid_DBEdit.Text;
    emp_clientdataset.GotoKey;}
    family_ClientDataset.Edit;
    Family_ClientDataset.Delete;
    Emp_ClientDataset.ApplyUpdates(100);
  end;
end;

procedure TForm2.insertEmp_ButtonClick(Sender: TObject);
begin
  empinsert_Clientdataset.Close;
  empinsert_ClientDataset.Params[0].asString := empid_DBEdit.text;
  empinsert_ClientDataset.Params[1].asString := empname_DBEdit.Text;
  empinsert_ClientDataset.Params[2].asString := surname_DBEdit.Text;
  empinsert_ClientDataset.Params[3].asString := department_DBComboBox.Text;
  empinsert_ClientDataset.Params[4].AsString := position_DBEdit.Text;
  empinsert_ClientDataset.Params[5].AsString := cntrlby_DBEdit.Text;
  empinsert_ClientDataset.Params[6].AsString := workertype_DBComboBox.Text;
  empinsert_ClientDataset.Params[7].AsDateTime := StrToDate(daystartwork_DBEdit.Text);
  empinsert_ClientDataset.Params[8].AsString := add_no_DBEdit.Text;
  empinsert_ClientDataset.Params[9].AsString := addRoad_DBEdit.Text;
  empinsert_ClientDataset.Params[10].AsString := district_DBEdit.Text;
  empinsert_ClientDataset.Params[11].AsString := amphur_DBEdit.Text;
  empinsert_ClientDataset.Params[12].AsString := province_DBEdit.Text;
  empinsert_ClientDataset.Params[13].AsString := zipcode_DBEdit.Text;
  empinsert_ClientDataset.Params[14].AsString := telno_DBEdit.Text;
  empinsert_ClientDataset.Params[15].AsDateTime := StrToDate(birthdate_DBEdit.Text);
  empinsert_ClientDataset.Params[16].AsString := marrital_DBComboBox.Text;
  empinsert_ClientDataset.Params[17].AsFloat := StrToFloat(salary_DBEdit.Text);
  empinsert_ClientDataset.Params[18].AsString := nationality_DBEdit.Text;
  empinsert_ClientDataset.Params[19].AsString := origin_DBEdit.Text;
  empinsert_ClientDataset.Params[20].AsString := religion_DBEdit.Text;
  empinsert_ClientDataset.Params[21].AsString := idcard_DBEdit.Text;
  empinsert_ClientDataset.Params[22].AsString := sscard_DBEdit.Text;
  empinsert_ClientDataset.Params[23].AsDateTime := StrToDate(beginss_DBedit.Text);
  empinsert_ClientDataset.Params[24].AsFloat := StrTOFloat(previoustotalss_DBEdit.Text);
  empinsert_ClientDataset.Params[25].AsString := gender_DBComboBox.Text;
  empinsert_ClientDataset.Params[26].AsString := bloodtype_DBComboBox.Text;
  empinsert_ClientDataset.Params[27].AsString := disease_DBEdit.Text;
  empinsert_ClientDataset.Params[28].AsString := bnkaccount_DBEdit.Text;
  empinsert_ClientDataset.SendParams;
  empInsert_ClientDataset.Provider.DataRequest(empInsert_clientDataset.Data);
end;

procedure TForm2.clearEdit;
begin
  empid_DBEdit.Text := '';
  empname_DBEdit.Text := '';
  surname_DBEdit.Text := '';
  department_DBComboBox.Text := '';
  Position_DBEdit.Text := '';
  CntrlBy_DBEdit.Text := '';
  workerType_DBComboBox.Text := '';
  daystartwork_DBEdit.Text := '';
  add_no_DBEdit.Text := '';
  addRoad_DBEdit.Text := '';
  district_DBEdit.Text := '';
  amphur_DBEdit.Text := '';
  province_DBEdit.Text := '';
  zipcode_DBEdit.Text := '';
  telno_DBEdit.Text := '';
  birthdate_DBEdit.Text := '';
  marrital_DBComboBox.Text := '';
  salary_DBEdit.Text := '';
  nationality_DBEdit.Text := '';
  origin_DBEdit.Text := '';
  religion_DBEdit.Text := '';
  idcard_DBEdit.Text := '';
  sscard_DBEdit.Text := '';
  beginss_DBEdit.Text := '';
  previoustotalss_DBEdit.Text := '';
  gender_DBComboBox.Text := '';
  bloodtype_DBComboBox.Text := '';
  disease_DBEdit.Text := '';
  bnkaccount_DBEdit.Text := '';
end;

procedure TForm2.fampostButtonClick(Sender: TObject);
begin
  if (family_clientdataset.State = dsEdit) or (family_clientdataset.State = dsInsert) then
  begin
  family_clientdataset.Post;
  Emp_clientdataset.ApplyUpdates(100);
  end else
  abort;
end;

procedure TForm2.postwork_ButtonClick(Sender: TObject);
begin
  if (worked_clientdataset.State = dsEdit) or (worked_clientdataset.State = dsInsert) then
  begin
    worked_clientdataset.Post;
    emp_clientdataset.ApplyUpdates(100);
  end else
  abort;
end;

procedure TForm2.postEducated_ButtonClick(Sender: TObject);
begin
  if (tbleducated_ClientDataset.State = dsEdit) or (tbleducated_ClientDataset.State = dsInsert) then
    begin
    tbleducated_ClientDataset.Post;
    tbleducated_ClientDataset.ApplyUpdates(100);
    end
    else abort;
end;

procedure TForm2.postTrain_ButtonClick(Sender: TObject);
begin
  if (tblTrained_ClientDataset.State = dsEdit) or (tblTrained_ClientDataset.State = dsInsert) then
  begin
    tblTrained_ClientDataset.Post;
    tblTrained_ClientDataset.ApplyUpdates(100);
  end
  else abort;
end;

end.
