unit emp_earning;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, MConnect, StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls;

type
  TForm14 = class(TForm)
    DCOMConnection1: TDCOMConnection;
    GroupBox1: TGroupBox;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    payMonth_DBText: TDBText;
    salary_DBText: TDBText;
    otmoney_DBText: TDBText;
    taxpay_DBText: TDBText;
    ssmoney_DBText: TDBText;
    totalmoney_DBText: TDBText;
    totalss_DBText: TDBText;
    totalTax_DBText: TDBText;
    DBGrid1: TDBGrid;
    emp_ClientDataSet: TClientDataSet;
    emp_ClientDataSetEMPLOYEEID: TFloatField;
    emp_ClientDataSetNAME: TStringField;
    emp_ClientDataSetSURNAME: TStringField;
    emp_ClientDataSetDEPARTMENTID: TFloatField;
    emp_ClientDataSetPOSITION: TStringField;
    emp_ClientDataSetWORKER_TYPE: TStringField;
    DataSource2: TDataSource;
    DBNavigator1: TDBNavigator;
    emp_ClientDataSetEMP_EARNING: TDataSetField;
    empEarning_ClientDataSet: TClientDataSet;
    empEarning_ClientDataSetPAY_MONTH: TDateTimeField;
    empEarning_ClientDataSetOT_MONEY: TFloatField;
    empEarning_ClientDataSetDEDUCT_MONEY: TFloatField;
    empEarning_ClientDataSetTAX_PAY: TFloatField;
    empEarning_ClientDataSetSS_MONEY_PAY: TFloatField;
    empEarning_ClientDataSetMONEY_PAY: TFloatField;
    empEarning_ClientDataSetTOTAL_TAX: TFloatField;
    empEarning_ClientDataSetTOTAL_SS_MONEY: TFloatField;
    emp_ClientDataSetBANKACCOUNT: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

{$R *.DFM}

procedure TForm14.FormCreate(Sender: TObject);
begin
  empEarning_ClientDataset.Open;
  empEarning_ClientDataset.Last;
end;

end.
