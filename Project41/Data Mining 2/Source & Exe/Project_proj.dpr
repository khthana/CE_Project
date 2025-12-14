program Project_proj;

uses
  Forms,
  Unit_feed in 'Unit_feed.pas',
  Unit_proj in 'Unit_proj.pas' {Form3},
  Unit_comp in 'Unit_comp.pas' {Form2},
  Info in 'Info.pas' {Form4},
  Unit_new_1 in 'Unit_new_1.pas' {Form5};

  {$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
