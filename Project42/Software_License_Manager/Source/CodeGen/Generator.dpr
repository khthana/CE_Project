program Generator;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain},
  uCryptSetting in 'uCryptSetting.pas' {dlgCrypto},
  Stampex1 in 'Stampex1.pas' {frmStamp};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'License Code File Generator';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgCrypto, dlgCrypto);
  Application.CreateForm(TfrmStamp, frmStamp);
  Application.Run;
end.
