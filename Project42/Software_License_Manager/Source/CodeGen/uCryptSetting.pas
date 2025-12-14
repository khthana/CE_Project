unit uCryptSetting;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TdlgCrypto = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    edContainer: TEdit;
    Label2: TLabel;
    edOwner: TEdit;
    cbbAlgo: TComboBox;
    Label3: TLabel;
    cbAutoSession: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgCrypto: TdlgCrypto;

implementation

{$R *.DFM}

end.
