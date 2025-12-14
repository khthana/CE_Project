unit msg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    Procedure PrintMessage(Strng : String) ;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
Uses Board2 ;
{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
begin
     Form1.Enabled := true ;
     Close ;
end;

Procedure TForm2.PrintMessage(Strng : String) ;
var Len : integer ;
begin
     Len := Length(Strng) ;
     Label1.Left := (Width div 2)-12*(Len div 2) ;
     Left := Form1.Left+60 ;
     Top  := Form1.Top+60  ;
     visible := true ;
     Label1.Caption := Strng ;
     Form1.Enabled := false ;
end ;

end.
