program newothello;

uses
  Forms,
  board2 in 'board2.pas' {Form1},
  Reversi in 'Reversi.pas',
  msg in 'msg.pas' {Form2},
  GenMonitor in 'GenMonitor.pas' {Form3},
  GA1 in 'Ga1.pas',
  monitorfrm in 'monitorfrm.pas' {Form4};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
