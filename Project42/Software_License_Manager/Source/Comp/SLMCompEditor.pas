unit SLMCompEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DsgnIntf, SLM_01;

type

  TPublicKeyEditor = class(TComponentEditor)
  private
    procedure DoEditPublicKey;
  protected

  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  published

  end;

  TLicenseConfigEditor = class(TComponentEditor)
  private
    procedure DoEditConfig;
  protected

  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  published

  end;

implementation

uses
  uPublicKey, uLicConfig;

{ TPublicKeyEditor }

procedure TPublicKeyEditor.DoEditPublicKey;
begin
  with TfrmPBKeyDlg.Create(nil) do
  begin
    try
      PublicKeyStream.LoadFromStream((Component as TPublicKey).PublicKeyStream);
      if ShowModal = mrOK then
      begin
        (Component as TPublicKey).LoadFromStream(PublicKeyStream);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPublicKeyEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: DoEditPublicKey;
  end;
end;

function TPublicKeyEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Set &Public Key';
  end;
end;

function TPublicKeyEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLicenseConfigEditor }

procedure TLicenseConfigEditor.DoEditConfig;
begin
  with TfrmLCfgEditor.Create(nil) do
  begin
    try
      LicenseConfig := (Component as TLicenseConfig);
      if ShowModal = mrOK then
      begin

      end;
    finally
      Free;
    end;
  end;
end;

procedure TLicenseConfigEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 : DoEditConfig;
  end;
end;

function TLicenseConfigEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Configurations...';
  end;
end;

function TLicenseConfigEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
