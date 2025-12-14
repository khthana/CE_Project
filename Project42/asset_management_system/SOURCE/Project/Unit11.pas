unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Db, DBTables;

type
  TForm11 = class(TForm)
    ControlBar2: TControlBar;
    Label2: TLabel;
    Edit2: TEdit;
    ControlBar1: TControlBar;
    Label1: TLabel;
    Edit1: TEdit;
    ControlBar5: TControlBar;
    Button2: TButton;
    Button1: TButton;
    Query1: TQuery;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses Unit10;

{$R *.DFM}

procedure TForm11.FormActivate(Sender: TObject);
begin
edit1.SetFocus;
edit2.Text:= form10.getid;//////////
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
 if (edit1.Text<>'')and(edit1.Text<>edit2.Text) then
   begin
    if MessageDlg('รหัสใหม่นี้จะใช้แทนรหัสเก่าคุณแน่ใจหรือไม่ที่จะเปลี่ยนรหัสใหม่ !! ',mtwarning,[mbOK,mbcancel],0)=mrOK then
       begin
       query1.close;
       query1.Params.Clear;
       query1.SQL.Clear;
       query1.sql.add(' Use data_stores select id from Tuser where id = '+''''+edit1.Text+'''');
       query1.open;
       if query1.RecordCount =0 then
          begin
            query1.close;
            query1.Params.Clear;
            query1.SQL.Clear;
            /// begin transaction
            query1.sql.Add(' DECLARE @TranName VARCHAR(20) SELECT @TranName = ''MyTransaction'' BEGIN TRANSACTION @TranName ');
            query1.sql.add(' use data_stores update Tuser set id = :1 where id = '+''''+edit2.Text+'''');
            query1.Params[0].asstring := edit1.Text;
            ///////   update store borrow
            query1.sql.add(' update borrow_stores set id_user = :2 where id_user = '+''''+edit2.Text+'''');
            query1.Params[1].asstring := edit1.Text;
            ///////
            query1.sql.Add(' COMMIT TRANSACTION @TranName ');
            query1.ExecSQL;

            form10.setid(edit1.text);/////////from form10
            form10.Edit1.Text:=edit1.Text;////
            edit2.Text:=edit1.Text;
            edit1.Text:='';
            edit1.SetFocus;
          end
          else
          begin
MessageDlg('ID:'+edit1.Text+' มีอยู่แล้วในฐานข้อมูลกรุณาเปลี่ยนใหม่ ',mterror,[mbOK],0);
           edit1.SetFocus;
           end;
       end;
    end;
end;

procedure TForm11.Button1Click(Sender: TObject);
begin
     form10.Enabled:=true;
     form11.Visible:=false;

end;

end.
