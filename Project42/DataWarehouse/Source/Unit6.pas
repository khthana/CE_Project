unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Db, DBTables;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BtOk: TButton;
    BtCancel: TButton;
    DimTV: TTreeView;
    FieldDimListBox: TListBox;
    Edit1: TEdit;
    Label3: TLabel;
    DimTable: TTable;
    DataSource1: TDataSource;
    BtAnd: TButton;
    BtOr: TButton;
    BtClear: TButton;
    GroupBox2: TGroupBox;
    ConditionLabel: TLabel;
    procedure BtOkClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure DimTVClick(Sender: TObject);
    procedure BtAndClick(Sender: TObject);
    procedure BtOrClick(Sender: TObject);
    procedure BtClearClick(Sender: TObject);
  private
    { Private declarations }
    procedure CollectConditionTable;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

  StrCondition :string;
  setcondition :boolean;
  EditCondition :boolean;
  SelectDimChange :boolean;

implementation

uses unit4, Unit5;

{$R *.DFM}


procedure TForm6.DimTVClick(Sender: TObject);
{var script :string;}
begin
{paradox}
     DimTable.active := false;
     DimTable.DatabaseName := DatabaseName;
     DimTable.TableName := DimTV.Selected.Text;
     DimTable.Active := true;
     DimTable.GetFieldNames(FieldDimListBox.Items);

{     FieldDimQuery.DatabaseName := DatabaseName;
     script := 'select *' + #13 +
               'from ' + DimTV.Selected.Text;

     with FieldDimQuery do
     begin
          Close;
          SQL.Text := script;
          Open;
     end;
     FieldDimListBox.Items.text:=FieldDimQuery.FieldDefList.Text;}

end;

procedure TForm6.BtAndClick(Sender: TObject);
begin
     if (Edit1.Text <> '') and
        (FieldDimListbox.Selected[FieldDimListBox.ItemIndex])then
     begin
          if EditCondition = false then
             StrCondition := '';

          StrCondition := StrCondition + DimTV.Selected.Text + '.' + FieldDimlistbox.Items[FieldDimListBox.ItemIndex];
          StrCondition := StrCondition + ' = '+ Edit1.Text + ' and '#13#10;
          CollectConditionTable;
          form6.ConditionLabel.Caption := StrCondition;
          Edit1.Text := '';
          EditCondition := true;
     end;
end;

procedure TForm6.BtOrClick(Sender: TObject);
begin
     if (Edit1.Text <> '') and
        (FieldDimListbox.Selected[FieldDimListBox.ItemIndex])then
     begin
          if EditCondition = false then
             StrCondition := '';

          StrCondition := StrCondition + DimTV.Selected.Text + '.' + FieldDimlistbox.Items[FieldDimListBox.ItemIndex];
          StrCondition := StrCondition + ' = '+ Edit1.Text + ' or '#13#10;
          CollectConditionTable;
          form6.ConditionLabel.Caption := StrCondition;
          Edit1.Text := '';
          EditCondition := true;
     end;
end;

procedure TForm6.BtOkClick(Sender: TObject);
begin
     if Edit1.Text <> '' then
     begin
          if EditCondition = false then
             StrCondition := '';

          StrCondition := StrCondition + DimTV.Selected.Text + '.' + FieldDimlistbox.Items[FieldDimListBox.ItemIndex];
          StrCondition := StrCondition + ' = '+ Edit1.Text;
          CollectConditionTable;
          Edit1.Text := '';
          form6.ConditionLabel.Caption := StrCondition;
          form4.ConditionLabel.Caption := StrCondition;
          setcondition := true;
          close;
     end;
end;

procedure TForm6.BtClearClick(Sender: TObject);
begin
     setcondition := false;
     StrCondition := '';
     form4.ConditionTableListBox.Clear;
     form6.ConditionLabel.Caption := '';
     form4.ConditionLabel.Caption := '';
     Edit1.Text := '';
end;

procedure TForm6.BtCancelClick(Sender: TObject);
begin
     close;
end;

procedure TForm6.CollectConditionTable;
var i,l :integer;
    MyTreeNode :TTreenode;
    check1,check2 :boolean;
begin
          if DimTV.Selected.Level = 0 then
          begin
               check1 := false;
               for i:=0 to Form4.TableUsedListBox.Items.Capacity-1 do
                   if Form4.TableUsedListBox.Items[i] = DimTV.Selected.Text then
                      check1 := true;
               check2 := false;
               for i:=0 to Form4.ConditionTableListbox.Items.Capacity-1 do
                   if Form4.ConditionTablelistbox.Items[i] = DimTV.Selected.Text then
                      check2 := true;
               if (check1 = false) and (check2 = false) then
                  form4.ConditionTableListBox.Items.Add(DimTV.Selected.Text);
          end else      {level <> 0}
          begin
               l := DimTV.Selected.Level;
               MyTreeNode := DimTV.Selected;
               check1 := false;
               check2 := false;
               Repeat
                     for i:=0 to Form4.TableUsedListBox.Items.Capacity-1 do
                         if Form4.TableUsedListBox.Items[i] = MyTreeNode.Text then
                            check1 := true;
                     for i:=0 to Form4.ConditionTableListbox.Items.Capacity-1 do
                         if Form4.ConditionTablelistbox.Items[i] = MyTreeNode.Text then
                            check2 := true;
                     if (check1 = false) and (check2 = false) then
                         form4.ConditionTableListBox.Items.Add(MyTreenode.Text);

                     MyTreenode := MyTreenode.Parent;
                     l := l-1;
               Until l = 0;
               for i:=0 to Form4.TableUsedListBox.Items.Capacity-1 do
                   if Form4.TableUsedListBox.Items[i] = MyTreeNode.Text then
                      check1 := true;
               for i:=0 to Form4.ConditionTableListbox.Items.Capacity-1 do
                   if Form4.ConditionTablelistbox.Items[i] = MyTreeNode.Text then
                      check2 := true;
               if (check1 = false) and (check2 = false) then
                  form4.ConditionTableListBox.Items.Add(MyTreenode.Text);
          end;
end;

end.
