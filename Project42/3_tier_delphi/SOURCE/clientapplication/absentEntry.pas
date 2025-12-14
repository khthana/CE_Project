unit absentEntry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, MConnect, StdCtrls, Mask, DBCtrls, ComCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    absent_DCOMConnection: TDCOMConnection;
    absent_ClientDataSet: TClientDataSet;
    absent_DataSource: TDataSource;
    late_ClientDataSet: TClientDataSet;
    dayoff_ClientDataSet: TClientDataSet;
    late_DataSource: TDataSource;
    dayoff_DataSource: TDataSource;
    late_ClientDataSetSEQNO: TFloatField;
    late_ClientDataSetEMPLOYEEID: TFloatField;
    dayoff_ClientDataSetSEQNO: TFloatField;
    dayoff_ClientDataSetEMPLOYEEID: TFloatField;
    dayoff_ClientDataSetDAYOFFDATE: TDateTimeField;
    absent_PageControl: TPageControl;
    absent_TabSheet: TTabSheet;
    Dayoff_TabSheet: TTabSheet;
    Late_TabSheet: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    empIdAbs_DBEdit: TDBEdit;
    dateAbs_DBEdit: TDBEdit;
    empIdDayoff_DBEdit: TDBEdit;
    dateDayoff_DBEdit: TDBEdit;
    empIdLate_DBEdit: TDBEdit;
    dayLate_DBEdit: TDBEdit;
    late_ClientDataSetLATEDATE: TDateTimeField;
    lateSeqNo_DBEdit: TDBEdit;
    dayoffSeqNo_DBEdit: TDBEdit;
    absentSeqNo_DBEdit: TDBEdit;
    absEdit_Button: TButton;
    absInsertButton: TButton;
    absPost_Button: TButton;
    absent_DBNavigator: TDBNavigator;
    dayoff_DBNavigator: TDBNavigator;
    late_DBNavigator: TDBNavigator;
    dayoffEdit_Button: TButton;
    dayoffInsert_Button: TButton;
    dayoffPost_Button: TButton;
    lateEdit_Button: TButton;
    lateInsert_Button: TButton;
    latePost_Button: TButton;
    Label10: TLabel;
    absent_ClientDataSetSEQNO: TFloatField;
    absent_ClientDataSetEMPLOYEEID: TFloatField;
    absent_ClientDataSetABSENTDATE: TDateTimeField;
    procedure absEdit_ButtonClick(Sender: TObject);
    procedure absInsertButtonClick(Sender: TObject);
    procedure absPost_ButtonClick(Sender: TObject);
    procedure dayoffEdit_ButtonClick(Sender: TObject);
    procedure dayoffInsert_ButtonClick(Sender: TObject);
    procedure dayoffPost_ButtonClick(Sender: TObject);
    procedure lateEdit_ButtonClick(Sender: TObject);
    procedure lateInsert_ButtonClick(Sender: TObject);
    procedure latePost_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.DFM}

procedure TForm5.absEdit_ButtonClick(Sender: TObject);
begin
  absent_clientDataset.Open;
  absent_clientDataset.Edit;
end;

procedure TForm5.absInsertButtonClick(Sender: TObject);
begin
  absent_clientDataset.Open;
  absent_clientDataset.Last;
  absent_clientDataset.Insert;
  
end;

procedure TForm5.absPost_ButtonClick(Sender: TObject);
begin
  if (absent_clientdataset.State = dsEdit) or (absent_clientdataset.State = dsInsert) then
  begin
  absent_clientdataset.Post;
  absent_clientdataset.ApplyUpdates(10);
  end else
  abort;

end;

procedure TForm5.dayoffEdit_ButtonClick(Sender: TObject);
begin
  dayoff_clientdataset.Open;
  dayoff_clientDataset.Edit;
end;

procedure TForm5.dayoffInsert_ButtonClick(Sender: TObject);
begin
  dayoff_clientDataset.Open;
  dayoff_clientDataset.Last;
  dayoff_clientDataset.Insert;
end;

procedure TForm5.dayoffPost_ButtonClick(Sender: TObject);
begin
  if (dayoff_clientdataset.State = dsEdit) or (dayoff_clientdataset.State = dsInsert) then
  begin
  dayoff_clientdataset.Post;
  dayoff_clientdataset.ApplyUpdates(10);
  end else
  abort;

end;

procedure TForm5.lateEdit_ButtonClick(Sender: TObject);
begin
  late_ClientDataset.Open;
  late_ClientDataset.edit;
end;

procedure TForm5.lateInsert_ButtonClick(Sender: TObject);
begin
  late_clientDataset.Open;
  late_ClientDataset.Last;
  late_ClientDataset.Insert;
end;

procedure TForm5.latePost_ButtonClick(Sender: TObject);
begin
  if (late_clientdataset.State = dsEdit) or (late_clientdataset.State = dsInsert) then
  begin
  late_clientdataset.Post;
  late_clientdataset.ApplyUpdates(10);
  end else
  abort;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  absent_ClientDataset.Open;
  late_ClientDataset.Open;
  dayoff_ClientDataset.Open;
end;

end.
