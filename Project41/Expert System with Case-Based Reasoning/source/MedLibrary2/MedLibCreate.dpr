program MedLibCreate;

uses
  Forms,
  MainForm in 'MainForm.pas' {MedForm},
  LoadMed in 'LoadMed.pas' {LoadForm},
  SaveMed in 'SaveMed.pas' {SaveForm};


{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMedForm, MedForm);
  Application.CreateForm(TLoadForm, LoadForm);
  Application.CreateForm(TSaveForm, SaveForm);
  Application.Run;
end.
