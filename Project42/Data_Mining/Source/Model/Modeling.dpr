{************ Modeling Program ************}
{ AUTHOR : DATA MINING PROJECT 1999.
           COMPUTER ENGINEERING, KMIT'L
  ----------------------------------------------------------------
  This program is used for creating Backpropagation neural network
  which will be used in Lottery Prediction Program }

program Modeling;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  BPN in 'BPN.pas',
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Massage in 'Massage.pas',
  Main in 'Main.pas' {MainForm},
  About in 'about.pas' {AboutBox},
  Reader in 'Reader.pas';

{$R *.RES}


begin
  Application.Initialize;
  Application.Title := 'Model Creator';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
