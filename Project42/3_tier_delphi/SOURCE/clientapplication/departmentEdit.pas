unit departmentEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Db, DBClient, MConnect;

type
  TForm4 = class(TForm)
    department_DCOMConnection: TDCOMConnection;
    department_ClientDataSet: TClientDataSet;
    department_DataSource: TDataSource;
    departmentID_DBEdit: TDBEdit;
    departmentName_DBEdit: TDBEdit;
    location_DBEdit: TDBEdit;
    totalWorker_DBEdit: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    department_DBNavigator: TDBNavigator;
    post_Button: TButton;
    insert_Button: TButton;
    edit_Button: TButton;
    department_ClientDataSetDEPARTMENTID: TFloatField;
    department_ClientDataSetDEPARTMENTNAME: TStringField;
    department_ClientDataSetTOTALWORKER: TFloatField;
    department_ClientDataSetLOCATION: TStringField;
    cntdept_ClientDataSet: TClientDataSet;
    cntdept_ClientDataSetCOUNT: TFloatField;
    Label5: TLabel;
    procedure insert_ButtonClick(Sender: TObject);
    procedure edit_ButtonClick(Sender: TObject);
    procedure post_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.DFM}

procedure TForm4.insert_ButtonClick(Sender: TObject);
var
  ID : integer;
begin
  cntdept_ClientDataset.Open;
  department_clientDataset.Open;
  department_clientDataset.last;
  ID := cntdept_ClientDatasetCOUNT.AsInteger;
  departmentID_DBEdit.text := IntToStr(ID+1);
  department_clientDataset.Insert;
  department_ClientDatasetDEPARTMENTID.AsString := departmentID_DBEdit.Text;
  department_ClientDatasetDEPARTMENTNAME.AsString := departmentname_DBEdit.Text;
end;

procedure TForm4.edit_ButtonClick(Sender: TObject);
begin
  department_clientDataset.Open;
  department_clientDataset.edit;
  department_ClientDatasetDEPARTMENTID.AsString := DepartmentID_DBEdit.Text;
  department_ClientDataSet.fieldbyname('DepartmentName').asString := departmentname_DBEdit.text;
end;

procedure TForm4.post_ButtonClick(Sender: TObject);
begin
  if (department_clientdataset.State = dsEdit) or (department_clientdataset.State = dsInsert) then
  begin
  department_clientdataset.Post;
  department_clientdataset.ApplyUpdates(10);
  end else
  abort;

end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  department_ClientDataset.open;
end;

end.
