program PClient;

uses
  Forms,
  UClient in 'UClient.pas' {FClient},
  Uremote in 'Uremote.pas' {Fremote};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFClient, FClient);
  Application.CreateForm(TFremote, Fremote);
  Application.Run;
end.
