unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, StdCtrls, QuickRpt, ExtCtrls, Db, DBTables;

type
  TForm6 = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel8: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel1: TQRLabel;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type  TArrayInt = Array [1..20] of Integer;

var
  Form6: TForm6;
  i : integer;
implementation

uses Unit4, Unit7;
{$R *.DFM}




procedure TForm6.Button1Click(Sender: TObject);
begin
     Form6.close;
     Form7.show;
end;

end.
