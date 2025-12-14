unit uPublicKey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SLM_01;

type
  TfrmPBKeyDlg = class(TForm)
    btnOK: TButton;
    odlgPublicKey: TOpenDialog;
    GroupBox1: TGroupBox;
    btnChange: TButton;
    lbOwner: TLabel;
    edOwner: TEdit;
    Label3: TLabel;
    edType: TEdit;
    Label4: TLabel;
    edVersion: TEdit;
    Label5: TLabel;
    edPubExpo: TEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    edBitLen: TEdit;
    Label2: TLabel;
    edContainer: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ShowKeyInfo;
  public
    { Public declarations }
    PublicKeyStream: TMemoryStream;
  end;

implementation

{$R *.DFM}

procedure TfrmPBKeyDlg.FormCreate(Sender: TObject);
begin
  PublicKeyStream := TMemoryStream.Create;
end;

procedure TfrmPBKeyDlg.FormDestroy(Sender: TObject);
begin
  PublicKeyStream.Free;
end;

procedure TfrmPBKeyDlg.btnChangeClick(Sender: TObject);
var
  fs: TFileStream;
begin
  if odlgPublicKey.Execute then
  begin
    fs := TFileStream.Create(odlgPublicKey.FileName, fmOpenRead);
    PublicKeyStream.LoadFromStream(fs);
    fs.Free;
  end;
  ShowKeyInfo;
end;

procedure TfrmPBKeyDlg.FormActivate(Sender: TObject);
begin
  ShowKeyInfo;
end;

procedure TfrmPBKeyDlg.ShowKeyInfo;
var
  PBKInfo: TPBKInfo;
  BlobHeader: TBlobHeader;
  RSAPubKey: TRSAPubKey;
begin
  with PublicKeyStream do
  begin
    if Size = 0 then
    begin
      edOwner.Text := '';
      edContainer.Text := '';
      edType.Text := '';
      edVersion.Text := '';
      edPubExpo.Text := '';
      edBitLen.Text := '';
    end
    else begin
      Position := 0;
      Read(PBKInfo, SizeOf(PBKInfo));
      Read(BlobHeader, SizeOf(BlobHeader));
      Read(RSAPubKey, SizeOf(RSAPubKey));

      edOwner.Text := PBKInfo.Owner;
      edContainer.Text := PBKInfo.Container;
      if PBKInfo.KeyType = pktSign then
        edType.Text := 'Signature'
      else
        edType.Text := 'Exchange';
              
      edVersion.Text := IntToStr(BlobHeader.bVersion);
      edPubExpo.Text := IntToStr(RSAPubKey.pubexp);
      edBitLen.Text := IntToStr(RSAPubKey.bitlen);
    end;
  end;

end;

end.
