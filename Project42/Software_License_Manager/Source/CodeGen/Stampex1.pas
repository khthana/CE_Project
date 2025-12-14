unit Stampex1;

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,
  ProEXE, ComCtrls;

type
  TfrmStamp = class(TForm)
    FileEd: TEdit;
    BrowseBtn: TBitBtn;
    StampBtn: TBitBtn;
    CloseBtn: TBitBtn;
    ClearBtn: TBitBtn;
    OpenDialog1: TOpenDialog;
    EraseMarkerCb: TCheckBox;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    procedure BrowseBtnClick(Sender: TObject);
    procedure StampBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure FileEdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStamp: TfrmStamp;

implementation

{$R *.DFM}

procedure TfrmStamp.BrowseBtnClick(Sender: TObject);
begin
  OpenDialog1.FileName := FileEd.Text;
  if OpenDialog1.Execute then
    FileEd.Text := OpenDialog1.Filename;
end;

procedure TfrmStamp.StampBtnClick(Sender: TObject);
begin
  if FileEd.Text <> '' then
    if ProtectExe(FileEd.Text, EraseMarkerCb.Checked) then
      StatusBar1.SimpleText := 'File marked'
    else
      StatusBar1.SimpleText := 'Error while attemping to mark file';
end;

procedure TfrmStamp.ClearBtnClick(Sender: TObject);
begin
  if FileEd.Text <> '' then
    if UnprotectExe(FileEd.Text) then
      StatusBar1.SimpleText := 'EXE file signature record reset'
    else
      StatusBar1.SimpleText := 'Error while attemping to reset signature record';
end;

procedure TfrmStamp.FileEdChange(Sender: TObject);
begin
  StampBtn.Enabled := FileExists(FileEd.Text);
  ClearBtn.Enabled := FileExists(FileEd.Text);
  if FileExists(FileEd.Text) then
    StatusBar1.SimpleText := 'Valid filename'
  else
    StatusBar1.SimpleText := 'Invalid filename';
end;

procedure TfrmStamp.FormCreate(Sender: TObject);
begin
  StatusBar1.SimpleText := '';
  FileEdChange(Sender);
end;

end.
