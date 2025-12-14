unit Uremote;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFremote = class(TForm)
    EditIP: TEdit;
    EditPort: TEdit;
    OK: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure OKClick(Sender: TObject);
    procedure EditIPKeyPress(Sender: TObject; var Key: Char);
    procedure EditPortKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fremote: TFremote;

implementation
 Uses UClient;

{$R *.DFM}

procedure TFremote.OKClick(Sender: TObject);
begin
 With FClient do
 begin
  { Denote Text to Public Variable IP_Text,Port_Text }
  IP_Text   := EditIP.Text;
  Port_Text := EditPort.Text;
 End;
 Close; { Close Form Remote }
end;

procedure TFremote.EditIPKeyPress(Sender: TObject; var Key: Char);
begin
 { Change Focus }
 IF Key = Chr(13) Then EditPort.SetFocus;
end;

procedure TFremote.EditPortKeyPress(Sender: TObject; var Key: Char);
begin
 If Key = Chr(13) Then Ok.Setfocus;
end;

end.
