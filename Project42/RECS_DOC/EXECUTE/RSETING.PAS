unit rseting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Label6: TLabel;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses recs2;

{$R *.DFM}

procedure TForm2.Button4Click(Sender: TObject);
begin
     Form1.Comm1.DeviceName := ComboBox1.items.Strings[ComboBox1.ItemIndex];
     Form2.visible := False;
     Form1.Enabled := True;
     Form1.SetFocus;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
     Form2.visible := False;
     Form1.Enabled := True;
     Form1.SetFocus;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
     Form1.Comm1.DeviceName := ComboBox1.items.Strings[ComboBox1.ItemIndex];
end;

end.
