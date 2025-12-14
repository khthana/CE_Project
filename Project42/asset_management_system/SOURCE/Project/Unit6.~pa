unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DBCtrls, StdCtrls, ComCtrls;

type
  TForm6 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ListView1: TListView;
    ListView2: TListView;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit7: TEdit;
    Label15: TLabel;
    Edit10: TEdit;
    Label17: TLabel;
    Edit13: TEdit;
    Label16: TLabel;
    Edit12: TEdit;
    Edit14: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Edit15: TEdit;
    Label18: TLabel;
    Label22: TLabel;
    Edit17: TEdit;
    Label23: TLabel;
    Edit18: TEdit;
    Label2: TLabel;
    ComboBox6: TComboBox;
    Label24: TLabel;
    Label26: TLabel;
    Edit3: TEdit;
    Edit19: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Edit2: TEdit;
    Label1: TLabel;
    TabSheet4: TTabSheet;
    Label40: TLabel;
    Label6: TLabel;
    Edit8: TEdit;
    Label7: TLabel;
    Edit9: TEdit;
    Edit11: TEdit;
    Label8: TLabel;
    Label21: TLabel;
    Edit16: TEdit;
    TabSheet5: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    combobox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    Edit25: TEdit;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    Label10: TLabel;
    Edit1: TEdit;
    Label11: TLabel;
    Edit6: TEdit;
    Label25: TLabel;
    Edit21: TEdit;
    Edit26: TEdit;
    Label29: TLabel;
    ComboBox4: TComboBox;
    Label3: TLabel;
    Edit4: TEdit;
    Label30: TLabel;
    Edit20: TEdit;
    Label31: TLabel;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    procedure combobox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox3Enter(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ComboBox4Enter(Sender: TObject);
    procedure Edit13Click(Sender: TObject);
    procedure Edit8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
uses unit3,unit6_1, Unit1, Unit2;
{$R *.DFM}

procedure TForm6.combobox2Change(Sender: TObject);
begin
     if (combobox2.Text = 'เสีย')  then
     begin
       button1.enabled := true;
       form6_1 := Tform6_1.Create(nil);
       form6_1.Visible := true;
     end;
     button1.enabled := true;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
form3.Database1.StartTransaction;
try

// update status
        if (combobox2.Items.Count = 2) and (combobox2.text <> '') then
        begin
        form3.query1.Close;
        form3.query1.SQL.text := 'update durable set du_status = :du_status,du_lose = :du_lose where du_id = :du_id ' ;
        form3.query1.ParambyName('du_status').asstring := combobox2.Text;
        form3.query1.ParambyName('du_lose').asstring := edit8.text;
        form3.query1.ParamByName('du_id').asstring := edit10.text;
        form3.Query1.ExecSQL;
        form3.query1.Close;
        end;
// update common detail
        form3.query1.close;
        form3.Query1.sql.Clear;
        form3.Query1.Params.Clear;
        form3.Query1.sql.Add(' Declare @du_dayincome datetime ,@du_dayEnd datetime ');
        form3.Query1.sql.Add(' set @du_dayincome = :du_dayincome set @du_dayEnd = :du_dayEnd ');
        form3.query1.sql.add(' update durable set ');
        form3.query1.sql.add('du_se = :du_se, du_type = :du_type,du_dayincome = :du_dayincome,du_maintain = :du_maintain,du_comment = :du_comment,du_vender = :du_vender,du_name = :du_name,du_brand = :du_brand,du_gen = :du_gen,du_dayend = :du_dayend,du_room = :du_room,com_id = :com_id ');
        form3.query1.sql.add(' where du_id = :du_id');
        form3.query1.parambyname('du_se').asstring := edit13.text;
        form3.query1.parambyname('du_type').asstring := combobox3.Text ;
        form3.query1.parambyname('du_dayincome').asstring := edit17.Text ;
        form3.query1.parambyname('du_maintain').asstring := combobox6.Text ;
        form3.query1.parambyname('du_comment').asstring := edit3.Text ;
        form3.query1.parambyname('du_vender').asstring := edit19.Text ;
        form3.query1.parambyname('du_name').asstring := edit12.Text ;
        form3.query1.parambyname('du_brand').asstring := edit14.Text ;
        form3.query1.parambyname('du_gen').asstring := edit15.Text ;
        form3.query1.parambyname('du_dayend').asstring := edit18.Text ;
        form3.query1.parambyname('du_room').asstring := combobox1.Text ;
        form3.query1.parambyname('com_id').asinteger := form2.comNameToComID(combobox4.text) ;
        form3.query1.parambyname('du_id').asstring := edit10.Text ;
        form3.query1.ExecSQL;
        form3.Database1.Commit;
        showmessage('update complete');
except
      form3.Database1.Rollback;
      showmessage('have error');
end;



end;

procedure TForm6.Button2Click(Sender: TObject);
begin
     form6.Close;
end;

procedure TForm6.ComboBox1Enter(Sender: TObject);
begin
     combobox1.Items := form1.room_items.Items ;
end;

procedure TForm6.ComboBox3Enter(Sender: TObject);
begin
     combobox3.Items := form1.Type_Items.Items;
end;

procedure TForm6.ListView1Click(Sender: TObject);
begin
// check click right or not
     if listview1.SelCount = 0 then
     begin
          exit;
     end;
// history fix
        edit5.text := '';
        edit7.text := '';
        edit25.text := '';
        form3.query1.close;
        form3.Query1.sql.Clear;
        form3.Query1.Params.Clear;
        form3.Query1.sql.Add(' Declare @Fix_day datetime ');
        form3.Query1.sql.Add(' set @Fix_day= :Fix_day  ');
        form3.query1.SQL.add(' select * from Fixhis where du_id = :du_id and Fix_day = @Fix_day ');
        form3.query1.ParamByName('du_id').asstring := edit10.text;
        form3.query1.ParamByName('Fix_day').asstring := listview1.Selected.Caption;
        form3.query1.Open;
        if form3.query1.fieldValues['Fix_lose'] = null then
             edit5.text := ''
        else
            edit5.text := form3.query1.fieldValues['Fix_lose'];
        if form3.query1.fieldValues['Fix_unFix'] = null then
             edit7.text := ''
        else
            edit7.text := form3.query1.fieldValues['Fix_unFix'];
        if form3.query1.fieldValues['Fix_detail'] = null then
             edit25.text := ''
        else
            edit25.text := form3.query1.fieldValues['Fix_detail'];
end;

procedure TForm6.ComboBox4Enter(Sender: TObject);
begin
     combobox4.Items := form1.com_items.Items;
end;

procedure TForm6.Edit13Click(Sender: TObject);
begin
     IF  combobox2.Text <> 'แทงจำหน่าย' then
     begin
     button1.Enabled := true;
     form6.caption := 'Durable Detail (Modified)';
     end;
end;

procedure TForm6.Edit8Click(Sender: TObject);
begin
     button1.Enabled := true;
     form6.caption := 'Durable Detail (Modified)';
end;

end.
