unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, BPN, Massage;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    Edit1: TEdit;
    Label10: TLabel;
    Edit2: TEdit;
    Label11: TLabel;
    Edit3: TEdit;
    Label12: TLabel;
    Edit4: TEdit;
    procedure MassageFile(FileName: string; Mn,Mx,Up,Lw : real);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Main, Unit1, Unit2, Unit3, Unit5;

{$R *.DFM}

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form4.Close;
  Form3.Close;
  Form2.Close;
  Form1.Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form4.Close;
  Form3.Close;
  Form2.Close;
  Form1.Close;
end;

procedure TForm4.MassageFile(FileName: string; Mn,Mx,Up,Lw : real);
var
  Massager : Massage.TMassage;
  FManager : Massage.TManageFile;
begin
    Massager := Massage.TMassage.Create(FileName,Mn,Mx,Up,Lw);
    FManager := Massage.TManageFile.Create(FileName);
    Massage.EndFile := False;
    Massager.Massage(FManager.NumIP,FManager);
    FManager.Free;
    Massager.Free;
end;

procedure TForm4.Button1Click(Sender: TObject);
var
  F : TextFile;
begin
  if (Edit1.Text = '') or
     (Edit2.Text = '') or
     (Edit3.Text = '') or
     (Edit4.Text = '') then
  begin
     MessageDlg('Missing Input !  ' +
         'Please specify value for every input field.', mtError,[mbOK],0);
      Exit;
  end {if Edit.Text = ''}
  else if (StrToFloat(Edit1.Text) = 0.00) or
     (StrToInt(Edit3.Text) = 0) then
  begin
     MessageDlg('Invalid Input !  ' +
         '"Learning rate" and "Cycle for training" value must not be zero.'+
         chr(10) + 'Please specify valid input.',
         mtError,[mbOK],0);
      Exit;
  end {if LR or Cycle = 0 }
  else begin
    BPN.LR := StrToFloat(Edit1.text);
    BPN.Mo := StrToFloat(Edit2.text);
    Unit5.Cycles := StrToInt(Edit3.text);
    Unit5.Errors := StrToFloat(Edit4.text);
{Massage File}
{ - Input File}
    MassageFile(Main.InputFileName,0,99,1,0);
    AssignFile(F,Main.InputFileName);
    Erase(F);
    RenameFile(Massage.OutputFile,Main.InputFileName);
{ - Target File}
    MassageFile(Main.TargetFileName,0,99,1,0);
    AssignFile(F,Main.TargetFileName);
    Erase(F);
    RenameFile(Massage.OutputFile,Main.TargetFileName);
{Goto Next Form}
    Form4.Visible := false;
    Form5.ShowModal;
  end; {else begin }
end;

end.
