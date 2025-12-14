unit Unit2_3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2_3 = class(TForm)
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
  Form2_3: TForm2_3;

implementation

uses Unit3, Unit2, Unit1;

{$R *.DFM}

procedure TForm2_3.Button1Click(Sender: TObject);
begin
     form3.Database1.StartTransaction;
     try
        form3.Query1.Close;
        form3.Query1.SQL.text := 'insert into type (type_name) values(:type_name)';
        form3.Query1.ParamByName('type_name').asstring := edit1.text;
        form3.Query1.ExecSQL;
        form3.Database1.Commit;
        // Type_Items
        form1.updateType_Items;
//refresh
        form3.query3.close;
        form3.Query3.Open;
     except
        showmessage('have error');
        form3.Database1.Rollback;
     end;
        form2.Enabled := true;
        form2_3.Close;
end;

procedure TForm2_3.Button2Click(Sender: TObject);
begin
        form2.Enabled := true;
        form2_3.Close;

end;

end.
