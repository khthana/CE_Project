unit Unit7_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, Db, DBTables, QuickRpt, ExtCtrls;

type
  TForm7_2 = class(TForm)
    Query1: TQuery;
    QuickRep: TQuickRep;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRBand1: TQRBand;
    QRExpr4: TQRExpr;
    QRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7_2: TForm7_2;

implementation

{$R *.DFM}

end.
