unit Unit5;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQuickReport5 = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    QRSysData3: TQRSysData;
    QRLabel9: TQRLabel;
  private

  public

  end;

var
  QuickReport5: TQuickReport5;

implementation

uses Unit1;

{$R *.DFM}

end.
