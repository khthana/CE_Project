unit personal_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBClient, MConnect, DBCtrls, Grids, DBGrids;

type
  TForm11 = class(TForm)
    DCOMConnection1: TDCOMConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    addNo_DBText: TDBText;
    addRoad_DBText: TDBText;
    district_DBText: TDBText;
    amphur_DBText: TDBText;
    province_DBText: TDBText;
    zipcode_DBText: TDBText;
    phone_DBText: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    brthdate_DBText: TDBText;
    nation_DBText: TDBText;
    origin_DBText: TDBText;
    religion_DBText: TDBText;
    marrital_DBText: TDBText;
    GroupBox4: TGroupBox;
    Label14: TLabel;
    id_DBText: TDBText;
    bld_DBText: TDBText;
    disease_DBText: TDBText;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ComboBox1: TComboBox;
    ClientDataSet2: TClientDataSet;
    ClientDataSet2SURNAME: TStringField;
    ClientDataSet1ADDRESS_NO: TStringField;
    ClientDataSet1ADD_ROAD: TStringField;
    ClientDataSet1DISTRICT: TStringField;
    ClientDataSet1AMPHUR: TStringField;
    ClientDataSet1PROVINCE: TStringField;
    ClientDataSet1ZIPCODE: TStringField;
    ClientDataSet1PHONE_NO: TStringField;
    ClientDataSet1BIRTH_DATE: TDateTimeField;
    ClientDataSet1RELIGION: TStringField;
    ClientDataSet1NATIONALITY: TStringField;
    ClientDataSet1ORIGIN: TStringField;
    ClientDataSet1MARRITAL_STATUS: TStringField;
    ClientDataSet1ID_CARD_NO: TStringField;
    ClientDataSet1BLOODTYPE: TStringField;
    ClientDataSet1DISEASE: TStringField;
    ClientDataSet1BANKACCOUNT: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.DFM}

procedure TForm11.Button1Click(Sender: TObject);
var
  name,surname : string;
begin
  name := Edit1.Text;
  surname := ComboBox1.Text;
  ClientDataset1.Close;
  ClientDataset1.Params[0].asString := name;
  ClientDataset1.Params[1].asString := surname;
  ClientDataset1.Open;
  ClientDataset1.SendParams;
end;

procedure TForm11.Edit1Exit(Sender: TObject);
var
  name : string;
begin
  name := Edit1.Text;
  ClientDataset2.Close;
  ClientDataset2.Params[0].asString := name;
  ClientDataset2.Open;
  ClientDataset2.SendParams;
  ComboBox1.Items.Clear;
  while not ClientDataset2.Eof do
  begin
    ComboBox1.Items.Add(ClientDataset2SURNAME.AsString);
    ClientDataset2.Next;
  end;
  ComboBox1.Text := ComboBox1.items.Strings[0];
end;

end.
