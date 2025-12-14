unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Db, DBTables;

type
  Tuser = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Update: TButton;
    Button2: TButton;
    Query1: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  user: Tuser;

implementation

uses Unit2, Unit3;

{$R *.DFM}

procedure Tuser.Button2Click(Sender: TObject);
begin
     user.Close;
     form2.enabled := true;
     form2.visible := true;

end;

procedure Tuser.FormActivate(Sender: TObject);
begin
     edit2.SetFocus;
end;

procedure Tuser.UpdateClick(Sender: TObject);
begin
     form3.query1.Close;
     form3.query1.sql.text := 'update Tuser ';
     form3.query1.sql.add(' set name = :name ,comment = :comment');
     form3.query1.sql.add(' where id = :id');
     form3.query1.parambyname('name').asstring := edit2.text;
     form3.query1.parambyname('comment').asstring := edit3.text;
     form3.query1.parambyname('id').asstring := edit1.text;
     form3.query1.ExecSQL;
     user.Close;

end;

end.
