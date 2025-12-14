unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, ExtCtrls;

type
  TForm9_a = class(TForm)
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    Query2: TQuery;
    ControlBar1: TControlBar;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9_a: TForm9_a;

implementation
 uses unit2;
{$R *.DFM}

procedure TForm9_a.Button1Click(Sender: TObject);
begin
     IF (edit3.Text<>'')and (edit4.Text<>'') and (ComboBox1.Text <>'')
        THEN
            begin
            query2.close;
            query2.sql.Clear;
            query2.params.Clear;
            query2.sql.Add(' select * from Tuser where (id = :1) and (status =''user'') ');
            query2.params[0].value := edit3.Text;
            query2.open;
        IF query2.RecordCount = 0 then
        begin
            // ADD new user
            query1.sql.Clear;
            query1.close;
            query1.params.Clear;
            query1.sql.Add(' DECLARE @TranName VARCHAR(20) SELECT @TranName = ''MyTransaction'' BEGIN TRANSACTION @TranName ');
            query1.sql.Add(' Use data_stores insert into Tuser(id,status,name,comment) ');
            query1.sql.Add(' VALUES ( :1 , :2 , :3 , :4 ) ');
            query1.Params[0].value := edit3.Text;
            query1.Params[1].value := 'user';
            query1.Params[2].value := edit4.Text;
            query1.Params[3].value := combobox1.Text;
            query1.sql.Add(' COMMIT TRANSACTION @TranName ');
            query1.ExecSQL;
           query1.close;
           query1.SQL.Clear;
           Query1.Params.Clear;
           Query1.sql.Add(' Select * from Tuser where (id = :1) and (status =''user'')  ');           form9_a.Query1.params[0].value := edit3.Text;
           DBGrid1.Columns[0].fieldname := 'id';
           DBGrid1.Columns[1].fieldname := 'name';
           DBGrid1.Columns[2].fieldname := 'comment';
           Query1.open;
           edit3.Text:='';
           edit4.Text:='';
           edit3.SetFocus;
        end;
           end
           else
            MessageDlg('Press add id or name or class ',mterror,[mbOK],0);
end;

procedure Tform9_a.Edit3Exit(Sender: TObject);
begin
            form9_a.query2.close;
            form9_a.query2.sql.Clear;
            form9_a.query2.params.Clear;
            form9_a.query2.sql.Add(' select * from Tuser where id = :1 ');
            form9_a.query2.params[0].value := edit3.Text;
            form9_a.query2.open;
            IF query2.RecordCount <> 0 then
               begin
//               MessageDlg('id exist in database!! ',mterror,[mbOK],0);
               if MessageDlg('รหัสนักศึกษาได้ลงทะเบียนไว้แล้วต้องการเปลี่ยนใหม่หรือไม่ !! ',mterror,[mbOK,mbcancel],0)=mrOK then
               form9_a.edit3.SetFocus
               else
                button1.Enabled:=false;
               end;

end;

procedure Tform9_a.ComboBox1Enter(Sender: TObject);
begin
combobox1.ItemIndex:=1;

end;

procedure Tform9_a.Edit3Enter(Sender: TObject);
begin
                button1.Enabled:=true;
end;

procedure TForm9_a.Button3Click(Sender: TObject);
begin
query2.close;
query1.close;
form9_a.Visible:=false;
form2.Visible:=true;
end;

end.
