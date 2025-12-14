unit willow;

interface

uses
  Windows, Messages,Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,FmxUtils,sysutils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
i:integer;
PC: array[0..200] of Char;

begin
 WinExec(StrPCopy(PC,'f:\willowtalk\wiltalk.exe /Outfile:“f:\willowtalk\test.wav” /OutText:"pig good" /OutVoice:Betty'),SW_HIDE);
// ExecuteFile('wiltalk.exe',' /OutText:“Hello world!” /OutVoice:Betty  /AutoShutdown:on','f:\willowtalk\', SW_SHOW);
end;

end.
