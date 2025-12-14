unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg, GIFImage;

type
  TForm1 = class(TForm)
    Image1: TImage;
    GIFImage1: TGIFImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4;

{$R *.DFM}

procedure TForm1.Image1Click(Sender: TObject);
begin
     timer1.Enabled  := false;
     form1.Visible := false;
     form4.ShowModal;
     close;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
     timer1.Enabled  := false;
     close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     if label1.Left > -528 then
        label1.Left := label1.Left - 1
     else label1.Left := 784;end;

end.
