unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm7 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses  Unit1, Unit5;

{$R *.DFM}

procedure TForm7.Button1Click(Sender: TObject);
begin
     Form7.close;
     Form5.show;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
     Form7.close;
     Form1.show;
end;

end.
