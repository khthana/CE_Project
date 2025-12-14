program Project_new_1;

uses
  Forms,
  Unit_new_1 in 'Unit_new_1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
