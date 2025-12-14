unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables;

type
  TForm13 = class(TForm)
    ControlBar2: TControlBar;
    Label2: TLabel;
    Edit2: TEdit;
    ControlBar1: TControlBar;
    Label1: TLabel;
    ComboBox2: TComboBox;
    ControlBar5: TControlBar;
    Button2: TButton;
    Button1: TButton;
    Query1: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

uses Unit10, Unit11;

{$R *.DFM}

procedure TForm13.Button2Click(Sender: TObject);
begin
 if (combobox2.Text<>'')and(edit2.Text<>combobox2.Text) then
   begin
    if MessageDlg('ต้องการเปลี่ยนแปลงชั้นของนักศึกษาโปรดเลือก OK !! ',mtwarning,[mbOK,mbcancel],0)=mrOK then
       begin
       query1.close;
       query1.SQL.Clear;
       query1.Params.Clear;
            query1.sql.Add(' DECLARE @TranName VARCHAR(20) SELECT @TranName = ''MyTransaction'' BEGIN TRANSACTION @TranName ');
       query1.sql.Add(' Use data_stores Update Tuser set comment= :item where id ='+''''+form10.getid+'''');/////////
       query1.params[0].value := combobox2.Text;
            query1.sql.Add(' COMMIT TRANSACTION @TranName ');
       query1.ExecSQL;
       form10.setroom(combobox2.text);/////////from form10
       edit2.Text:=combobox2.Text;
       combobox2.SetFocus;
       end;
    end;


end;

procedure TForm13.Button1Click(Sender: TObject);
begin
     form10.Enabled:=true;
     form13.Visible:=false;

end;

procedure TForm13.FormActivate(Sender: TObject);
begin
edit2.Text:=form10.getroom; /////
if edit2.text = '1D' then combobox2.ItemIndex:=0;
if edit2.text = '2D' then combobox2.ItemIndex:=1;
if edit2.text = '3D' then combobox2.ItemIndex:=2;
if edit2.text = '4D' then combobox2.ItemIndex:=3;
if edit2.text = '1P' then combobox2.ItemIndex:=4;
if edit2.text = '2P' then combobox2.ItemIndex:=5;
if edit2.text = '3P' then combobox2.ItemIndex:=6;
combobox2.SetFocus;

end;

end.
