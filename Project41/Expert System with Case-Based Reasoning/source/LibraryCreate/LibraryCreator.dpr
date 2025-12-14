program LibraryCreator;

uses
  Forms,
  AttrMain in 'AttrMain.pas' {AttrForm},
  AttrEnter in 'AttrEnter.pas' {AttrEnterForm},
  ShowAttr in 'ShowAttr.pas' {ShowForm},
  SaveLib in 'SaveLib.pas' {SaveForm},
  LoadLib in 'LoadLib.pas' {LoadForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAttrForm, AttrForm);
  Application.CreateForm(TAttrEnterForm, AttrEnterForm);
  Application.CreateForm(TShowForm, ShowForm);
  Application.CreateForm(TSaveForm, SaveForm);
  Application.CreateForm(TLoadForm, LoadForm);
  Application.Run;
end.
