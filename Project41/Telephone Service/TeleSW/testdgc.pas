unit testdgc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DGCSnd, dgcslib, StdCtrls, DGC, hiscore, DGCILib, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DGCSoundLib1: TDGCSoundLib;
    DGCAudio1: TDGCAudio;
    DGCScreen1: TDGCScreen;
    DGCImageLib1: TDGCImageLib;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 dgcaudio1.Sound[2].replay;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 dgcaudio1.Sound[3].replay;
end;

end.
