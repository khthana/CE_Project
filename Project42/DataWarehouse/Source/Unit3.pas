unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Grids, DBGrids, GIFImage;

type


  TForm3 = class(TForm)
    TableListBox: TListBox;
    FieldListBox: TListBox;
    Query1: TQuery;
    BtSelect: TButton;
    BtConnect: TButton;
    BtCancel: TButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    AliasCombo: TComboBox;
    procedure TableListBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtConnectClick(Sender: TObject);
    procedure BtSelectClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
        procedure ListTable;
        procedure EnableComponent;
    { Public declarations }
  end;

var
  Form3: TForm3;
implementation

uses Unit2, Unit1, Unit7;


{$R *.DFM}

procedure TForm3.FormCreate(Sender: TObject);
begin
     Session.GetAliasNames(AliasCombo.Items);
     session.Close;
end;

procedure TForm3.BtConnectClick(Sender: TObject);
begin
     if AliasCombo.Text <> '' then
     begin
          ModelDatabaseName := AliasCombo.Text;

          EnableComponent;
          ListTable;

     end;
end;

procedure TForm3.TableListBoxClick(Sender: TObject);
var script :string;
begin
     Query1.DatabaseName := ModelDatabaseName;
     script := 'select *' + #13 +
               'from ' + TableListBox.Items[TableListBox.ItemIndex];
     with query1 do
     begin
          Close;
          query1.SQL.Text := script;
          Open;
     end;
     FieldListBox.Items.text:=query1.FieldDefList.Text;
end;

procedure TForm3.BtSelectClick(Sender: TObject);
var check :boolean;
    i :integer;
begin

     if AddStatus = AddDimension then
     begin
          if (TableListBox.Items.Count <> 0) and
             (TableListBox.Selected[TableListBox.ItemIndex]) then                 {if list1 is selected}
          begin
               check := false;
               for i:=0 to form2.DimTV.Items.Count-1 do           {check exist that item in list1}
                   if form2.DimTV.Items[i].text = TableListBox.Items[TableListBox.ItemIndex] then
                      check := true;
               if check = false then form2.DimTV.Items.Add(nil,TableListBox.Items[TableListBox.ItemIndex]);

               form2.Label1.Caption := IntToStr(form2.DimTV.Items.Count);
               Close;
          end;
     end;

     if AddStatus = AddFact then
     begin
          if (FieldListBox.Items.Count <> 0) and
             (FieldListBox.Selected[FieldListBox.ItemIndex]) then                 {if list2 is selected}
          begin
               check := false;
               for i:=0 to form2.FactFieldListbox.Items.Capacity-1 do           {check exist that item in list1}
                   if form2.FactFieldListbox.Items[i] = FieldListBox.Items[FieldListBox.ItemIndex] then
                      check := true;
               if check = false then form2.FactFieldListbox.Items.Add(FieldListBox.Items[FieldListBox.ItemIndex]);
{keep fact in form2.FactTablelistbox}
               form2.FactTableListBox.Items.Add(TableListBox.Items[TableListBox.ItemIndex]);

               form2.Label2.Caption := IntToStr(form2.FactFieldListbox.Items.Capacity);
               Close;
          end;
     end;

     if AddStatus = AddAgreFactMonth then
     begin
          if (TableListBox.Items.Count <> 0) and
             (TableListBox.Selected[TableListBox.ItemIndex]) then                 {if list1 is selected}
          begin
               form2.EditMonth.Text := TableListBox.Items[TableListBox.ItemIndex];
               Close;
          end;
     end;

     if AddStatus = AddAgreFactYear then
     begin
          if (TableListBox.Items.Count <> 0) and
             (TableListBox.Selected[TableListBox.ItemIndex]) then                 {if list1 is selected}
          begin
               form2.EditYear.Text := TableListBox.Items[TableListBox.ItemIndex];
               Close;
          end;
     end;

end;

procedure TForm3.BtCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TForm3.ListTable;
var i :integer;
    script :string;
begin
{oracle <== correct}
{     Session.GetTableNames(ModelDatabaseName,'',False,False,TableListbox.Items);}

     Query1.DatabaseName := ModelDatabaseName;
     script := 'select TNAME' + #13 +
               'from tab';
     with query1 do
     begin
          Close;
          query1.SQL.Text := script;
          Open;
     end;
     for i:=0 to query1.RecordCount-1 do
     begin
          TableListBox.Items.Add(query1.FieldValues['TNAME']);
          query1.Next;
     end;

end;

procedure TForm3.EnableComponent;
begin
     label1.Enabled := false;
     AliasCombo.Enabled := false;
     BtConnect.Enabled := false;

     label4.Enabled := true;
     label5.Enabled := true;
     TableListBox.Enabled := true;
     BtSelect.Enabled := true;
     BtCancel.Enabled := true;

     form7.AliasCombo.Text := form3.AliasCombo.Text;

end;

end.
