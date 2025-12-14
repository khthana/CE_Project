unit dxsound;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DXClass, DXSounds, StdCtrls, Wave;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    DXSound1: TDXSound;
    DXTimer1: TDXTimer;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    DXWaveList1: TDXWaveList;
    Button3: TButton;
    DXWave1: TDXWave;
    Button4: TButton;
    procedure Open1Click(Sender: TObject);
    procedure DXSound1Finalize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    audio:Taudiofilestream;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Open1Click(Sender: TObject);
begin
 if not Opendialog1.execute then exit;
  caption:=application.title +'File name='+
  ExtractFileName(Opendialog1.FileName);

  Dxsound1.initialize;
  audio:=taudiofilestream.create(dxsound1.dsound);
  audio.filename:=opendialog1.filename;
  



 end;

procedure TForm1.DXSound1Finalize(Sender: TObject);
begin
 audio.free;audio:=nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
audio.play;
audio.AutoUpdate:=true;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 audio.position:=0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
DXWaveList1.Items[1].play(false);
//DXWaveList.Items.Find(Name).Play(Wait);
end;

end.

