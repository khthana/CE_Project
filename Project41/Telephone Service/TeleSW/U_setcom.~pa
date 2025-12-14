unit U_setcom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,ComDrv32;


type
  TSetCom = class(TForm)
    BaudRateRG: TRadioGroup;
    ComPortRG: TRadioGroup;
    DataBitsRG: TRadioGroup;
    ParityRG: TRadioGroup;
    procedure BaudRateRGClick(Sender: TObject);
    procedure DataBitsRGClick(Sender: TObject);
    procedure ParityRGClick(Sender: TObject);
    procedure ComPortRGClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetCom: TSetCom;

implementation

uses ts_1;

{$R *.DFM}






procedure TSetCom.BaudRateRGClick(Sender: TObject);
begin
ts1.CommPortDriver1.ComPortSpeed := TComPortBaudRate(BaudRateRG.ItemIndex+1);
end;


procedure TSetCom.DataBitsRGClick(Sender: TObject);
begin
ts1.CommPortDriver1.ComPortDataBits := TComPortDataBits(DataBitsRG.ItemIndex);

end;

procedure TSetCom.ParityRGClick(Sender: TObject);
begin
ts1.CommPortDriver1.ComPortParity := TComPortParity(ParityRG.ItemIndex);

end;

procedure TSetCom.ComPortRGClick(Sender: TObject);
begin
ts1.CommPortDriver1.ComPort := TComPortNumber(ord(ComPortRG.ItemIndex));
end;

end.
