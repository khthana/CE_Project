program TS;

uses
  Forms,
  ts_1 in 'ts_1.pas' {TS1},
  ai2 in 'ai2.pas' {Form2},
  commu in 'commu.pas' {Comform},
  U_setcom in 'U_setcom.pas' {SetCom},
  recall in 'recall.pas' {Form4},
  ts_setup in 'ts_setup.pas' {Form5},
  About in 'About.pas' {Form6},
  mailbox in 'mailbox.pas' {Form3},
  psound in 'psound.pas' {MainForm},
  ai1 in 'ai1.pas' {Form1};



{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TELEPHONE SERVICE';
  Application.HelpFile := 'G:\Borland\PIG\Ts.hlp';
  Application.CreateForm(TTS1, TS1);
  Application.CreateForm(TComform, Comform);
  Application.CreateForm(TSetCom, SetCom);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
