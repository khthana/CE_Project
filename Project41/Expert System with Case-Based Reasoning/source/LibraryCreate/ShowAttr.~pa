unit ShowAttr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TShowForm = class(TForm)
    CaseNoLabel: TLabel;
    CaseNo: TEdit;
    ShowButton: TButton;
    CloseButton: TButton;
    SolNoLabel: TLabel;
    AttrLabel: TLabel;
    PreviousButton: TButton;
    NextButton: TButton;
    SolNo: TEdit;
    Attr: TEdit;
    procedure ShowButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShowForm: TShowForm;
  NoCase : Word;

implementation

{$R *.DFM}
uses AttrMain;

procedure CaseShow(No : Word);
var
   AndPtr : AndFeat;
   OrPtr : OrFeat;
   AttrStr : String;
   FeatTemp : String;
   AttrTemp : String;
   TempStr : String;
begin
     Str(No,TempStr);
     ShowForm.CaseNo.Text := TempStr;
     NoCase := No;
     Str(CaseLib[No].SolNo,TempStr);
     ShowForm.SolNo.Text := TempStr;
     AndPtr := CaseLib[No].Feature;
     AttrStr := '';
     While AndPtr <> Nil do
     begin
          OrPtr := AndPtr^.GroupOr;
          AttrStr := AttrStr + '(';
          While OrPtr <> Nil do
          begin
               Str(OrPtr^.Feat,FeatTemp);
               Str(OrPtr^.Attr,AttrTemp);
               AttrStr := AttrStr + FeatTemp + ':' + AttrTemp;
               OrPtr := OrPtr^.NextOr;
               If OrPtr = Nil then
                  AttrStr := AttrStr + ')'
               Else
                   AttrStr := AttrStr + ' V ';
          end;
          AndPtr := AndPtr^.NextAnd;
          If AndPtr <> Nil then
             AttrStr := AttrStr + ' ^ ';
     end;
     ShowForm.Attr.Text := AttrStr;
end;

procedure TShowForm.ShowButtonClick(Sender: TObject);
var
   Error : integer;
   No : Word;
begin
     Val(ShowForm.CaseNo.Text ,No,Error);
     If (Error = 0) and (No < AttrMain.Index) then
        CaseShow(No);
end;

procedure TShowForm.CloseButtonClick(Sender: TObject);
begin
     AttrForm.show;
     ShowForm.close;
     ShowForm.CaseNo.Text := '';
     ShowForm.SolNoLabel.caption := '';
     ShowForm.AttrLabel.caption := '';
end;


procedure TShowForm.PreviousButtonClick(Sender: TObject);
var
   No : Word;
begin
     No := NoCase - 1;
     If (No >= 1) and (No < AttrMain.Index) then
        CaseShow(No);
end;

procedure TShowForm.NextButtonClick(Sender: TObject);
var
   No : Word;
begin
     No := NoCase + 1;
     If No < AttrMain.Index then
          CaseShow(No);
end;
end.
