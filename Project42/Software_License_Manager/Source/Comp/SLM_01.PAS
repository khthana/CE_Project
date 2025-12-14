unit SLM_01;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, StdCtrls, Controls, Forms, Dialogs,
  ActnList, Appevnts, ExtCtrls, Wincrypt, CryptEMsg, uDFPAPI;

type
  TLicenseMagic = array[1..4] of Char;

const
  LTP_MAGIC: TLicenseMagic = 'LTP1';
  LRQ_MAGIC: TLicenseMagic = 'LRQ1';
  ELC_MAGIC: TLicenseMagic = 'ELC1';
  PLC_MAGIC: TLicenseMagic = 'PLC1';

  PROV_NAME = nil;
  PROV_TYPE = PROV_RSA_FULL;

  MAX_PKBLOB_LEN = 1024;
  MAX_SIMPBLOB_LEN = 256;
  MAX_HASH_LEN = 128;
  MAX_SIGNATURE_LEN = 128;

  BLOCK_SIZE = 160;
  BUFFER_SIZE = BLOCK_SIZE + 16; { For padding }

  DefTamperThreshold = 5;
  DefRenewalTime = 60;
  DefAutoRenew = True;

type
  TProviderType = (PROV_RSA_FULL, PROV_RSA_SIG, PROV_DSS, PROV_FORTEZZA, PROV_MS_MAIL);

  TSimpleBlob = array[1..MAX_SIMPBLOB_LEN] of Byte;

  TBlockBuffer = array[1..BUFFER_SIZE] of Byte;

  THashValue = array[1..MAX_HASH_LEN] of Byte;
  TSignature = array[1..MAX_SIGNATURE_LEN] of Byte;

  TPBKeyType = (pktXchg, pktSign, pktNone);

  TPBKInfo = packed record
               Owner: string[255];
               Container: string[255];
               KeyType: TPBKeyType;
               BlobLen: Longint;
             end;

  TPBKBlob = array[1..MAX_PKBLOB_LEN] of Byte;

  TPBKeyData = packed record
                 Info: TPBKInfo;
                 Blob: TPBKBlob;
               end;

  TBlobHeader = packed record
                  bType: Byte;
                  bVersion: Byte;
                  Reserved: Word;
                  aiKeyAlg: ALG_ID;
                end;

  TRSAPubKey = packed record
                 magic: LongWord;
                 bitlen: LongWord;
                 pubexp: LongWord;
               end;

  TDFPType = set of (dfpHDIDE, dfpLogHD, dfpMAC, dfpCPU);

  THashAlgo = (haMD2, haMD4, haMD5);

  THashOptions = (hoNone, hoSign, hoVerify);

  TLicenseType = (ltPermanent, ltExpired, ltDisable, ltDemoExpired);

  PAppInfo = ^TAppInfo;
  TAppInfo = packed record
               AppName: string[255];
               Version: string[15];
               BuildNo: Integer;
               Description: string[255];
               LicenseType: TLicenseType;
               ExpiredDate: TDateTime;
             end;

  TLicenseConfig = class;
  TPublicKey = class;

  TVerifiedSigEvent =
    procedure(Sender : TObject; Valid: Boolean)
    of object;

  TCryptoManager = class(TComponent)
  private
    FPBKeySig: HCRYPTKEY;
    FPBKeyXchg: HCRYPTKEY;
    FSessionKey: HCRYPTKEY;

    FProvHandle: HCRYPTPROV;
    FHashHandle: HCRYPTHASH;

    FContainerName: string;
    FHashAlgorithm: THashAlgo;
    FDFPType: TDFPType;

    FExchangeKey: TPublicKey;
    FVerifyKey: TPublicKey;
    XchgKeyHandle: HCRYPTKEY;
    VerifyKeyHandle: HCRYPTKEY;

    FOnVerified: TVerifiedSigEvent;
    FAutoSessionKey: Boolean;
    FOwnerName: string;
    procedure SetContainerName(const Value: string);
    function InitCryptoSystem(NewContainer: Boolean): Boolean;
    procedure FreeCryptoSystem;
    function InitUserKey: Boolean;
    procedure FreeUserKey;
    procedure SetHashAlgorithm(const Value: THashAlgo);
    function GetHashAlgo: ALG_ID;
    procedure SetDFPType(const Value: TDFPType);
    function HashData(Stream: TStream; Option: THashOptions): Boolean;
    procedure SetExchangeKey(const Value: TPublicKey);
    procedure SetVerifyKey(const Value: TPublicKey);
    procedure SetOnVerified(const Value: TVerifiedSigEvent);
    procedure UpdateKeyExchange;
    procedure UpdateKeyVerify;
    procedure SetAutoSessionKey(const Value: Boolean);
    procedure SetOwnerName(const Value: string);
    procedure DestroyKey(Key: HCRYPTKEY);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoOnVerified(Valid: Boolean); dynamic;
  public
    { Public declarations }
    HashValue: string;
    Signature: string;
    SignValid: Boolean;
    function GetSessionKey(var KeyData: TSimpleBlob; var Len: Longint): Boolean;
    function SetSessionKey(var KeyData: TSimpleBlob; var Len: Longint): Boolean;
    function GetUserKey(KeySpec: LongWord; var KeyData: TPBKBlob; var Len: Longint): Boolean;
    function ByteArrayToHex(var ByteArray: array of Byte; Len: Integer): string;
    function HexToString(Hex: string): string;
    function HexValueTable(h: Char): Byte;
    destructor Destroy; override;
    function AcquireContext(NewContainer: Boolean): Boolean;
    function ExportUserKey(KeySpec: LongWord; const PKFileName: string): Boolean; overload;
    function ExportUserKey(KeySpec: LongWord; var KeyData: TPBKeyData): Boolean; overload;
    function ImportPBKey(KeySpec: LongWord; const PKFileName: string): Boolean; overload;
    function ImportPBKey(KeySpec: LongWord; var KeyData: TPBKeyData): Boolean; overload;
    function GetDFP: string;
    function Hash(Stream: TStream): Boolean;
    function Sign(Stream: TStream): Boolean;
    procedure NewSessionKey;
    function ExportSessionKey(const FileName: string): Boolean;
    function VerifySignature(Stream: TStream): Boolean;
    function Encrypt(InStream, OutStream: TStream; NewSession: Boolean): Boolean;
    function Decrypt(InStream, OutStream: TStream): Boolean;
    procedure DefaultPublicKey;
  published
    { Published declarations }
    property Container: string read FContainerName write SetContainerName;
    property HashAlgorithm: THashAlgo read FHashAlgorithm write SetHashAlgorithm;
    property DFPType: TDFPType read FDFPType write SetDFPType;
    property VerifyKey: TPublicKey read FVerifyKey write SetVerifyKey;
    property ExchangeKey: TPublicKey read FExchangeKey write SetExchangeKey;
    property AutoSessionKey: Boolean read FAutoSessionKey write SetAutoSessionKey default True;
    property OwnerName: string read FOwnerName write SetOwnerName;

    { Events }
    property OnVerified : TVerifiedSigEvent read FOnVerified write SetOnVerified;
  end;

  TPublicKey = class(TComponent)
  private
    { Private declarations }
    procedure LoadCompProperty(Stream: TStream);
    procedure StoreCompProperty(Stream: TStream);
  protected
    { Protected declarations }
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    PublicKeyStream: TMemoryStream;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromStream(Stream: TStream);
    function GetKeyType: TPBKeyType;
  published
    { Published declarations }
  end;

  TFeature = class(TCollectionItem)
  private
    FName: string;
    FExpiredDate: TDate;
    FDescription: string;
    FLicenseType: TLicenseType;
    procedure SetName(const Value: string);
    procedure SetExpiredDate(const Value: TDate);
    procedure SetDescription(const Value: string);
    procedure SetLicenseType(const Value: TLicenseType);
    procedure LoadCompProperty(Reader: TReader);
    procedure StoreCompProperty(Writer: TWriter);
  protected
    function GetDisplayName: string; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    ActionList: TStringList;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ExpiredDate: TDate read FExpiredDate write SetExpiredDate;
    property LicenseType: TLicenseType read FLicenseType write SetLicenseType;    
  published
    property Name: string read FName write SetName;
    property Description: string read FDescription write SetDescription;
  end;

  TFeatures = class(TCollection)
  private
    FLicenseConfig: TLicenseConfig;
    function GetItem(Index: Integer): TFeature;
    procedure SetItem(Index: Integer; Value: TFeature);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(LicenseConfig: TLicenseConfig);
    function Add: TFeature;
    property Items[Index: Integer]: TFeature read GetItem write SetItem; default;
  end;

  TLicenseConfig = class(TComponent)
  private
    LicFileName: string;
    FFeatures: TFeatures;
    FActionList: TActionList;
    FCryptoManager: TCryptoManager;
    procedure LoadCompProperty(Stream: TStream);
    procedure StoreCompProperty(Stream: TStream);
    procedure SetFeatures(const Value: TFeatures);
    procedure SetActionList(const Value: TActionList);
    function GetActionByName(const Name: string): TAction;
    procedure InitFeatureActsByName;
    procedure SetCryptoManager(const Value: TCryptoManager);
    procedure InitCryptoManager;
    { Private declarations }
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    { Protected declarations }
  public
    AppInfo: TAppInfo;
    RequestMode: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetLocalInfo(var PBKeyXchg: TPBKeyData; var DFP: String);
    procedure SaveLicTemplate(const FileName: string);
    procedure SaveLicRequest(const FileName: string);
    procedure ShowRequestForm;
    function LoadLicenseFile(const FileName: string): Boolean;
    function StrToCharArray(const Str: string; var CharArray: array of Char): Longint;
    function BufCharToStr(BufChar: array of Char; Len: Integer): string;
    { Public declarations }
  published
    property Features: TFeatures read FFeatures write SetFeatures;
    property ActionList: TActionList read FActionList write SetActionList;
    property CryptoManager: TCryptoManager read FCryptoManager write SetCryptoManager;
    { Published declarations }
  end;

  TDisabledStyle = (dsDialog, dsHide, dsFreeze);

  TVerify = class(TCustomApplicationEvents)
  private
    FTamperPath: string;
    FCheckTimeTamper: Boolean;
    FTamperThreshold: Integer;
    FLicenseConfig: TLicenseConfig;
    procedure SetCheckTimeTamper(const Value: Boolean);
    procedure SetTamperThreshold(const Value: Integer);
    function GetTamperPath: string;
    procedure SetLicenseConfig(const Value: TLicenseConfig);
  protected
    function GetLastestFileTime(FindData: WIN32_FIND_DATA): TDateTime;
    function IsExpired(Date: TDate): Boolean;
    function DetermineTimeTamper(const FileFilter: string; Threshold: Integer): Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ShowLicenseInfo;
    function ShowDecisionMessage(const Msg, Suggest, OKCap, CancelCap: string): Boolean;
  published
    property LicenseConfig: TLicenseConfig read FLicenseConfig write SetLicenseConfig;
    property CheckTimeTamper: Boolean read FCheckTimeTamper write SetCheckTimeTamper;
    property TamperThreshold: Integer read FTamperThreshold write SetTamperThreshold
             default DefTamperThreshold;
  end;

  TActionsVerify = class(TVerify)
  private
    FDisabledStyle: TDisabledStyle;
    procedure ActionExeHandler(Action: TBasicAction; var Handled: Boolean);
    procedure ActionUpdateHandler(Action: TBasicAction; var Handled: Boolean);
    function SetDisabledAction(Action: TAction): Boolean;
    procedure SetDisabledStyle(const Value: TDisabledStyle);
    function ValidAction(Feature: TFeature; Action: TBasicAction): Boolean;
    function VerifyAction(Action: TBasicAction): Boolean;
    { Private declarations }
  protected
    procedure Loaded; override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function ActionInFeature(Features: TFeatures; Action: TBasicAction): Integer;
    { Public declarations }
  published
    property CheckTimeTamper;
    property TamperThreshold;
    property LicenseConfig;
    property DisabledStyle: TDisabledStyle read FDisabledStyle write SetDisabledStyle;
    { Published declarations }
  end;

  TMainVerify = class(TVerify)
  private
    First: Boolean;
    Timer: TTimer;
    FRenewalTime: Word;
    FLicenseFile: TFileName;
    FAutoRenew: Boolean;
    procedure MessageHandler(var Msg: TMsg; var Handled: Boolean);
    procedure RenewTimerHandler(Sender: TObject);
    procedure SetRenewalTime(const Value: Word);
    procedure SetLicenseFile(const Value: TFileName);
    procedure LoadAndVerifyLicenseFile;
    procedure SetAutoRenew(const Value: Boolean);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoRenew: Boolean read FAutoRenew write SetAutoRenew default DefAutoRenew;
    property CheckTimeTamper;
    property LicenseConfig;
    property TamperThreshold;
    property RenewalTime: Word read FRenewalTime write SetRenewalTime default DefRenewalTime;
    property LicenseFile: TFileName read FLicenseFile write SetLicenseFile;
  end;

implementation

uses
  uDisable, uLicInfo, uLicRequest;

{ TCryptoManager }

function TCryptoManager.AcquireContext(NewContainer: Boolean): Boolean;
begin
  Result := InitCryptoSystem(NewContainer);
  if Result then
    Result := InitUserKey;
  DefaultPublicKey;
end;

destructor TCryptoManager.Destroy;
begin
  FreeCryptoSystem;
  FreeUserKey;
  inherited Destroy;
end;

procedure TCryptoManager.FreeCryptoSystem;
begin
  if FSessionKey <> 0 then
    CryptDestroyKey(FSessionKey);

  if FHashHandle <> 0 then
    CryptDestroyHash(FHashHandle);

  if FProvHandle <> 0 then
    CryptReleaseContext(FProvHandle, 0);
end;

function TCryptoManager.InitUserKey: Boolean;
begin
  { Private/Public Key Signature }
  Result := CryptGetUserKey(FProvHandle, AT_SIGNATURE, @FPBKeySig);
  if (not Result) and (HRESULT(GetLastError) = NTE_NO_KEY) then
    Result := CryptGenKey(FProvHandle, AT_SIGNATURE, CRYPT_EXPORTABLE, @FPBKeySig);

  if not Result then Exit;

  { Private/Public Key Exchange }
  Result := CryptGetUserKey(FProvHandle, AT_KEYEXCHANGE, @FPBKeyXchg);
  if (not Result) and (HRESULT(GetLastError) = NTE_NO_KEY) then
     Result := CryptGenKey(FProvHandle, AT_KEYEXCHANGE, CRYPT_EXPORTABLE, @FPBKeyXchg);
end;

function TCryptoManager.GetDFP: string;
const
  MAX_LEN = 500;
var
  Len: Integer;
  IDStr: string;
  ss: TStringStream;
begin
  Result := '';

  if FProvHandle = 0 then Exit;

  if dfpHDIDE in DFPType then
  begin
    Len := MAX_LEN;
    SetLength(IDStr, Len);
    Len := GetHarddiskDFP(0, PChar(IDStr), Len);
    if Len <> -1 then
    begin
      SetLength(IDStr, Len);
      Result := Result + '[' + IDStr + ']';
    end;
  end;

  if dfpLogHD in DFPType then
  begin
    Len := MAX_LEN;
    SetLength(IDStr, Len);
    Len := GetLogicalDiskDFP('C', PChar(IDStr), Len);
    if Len <> -1 then
    begin
      SetLength(IDStr, Len);
      Result := Result + '[' + IDStr + ']';
    end;
  end;

  if dfpMAC in DFPType then
  begin
    Len := MAX_LEN;
    SetLength(IDStr, Len);
    Len := GetMACAddress(PChar(IDStr), Len);
    if Len <> -1 then
    begin
      SetLength(IDStr, Len);
      Result := Result + '[' + IDStr + ']';
    end;
  end;

  if dfpCPU in DFPType then
  begin
    Len := MAX_LEN;
    SetLength(IDStr, Len);
    Len := GetProcessorDFP(PChar(IDStr), Len);
    if Len <> -1 then
    begin
      SetLength(IDStr, Len);
      Result := Result + '[' + IDStr + ']';
    end;
  end;

  ss := TStringStream.Create(Result);
  Hash(ss);
  ss.Free;

  Result := HashValue;
end;

function TCryptoManager.InitCryptoSystem(NewContainer: Boolean): Boolean;
var
  ContainerName: PChar;
begin

  FreeCryptoSystem;

  { Convert Container name from string to PChar. }
  if FContainerName <> '' then
    ContainerName := PChar(FContainerName)
  else
    ContainerName := nil;

  Result := CryptAcquireContext(@FProvHandle, ContainerName, PROV_NAME,
                                PROV_TYPE, 0);
  if NewContainer and (not Result) and (HRESULT(GetLastError) = NTE_BAD_KEYSET) then
  begin
    Result := CryptAcquireContext(@FProvHandle, ContainerName, PROV_NAME,
                                PROV_TYPE, CRYPT_NEWKEYSET);
  end;

  if AutoSessionKey then
    NewSessionKey;
end;

procedure TCryptoManager.SetContainerName(const Value: string);
begin
  FContainerName := Value;
end;

function TCryptoManager.ExportUserKey(KeySpec: LongWord; const PKFileName: string): Boolean;
var
  UserKeyBlob: TPBKBlob;
  UserKeyLen: Longint;
  KeyInfo: TPBKInfo;
begin
  Result := GetUserKey(KeySpec, UserKeyBlob, UserKeyLen);

  if not Result then Exit;

  with KeyInfo do
  begin
    Owner := OwnerName;
    Container := Self.Container;
    if KeySpec = AT_SIGNATURE then
      KeyType := pktSign
    else
      KeyType := pktXchg;
    BlobLen := UserKeyLen;
  end;

  { Write UserKeyBlob Buffer to file via TFileStream. }
  with TFileStream.Create(PKFileName, fmCreate or fmOpenWrite) do
  begin
    Write(KeyInfo, SizeOf(KeyInfo));
    Write(UserKeyBlob, UserKeyLen);
    Free;
  end;
end;

function TCryptoManager.ImportPBKey(KeySpec: LongWord; const PKFileName: string): Boolean;
var
  ExtKeyLen: Longint;
  ExtKeyBlob: TPBKBlob;
  ExtKeyInfo: TPBKInfo;
  PExtKeyHandle: PHCRYPTKEY;
begin
  Result := False;

  if KeySpec = AT_SIGNATURE then
  begin
    CryptDestroyKey(VerifyKeyHandle);
    PExtKeyHandle := @VerifyKeyHandle;
  end
  else
    if KeySpec = AT_KEYEXCHANGE then
    begin
      DestroyKey(XchgKeyHandle);
      PExtKeyHandle := @XchgKeyHandle;
    end
    else Exit;

  { Open and read public key exchange from file. }
  with TFileStream.Create(PKFileName, fmOpenRead) do
  begin
    Read(ExtKeyInfo, SizeOf(TPBKInfo));
    ExtKeyLen := Read(ExtKeyBlob, ExtKeyInfo.BlobLen);
    Free;
  end;

  Result := CryptImportKey(FProvHandle, @ExtKeyBlob, ExtKeyLen, 0, 0, PExtKeyHandle);
end;

procedure TCryptoManager.FreeUserKey;
begin
  DestroyKey(FPBKeySig);
  DestroyKey(FPBKeyXchg);
end;

procedure TCryptoManager.SetHashAlgorithm(const Value: THashAlgo);
begin
  FHashAlgorithm := Value;
end;

function TCryptoManager.Hash(Stream: TStream): Boolean;
begin
  Result := HashData(Stream, hoNone);
end;

function TCryptoManager.GetHashAlgo: ALG_ID;
begin
  Result := 0;
  case FHashAlgorithm of
    haMD2: Result := CALG_MD2;
    haMD4: Result := CALG_MD4;
    haMD5: Result := CALG_MD5;
  end;
end;

function TCryptoManager.ByteArrayToHex(var ByteArray: array of Byte;
  Len: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Len - 1 do
  begin
    Result := Result + IntToHex(ByteArray[i], 2);
  end;
end;

procedure TCryptoManager.SetDFPType(const Value: TDFPType);
begin
  FDFPType := Value;
end;

function TCryptoManager.Sign(Stream: TStream): Boolean;
begin
  Result := HashData(Stream, hoSign);
end;

function TCryptoManager.HashData(Stream: TStream; Option: THashOptions): Boolean;
var
  HashHandle: HCRYPTHASH;
  HashLen: Longint;
  HashArray: THashValue;
  SignArray: TSignature;
  SignStr: string;
  SignLen: Longint;
begin
  Result := False;

  if FProvHandle = 0 then Exit;

  if not CryptCreateHash(FProvHandle, GetHashAlgo, 0, 0, @HashHandle) then
    Exit;

  with TMemoryStream.Create do
  begin
    try
      LoadFromStream(Stream);
      if not CryptHashData(HashHandle, PByte(Memory), Size, 0) then
      begin
        CryptDestroyHash(HashHandle);
        Exit;
      end;
    finally
      Free;
    end;
  end;

  if not CryptGetHashParam(HashHandle, HP_HASHVAL, nil, @HashLen, 0) then
  begin
    CryptDestroyHash(HashHandle);
    Exit;
  end
  else
    if not CryptGetHashParam(HashHandle, HP_HASHVAL, @HashArray, @HashLen, 0) then
    begin
      CryptDestroyHash(HashHandle);
      Exit;
    end;

  HashValue := ByteArrayToHex(HashArray, HashLen);

  { Sign Hash Option }
  if Option = hoSign then
  begin
    if not CryptSignHash(HashHandle, AT_SIGNATURE, PChar(''), 0, nil, @SignLen) then
    begin
      CryptDestroyHash(HashHandle);
      Exit;
    end
    else
      if not CryptSignHash(HashHandle, AT_SIGNATURE, PChar(''), 0, @SignArray, @SignLen) then
      begin
        CryptDestroyHash(HashHandle);
        Exit;
      end;

    Signature := ByteArrayToHex(SignArray, SignLen);
  end;

  if Option = hoVerify then
  begin
    SignStr := HexToString(Signature);
    SignLen := Length(SignStr);
    SignValid := CryptVerifySignature(HashHandle, PByte(SignStr), SignLen, VerifyKeyHandle, '', 0);
    DoOnVerified(SignValid);
  end;

  CryptDestroyHash(HashHandle);
  Result := True;
end;

procedure TCryptoManager.SetExchangeKey(const Value: TPublicKey);
begin
  if Value = nil then Exit;

  if Value.GetKeyType <> pktXchg then
  begin
    ShowMessage('This property must be Public Key Exchange type.');
    Exit;
  end;

  FExchangeKey := Value;
  if FProvHandle <> 0 then
    UpdateKeyExchange;

end;

procedure TCryptoManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then
  begin
    if AComponent is TPublicKey then
    begin
      if (AComponent as TPublicKey) = FVerifyKey then
      begin
        if XchgKeyHandle <> 0 then
          CryptDestroyKey(XchgKeyHandle);
        FVerifyKey := nil;
      end;
      if (AComponent as TPublicKey) = FExchangeKey then
      begin
        if VerifyKeyHandle <> 0 then
          CryptDestroyKey(VerifyKeyHandle);
        FExchangeKey := nil;
      end;
    end;
  end;
end;

procedure TCryptoManager.SetVerifyKey(const Value: TPublicKey);
begin
  if Value = nil then Exit;

  if Value.GetKeyType <> pktSign then
  begin
    ShowMessage('This property must be Public Key Signature type.');
    Exit;
  end;

  FVerifyKey := Value;
  if FProvHandle <> 0 then
    UpdateKeyVerify;
    
end;

function TCryptoManager.VerifySignature(Stream: TStream): Boolean;
begin
  Result := HashData(Stream, hoVerify);
end;

procedure TCryptoManager.SetOnVerified(const Value: TVerifiedSigEvent);
begin
  FOnVerified := Value;
end;

procedure TCryptoManager.DoOnVerified(Valid: Boolean);
begin
  if Assigned(FOnVerified) then
    FOnVerified(Self, Valid);
end;

procedure TCryptoManager.UpdateKeyExchange;
var
  PBKeyBlob: TPBKBlob;
begin
  if not Assigned(FExchangeKey) then Exit;

  DestroyKey(XchgKeyHandle);

  with FExchangeKey.PublicKeyStream do
  begin
    Seek(SizeOf(TPBKInfo), soFromBeginning);
    Read(PBKeyBlob, Size - SizeOf(TPBKInfo));
    CryptImportKey(FProvHandle, @PBKeyBlob, Size - SizeOf(TPBKInfo), 0, 0, @XchgKeyHandle);
  end;
end;

procedure TCryptoManager.UpdateKeyVerify;
var
  PBKeyBlob: TPBKBlob;
begin
  if not Assigned(FVerifyKey) then Exit;

  DestroyKey(VerifyKeyHandle);

  with FVerifyKey.PublicKeyStream do
  begin
    Seek(SizeOf(TPBKInfo), soFromBeginning);
    Read(PBKeyBlob, Size - SizeOf(TPBKInfo));
    CryptImportKey(FProvHandle, @PBKeyBlob, Size - SizeOf(TPBKInfo), 0, 0, @VerifyKeyHandle);
  end;
end;

function TCryptoManager.HexToString(Hex: string): string;
var
  i: Integer;
  temp: string;
begin
  i := 1;
  temp := '';
  while i < Length(Hex) do
  begin
    temp := temp + Char(HexValueTable(hex[i]) * 16 + HexValueTable(Hex[i + 1]));
    i := i + 2;
  end;
  Result := temp;
end;

function TCryptoManager.HexValueTable(h: Char): Byte;
const
  HexTable: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8',
                                    '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  i: Byte;
begin
  for i := 0 to 15 do
    if h = HexTable[i] then
      Break;
  Result := i;
end;

function TCryptoManager.ExportSessionKey(
  const FileName: string): Boolean;
var
  SimpBlob: TSimpleBlob;
  SimpBlobLen: Longint;
begin
  with TFileStream.Create(FileName, fmCreate or fmOpenWrite) do
  begin
    try
      Result := GetSessionKey(SimpBlob, SimpBlobLen);
      if Result then Write(SimpBlob, SimpBlobLen);
    finally
      Free;
    end;
  end;
end;

procedure TCryptoManager.NewSessionKey;
begin
  if FSessionKey <> 0 then
    CryptDestroyKey(FSessionKey);
  CryptGenKey(FProvHandle, CALG_RC2, CRYPT_EXPORTABLE, @FSessionKey);
end;

procedure TCryptoManager.SetAutoSessionKey(const Value: Boolean);
begin
  FAutoSessionKey := Value;
end;

procedure TCryptoManager.SetOwnerName(const Value: string);
begin
  FOwnerName := Value;
end;

function TCryptoManager.Encrypt(InStream, OutStream: TStream; NewSession: Boolean): Boolean;
var
  BlockBuffer: TBlockBuffer;
  NumRead: Integer;
  SessionBlob: TSimpleBlob;
  SessionLen: Longint;
begin
  if NewSession then
    NewSessionKey;
  Result := GetSessionKey(SessionBlob, SessionLen);

  if not Result then Exit;

  with OutStream do
  begin
    Write(SessionLen, SizeOf(SessionLen));
    Write(SessionBlob, SessionLen);
  end;

  repeat
    NumRead := InStream.Read(BlockBuffer, BLOCK_SIZE);
    if not CryptEncrypt(FSessionKey, 0, NumRead <> BLOCK_SIZE, 0, @BlockBuffer,
                        @NumRead, BUFFER_SIZE) then
    begin
      Result := False;
      Exit;
    end;
    OutStream.Write(BlockBuffer, NumRead);
  until (NumRead <> BLOCK_SIZE);
  Result := True;
end;

function TCryptoManager.GetSessionKey(var KeyData: TSimpleBlob; var Len: Integer): Boolean;
begin
  Result := False;
  if CryptExportKey(FSessionKey, XchgKeyHandle, SIMPLEBLOB, 0, nil, @Len) then
    Result := CryptExportKey(FSessionKey, XchgKeyHandle, SIMPLEBLOB, 0, @KeyData, @Len);
end;

function TCryptoManager.Decrypt(InStream, OutStream: TStream): Boolean;
var
  SessionBlob: TSimpleBlob;
  SessionLen: Longint;
  Buffer: TBlockBuffer;
  NumRead: Longint;
begin

  InStream.Read(SessionLen, SizeOf(SessionLen));
  InStream.Read(SessionBlob, SessionLen);

  Result := SetSessionKey(SessionBlob, SessionLen);

  if not Result then Exit;

  repeat
    NumRead := InStream.Read(Buffer, BLOCK_SIZE);
    if not CryptDecrypt(FSessionKey, 0, NumRead <> BLOCK_SIZE, 0, @Buffer, @NumRead) then
    begin
      Result := False;
      Exit;
    end;
    OutStream.Write(Buffer, NumRead);
  until NumRead <> BLOCK_SIZE;
  Result := True;
end;

function TCryptoManager.SetSessionKey(var KeyData: TSimpleBlob;
  var Len: Integer): Boolean;
begin
  DestroyKey(FSessionKey);
  Result := CryptImportKey(FProvHandle, @KeyData, Len, 0, 0, @FSessionKey);
end;

procedure TCryptoManager.DestroyKey(Key: HCRYPTKEY);
begin
  if Key <> 0 then
    CryptDestroyKey(Key);
end;

function TCryptoManager.GetUserKey(KeySpec: LongWord;
  var KeyData: TPBKBlob; var Len: Integer): Boolean;
var
  UserKeyHandle: HCRYPTKEY;
begin
  Result := False;
  if KeySpec = AT_SIGNATURE then
    UserKeyHandle := FPBKeySig
  else
    if KeySpec = AT_KEYEXCHANGE then
      UserKeyHandle := FPBKeyXchg
    else Exit;

  Result := CryptExportKey(UserKeyHandle, 0, PUBLICKEYBLOB, 0, nil, @Len);

  if not Result then Exit;

  Result := CryptExportKey(UserKeyHandle, 0, PUBLICKEYBLOB, 0, @KeyData, @Len);

end;

function TCryptoManager.ExportUserKey(KeySpec: LongWord;
  var KeyData: TPBKeyData): Boolean;
var
  UserKeyBlob: TPBKBlob;
  UserKeyLen: Longint;
  KeyInfo: TPBKInfo;
begin
  Result := GetUserKey(KeySpec, UserKeyBlob, UserKeyLen);

  if not Result then Exit;

  with KeyInfo do
  begin
    FillChar(Owner, SizeOf(Owner), 0);
    Owner := OwnerName;
    FillChar(Container, SizeOf(Container), 0);
    Container := Self.Container;
    if KeySpec = AT_SIGNATURE then
      KeyType := pktSign
    else
      KeyType := pktXchg;
    BlobLen := UserKeyLen;
  end;

  KeyData.Info := KeyInfo;
  KeyData.Blob := UserKeyBlob;

end;

function TCryptoManager.ImportPBKey(KeySpec: LongWord;
  var KeyData: TPBKeyData): Boolean;
var
  PExtKeyHandle: PHCRYPTKEY;
begin
  Result := False;

  if KeySpec = AT_SIGNATURE then
  begin
    CryptDestroyKey(VerifyKeyHandle);
    PExtKeyHandle := @VerifyKeyHandle;
  end
  else
    if KeySpec = AT_KEYEXCHANGE then
    begin
      DestroyKey(XchgKeyHandle);
      PExtKeyHandle := @XchgKeyHandle;
    end
    else Exit;

  Result := CryptImportKey(FProvHandle, @KeyData.Blob, KeyData.Info.BlobLen, 0, 0, PExtKeyHandle);

end;

procedure TCryptoManager.DefaultPublicKey;
begin
  UpdateKeyExchange;
  UpdateKeyVerify;
end;

{ TPublicKey }

procedure TPublicKey.LoadCompProperty(Stream: TStream);
begin
  PublicKeyStream.LoadFromStream(Stream);
end;

procedure TPublicKey.StoreCompProperty(Stream: TStream);
begin
  PublicKeyStream.SaveToStream(Stream);
end;

procedure TPublicKey.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then { check Ancestor for an inherited value }
      Result := False
    else { no inherited value -- check for default (nil) value }
      Result := True;
  end;
begin
  inherited; { allow base classes to define properties }
  Filer.DefineBinaryProperty('PublicKeyBlob', LoadCompProperty, StoreCompProperty, DoWrite);
end;

constructor TPublicKey.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PublicKeyStream := TMemoryStream.Create;
end;

destructor TPublicKey.Destroy;
begin
  PublicKeyStream.Free;
  inherited Destroy;
end;

procedure TPublicKey.LoadFromStream(Stream: TStream);
begin
  PublicKeyStream.LoadFromStream(Stream);
end;

function TPublicKey.GetKeyType: TPBKeyType;
var
  PBKInfo: TPBKInfo;
begin
  with PublicKeyStream do
  begin
    if Size = 0 then
    begin
      Result := pktNone;
      Exit;
    end;
    Position := 0;
    Read(PBKInfo, SizeOf(PBKInfo));
    Result := PBKInfo.KeyType;
  end;
end;

{ TLicenseConfig }

function TLicenseConfig.BufCharToStr(BufChar: array of Char;
  Len: Integer): string;
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

constructor TLicenseConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RequestMode := False;
  Features := TFeatures.Create(Self);
  with AppInfo do
  begin
    AppName := 'Application Name';
    Version := '1.00';
    BuildNo := 1;
    Description := 'Application description';
    LicenseType := ltPermanent;
    ExpiredDate := Now;
  end;
end;

procedure TLicenseConfig.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then { check Ancestor for an inherited value }
      Result := False
    else { no inherited value -- check for default (nil) value }
      Result := True;
  end;
begin
  inherited; { allow base classes to define properties }
  Filer.DefineBinaryProperty('AppInfo', LoadCompProperty, StoreCompProperty, DoWrite);
end;

destructor TLicenseConfig.Destroy;
begin
  inherited Destroy;
  Features.Free;
end;

function TLicenseConfig.GetActionByName(const Name: string): TAction;
begin
  Result := nil;
  if ActionList <> nil then
  begin
    Result := ActionList.Owner.FindComponent(Name) as TAction;
  end;
end;

procedure TLicenseConfig.GetLocalInfo(var PBKeyXchg: TPBKeyData;
  var DFP: String);
begin
  with CryptoManager do
  begin
    InitCryptoManager;
    DFP := GetDFP;
    ExportUserKey(AT_KEYEXCHANGE, PBKeyXchg);
  end;
end;

procedure TLicenseConfig.InitCryptoManager;
begin
  if CryptoManager = nil then Exit;

  CryptoManager.AcquireContext(True);
end;

procedure TLicenseConfig.InitFeatureActsByName;
var
  i, j: Integer;
begin
  for i := 0 to Features.Count - 1 do
    with Features[i] do
      for j := 0 to ActionList.Count - 1 do
        ActionList.Objects[j] := GetActionByName(ActionList[j]);
end;

procedure TLicenseConfig.LoadCompProperty(Stream: TStream);
begin
  Stream.ReadBuffer(AppInfo, SizeOf(TAppInfo));
end;

procedure TLicenseConfig.Loaded;
begin
  inherited Loaded;
  InitFeatureActsByName;
end;

function TLicenseConfig.LoadLicenseFile(const FileName: string): Boolean;
var
  PBKeyXchg: TPBKeyData;
  fs: TFileStream;
  ms, sms: TMemoryStream;
  Magic: TLicenseMagic;
  LicType: TLicenseType;
  Expired: TDate;
  FCount, ACount: Longint;
  i, j: Integer;
  BufSize: Longint;
  BufChar: array[1..255] of Char;
  DFPStr: string;
begin
  Result := False;

  if not FileExists(FileName) then Exit;

  LicFileName := FileName;

  if CryptoManager = nil then
  begin
    ShowMessage('This operation must have CryptoManager!!!');
    Exit;
  end;

  CryptoManager.AcquireContext(True);

  fs := TFileStream.Create(FileName, fmOpenRead);
  fs.Read(Magic, SizeOf(Magic));
  ms := TMemoryStream.Create;
  sms := TMemoryStream.Create;
  if Magic = ELC_MAGIC then
  begin
    CryptoManager.Decrypt(fs, ms);
    CryptoManager.ExportUserKey(AT_KEYEXCHANGE, PBKeyXchg);
  end
  else
    ms.CopyFrom(fs, fs.Size - fs.Position);

  ms.Seek(0, soFromBeginning);

  with ms do
  begin
    // Read Application Infromation from License File to Internal AppInfo.
    Read(AppInfo, SizeOf(AppInfo));
    sms.Write(AppInfo, SizeOf(AppInfo));
    // Read All Feature Infromation and set to internal.
    Read(FCount, SizeOf(FCount));
    sms.Write(FCount, SizeOf(FCount));
    for i := 0 to FCount - 1 do
    begin
      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      sms.Write(BufSize, SizeOf(BufSize));
      sms.Write(BufChar, BufSize);

      Features[i].Name := BufCharToStr(BufChar, BufSize);

      Read(BufSize, SizeOf(BufSize));
      Read(BufChar, BufSize);
      sms.Write(BufSize, SizeOf(BufSize));
      sms.Write(BufChar, BufSize);

      Features[i].Description := BufCharToStr(BufChar, BufSize);

      Read(LicType, SizeOf(LicType));
      sms.Write(LicType, SizeOf(LicType));

      Features[i].LicenseType := LicType;

      Read(Expired, SizeOf(Expired));
      sms.Write(Expired, SizeOf(Expired));

      Features[i].ExpiredDate := Expired;

      // Read all actions in current features[i] to internal.
      Read(ACount, SizeOf(ACount));
      sms.Write(ACount, SizeOf(ACount));
      if ACount <> -1 then
        for j := 0 to ACount - 1 do
        begin
          Read(BufSize, SizeOf(BufSize));
          Read(BufChar, BufSize);
          sms.Write(BufSize, SizeOf(BufSize));
          sms.Write(BufChar, BufSize);
        end;
    end;
    // Read License File Signature and set it to CryptoManager.
    Read(BufSize, SizeOf(BufSize));
    Read(BufChar, BufSize);
    CryptoManager.Signature := BufCharToStr(BufChar, BufSize);
  end;
  // Stamp Local Infromation (DFP & Local Public Key Exchange)
  if AppInfo.LicenseType <> ltDemoExpired then
  begin
    DFPStr := CryptoManager.GetDFP;
    BufSize := StrToCharArray(DFPStr, BufChar);
    sms.Write(BufSize, SizeOf(BufSize));
    sms.Write(BufChar, BufSize);
  end;
  if Magic = ELC_MAGIC then
  begin
    BufSize := SizeOf(PBKeyXchg.Info) + PBKeyXchg.Info.BlobLen;
    sms.Write(BufSize, SizeOf(BufSize));
    sms.Write(PBKeyXchg, BufSize);
  end;

  // Verify Signature
  if CryptoManager.VerifySignature(sms) then
    if CryptoManager.SignValid then
      Result := True;
  fs.Free;
  ms.Free;
  sms.Free;
end;

procedure TLicenseConfig.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent is TActionList then
    begin
        if AComponent = ActionList then
        begin
          ActionList := nil;
          for i := 0 to Features.Count - 1 do
            Features[i].ActionList.Clear;
        end;
    end
    else
      if (AComponent is TCryptoManager) and (AComponent = CryptoManager) then
        CryptoManager := nil;
  end;
end;

procedure TLicenseConfig.SaveLicRequest(const FileName: string);
var
  NumOfFeatures: Integer;
  NumOfActions: Integer;
  i, j: Integer;
  CharBuf: array[1..255] of Char;
  BufSize: Longint;
  PBKeyXchg: TPBKeyData;
  DFP: string;
begin
  if CryptoManager = nil then
  begin
    ShowMessage('This operation must have CryptoManager!!!');
    Exit;
  end;

  with TFileStream.Create(FileName, fmCreate or fmOpenWrite) do
  begin
    try
      Write(LRQ_MAGIC, SizeOf(TLicenseMagic));
      Write(AppInfo, SizeOf(AppInfo));

      NumOfFeatures := Features.Count;
      Write(NumOfFeatures, SizeOf(NumOfFeatures));
      for i := 0 to NumOfFeatures - 1 do
        with Features[i] do
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
          NumOfActions := ActionList.Count;
          Write(NumOfActions, SizeOf(NumOfActions));
          for j := 0 to NumOfActions - 1 do
            with TAction(ActionList.Objects[j]) do
            begin
              BufSize := StrToCharArray(Name, CharBuf);
              Write(BufSize, SizeOf(BufSize));
              Write(CharBuf, BufSize);
            end;
        end;
      GetLocalInfo(PBKeyXchg, DFP);
      BufSize := StrToCharArray(DFP, CharBuf);
      Write(BufSize, SizeOf(BufSize));
      Write(CharBuf, BufSize);
      BufSize := SizeOf(PBKeyXchg.Info) + PBKeyXchg.Info.BlobLen;
      Write(BufSize, SizeOf(BufSize));
      Write(PBKeyXchg, BufSize);
    finally
      Free;
    end;
  end;
end;

procedure TLicenseConfig.SaveLicTemplate(const FileName: string);
var
  NumOfFeatures: Integer;
  NumOfActions: Integer;
  i, j: Integer;
  CharBuf: array[1..255] of Char;
  BufSize: Longint;
begin
  with TFileStream.Create(FileName, fmCreate or fmOpenWrite) do
  begin
    try
      Write(LTP_MAGIC, SizeOf(TLicenseMagic));
      Write(AppInfo, SizeOf(AppInfo));
      NumOfFeatures := Features.Count;
      Write(NumOfFeatures, SizeOf(NumOfFeatures));
      for i := 0 to NumOfFeatures - 1 do
        with Features[i] do
        begin
          BufSize := StrToCharArray(Name, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);
          BufSize := StrToCharArray(Description, CharBuf);
          Write(BufSize, SizeOf(BufSize));
          Write(CharBuf, BufSize);
          // Update Actions Data
          NumOfActions := ActionList.Count;
          Write(NumOfActions, SizeOf(NumOfActions));
          for j := 0 to NumOfActions - 1 do
            with TAction(ActionList.Objects[j]) do
            begin
              BufSize := StrToCharArray(Name, CharBuf);
              Write(BufSize, SizeOf(BufSize));
              Write(CharBuf, BufSize);
            end;
        end;
    finally
      Free;
    end;
  end;
end;

procedure TLicenseConfig.SetActionList(const Value: TActionList);
begin
  FActionList := Value;
end;

procedure TLicenseConfig.SetCryptoManager(const Value: TCryptoManager);
begin
  if FCryptoManager <> Value then
  begin
    FCryptoManager := Value;
  end;
end;

procedure TLicenseConfig.SetFeatures(const Value: TFeatures);
begin
  FFeatures := Value;
end;

procedure TLicenseConfig.ShowRequestForm;
begin
  with TfrmLicRequest.Create(Application) do
  begin
    RequestMode := True;
    LicenseConfig := Self;
    ShowModal;
    LoadLicenseFile(LicFileName);
    RequestMode := False;
  end;
end;

procedure TLicenseConfig.StoreCompProperty(Stream: TStream);
begin
  Stream.WriteBuffer(AppInfo, SizeOf(TAppInfo));
end;

function TLicenseConfig.StrToCharArray(const Str: string;
  var CharArray: array of Char): Longint;
var
  i: Integer;
begin
  Result := Length(Str);
  for i := 1 to Result do
    CharArray[i - 1] := Str[i];
end;

{ TFeature }

procedure TFeature.Assign(Source: TPersistent);
begin
  if Source is TFeature then
  begin
    Name := TFeature(Source).Name;
  end
  else inherited Assign(Source);
end;

constructor TFeature.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if Collection <> nil then
    FName := 'Feature ' + IntToStr(Collection.Count);
  FExpiredDate := Now;
  ActionList := TStringList.Create;
end;

procedure TFeature.DefineProperties(Filer: TFiler);
  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then { check Ancestor for an inherited value }
      Result := False
    else { no inherited value -- check for default (nil) value }
      Result := True;
  end;
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('FeatureActs', LoadCompProperty, StoreCompProperty, DoWrite);
end;

destructor TFeature.Destroy;
begin
  ActionList.Free;
  inherited Destroy;
end;

function TFeature.GetDisplayName: string;
begin
  Result := Name;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TFeature.LoadCompProperty(Reader: TReader);
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
  begin
    ActionList.Add(Reader.ReadString);
  end;
  Reader.ReadListEnd;
end;

procedure TFeature.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TFeature.SetExpiredDate(const Value: TDate);
begin
  FExpiredDate := Value;
end;

procedure TFeature.SetLicenseType(const Value: TLicenseType);
begin
  FLicenseType := Value;
end;

procedure TFeature.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
  end;
end;

procedure TFeature.StoreCompProperty(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to ActionList.Count - 1 do
    Writer.WriteString((ActionList.Objects[i] as TAction).Name);
  Writer.WriteListEnd;
end;

{ TFeatures }

function TFeatures.Add: TFeature;
begin
  Result := TFeature(inherited Add);
end;

constructor TFeatures.Create(LicenseConfig: TLicenseConfig);
begin
  inherited Create(TFeature);
  FLicenseConfig := LicenseConfig;
end;

function TFeatures.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'Description';
  else
    Result := '';
  end;
end;

function TFeatures.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TFeatures.GetItem(Index: Integer): TFeature;
begin
  Result := TFeature(inherited GetItem(Index));
end;

function TFeatures.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].Name;
    1: Result := Items[ItemIndex].Description;
  else
    Result := '';
  end;
end;

function TFeatures.GetOwner: TPersistent;
begin
  Result := FLicenseConfig;
end;

procedure TFeatures.SetItem(Index: Integer; Value: TFeature);
begin
  inherited SetItem(Index, Value);
end;

procedure TFeatures.Update(Item: TCollectionItem);
begin
  inherited;
end;

{ TActionsVerify }

procedure TActionsVerify.ActionExeHandler(Action: TBasicAction;
  var Handled: Boolean);
begin
  Handled := not VerifyAction(Action);
end;

function TActionsVerify.ActionInFeature(Features: TFeatures;
  Action: TBasicAction): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  for i := 0 to Features.Count - 1 do
    with Features[i] do
    begin
      for j := 0 to ActionList.Count - 1 do
      begin
        if ActionList.IndexOf((Action as TAction).Name) <> -1 then
        begin
          Result := i;
          Exit;
        end;
      end;
    end;
end;

constructor TActionsVerify.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TVerify.IsExpired(Date: TDate): Boolean;
begin
  if FCheckTimeTamper then
  begin
    if DetermineTimeTamper(FTamperPath, FTamperThreshold) then
    begin
      ShowMessage('Your system time has tampered!!!');
      Application.Terminate;
    end;
  end;
  Result := Date <= Now;
end;

function TActionsVerify.SetDisabledAction(Action: TAction): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Assigned(LicenseConfig) then
    for i := 0 to LicenseConfig.Features.Count - 1 do
      with LicenseConfig.Features[i] do
      begin
          if (LicenseType <> ltPermanent) and
             ((LicenseType = ltDisable) or IsExpired(ExpiredDate)) then
            if ActionList.IndexOf(Action.Name) <> -1 then
            begin
              case DisabledStyle of
                dsHide  : Action.Visible := False;
                dsFreeze: Action.Enabled := False;
              end;
              Result := True;
            end;
      end;
end;

procedure TActionsVerify.SetDisabledStyle(const Value: TDisabledStyle);
begin
  FDisabledStyle := Value;
end;

function TActionsVerify.ValidAction(Feature: TFeature;
  Action: TBasicAction): Boolean;
begin
  Result := True;
  with Feature do
  begin
    if LicenseType = ltPermanent then
    begin
      Result := True;
      Exit;
    end;
    if LicenseType = ltDisable then
    begin
      Result := False;
      if ShowDecisionMessage('This action has disabled',
                             'You must be request new license code file from vendor',
                             'Request', 'Cancel') then
        LicenseConfig.ShowRequestForm;
      Exit;
    end;
    if LicenseType = ltExpired then
    begin
      if IsExpired(ExpiredDate) then
      begin
        Result := False;
      if ShowDecisionMessage('This action has expired',
                             'You must be request new license code file from vendor',
                             'Request', 'Cancel') then
        LicenseConfig.ShowRequestForm;
      end
      else
        Result := True;
    end;
  end;
end;

function TActionsVerify.VerifyAction(Action: TBasicAction): Boolean;
var
  FeatureIndex: Integer;
begin
  Result := True;
  if Assigned(LicenseConfig) then
  begin
    with LicenseConfig do
    begin
      FeatureIndex := ActionInFeature(Features, Action);
      if FeatureIndex = -1 then
      begin
        Result := False;
        Exit;
      end;
      Result := ValidAction(Features[FeatureIndex], Action);
    end;
  end;
end;

procedure TActionsVerify.ActionUpdateHandler(Action: TBasicAction;
  var Handled: Boolean);
begin
  Handled := SetDisabledAction(Action as TAction);
end;

procedure TActionsVerify.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then
  begin
    OnActionExecute := ActionExeHandler;
    if DisabledStyle <> dsDialog then
      OnActionUpdate := ActionUpdateHandler;
  end;
end;

{ TMainVerify }

constructor TMainVerify.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  First := True;
  RenewalTime := DefRenewalTime;
  AutoRenew := DefAutoRenew;
  if not (csDesigning in ComponentState) then
  begin
    Timer := TTimer.Create(Self);
    Timer.Interval := RenewalTime * 1000;
    Timer.OnTimer := RenewTimerHandler;
    Timer.Enabled := False;
  end;
  OnMessage := MessageHandler;
end;

destructor TMainVerify.Destroy;
begin
  Timer.Free;
  inherited Destroy;
end;

procedure TMainVerify.LoadAndVerifyLicenseFile;
begin
  if LicenseConfig <> nil then
    with LicenseConfig do
    begin
      if not RequestMode then
      begin
        if not LoadLicenseFile(LicenseFile) then
        begin
          if ShowDecisionMessage('License code file has tampered or invalid signature',
                                 'You must be request new license code file from vendor',
                                 'Request', 'Quit') then
            ShowRequestForm;
          Application.Terminate;
        end;

        case AppInfo.LicenseType of
          ltPermanent: ;
          ltDisable: begin
                      if ShowDecisionMessage('This Applicaton has disabled',
                                             'You must be request new license code file from vendor',
                                             'Request', 'Quit') then
                         ShowRequestForm;
                       Application.Terminate;
                     end;
          ltExpired, ltDemoExpired:
                     if IsExpired(AppInfo.ExpiredDate) then
                     begin
                      if ShowDecisionMessage('This Applicaton has expired',
                                             'You must be request new license code file from vendor',
                                             'Request', 'Quit') then
                         ShowRequestForm;
                       Application.Terminate;
                     end;
        end;
      end;
    end;
end;

procedure TMainVerify.Loaded;
begin
  inherited Loaded;
end;

procedure TMainVerify.MessageHandler(var Msg: TMsg; var Handled: Boolean);
begin
  if not (csDesigning in ComponentState) then
    if First then
    begin
      First := False;
      LoadAndVerifyLicenseFile;
      if AutoRenew then
        Timer.Enabled := True;
    end;
end;

procedure TMainVerify.SetAutoRenew(const Value: Boolean);
begin
  FAutoRenew := Value;
end;

procedure TMainVerify.SetLicenseFile(const Value: TFileName);
begin
  FLicenseFile := Value;
end;

procedure TMainVerify.SetRenewalTime(const Value: Word);
begin
  if Value < 10 then
    FRenewalTime := DefRenewalTime
  else
    FRenewalTime := Value;

  if Timer <> nil then
    Timer.Interval := FRenewalTime * 1000;
end;

procedure TMainVerify.RenewTimerHandler(Sender: TObject);
begin
  Timer.Enabled := False;
  LoadAndVerifyLicenseFile;
  Timer.Enabled := True;  
end;

{ TVerify }

constructor TVerify.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TamperThreshold := DefTamperThreshold;
  FTamperPath := GetTamperPath;
end;

function TVerify.GetTamperPath: string;
var
  WinDir: string;
begin
  SetLength(WinDir, MAX_PATH);
  SetLength(WinDir, GetWindowsDirectory(PChar(WinDir), MAX_PATH));
  Result := WinDir + '\*.*';
end;

function TVerify.DetermineTimeTamper(const FileFilter: string;
  Threshold: Integer): Boolean;
var
  FindHandle: THandle;
  FindData: WIN32_FIND_DATA;
  Count: Integer;
  BaseTime, LastestTime: TDateTime;
begin
  Count := 0;
  BaseTime := Now;
  FindHandle := FindFirstFile(PChar(FileFilter), FindData);
  LastestTime := GetLastestFileTime(FindData);
  if LastestTime > BaseTime then
    Inc(Count);
  while FindNextFile(FindHandle, FindData) do
  begin
    LastestTime := GetLastestFileTime(FindData);
    if LastestTime > BaseTime then
      Inc(Count);
  end;
  Windows.FindClose(FindHandle);
  Result := Count > Threshold;
end;

function TVerify.GetLastestFileTime(FindData: WIN32_FIND_DATA): TDateTime;
var
  LocCreateTime, LocAccessTime, LocWriteTime: FILETIME;
  SysCreateTime, SysAccessTime, SysWriteTime: SYSTEMTIME;
  CreateTime, AccessTime, WriteTime: TDateTime;
begin
  with FindData do
  begin
    FileTimeToLocalFileTime(ftCreationTime, LocCreateTime);
    FileTimeToLocalFileTime(ftLastAccessTime, LocAccessTime);
    FileTimeToLocalFileTime(ftLastWriteTime, LocWriteTime);
  end;
  FileTimeToSystemTime(LocCreateTime, SysCreateTime);
  FileTimeToSystemTime(LocAccessTime, SysAccessTime);
  FileTimeToSystemTime(LocWriteTime, SysWriteTime);

  CreateTime := SystemTimeToDateTime(SysCreateTime);
  AccessTime := SystemTimeToDateTime(SysAccessTime);
  WriteTime := SystemTimeToDateTime(SysWriteTime);
  Result := AccessTime;
  if WriteTime > Result then
    Result := WriteTime;
  if CreateTime > Result then
    Result := CreateTime;
end;

procedure TVerify.SetCheckTimeTamper(const Value: Boolean);
begin
  FCheckTimeTamper := Value;
end;

procedure TVerify.SetTamperThreshold(const Value: Integer);
begin
  FTamperThreshold := Value;
end;

procedure TVerify.SetLicenseConfig(const Value: TLicenseConfig);
begin
  FLicenseConfig := Value;
end;

procedure TVerify.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if (AComponent is TLicenseConfig) and (AComponent = LicenseConfig) then
      LicenseConfig := nil;
end;

procedure TVerify.ShowLicenseInfo;
begin
  with TfrmLicInfo.Create(Application) do
  begin
    LicenseConfig := Self.LicenseConfig;
    ShowModal;
  end;
end;

function TVerify.ShowDecisionMessage(const Msg, Suggest, OKCap, CancelCap: string): Boolean;
begin
  with TdlgDecision.Create(Application) do
  begin
    lbMessage.Caption := Msg;
    lbHint.Caption := Suggest;
    if OKCap <> '' then
      OKBtn.Caption := OKCap;
    if CancelCap <> '' then
      CancelBtn.Caption := CancelCap;
    Result := ShowModal = mrOK;
  end;
end;

end.
