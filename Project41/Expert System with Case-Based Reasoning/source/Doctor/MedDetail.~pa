unit MedDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMedDetailForm = class(TForm)
    Label1: TLabel;
    MedName: TEdit;
    Detail: TMemo;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MedDetailForm: TMedDetailForm;
  MedNo : byte;

implementation
uses MainScreen;
{$R *.DFM}

procedure TMedDetailForm.FormShow(Sender: TObject);
begin
     Detail.Clear;
     If (MedNo > 0) and (MedNo <= NumMed) then
     begin
     MedName.Text := MedLib[MedNo].MedName;

     Detail.Lines.Add('คำแนะนำ');
     Detail.Lines.Add(MedLib[MedNo].MedDetail);
     Detail.Lines.Add('');
     Detail.Lines.Add('วิธีใช้ในผู้ใหญ่');
     Detail.Lines.Add(MedLib[MedNo].MedAdult);
     Detail.Lines.Add('');
     Detail.Lines.Add('วิธีใช้ในเด็ก');
     Detail.Lines.Add(MedLib[MedNo].MedYouth);
     end
     Else
         MedName.Text := ''
end;

procedure TMedDetailForm.Button1Click(Sender: TObject);
begin
     MedDetailForm.close;
end;

end.
