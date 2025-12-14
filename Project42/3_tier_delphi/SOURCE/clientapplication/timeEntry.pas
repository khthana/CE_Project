unit timeEntry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, MConnect, StdCtrls, DBCtrls, Mask, ExtCtrls;

type
  TForm3 = class(TForm)
    timeEntry_DCOMConnection: TDCOMConnection;
    timeEntry_ClientDataSet: TClientDataSet;
    timeEntry_DataSource: TDataSource;
    entryNo_DBEdit: TDBEdit;
    empid_DBEdit: TDBEdit;
    daywork_DBEdit: TDBEdit;
    timeIn_DBEdit: TDBEdit;
    timeOut_DBEdit: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    workType_DBComboBox: TDBComboBox;
    post_Button: TButton;
    edit_Button: TButton;
    addButton: TButton;
    TimeEntry_DBNavigator: TDBNavigator;
    Label7: TLabel;
    timeEntry_ClientDataSetENTER_NO: TFloatField;
    timeEntry_ClientDataSetEMPLOYEEID: TFloatField;
    timeEntry_ClientDataSetDAY_WORK: TDateTimeField;
    timeEntry_ClientDataSetTIME_IN: TStringField;
    timeEntry_ClientDataSetTIME_OUT: TStringField;
    timeEntry_ClientDataSetWORK_TYPE: TStringField;
    procedure addButtonClick(Sender: TObject);
    procedure edit_ButtonClick(Sender: TObject);
    procedure post_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.addButtonClick(Sender: TObject);
var
  enterNO : integer;
begin
  timeEntry_ClientDataset.Open;
  timeEntry_clientDataset.Last;
  enterNo := timeEntry_ClientDataSetENTER_NO.AsInteger+1;
  timeEntry_clientDataset.Insert;
  timeEntry_ClientDatasetENTER_NO.AsInteger := enterNO;
end;

procedure TForm3.edit_ButtonClick(Sender: TObject);
begin
  timeEntry_clientDataset.Open;
  timeEntry_clientDataset.edit;
end;

procedure TForm3.post_ButtonClick(Sender: TObject);
begin
  if (timeEntry_clientdataset.State = dsEdit) or (timeEntry_clientdataset.State = dsInsert) then
  begin
  timeEntry_clientdataset.Post;
  timeEntry_clientdataset.ApplyUpdates(10);
  end else
  abort;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  timeEntry_ClientDataset.Open;
end;

end.
