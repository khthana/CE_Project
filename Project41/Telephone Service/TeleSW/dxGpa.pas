unit dxGpa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Mask, Db, DBTables, ExtCtrls, Grids, DBGrids, DBCGrids,
  DXSounds, DXClass;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DXSound1: TDXSound;
    DXWaveList1: TDXWaveList;
    Button2: TButton;
    DXTimer1: TDXTimer;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
  private
    { Private declarations }
     num:integer;
     str:string;
  public
    { Public declarations }
    audio:Taudiofilestream;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 table1.SetKey;
 table1.Fields[0].AsString:= edit1.Text;
 table1.GotoKey;
 dbedit3.DataField:='GPA';
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
    begin
    table1.SetKey;
    table1.Fields[0].AsString:= edit1.Text;
    table1.GotoKey;
    dbedit3.DataField:='GPA';
    end
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
DXWaveList1.Items[1].play(false);
end;

procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
begin
 // if Audio.Playing then
 //  label3.caption:='playing'
 // else
 //   label3.caption:='stop';

end;

end.
