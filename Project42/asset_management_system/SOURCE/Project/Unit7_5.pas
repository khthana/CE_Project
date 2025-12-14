unit Unit7_5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls;

type
  TForm7_5 = class(TForm)
    QuickRep: TQuickRep;
    DetailBand1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRBand1: TQRBand;
    QRExpr4: TQRExpr;
    QRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Query1: TQuery;
    DataSource1: TDataSource;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7_5: TForm7_5;

implementation

{$R *.DFM}

end.
