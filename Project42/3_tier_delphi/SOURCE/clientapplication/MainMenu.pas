unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,emp_dataEntry,timeEntry,departmentEdit,absentEntry,empInfo,
  departmentsEmp,personal_info,empedu,emp_earning;

type
  TForm9 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.DFM}

procedure TForm9.Label2Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm9.Label3Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm9.Label4Click(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm9.Label5Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm9.Button4Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

procedure TForm9.Button5Click(Sender: TObject);
begin
  Form11.ShowModal;
end;

procedure TForm9.Button6Click(Sender: TObject);
begin
  Form8.ShowModal;
end;

procedure TForm9.Button7Click(Sender: TObject);
begin
  Form7.ShowModal;
end;

procedure TForm9.Button8Click(Sender: TObject);
begin
  Form13.ShowModal;
end;

procedure TForm9.Button9Click(Sender: TObject);
begin
  Form14.ShowModal;
end;

end.
