unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    btGetDFP: TButton;
    Label3: TLabel;
    edMACAddr: TEdit;
    Label5: TLabel;
    edDiskSerial: TEdit;
    Label6: TLabel;
    edHDInfo: TEdit;
    DriveComboBox1: TDriveComboBox;
    Label1: TLabel;
    edPSN: TEdit;
    procedure btGetDFPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  uDFPDeclares;

procedure TForm1.btGetDFPClick(Sender: TObject);
const
  MAX_LEN = 500;
var
  IDStr: string;
  Len: Integer;
begin

  Len := MAX_LEN;
  SetLength(IDStr, Len);
  SetLength(IDStr, GetMACAddress(PChar(IDStr), Len));
  edMACAddr.Text := IDStr;

  Len := MAX_LEN;
  SetLength(IDStr, Len);
  SetLength(IDStr, GetLogicalDiskDFP(DriveComboBox1.Drive, PChar(IDStr), Len));
  edDiskSerial.Text := IDStr;

  Len := MAX_LEN;
  SetLength(IDStr, Len);
  SetLength(IDStr, GetHarddiskDFP(0, PChar(IDStr), Len));
  edHDInfo.Text := IDStr;

  Len := MAX_LEN;
  SetLength(IDStr, Len);
  Len := GetProcessorDFP(PChar(IDStr), Len);
  if Len = -1 then
    edPSN.Text := 'Processor Serial Number not present.'
  else begin
    SetLength(IDStr, Len);
    edPSN.Text := IDStr;
  end;
end;

end.
