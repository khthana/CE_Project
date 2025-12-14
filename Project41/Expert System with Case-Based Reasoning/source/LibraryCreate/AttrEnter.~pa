unit AttrEnter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAttrEnterForm = class(TForm)
    AttrNoLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Feat1: TEdit;
    Feat2: TEdit;
    Feat3: TEdit;
    Feat4: TEdit;
    Feat5: TEdit;
    Feat6: TEdit;
    Feat7: TEdit;
    Feat8: TEdit;
    Attr1: TEdit;
    Attr2: TEdit;
    Attr3: TEdit;
    Attr4: TEdit;
    Attr5: TEdit;
    Attr6: TEdit;
    Attr7: TEdit;
    Attr8: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    AndButton: TButton;
    EndButton: TButton;
    procedure EndButtonClick(Sender: TObject);
    procedure AndButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AttrEnterForm: TAttrEnterForm;
  NoOfAttr : Byte;

implementation

uses AttrMain;

{$R *.DFM}















procedure TAttrEnterForm.EndButtonClick(Sender: TObject);
begin
     AttrForm.show;
     AttrEnterForm.Close;
     If CaseLib[Index].Feature <> Nil then
     begin
          AttrForm.AttrButton.Enabled := False;
          AttrForm.OkButton.Enabled := True;
          NoOfAttr := 1;
     end;
end;

procedure createOrNode(Feat,Attr : String;var OrPtr : OrFeat);
var
   Error : Integer;
begin
     Val(Feat,OrPtr^.Feat,Error);
     Val(Attr,OrPtr^.Attr,Error);
     OrPtr^.NextOr := Nil;
end;

procedure TAttrEnterForm.AndButtonClick(Sender: TObject);
var
   AndPtr : AndFeat;
   OrPtr : OrFeat;
   TempStr : String;
begin
     If (Feat1.text <> '') and (Attr1.text <> '') then
     Begin
          If CaseLib[Index].Feature = Nil then
          begin
             New(CaseLib[Index].Feature);
             AndPtr := CaseLib[Index].Feature;
          end
          Else
          begin
               AndPtr := CaseLib[Index].Feature;
               While AndPtr^.NextAnd <> Nil do
                     AndPtr := AndPtr^.NextAnd;
               New(AndPtr^.NextAnd);
               AndPtr := AndPtr^.NextAnd;
          end;

          AndPtr^.NextAnd := Nil;
          New(AndPtr^.GroupOr);
          OrPtr := AndPtr^.GroupOr;
          createOrNode(Feat1.text,Attr1.text,OrPtr);
          If (Feat2.text <> '') and (Attr2.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat2.text,Attr2.text,OrPtr);
          end;
          If (Feat3.text <> '') and (Attr3.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat3.text,Attr3.text,OrPtr);
          end;
          If (Feat4.text <> '') and (Attr4.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat4.text,Attr4.text,OrPtr);
          end;
          If (Feat5.text <> '') and (Attr5.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat5.text,Attr5.text,OrPtr);
          end;
          If (Feat6.text <> '') and (Attr6.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat6.text,Attr6.text,OrPtr);
          end;
          If (Feat7.text <> '') and (Attr7.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat7.text,Attr7.text,OrPtr);
          end;
          If (Feat8.text <> '') and (Attr8.text <> '') then
          begin
               New(OrPtr^.NextOr);
               OrPtr := OrPtr^.NextOr;
               createOrNode(Feat8.text,Attr8.text,OrPtr);
          end;
          Inc(NoOfAttr);
     End;
     Feat1.text := '';
     Attr1.text := '';
     Feat2.text := '';
     Attr2.text := '';
     Feat3.text := '';
     Attr3.text := '';
     Feat4.text := '';
     Attr4.text := '';
     Feat5.text := '';
     Attr5.text := '';
     Feat6.text := '';
     Attr6.text := '';
     Feat7.text := '';
     Attr7.text := '';
     Feat8.text := '';
     Attr8.text := '';
     Str(NoOfAttr,TempStr);
     AttrNoLabel.caption := 'อาการกลุ่มที่ ' + TempStr;
end;

procedure TAttrEnterForm.FormCreate(Sender: TObject);
begin
     NoOfAttr := 1;
end;

procedure TAttrEnterForm.FormShow(Sender: TObject);
var
   TempStr : String;
begin
     Str(NoOfAttr,TempStr);
     AttrNoLabel.caption := 'อาการกลุ่มที่ ' + TempStr;
end;

end.
