program Project_comp;

uses
  Forms,
  Unit_comp in 'Unit_comp.pas'; {Form1}

  {$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
