unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls;

type
  Tadduser = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Query1: TQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  adduser: Tadduser;

implementation

uses Unit2;

{$R *.DFM}


procedure Tadduser.Button1Click(Sender: TObject);
begin
     IF (edit1.Text<>'')and (edit2.Text<>'') and (ComboBox1.Text <>'')
        THEN
            begin
            query1.close;
            query1.sql.Clear;
            query1.params.Clear;
            query1.sql.Add(' select * from Tuser where (id = :1) ');
            query1.params[0].value := edit1.Text;
            query1.open;
        IF query1.RecordCount = 0 then
        begin
            // ADD new user
            query1.sql.Clear;
            query1.close;
            query1.params.Clear;
            query1.sql.Add(' DECLARE @TranName VARCHAR(20) SELECT @TranName = ''MyTransaction'' BEGIN TRANSACTION @TranName ');
            query1.sql.Add(' Use data_stores insert into Tuser(id,status,name,comment) ');
            query1.sql.Add(' VALUES ( :1 , :2 , :3 , :4 ) ');
            query1.Params[0].value := edit1.Text;
            if (combobox1.ItemIndex=0) then
            query1.Params[1].value := 'in';
            if (combobox1.ItemIndex=1) then
            query1.Params[1].value := 'out';
            query1.Params[2].value := edit2.Text;
            query1.Params[3].value := edit3.Text;
            query1.sql.Add(' COMMIT TRANSACTION @TranName ');
            query1.ExecSQL;
            showmessage(' เรียบร้อย');
            edit1.SetFocus;
        end
         else
            begin
            MessageDlg(' หมายเลข ID ซ้ำ ',mterror,[mbOK],0);
            edit1.SetFocus;
            end;
         end;
end;

procedure Tadduser.FormActivate(Sender: TObject);
begin
edit1.SetFocus;
combobox1.ItemIndex := 0;
end;

procedure Tadduser.Button2Click(Sender: TObject);
begin
     adduser.Close;
     form2.enabled := true;
     form2.visible := true;

end;

end.
