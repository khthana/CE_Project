unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Menus, ImgList, ActnList, SLM_01, AppEvnts, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Processing1: TMenuItem;
    Conversion1: TMenuItem;
    Help1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N3: TMenuItem;
    SelectAll1: TMenuItem;
    Blur1: TMenuItem;
    Shapen1: TMenuItem;
    Edge1: TMenuItem;
    Histogram1: TMenuItem;
    Resize1: TMenuItem;
    Mirror1: TMenuItem;
    Rotate1: TMenuItem;
    About1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    actExit: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    actSelAll: TAction;
    actProcBlur: TAction;
    actProcShapen: TAction;
    actProcEdge: TAction;
    actProcHist: TAction;
    actTransResize: TAction;
    actTransMirror: TAction;
    actTransRotate: TAction;
    N4: TMenuItem;
    License1: TMenuItem;
    Information1: TMenuItem;
    Request1: TMenuItem;
    CryptoManager1: TCryptoManager;
    PublicKey1: TPublicKey;
    LicenseConfig1: TLicenseConfig;
    MainVerify1: TMainVerify;
    ActionsVerify1: TActionsVerify;
    procedure About1Click(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actEditCopyExecute(Sender: TObject);
    procedure actEditPasteExecute(Sender: TObject);
    procedure actSelAllExecute(Sender: TObject);
    procedure actProcBlurExecute(Sender: TObject);
    procedure actProcShapenExecute(Sender: TObject);
    procedure actProcEdgeExecute(Sender: TObject);
    procedure actProcHistExecute(Sender: TObject);
    procedure actTransResizeExecute(Sender: TObject);
    procedure actTransMirrorExecute(Sender: TObject);
    procedure actTransRotateExecute(Sender: TObject);
    procedure Information1Click(Sender: TObject);
    procedure Request1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm1.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TForm1.actFileNewExecute(Sender: TObject);
begin
  ShowMessage('File New Execute');
end;

procedure TForm1.actFileOpenExecute(Sender: TObject);
begin
  ShowMessage('File Open Execute');
end;

procedure TForm1.actFileSaveExecute(Sender: TObject);
begin
  ShowMessage('File Save Execute');
end;

procedure TForm1.actFileSaveAsExecute(Sender: TObject);
begin
  ShowMessage('File Save As Execute');
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actEditCutExecute(Sender: TObject);
begin
  ShowMessage('Edit Cut Execute');
end;

procedure TForm1.actEditCopyExecute(Sender: TObject);
begin
  ShowMessage('Edit Copy Execute');
end;

procedure TForm1.actEditPasteExecute(Sender: TObject);
begin
  ShowMessage('Edit Paste Execute');
end;

procedure TForm1.actSelAllExecute(Sender: TObject);
begin
  ShowMessage('Edit Select All Execute');
end;

procedure TForm1.actProcBlurExecute(Sender: TObject);
begin
  ShowMessage('Processing Blue Execute');
end;

procedure TForm1.actProcShapenExecute(Sender: TObject);
begin
  ShowMessage('Processing Shapen Execute');
end;

procedure TForm1.actProcEdgeExecute(Sender: TObject);
begin
  ShowMessage('Processing Edge Execute');
end;

procedure TForm1.actProcHistExecute(Sender: TObject);
begin
  ShowMessage('Processing Histrogram Execute');
end;

procedure TForm1.actTransResizeExecute(Sender: TObject);
begin
  ShowMessage('Transform Resize Execute');
end;

procedure TForm1.actTransMirrorExecute(Sender: TObject);
begin
  ShowMessage('Transform Mirror Execute');
end;

procedure TForm1.actTransRotateExecute(Sender: TObject);
begin
  ShowMessage('Transform Rotate Execute');
end;

procedure TForm1.Information1Click(Sender: TObject);
begin
  MainVerify1.ShowLicenseInfo;
end;

procedure TForm1.Request1Click(Sender: TObject);
begin
  LicenseConfig1.ShowRequestForm;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;end;

end.
