unit uDisable;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TdlgDecision = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    lbMessage: TLabel;
    lbHint: TLabel;
    Bevel2: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgDecision: TdlgDecision;

implementation

{$R *.DFM}

end.
