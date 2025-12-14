unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SLM_01, WinCrypt, ActnList, ComCtrls, ToolWin, Menus, Spin,
  Buttons, ExtCtrls;

const
  MAX_FEATURE = 20;

type
  PTFeatureInfo = ^TFeatureInfo;
  TFeatureInfo = packed record
                   Name: string[255];
                   Description: string[255];
                   LicenseType: TLicenseType;
                   ExpiredDate: TDate;
                   Actions: TStringList;
                 end;

  TfrmMain = class(TForm)
    pnConfig: TPanel;
    pnFeature: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edFeatureName: TEdit;
    edFDescription: TEdit;
    gbLicTypes: TGroupBox;
    rbtnPermanent: TRadioButton;
    rbtnExpired: TRadioButton;
    dtpkFExpired: TDateTimePicker;
    rbtnDisable: TRadioButton;
    lbxFActions: TListBox;
    pnApplication: TPanel;
    lbAppName: TLabel;
    lbVersion: TLabel;
    lbBuildNo: TLabel;
    lbDescription: TLabel;
    lbDFP: TLabel;
    edAppName: TEdit;
    edVersion: TEdit;
    edDescription: TEdit;
    gbALicType: TGroupBox;
    rbtnAPermanent: TRadioButton;
    rbtnAExpired: TRadioButton;
    dtpkAExpired: TDateTimePicker;
    rbtnADisable: TRadioButton;
    cbDemo: TCheckBox;
    edBuildNo: TEdit;
    edDFP: TEdit;
    tvFeatures: TTreeView;
    CryptoManager: TCryptoManager;
    odlgLRF: TOpenDialog;
    sdlgSLF: TSaveDialog;
    sdlgPKS: TSaveDialog;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    GeneratefromWizard1: TMenuItem;
    GeneratefromRequest1: TMenuItem;
    N3: TMenuItem;
    Generate1: TMenuItem;
    N1: TMenuItem;
    EXit1: TMenuItem;
    Tools1: TMenuItem;
    ExportPublicKeySign1: TMenuItem;
    N2: TMenuItem;
    ExetableFileProtector1: TMenuItem;
    Setting1: TMenuItem;
    Cryptographic1: TMenuItem;
    About1: TMenuItem;
    About2: TMenuItem;
    odlgLTF: TOpenDialog;
    procedure ExportPublicKeySign1Click(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure EXit1Click(Sender: TObject);
    procedure GeneratefromRequest1Click(Sender: TObject);
    procedure Generate1Click(Sender: TObject);
    procedure GeneratefromWizard1Click(Sender: TObject);
    procedure Cryptographic1Click(Sender: TObject);
    procedure ExetableFileProtector1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvFeaturesChange(Sender: TObject; Node: TTreeNode);
    procedure rbtnAPermanentClick(Sender: TObject);
    procedure rbtnADisableClick(Sender: TObject);
    procedure rbtnAExpiredClick(Sender: TObject);
    procedure dtpkAExpiredChange(Sender: TObject);
    procedure cbDemoClick(Sender: TObject);
    procedure rbtnPermanentClick(Sender: TObject);
    procedure rbtnDisableClick(Sender: TObject);
    procedure rbtnExpiredClick(Sender: TObject);
    procedure dtpkFExpiredChange(Sender: TObject);
  private
    { Private declarations }
    procedure InitEmptyFeaturesInfo;
    procedure FreeFeaturesInfo;
    procedure ShowAppPanel(AppInfo: TAppInfo);
    procedure ShowFeaturePanel(PFeatureInfo: PTFeatureInfo);
  public
    procedure AddToMemo(line: string);
    procedure OpenLicRequestFile(const FileName: string);
    procedure OpenLicTemplateFile(const FileName: string);
    function BufCharToStr(BufChar: array of Char; Len: Longint): string;
    procedure GenerateFromTemplate(const FileName: string);
    procedure GenerateFromRequest(const FileName: string);
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  AppInfo: TAppInfo;
  IsTemplate: Boolean;
  FeaturesInfo: array[0..MAX_FEATURE - 1] of TFeatureInfo;
  PBKeyXchg: TPBKeyData;

implementation

uses uCryptSetting, Stampex1;

{$R *.DFM}

procedure TfrmMain.AddToMemo(line: string);
begin
end;

function TfrmMain.BufCharToStr(BufChar: array of Char; Len: Integer): string;
var
  i: Integer;
begin
  Result := '';
  SetLength(Result, Len);
  for i := 0 to Len - 1 do
  begin
    Result[i + 1] := BufChar[i];
  end;
end;

function StrToCharArray(const Str: string;
  var CharArray: array of Char): Longint;
var
  i: Integer;
begin
  Result := Length(Str);
  for i := 1 to Result do
    CharArray[i - 1] := Str[i];
end;

procedure TfrmMain.OpenLicRequestFile(const FileName: string);
var
  fs: TFileStream;
  Magic: TLicenseMagic;
  BufSize: Longint;
  FCount, ACount: Longint;
  BufChar: array[1..255] of Char;
  LicType: TLicenseType;
  Expired: TDate;
  i, j: Integer;
begin
  tvFeatures.Items.Clear;

  CryptoManager.AcquireContext(True);

  fs := TFileStream.Create(FileName, fmOpenRead);
  with fs do
  begin
    Read(Magic, SizeOf(Magic));
    Read(AppInfo, SizeOf(AppInfo));
    tvFeatures.Items.AddChildObject(nil, AppInfo.AppName, @AppInfo);
    Read(FCount, SizeOf(FCount));
    for i := 0 to FCount - 1 do
    begin
      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      FeaturesInfo[i].Name := BufCharToStr(BufChar, BufSize);
      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      FeaturesInfo[i].Description := BufCharToStr(BufChar, BufSize);
      Read(LicType, SizeOf(LicType));
      FeaturesInfo[i].LicenseType := LicType;
      Read(Expired, SizeOf(Expired));
      FeaturesInfo[i].ExpiredDate := Expired;
      Read(ACount, SizeOf(ACount));
      FeaturesInfo[i].Actions.Clear;
      for j := 0 to ACount - 1 do
      begin
          Read(BufSize, SizeOf(BufSize));
          Read(BufChar, BufSize);
          FeaturesInfo[i].Actions.Add(BufCharToStr(BufChar, BufSize));
      end;
      tvFeatures.Items.AddChildObject(tvFeatures.Items[0], FeaturesInfo[i].Name,
                                      @FeaturesInfo[i]);
    end;
    Read(BufSize, SizeOf(BufSize));
    Read(BufChar, BufSize);
    edDFP.Text := BufCharToStr(BufChar, BufSize);
    Read(BufSize, SizeOf(BufSize));
    Read(PBKeyXchg, BufSize);
    if CryptoManager.ImportPBKey(AT_KEYEXCHANGE, PBKeyXchg) then
      ShowMessage('Import Key Exchange OK.')
    else
      ShowMessage('Import Key Exchange FAIL.');
  end;
  fs.Free;
  tvFeatures.FullExpand;
  tvFeatures.SetFocus;
end;

procedure TfrmMain.ExportPublicKeySign1Click(Sender: TObject);
begin
  if sdlgPKS.Execute then
  begin
    CryptoManager.AcquireContext(True);
    if CryptoManager.ExportUserKey(AT_SIGNATURE, sdlgPKS.FileName) then
      ShowMessage('Public Key Sign exported.')
    else
      ShowMessage('Error!!!');
  end;
end;

procedure TfrmMain.About2Click(Sender: TObject);
begin
  ShowMessage('License Code File Generator v1.0');
end;

procedure TfrmMain.EXit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.GeneratefromRequest1Click(Sender: TObject);
begin
  if odlgLRF.Execute then
  begin
    Generate1.Enabled := True;
    pnConfig.Visible := True;
    IsTemplate := False;
    OpenLicRequestFile(odlgLRF.FileName);
  end;
end;

procedure TfrmMain.Generate1Click(Sender: TObject);
begin
  if sdlgSLF.Execute then
    if IsTemplate then
      GenerateFromTemplate(sdlgSLF.FileName)
    else
      GenerateFromRequest(sdlgSLF.FileName);
end;

procedure TfrmMain.OpenLicTemplateFile(const FileName: string);
var
  fs: TFileStream;
  Magic: TLicenseMagic;
  BufSize: Longint;
  FCount, ACount: Longint;
  BufChar: array[1..255] of Char;
  i, j: Integer;
begin
  tvFeatures.Items.Clear;

  fs := TFileStream.Create(FileName, fmOpenRead);
  with fs do
  begin
    Read(Magic, SizeOf(Magic));
    Read(AppInfo, SizeOf(AppInfo));
    tvFeatures.Items.AddChildObject(nil, AppInfo.AppName, @AppInfo);
    Read(FCount, SizeOf(FCount));
    for i := 0 to FCount - 1 do
    begin
      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      FeaturesInfo[i].Name := BufCharToStr(BufChar, BufSize);
      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      FeaturesInfo[i].Description := BufCharToStr(BufChar, BufSize);
      Read(ACount, SizeOf(ACount));
      FeaturesInfo[i].Actions.Clear;
      for j := 0 to ACount - 1 do
      begin
        Read(BufSize, SizeOf(BufSize));
        Read(BufChar, BufSize);
        FeaturesInfo[i].Actions.Add(BufCharToStr(BufChar, BufSize));
      end;
      tvFeatures.Items.AddChildObject(tvFeatures.Items[0], FeaturesInfo[i].Name,
                                      @FeaturesInfo[i]);
    end;
  end;
  fs.Free;
  tvFeatures.FullExpand;
  tvFeatures.SetFocus;
end;

procedure TfrmMain.GeneratefromWizard1Click(Sender: TObject);
begin
  if odlgLTF.Execute then
  begin
    Generate1.Enabled := True;
    pnConfig.Visible := True;
    IsTemplate := True;
    OpenLicTemplateFile(odlgLTF.FileName);
  end;
end;

procedure TfrmMain.Cryptographic1Click(Sender: TObject);
begin
  with dlgCrypto do
  begin
    edContainer.Text := CryptoManager.Container;
    edOwner.Text := CryptoManager.OwnerName;
    cbAutoSession.Checked := CryptoManager.AutoSessionKey;
    cbbAlgo.ItemIndex := Ord(CryptoManager.HashAlgorithm);
    if ShowModal = mrOK then
    begin
      CryptoManager.Container := edContainer.Text;
      CryptoManager.OwnerName := edOwner.Text;
      CryptoManager.AutoSessionKey := cbAutoSession.Checked;
      CryptoManager.HashAlgorithm := THashAlgo(cbbAlgo.ItemIndex);
      CryptoManager.AcquireContext(True);
    end;
  end;
end;

procedure TfrmMain.ExetableFileProtector1Click(Sender: TObject);
begin
  frmStamp.ShowModal;  
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitEmptyFeaturesInfo;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeFeaturesInfo;
end;

procedure TfrmMain.FreeFeaturesInfo;
var
  i: Integer;
begin
  for i := 0 to MAX_FEATURE - 1 do
  begin
    FeaturesInfo[i].Actions.Free;
  end;
end;

procedure TfrmMain.InitEmptyFeaturesInfo;
var
  i: Integer;
begin
  for i := 0 to MAX_FEATURE - 1 do
    with FeaturesInfo[i] do
    begin
      LicenseType := ltPermanent;
      ExpiredDate := Now;
      Actions := TStringList.Create;
    end;
end;

procedure TfrmMain.tvFeaturesChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.AbsoluteIndex = 0 then
  begin
    ShowAppPanel(PAppInfo(Node.Data)^);
  end
  else begin
    ShowFeaturePanel(PTFeatureInfo(Node.Data));
  end;
end;

procedure TfrmMain.ShowAppPanel(AppInfo: TAppInfo);
begin
  pnFeature.Visible := False;
  pnApplication.Visible := True;
  with AppInfo do
  begin
    edAppName.Text := AppName;
    edVersion.Text := Version;
    edBuildNo.Text := IntToStr(BuildNo);
    edDescription.Text := Description;
    if IsTemplate then
    begin
      lbDFP.Visible := False;
      edDFP.Visible := False;
      rbtnAPermanent.Enabled := False;
      rbtnADisable.Enabled := False;
      LicenseType := ltDemoExpired;
    end
    else begin
      lbDFP.Visible := True;
      edDFP.Visible := True;
      rbtnAPermanent.Enabled := True;
      rbtnADisable.Enabled := True;
    end;
    if LicenseType = ltPermanent then
      rbtnAPermanent.Checked := True
    else
      if LicenseType = ltDisable then
        rbtnADisable.Checked := True
      else begin
        rbtnAExpired.Checked := True;
        dtpkAExpired.Date := ExpiredDate;
        cbDemo.Enabled := not IsTemplate;
        cbDemo.Checked := IsTemplate;
      end;
  end;
end;

procedure TfrmMain.ShowFeaturePanel(PFeatureInfo: PTFeatureInfo);
var
  i: Integer;
begin
  pnApplication.Visible := False;
  pnFeature.Visible := True;
  with PFeatureInfo^ do
  begin
    edFeatureName.Text := Name;
    edFDescription.Text := Description;
    if LicenseType = ltPermanent then
      rbtnPermanent.Checked := True
    else
      if LicenseType = ltDisable then
        rbtnDisable.Checked := True
      else begin
        rbtnExpired.Checked := True;
        dtpkFExpired.Date := ExpiredDate;
      end;
    lbxFActions.Clear;
    for i := 0 to Actions.Count - 1 do
      lbxFActions.Items.Add(Actions[i]);
  end;
end;

procedure TfrmMain.rbtnAPermanentClick(Sender: TObject);
begin
  dtpkAExpired.Visible := False;
  cbDemo.Visible := False;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltPermanent
  end;
end;

procedure TfrmMain.rbtnADisableClick(Sender: TObject);
begin
  dtpkAExpired.Visible := False;
  cbDemo.Visible := False;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltDisable;
  end;
end;

procedure TfrmMain.rbtnAExpiredClick(Sender: TObject);
begin
  dtpkAExpired.Visible := True;
  cbDemo.Visible := True;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    dtpkAExpired.Date := ExpiredDate;
    LicenseType := ltExpired;
  end;
end;

procedure TfrmMain.dtpkAExpiredChange(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    ExpiredDate := dtpkAExpired.Date;
  end;
end;

procedure TfrmMain.cbDemoClick(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    if cbDemo.Checked then
      LicenseType := ltDemoExpired
    else
      LicenseType := ltExpired;
  end;
end;

procedure TfrmMain.rbtnPermanentClick(Sender: TObject);
begin
  dtpkFExpired.Visible := False;
  with PTFeatureInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltPermanent
  end;
end;

procedure TfrmMain.rbtnDisableClick(Sender: TObject);
begin
  dtpkFExpired.Visible := False;
  with PTFeatureInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltDisable;
  end;
end;

procedure TfrmMain.rbtnExpiredClick(Sender: TObject);
begin
  dtpkFExpired.Visible := True;
  with PTFeatureInfo(tvFeatures.Selected.Data)^ do
  begin
    dtpkFExpired.Date := ExpiredDate;
    LicenseType := ltExpired;
  end;
end;

procedure TfrmMain.GenerateFromRequest(const FileName: string);
var
  NumOfFeatures: Integer;
  NumOfActions: Integer;
  i, j : Integer;
  CharBuf: array[1..255] of Char;
  BufSize: Longint;
  sms, ems: TMemoryStream;
  ofs: TFileStream;
begin
  sms := TMemoryStream.Create;
  ems := TMemoryStream.Create;
  ofs := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
  ofs.Write(ELC_MAGIC, SizeOf(TLicenseMagic));
  with sms do
  begin
    try
      Write(AppInfo, SizeOf(AppInfo));
      NumOfFeatures := tvFeatures.Items.Count - 1;
      Write(NumOfFeatures, SizeOf(NumOfFeatures));
      for i := 0 to NumOfFeatures - 1 do
        with FeaturesInfo[i] do
        begin
          BufSize := StrToCharArray(Name, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);

          BufSize := StrToCharArray(Description, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);

          Write(LicenseType, SizeOf(LicenseType));
          Write(ExpiredDate, SizeOf(ExpiredDate));
          // Update Actions Data
          NumOfActions := Actions.Count;
          Write(NumOfActions, SizeOf(NumOfActions));
          for j := 0 to NumOfActions - 1 do
          begin
            BufSize := StrToCharArray(Name, CharBuf);
            Write(BufSize, SizeOf(BufSize));
            Write(CharBuf, BufSize);
          end;
        end;
        ems.CopyFrom(sms, 0);
        BufSize := StrToCharArray(edDFP.Text, CharBuf);
        Write(BufSize, SizeOf(BufSize));
        Write(CharBuf, BufSize);
        BufSize := PBKeyXChg.Info.BlobLen + SizeOf(PBKeyXChg.Info);
        Write(BufSize, SizeOf(BufSize));
        Write(PBKeyXChg, BufSize);
        with CryptoManager do
        begin
          Sign(sms);
          BufSize := StrToCharArray(CryptoManager.Signature, CharBuf);
          ems.Write(BufSize, SizeOf(BufSize));
          ems.Write(CharBuf, BufSize);
          ems.Seek(0, soFromBeginning);
          Encrypt(ems, ofs, True);
        end;
    finally
      Free;
    end;
  end;
  ofs.Free;
  ems.Free;
end;

procedure TfrmMain.GenerateFromTemplate(const FileName: string);
var
  NumOfFeatures: Integer;
  NumOfActions: Integer;
  i, j : Integer;
  CharBuf: array[1..255] of Char;
  BufSize: Longint;
  sms: TMemoryStream;
  ofs: TFileStream;
begin
  sms := TMemoryStream.Create;
  ofs := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
  with ofs do
  begin
    try
      Write(PLC_MAGIC, SizeOf(TLicenseMagic));
      Write(AppInfo, SizeOf(AppInfo));
      NumOfFeatures := tvFeatures.Items.Count - 1;
      Write(NumOfFeatures, SizeOf(NumOfFeatures));
      for i := 0 to NumOfFeatures - 1 do
        with FeaturesInfo[i] do
        begin
          BufSize := StrToCharArray(Name, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);

          BufSize := StrToCharArray(Description, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);

          Write(LicenseType, SizeOf(LicenseType));
          Write(ExpiredDate, SizeOf(ExpiredDate));
          // Update Actions Data
          NumOfActions := Actions.Count;
          Write(NumOfActions, SizeOf(NumOfActions));
          for j := 0 to NumOfActions - 1 do
          begin
            BufSize := StrToCharArray(Name, CharBuf);
            Write(BufSize, SizeOf(BufSize));
            Write(CharBuf, BufSize);
          end;
        end;
        ofs.Seek(SizeOf(TLicenseMagic), soFromBeginning);
        sms.CopyFrom(ofs, ofs.Size - ofs.Position);
        with CryptoManager do
        begin
          AcquireContext(True);
          Sign(sms);
          BufSize := StrToCharArray(CryptoManager.Signature, CharBuf);
          ofs.Write(BufSize, SizeOf(BufSize));
          ofs.Write(CharBuf, BufSize);
        end;
    finally
      Free;
    end;
  end;
  sms.Free;
end;

procedure TfrmMain.dtpkFExpiredChange(Sender: TObject);
begin
  with PTFeatureInfo(tvFeatures.Selected.Data)^ do
  begin
    ExpiredDate := dtpkFExpired.DateTime;
  end;
end;

end.
