unit unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tcompany_add = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure Findprimarykey(var pno:integer);
  end;

var
  company_add: Tcompany_add;

implementation
uses unit2,unit3, Unit1;
{$R *.DFM}
procedure Tcompany_add.findprimarykey(var pno:integer);
begin
     {find primary key of new company}
     //with form3.Query1 do begin
     form3.Query1.SQL.clear;
     form3.Query1.SQL.Add('select com_id from company ');
     form3.Query1.Open;
     form3.Query1.Last;
     pno := form3.Query1.FieldValues['com_id']+1;
     {find if not one}
     form3.Query1.SQL.clear;
     form3.Query1.SQL.Add('select com_id from company where com_id = ' +char(39) +inttostr(pno) +char(39));
     form3.Query1.Open;
     while form3.Query1.FieldValues['com_id']  = '' do
     begin
           pno:=pno+1;
           if pno > 99 then
           pno := 1;
           form3.Query1.SQL.Clear;
           form3.Query1.SQL.Add('select com_id from company where com_id = ' +char(39) +inttostr(pno) +char(39));
           form3.Query1.Open;
     end;

end;
procedure Tcompany_add.Button1Click(Sender: TObject);
var
   pno:integer;
begin
form3.Database1.StartTransaction;
try
     //findprimarykey(pno);
     form3.Query1.Close;
     form3.Query1.SQL.Clear;
     form3.Query1.SQL.Add('insert into company (Com_name,com_phone,com_add) ');
     form3.query1.sql.add(' values( :com_name,:com_phone,:com_add)');
     with form3.query1 do begin
          Parambyname('com_name').asstring := edit1.text;
          Parambyname('com_phone').asstring := edit2.text;
          Parambyname('com_add').asstring := edit3.text;
          execSQL;
     end;
     form2.Enabled := true;
     form3.Database1.Commit;
     // com_Items
     form1.updateCom_Items;
//Refresh Com show
     form3.Query2.close;
     form3.Query2.Open;
except
      showmessage('error');
      form3.Database1.Rollback;
end;            //try..except
     form2.enabled := true;
     company_add.close;
end;

procedure Tcompany_add.Button2Click(Sender: TObject);
begin
     form2.enabled := true;
     company_add.close;


end;

end.
