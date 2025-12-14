program hrproject;

uses
  Forms,
  welcome in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\welcome.pas' {Form1},
  hrproject_TLB in 'hrproject_TLB.pas',
  human in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\human.pas',
  hrdatamodule in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\hrdatamodule.pas' {DataModule1: TDataModule},
  hrsys in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\hrsys.pas' {hrserver: TRemoteDataModule} {hrserver: CoClass},
  checkwork in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\checkwork.pas',
  Timer in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\hrproject\Timer.pas';

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
