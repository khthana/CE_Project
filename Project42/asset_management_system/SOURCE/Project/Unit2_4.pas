unit Unit2_4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2_4 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    com_id :integer
  end;

var
  Form2_4: TForm2_4;

implementation

uses Unit3, Unit2, Unit1;

{$R *.DFM}

procedure TForm2_4.Button1Click(Sender: TObject);
begin
     form3.query1.Close;
     form3.query1.sql.text := 'update company ';
     form3.query1.sql.add(' set com_name = :com_name ,com_phone = :com_phone ,com_add = :com_add');
     form3.query1.sql.add(' where com_id = :com_id');
     form3.query1.parambyname('com_name').asstring := edit1.text;
     form3.query1.parambyname('com_phone').asstring := edit2.text;
     form3.query1.parambyname('com_add').asstring := edit3.text;
     form3.query1.parambyname('com_id').asinteger := com_id;
     form3.query1.ExecSQL;
     Form2.TabSheet15Show(Sender);
     form1.updateCom_Items;
     form2_4.Close;

end;

procedure TForm2_4.Button2Click(Sender: TObject);
begin
     form2_4.Close;
end;

end.
