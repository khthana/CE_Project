unit Unit2_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2_2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2_2: TForm2_2;
  

implementation
uses unit2,unit3, Unit1;
{$R *.DFM}

procedure TForm2_2.Button1Click(Sender: TObject);
begin
     form3.Database1.StartTransaction;
     try
        form3.Query1.Close;
        form3.Query1.SQL.text := 'insert into room (room_name) values(:room_name)';
        form3.Query1.ParamByName('room_name').asstring := edit1.text;
        form3.Query1.ExecSQL;
        form3.Database1.Commit;
        // Room_Items
        form1.updateRoom_Items;
//refresh
        form3.query2.close;
        form3.query2.open;
     except
        showmessage('have error');
        form3.Database1.Rollback;
     end;
        form2.Enabled := true;
        form2_2.Close;
end;

procedure TForm2_2.Button2Click(Sender: TObject);
begin
        form2.Enabled := true;
        form2_2.close;
end;

end.
