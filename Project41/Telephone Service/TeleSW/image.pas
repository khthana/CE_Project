unit image;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DGCILib, DGC;

type
  TForm1 = class(TForm)
    DGCScreen1: TDGCScreen;
    DGCImageLib1: TDGCImageLib;
    procedure DGCScreen1Initialize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DGCScreen1Initialize(Sender: TObject);
begin
    DGCScreen1.Back.Draw(50,50, DGCScreen1.Images[1], False);
    DGCScreen1.FadePaletteOut(1);
     DGCScreen1.Flip;
     DGCScreen1.FadePaletteIn(100);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
   //If the escape key is pressed fade the palette out and
     //Close the demo
     if Key = #27 then
     begin
           DGCScreen1.Flip;
          //DGCScreen1.FadePaletteOut(100);
          //Close;
     end;
end;

end.
