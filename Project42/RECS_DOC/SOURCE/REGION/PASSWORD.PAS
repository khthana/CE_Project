unit password;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses recs2;

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
var S : string;
begin
     if (Edit1.text = recs2.Pass) then
     begin

     Form3.visible := False;
     Form1.Enabled := True;
     Form1.SetFocus;
     with Form1 do
     begin
       Ch1Button.Enabled := True;
       Ch2Button.Enabled := True;
       Ch3Button.Enabled := True;
       Ch4Button.Enabled := True;
       Ch5Button.Enabled := True;
       Ch6Button.Enabled := True;
       Ch7Button.Enabled := True;
       Ch8Button.Enabled := True;
       DC1Button.Enabled := True;
       DC2Button.Enabled := True;
       SetT1Button.Enabled := True;
       SetT2Button.Enabled := True;
       SetT3Button.Enabled := True;

       Timer1.Enabled := False;
       Label5.Visible := False;
       ConButton.Enabled := False;
       S := ':&Y';
       Comm1.write(S[1],Length(S));
       Ch1Button.SetFocus;
     end;
     end;
     
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
     Form3.visible := False;
     Form1.Enabled := True;
     Form1.SetFocus;
     Form1.CloseButton.Click;

end;

end.
