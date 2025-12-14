unit Unit14;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables;

type
  TForm14 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Query1: TQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses Unit1, Unit10;

{$R *.DFM}

procedure TForm14.BitBtn2Click(Sender: TObject);
begin
edit2.Text:='';
form10.Enabled := true;
form14.Visible:= false;
end;

procedure TForm14.BitBtn1Click(Sender: TObject);
begin
     if edit2.Text = form1.edit2.Text then///////
     begin
       query1.Close;
       query1.sql.Clear;
       query1.Params.Clear;
            query1.sql.Add(' DECLARE @TranName VARCHAR(20) SELECT @TranName = ''MyTransaction'' BEGIN TRANSACTION @TranName ');
       query1.sql.Add(' Use Data_stores delete Tuser where id = :1 ');
       query1.Params[0].value := form10.getid;///////
            query1.sql.Add(' COMMIT TRANSACTION @TranName ');

       query1.ExecSQL;
       form10.setid('');   ///////>>
       form10.setnames('');
       form10.setroom('');
       form10.setok(false);
       ////////////////////////////
       edit2.Text:='';
       form10.Enabled := true;
       form14.Visible:= false;
    end
     else
     begin
   ShowMessage('Password ไม่ถูกต้อง');
    edit2.SetFocus;
    end;

end;

procedure TForm14.FormActivate(Sender: TObject);
begin
 edit1.Text := form1.edit1.Text;
 edit2.SetFocus;
end;

end.
