unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDataModule1 = class(TDataModule)
    DataSource1: TDataSource;
    Database1: TDatabase;
    Database2: TDatabase;
    Query1: TQuery;
    DataSource2: TDataSource;
    Query2: TQuery;
    DataSource3: TDataSource;
    Query3: TQuery;
    Table1: TTable;
    Table2: TTable;
    Table1BKCODE: TStringField;
    Table1BKCALL: TStringField;
    Table1BKGROUP: TStringField;
    Table1BKNAME: TStringField;
    Table1STATUS: TStringField;
    Table1YEAR_LOST: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.DFM}

end.
