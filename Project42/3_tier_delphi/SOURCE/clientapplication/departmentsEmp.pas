unit departmentsEmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, MConnect, Db, StdCtrls, DBCtrls, Grids, DBGrids;

type
  TForm8 = class(TForm)
    DCOMConnection1: TDCOMConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBComboBox1: TDBComboBox;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    Label1: TLabel;
    Button1: TButton;
    DBComboBox2: TDBComboBox;
    ClientDataSet3: TClientDataSet;
    DataSource3: TDataSource;
    ClientDataSet4: TClientDataSet;
    DataSource4: TDataSource;
    ClientDataSet2DEPARTMENTID: TFloatField;
    ClientDataSet2DEPARTMENTNAME: TStringField;
    ClientDataSet2TOTALWORKER: TFloatField;
    ClientDataSet2LOCATION: TStringField;
    ClientDataSet3DEPARTMENTNAME: TStringField;
    ClientDataSet4DEPARTMENTID: TFloatField;
    Label2: TLabel;
    Label3: TLabel;
    ClientDataSet1EMPLOYEEID: TFloatField;
    ClientDataSet1NAME: TStringField;
    ClientDataSet1SURNAME: TStringField;
    ClientDataSet1POSITION: TStringField;
    ClientDataSet1SALARY: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure DBComboBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.DFM}

procedure TForm8.FormCreate(Sender: TObject);
begin
  ClientDataset2.Open;
  while not ClientDataset2.Eof do
  begin
    DBComboBox1.Items.Add(intToStr(ClientDataset2DEPARTMENTID.AsInteger));
    DBComboBox2.Items.Add(ClientDataset2DEPARTMENTNAME.text);
    ClientDataset2.Next;
  end;
  DBComboBox1.Text := DBComboBox1.Items.Strings[0];
  DBComboBox2.Text := DBComboBox2.Items.Strings[0];
end;

procedure TForm8.DBComboBox1Change(Sender:TObject);
var
  departmentid : integer;
begin
  clientDataset3.Close;
  departmentid := StrToint(DBCombobox1.text);
  ClientDataset3.Params[0].asfloat := departmentid;
  clientDataset3.Open;
  clientdataset3.SendParams;
  DBComboBox2.DataSource := Datasource3;
  DBComboBox2.Text := ClientDataset3DEPARTMENTNAME.Text;
end;

procedure TForm8.DBComboBox2Change(Sender: TObject);
var
  departmentname : string;
begin
  ClientDataset4.Close;
  departmentname := DBComboBox2.Text;
  ClientDataset4.Params[0].asString := departmentname;
  ClientDataset4.Open;
  ClientDataset4.SendParams;
  DBComboBox1.DataSource := Datasource4;
  DBComboBox1.Text := ClientDataset4DEPARTMENTID.AsString;
end;

procedure TForm8.DBComboBox2Click(Sender: TObject);
begin
  ClientDataset2.Open;
  ClientDataset2.First;
  while ClientDataSet2.Eof do
  begin
    DBComboBox2.Items.Add(ClientDataset2DEPARTMENTNAME.text);
    ClientDataset2.Next;
  end;
end;
procedure TForm8.Button1Click(Sender: TObject);
var
  departmentid : integer;
begin
  departmentid := StrToint(DBComboBox1.text);
  ClientDataset1.Close;
  ClientDataset1.Params[0].asinteger := departmentid;
  ClientDataset1.Open;
  ClientDataset1.SendParams;
  Label3.Caption := DBComboBox2.Text;
  Label3.Visible := true;
end;

end.
