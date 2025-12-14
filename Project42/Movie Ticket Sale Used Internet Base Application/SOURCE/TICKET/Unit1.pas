unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, ComCtrls, DBTables;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    ControlBar1: TControlBar;
    Button1: TButton;
    Button2: TButton;
    Image6: TImage;
    Image7: TImage;
    Label1: TLabel;
    Image8: TImage;
    Database1: TDatabase;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.DFM}


procedure TForm1.Button1Click(Sender: TObject);
begin
     Form3.show;
     Form1.hide;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
      Form2.show;
      Form1.hide;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Database1.open;
end;

end.
