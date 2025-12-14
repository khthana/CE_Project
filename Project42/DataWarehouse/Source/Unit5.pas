unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, GIFImage;

type

    nodeptr = ^node;
    node = record
         field :string;
         Table :array[0..9] of string; {allow 10 level}
         level  :integer;
         next :nodeptr;
    end;


  TForm5 = class(TForm)
    DimTV: TTreeView;
    FieldDimListBox: TListBox;
    FieldDimQuery: TQuery;
    BtAdd: TButton;
    BtRem: TButton;
    FieldSelectedListBox: TListBox;
    BtOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure DimTVKeyPress(Sender: TObject; var Key: Char);
    procedure BtAddClick(Sender: TObject);
    procedure BtRemClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure DimTVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function getnode :nodeptr;
  end;

var
  Form5: TForm5;

  HeadSelectedField,TailSelectedField :nodeptr;

implementation

uses unit4, Unit6;

{$R *.DFM}

procedure TForm5.DimTVClick(Sender: TObject);
var script :string;
begin
     FieldDimQuery.DatabaseName := DatabaseName;
     script := 'select *' + #13 +
               'from ' + DimTV.Selected.Text;

     with FieldDimQuery do
     begin
          Close;
          SQL.Text := script;
          Open;
     end;
     FieldDimListBox.Items.text:=FieldDimQuery.FieldDefList.Text;
end;

procedure TForm5.DimTVKeyPress(Sender: TObject; var Key: Char);  {dup}
var script :string;
begin
     FieldDimQuery.DatabaseName := DatabaseName;
     script := 'select *' + #13 +
               'from ' + DimTV.Selected.Text;

     with FieldDimQuery do
     begin
          Close;
          SQL.Text := script;
          Open;
     end;
     FieldDimListBox.Items.text:=FieldDimQuery.FieldDefList.Text;

end;

procedure TForm5.BtAddClick(Sender: TObject);
var i:integer;
    check :boolean;
    p : nodeptr;
begin
     check := false;
     if FieldDimListbox.Selected[FieldDimlistbox.ItemIndex] then
     begin
          for i:=0 to FieldSelectedlistbox.Items.Capacity-1 do
              if FieldSelectedlistbox.Items[i] = FieldDimlistbox.Items[FieldDimlistbox.ItemIndex] then
                 check := true;
          if check = false then
          begin
               FieldSelectedlistbox.Items.Add(FieldDimlistbox.Items[FieldDimListBox.ItemIndex]);

               if FieldSelectedListbox.Items.Count = 1 then
               begin
                    HeadSelectedField := getnode;
                    TailSelectedField := HeadSelectedField;
               end else
               begin
                    p := getnode;
                    TailSelectedField^.next:=p;
                    TailSelectedField := p;
               end;
          end;
     end;
end;

procedure TForm5.BtRemClick(Sender: TObject);
var count:integer;
    p,q : nodeptr;
begin
     if FieldSelectedlistbox.Selected[FieldSelectedListbox.ItemIndex] then
     begin
          p := HeadSelectedField;
          q := HeadSelectedField;

          if FieldSelectedListbox.ItemIndex = 0 then
          begin
               p := q^.next;
               dispose(q);
               HeadSelectedField := p;
          end else
          begin
               for count := 0 to FieldSelectedListbox.ItemIndex-1 do
               begin
                    p := q;
                    q := p^.next;
               end;
               if q = TailSelectedField then
               begin
                    TailSelectedField := p;
                    TailSelectedField^.next := nil;
               end
               else p^.next := q^.next;
               dispose(q);
          end;
          FieldSelectedlistbox.Items.Delete(FieldSelectedListbox.ItemIndex);
          SelectDimChange := true;
     end;
end;

procedure TForm5.BtOkClick(Sender: TObject);
var i,j :integer;
    p :nodeptr;
    check :boolean;
begin
     Form4.TableUsedListBox.Clear;
     p := HeadSelectedField;
     while p <> nil do
     begin
          check := false;
          for i := 0 to P^.level do
          begin
               for j:=0 to Form4.TableUsedListbox.Items.Capacity-1 do
                   if Form4.TableUsedlistbox.Items[j] =  p^.Table[i] then
                      check := true;
               if check = false then form4.TableUsedListBox.Items.Add(p^.Table[i]);
          end;
{          form4.TableUsedListBox.Items.Add('----------');}
          p := p^.next;
     end;

     form4.DimLabel.caption := FieldSelectedListBox.Items.Text;

     if (form4.DimLabel.Caption = '') or (form4.FactFieldComboBox.Text = '') then
        form4.BtQuery.Enabled := false
     else form4.BtQuery.Enabled := true;

     if SelectDimChange = true then form6.BtClearClick(sender);
     close;
end;

function TForm5.getnode: nodeptr;
var p :nodeptr;
    i,l :integer;
    MyTreeNode :TTreenode;
begin
     new(p);
     p^.field := FieldDimlistbox.Items[FieldDimListBox.ItemIndex];
     if DimTV.Selected.Level = 0 then
     begin
          p^.Table[0] := DimTV.Selected.Text;
          p^.level := 0;
     end else     {level <> 0}
     begin
          i := 0;
          l := DimTV.Selected.Level;
          p^.level := l;
          MyTreeNode := DimTV.Selected;
          Repeat
               p^.Table[i] := MyTreenode.Text;
               MyTreenode := MyTreenode.Parent;
               i := i+1;
               l := l-1;
          Until l = 0;
          p^.Table[i] := MyTreenode.Text;
     end;
     p^.next := nil;
     getnode := p;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
     SelectDimChange := true;
end;

end.
