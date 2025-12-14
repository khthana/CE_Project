program HCB;

uses
  Forms,
  Main in '..\Source\MAIN.PAS' {MainForm},
  Unit2 in '..\..\Project_Dave\Project\Unit2.pas' {Form2},
  Unit1 in '..\..\Project_Dave\Project\Unit1.pas' {DataModule1: TDataModule},
  Unit9 in '..\..\Project_Dave\Project\Unit9.pas' {Form9},
  Unit5 in '..\..\Project_Dave\Project\Unit5.pas' {QuickReport5: TQuickRep},
  Unit6 in '..\..\Project_Dave\Project\Unit6.pas' {QuickReport6: TQuickRep},
  Unit7 in '..\..\Project_Dave\Project\Unit7.pas' {QuickReport7: TQuickRep},
  Unit8 in '..\..\Project_Dave\Project\Unit8.pas' {QuickReport8: TQuickRep},
  Unit3 in '..\Source\Unit3.pas' {Form3},
  Unit4 in '..\Source\Unit4.pas' {Form4},
  About in '..\Source\about.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TQuickReport5, QuickReport5);
  Application.CreateForm(TQuickReport6, QuickReport6);
  Application.CreateForm(TQuickReport7, QuickReport7);
  Application.CreateForm(TQuickReport8, QuickReport8);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
