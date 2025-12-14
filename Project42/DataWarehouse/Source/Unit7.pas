unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, GIFImage;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TableListBox: TListBox;
    FieldListBox: TListBox;
    AliasCombo: TComboBox;
    BtConnect: TButton;
    BtSelect: TButton;
    BtCancel: TButton;
    Query1: TQuery;
    procedure BtCancelClick(Sender: TObject);
    procedure BtSelectClick(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListTable;
  end;

var
  Form7: TForm7;

implementation

uses Unit2, Unit3, Unit4;

{$R *.DFM}

procedure TForm7.BtCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TForm7.BtSelectClick(Sender: TObject);
begin
     if (TableListBox.Items.Count <> 0) and
        (TableListBox.Selected[TableListBox.ItemIndex]) then
     begin
        form2.DimTV.Items.AddChild(Form2.DimTV.selected,TableListBox.Items[TableListBox.ItemIndex]);
        Close;
     end;
end;

procedure TForm7.ListTable;
var i :integer;
    field :string;
begin
     DatabaseName := ModelDatabaseName;
     form7.TableListBox.Clear;
     form7.FieldListBox.Clear;
     for i:=0 to form3.TableListBox.Items.Count - 1 do
     begin
          if (form2.DimTV.Selected.Text <> form3.TableListBox.Items[i]) then
          begin
              if form2.DimTV.Selected.Level = 0 then
              begin
                   field := form4.FindJoinField(form2.DimTV.Selected.Text,form3.TableListBox.Items[i]);
                   if field <> '' then
                      form7.TableListBox.Items.Add(form3.TableListBox.Items[i]);
              end else
              if form2.DimTV.Selected.Parent.Text <> form3.TableListBox.Items[i] then
              begin
                   field := form4.FindJoinField(form2.DimTV.Selected.Text,form3.TableListBox.Items[i]);
                   if field <> '' then
                      form7.TableListBox.Items.Add(form3.TableListBox.Items[i]);
              end;
          end;
     end;

end;

procedure TForm7.TableListBoxClick(Sender: TObject);
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

end.
