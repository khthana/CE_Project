unit Unit_proj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button2: TButton;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    RadioButton3: TRadioButton;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
 

implementation
     uses unit_feed, Unit_comp,info, Unit_new_1;
{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
begin
     if Form3.RadioButton1.Checked then
     begin
          Form3.hide;
          Form2.show;
     end
     else if Form3.RadioButton2.Checked then
     begin
          Form3.hide;
          Form1.show;
     end

     else if Form3.RadioButton3.Checked then
     begin
          Form3.hide;
          Form5.show;
     end;

end;


procedure TForm3.Button2Click(Sender: TObject);
begin
     Form3.hide;
     Form4.show;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
     Form1.Close;
     Form2.Close;
     Form3.Close;
     Form4.Close;
     Application.Terminate;
     Exit;

end;


end.
