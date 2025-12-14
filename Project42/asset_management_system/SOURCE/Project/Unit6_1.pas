unit Unit6_1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm6_1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6_1: TForm6_1;

implementation

uses Unit6;
{$R *.DFM}

procedure TForm6_1.Button2Click(Sender: TObject);
begin
     form6.combobox2.Text := 'ดี';
     form6.Enabled := true;
     form6_1.close;
end;

procedure TForm6_1.Button1Click(Sender: TObject);
begin
     if edit1.Text = ''   then
     begin
          showmessage('กรุณาใส่ลักษณะอาการที่เสีย');
          exit
     end;
     form6.label6.visible := true;
     form6.edit8.visible := true;
     form6.Edit8.Text := edit1.text;
     form6.Enabled := true;
     form6_1.close;
end;

end.
