unit Dial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Db, DBTables;

type
  TForm1 = class(TForm)
    Image1: TImage;
    DBEdit1: TDBEdit;
    Table1: TTable;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
