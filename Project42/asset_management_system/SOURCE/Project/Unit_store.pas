unit Unit_store;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Db, DBTables, ExtCtrls;

type
  TForm11 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label135: TLabel;
    Label136: TLabel;
    Label1_k: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Label1: TLabel;
    Edit4: TEdit;
    Label2: TLabel;
    Edit5: TEdit;
    Bevel2: TBevel;
    Button3: TButton;
    edit_temp: TEdit;
    Label3: TLabel;
    Edit6: TEdit;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses Unit3, Unit2;

{$R *.DFM}

procedure TForm11.Button1Click(Sender: TObject);
begin
     form3.query1.Close;
     form3.query1.Params.Clear;
     form3.query1.sql.Clear;
     form3.query1.sql.Add(' DECLARE @TranName1 VARCHAR(20) SELECT @TranName1 = ''MyTransaction'' BEGIN TRANSACTION @TranName1 ');
     form3.query1.sql.add (' update stores ');
     form3.query1.sql.add(' set name = :name ,comment = :comment');
     form3.query1.sql.add(' where store_name = :id');
     form3.query1.parambyname('name').asstring := edit2.text;
     form3.query1.parambyname('comment').asstring := edit3.text;
     form3.query1.parambyname('id').asstring := edit1.text;
form3.query1.sql.Add(' COMMIT TRANSACTION @TranName1 ');
     form3.query1.ExecSQL;
     showmessage(' เรียบร้อย');
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
     form11.Close;
     form2.enabled := true;
     form2.visible := true;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
form3.query1.close;
form3.query1.sql.Clear;
form3.query1.params.Clear;
form3.query1.sql.Add(' DECLARE @TranName1 VARCHAR(20) SELECT @TranName1 = ''MyTransaction'' BEGIN TRANSACTION @TranName1 ');
form3.query1.sql.Add(' Use data_stores Update stores set item= :0 where store_name = :1 ' );
form3.query1.sql.Add(' COMMIT TRANSACTION @TranName1 ');
form3.query1.params[0].value := strtoint(edit6.text)+strtoint(edit_temp.Text);
form3.query1.params[1].value := edit1.Text;
form3.query1.ExecSQL;
edit5.Text:=inttostr( strtoint(edit6.text)+strtoint(edit_temp.Text));
edit_temp.Text:=inttostr( strtoint(edit6.text)+strtoint(edit_temp.Text));
showmessage(' เรียบร้อย ');
end;

procedure TForm11.TabSheet2Enter(Sender: TObject);
begin
     edit4.Text:=edit1.Text;
     edit5.Text:=edit_temp.Text;
     edit6.Text:= '0';
end;

end.
