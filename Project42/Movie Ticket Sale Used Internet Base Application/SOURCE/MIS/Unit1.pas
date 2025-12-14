unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBTables;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Panel3: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Label3: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label4: TLabel;
    Label6: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    Database1: TDatabase;
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TForm1.Label3Click(Sender: TObject);
begin
     Form1.hide;
     Form2.show;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
     Form1.hide;
     Form3.show;
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
     Form1.Hide;
     Form4.show;
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
     Form1.close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Database1.open;
end;

end.
