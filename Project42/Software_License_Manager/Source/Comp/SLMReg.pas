unit SLMReg;

interface

uses
  Classes, DsgnIntf, SysUtils;

procedure Register;

implementation

uses
  SLM_01, SLMCompEditor, ProEXE, SLMPropEditor;

procedure Register;
begin
  RegisterComponents('License Manager', [TCryptoManager, TPublicKey, TLicenseConfig,
                                         TProtectEXE, TActionsVerify, TMainVerify]);
  RegisterComponentEditor(TPublicKey, TPublicKeyEditor);
  RegisterComponentEditor(TLicenseConfig, TLicenseConfigEditor);
  RegisterPropertyEditor(TypeInfo(TFileName), TMainVerify, 'LicenseFile', TFileNameProperty);
end;

end.
