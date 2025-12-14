program recsx2;

uses
  Forms,
  recs2 in 'recs2.pas' {Form1},
  rseting in 'rseting.pas' {Form2},
  password in 'password.pas' {Form3};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
