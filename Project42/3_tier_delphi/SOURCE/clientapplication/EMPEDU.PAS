unit empedu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBClient, MConnect, Grids, DBGrids;

type
  TForm13 = class(TForm)
    DCOMConnection1: TDCOMConnection;
    ClientDataSet1: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    ClientDataSet3: TClientDataSet;
    ClientDataSet3SURNAME: TStringField;
    ClientDataSet1EMPLOYEEID: TFloatField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ClientDataSet2SUBJECT: TStringField;
    ClientDataSet2INSTITUTE: TStringField;
    ClientDataSet2START_TRAINING: TDateTimeField;
    ClientDataSet2SUCCESS_TRAINING: TDateTimeField;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ClientDataSet4: TClientDataSet;
    DataSource3: TDataSource;
    ClientDataSet2EMPLOYEEID: TFloatField;
    ClientDataSet4EMPLOYEEID: TFloatField;
    ClientDataSet4SCHOOL_UNIVERSITY: TStringField;
    ClientDataSet4YEAR_BEGIN: TDateTimeField;
    ClientDataSet4YEAR_SUCCESS: TDateTimeField;
    ClientDataSet4DEGREE: TStringField;
    ClientDataSet4MAJOR: TStringField;
    ClientDataSet4GRADE: TFloatField;
    procedure Edit1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.DFM}

procedure TForm13.Edit1Exit(Sender: TObject);
var
  name : string;
begin
  name := Edit1.Text;
  ClientDataset3.Close;
  ClientDataset3.Params[0].asString := name;
  ClientDataset3.Open;
  ClientDataset3.SendParams;
  ComboBox1.Items.Clear;
  while not ClientDataset3.Eof do
  begin
    ComboBox1.Items.Add(ClientDataset3SURNAME.AsString);
    ClientDataset3.Next;
  end;
  ComboBox1.Text := ComboBox1.items.Strings[0];
end;

procedure TForm13.Button1Click(Sender: TObject);
var
  name,surname : string;
begin
  name := Edit1.Text;
  surname := ComboBox1.Text;
  Clientdataset1.Close;
  Clientdataset1.Params[0].asString := name;
  ClientDataset1.Params[1].asstring := surname;
  ClientDataset1.Open;
  ClientDataset1.SendParams;
end;

end.
