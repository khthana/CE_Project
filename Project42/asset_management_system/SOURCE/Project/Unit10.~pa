unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Db, DBTables, Grids, DBGrids;

type
  TForm10 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ControlBar2: TControlBar;
    Label2: TLabel;
    Edit2: TEdit;
    ControlBar3: TControlBar;
    Label3: TLabel;
    ControlBar4: TControlBar;
    Label4: TLabel;
    Query1: TQuery;
    DataSource1: TDataSource;
    Button3: TButton;
    Button2: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form10: TForm10;
  ok :boolean;


implementation

uses Unit2, Unit3 ;

{$R *.DFM}

procedure TForm10.FormActivate(Sender: TObject);
begin
     edit3.SetFocus;
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
     form10.Close;
     form2.enabled := true;
     form2.visible := true;
end;


/////////////////////////procedure decr
/////////////////////////procedure decr

procedure TForm10.Button2Click(Sender: TObject);
begin
     form3.query1.Close;
     form3.query1.sql.text := 'update Tuser ';
     form3.query1.sql.add(' set name = :name ,comment = :comment');
     form3.query1.sql.add(' where id = :id');
     form3.query1.parambyname('name').asstring := edit3.text;
     form3.query1.parambyname('comment').asstring := edit4.text;
     form3.query1.parambyname('id').asstring := edit2.text;
     form3.query1.ExecSQL;
     form10.Close;

end;

end.
