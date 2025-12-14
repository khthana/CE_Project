unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ComCtrls, Db, DBTables, Buttons, Grids,
  mxgrid, mxDB, mxstore, mxpivsrc;

type
    Joinnodeptr = ^Joinnode;

    Joinnode = record
         son :string;
         father :string;
         field  :string;
         next   :Joinnodeptr;
    end;

    TSwitchMode = (Thai,English);

  TForm4 = class(TForm)
    MainMenu1: TMainMenu;
    Model1: TMenuItem;
    CreateModel1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    LoadModel1: TMenuItem;
    FactFieldComboBox: TComboBox;
    OpenDialog: TOpenDialog;
    FactTableListBox: TListBox;
    FactFieldListBox: TListBox;
    BtCondition: TButton;
    TableUsedListBox: TListBox;
    TableJoinFieldListBox: TListBox;
    SonTable: TTable;
    FatherTable: TTable;
    ListBox1: TListBox;
    BtQuery: TButton;
    Query1: TQuery;
    DecisionCube1: TDecisionCube;
    DecisionSource1: TDecisionSource;
    DecisionGrid1: TDecisionGrid;
    Pivot: TDecisionPivot;
    BtSQL: TButton;
    BtSetTime: TButton;
    ConditionTableListBox: TListBox;
    BTClearCon: TButton;
    DecisionSource2: TDecisionSource;
    PrintDialog1: TPrintDialog;
    Graph1: TMenuItem;
    Language1: TMenuItem;
    English1: TMenuItem;
    Thai1: TMenuItem;
    BitBtView: TBitBtn;
    GroupBox1: TGroupBox;
    ConditionLabel: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DimLabel: TLabel;
    Panel1: TPanel;
    Print1: TMenuItem;
    N2: TMenuItem;
    EditMonth: TEdit;
    EditYear: TEdit;
    GroupBox4: TGroupBox;
    RdoNone: TRadioButton;
    RdoMonth: TRadioButton;
    RdoYear: TRadioButton;
    procedure CreateModel1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure LoadModel1Click(Sender: TObject);
    procedure BtConditionClick(Sender: TObject);
    procedure BtQueryClick(Sender: TObject);
    procedure BtSetTimeClick(Sender: TObject);
    procedure BtSQLClick(Sender: TObject);
    procedure BTClearConClick(Sender: TObject);
    procedure FactFieldComboBoxChange(Sender: TObject);
    procedure BitBtViewClick(Sender: TObject);
    procedure Graph1Click(Sender: TObject);
    procedure English1Click(Sender: TObject);
    procedure Thai1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Print1Click(Sender: TObject);

  private
    { Private declarations }
    procedure LoadModel;
    procedure CollectTableJoinField;
    function ListField :string;
    function ListTable :string;
    function ListJoin :string;
    function TimeKey :string;
    procedure clearComponent;
    function CurrentFactTable :string;

  public
    { Public declarations }
    function FindJoinField(son,father: string) :string;
    procedure SwitchToThai;
    procedure SwitchToEnglish;
  end;

var
  Form4: TForm4;

  DatabaseName :string;


  HeadTableJoinField,TailTableJoinField :Joinnodeptr;

  ShowSQL :boolean;
  SwitchMode :TSwitchMode;

implementation

uses Unit2, Unit1, Unit5, Unit6, Printers, Unit8;

{$R *.DFM}

procedure TForm4.CreateModel1Click(Sender: TObject);
begin
     form2 := TForm2.Create(self);
     form2.ShowModal;
end;

procedure TForm4.Exit1Click(Sender: TObject);
begin
     close;
end;

procedure TForm4.LoadModel1Click(Sender: TObject);
begin
     ClearComponent;

     if OpenDialog.Execute then
     begin
        ModelFileName := OpenDialog.FileName;
        ModelTVFileName := ModelFileName + '~';
        LoadReady := false;
        LoadModel;

        if LoadReady then  {if LoadReady = true}
        begin
             Form4.Caption := 'Data Warehouse 2000 - ' + ModelFileName;
             Panel1.Visible := false;

        end
 {if LoadReady = false}
        else   MessageDlg('Cannot read this file.'+ #13#10 + 'This is not a valid tam file, or its format is not currently supported',mtError,[mbOK],0);
     end;

end;

procedure TForm4.LoadModel;
var st :string;
begin
     assignfile(ModelFileHandle,ModelFileName);
     reset(ModelFileHandle);

     Readln(ModelFileHandle, st);              {:DBName:}
     if st = ':DBName:' then
     begin
          FactFieldComboBox.Clear;
          FactFieldListBox.Clear;
          FactTableListBox.Clear;

          Readln(ModelFileHandle,st);
          DatabaseName := st;

          Readln(ModelFileHandle,st);          {:FactMonth:}
          Readln(ModelFileHandle,st);
          EditMonth.Text := st;

          Readln(ModelFileHandle,st);          {:FactYear:}
          Readln(ModelFileHandle,st);
          EditYear.Text := st;

          if EditMonth.Text = '' then
             RdoMonth.Enabled := false
          else RdoMonth.Enabled := true;
          if EditYear.Text = '' then
             RdoYear.Enabled := false
          else RdoYear.Enabled := true;

          Readln(ModelFileHandle,st);          {:FactField:}
          Readln(ModelFileHandle,st);
          while st <> ':FactTable:' do
          begin
               FactFieldComboBox.Items.Add(st);
               FactFieldListbox.Items.Add(st);
               Readln(ModelFileHandle,st);
          end;

          while not Eof(ModelFileHandle) do
          begin
               Readln(ModelFileHandle,st);
               FactTableListbox.Items.Add(st);
          end;

          closefile(ModelFileHandle);
          Form5.DimTV.LoadFromFile(ModelTVFileName);
          Form5.DimTV.Selected := Form5.DimTV.Items.Item[0];
          Form6.DimTV.LoadFromFile(ModelTVFileName);
          Form6.DimTV.Selected := Form5.DimTV.Items.Item[0];
          CollectTableJoinField;
          LoadReady := true;
     end
     else LoadReady := false;
end;

procedure TForm4.CollectTableJoinField;
var p :Joinnodeptr;
    i :integer;
    MyTreeNode :TTreenode;
begin
     new(HeadTableJoinField);
     HeadTableJoinField^.son := Form5.DimTV.Items.Item[0].Text;
     HeadTableJoinField^.father := '';
     HeadTableJoinField^.field := FindJoinField(HeadTableJoinField^.son,HeadTableJoinField^.father);
     HeadTableJoinField^.next := nil;
     TailTableJoinField := HeadTableJoinField;

     for i := 1 to Form5.DimTV.Items.Count-1 do
     begin
          new(p);
          p^.son := Form5.DimTV.Items.Item[i].Text;

          if Form5.DimTV.Items.Item[i].Level <> 0 then
          begin
               MyTreenode := Form5.DimTV.Items.Item[i];
               MyTreenode := MyTreenode.Parent;
               p^.father := MyTreenode.Text;
          end
          else P^.father := '';

          p^.field := FindJoinField(p^.son,p^.father);
          p^.next := nil;
          TailTableJoinField^.next:=p;
          TailTableJoinField := p;
     end;

     TableJoinFieldListBox.Clear;
     p := HeadTableJoinField;
     while p <> nil do
     begin
          TableJoinFieldListBox.Items.Add(p^.son);
          TableJoinFieldListBox.Items.Add(p^.father);
          TableJoinFieldListBox.Items.Add(p^.field);
{          TableJoinFieldListBox.Items.Add('----------');}
          p := p^.next;
     end;

end;


function TForm4.FindJoinField(son, father: string): string;
var i:integer;
    field :string;
    found :boolean;
begin
     SonTable.Active := false;
     SonTable.DatabaseName := Databasename;
     SonTable.TableName := son;
     SonTable.Active := true;

     if father = '' then
        father := FactTableListbox.Items[0];
     FatherTable.Active := false;
     FatherTable.DatabaseName := Databasename;
     FatherTable.TableName := father;
     FatherTable.Active := true;

     found := false;
     for i:=0 to SonTable.FieldDefList.Count-1 do
     begin
          if FatherTable.FieldDefList.Find(SonTable.FieldDefList.FieldDefs[i].Name) <> nil then
          begin
               Field := SonTable.FieldDefList.FieldDefs[i].Name;
               found := true;
          end
     end;
     if found = false then Field := '';
     FindJoinField := Field;

end;

procedure TForm4.BtQueryClick(Sender: TObject);
var runscript :string;
begin

     runscript := 'Select  ' + ListField +','+ TimeKey + ',Sum(' + FactFieldCombobox.Text + ')';
     runscript := runscript+ #13#10;
     runscript := runscript+'From ' + ListTable;
     runscript := runscript+ #13#10;
     runscript := runscript+'Where ' + ListJoin;
     runscript := runscript+ #13#10;
     if setcondition = true then
        runscript := runscript+ 'and '+ StrCondition + #13#10;

     runscript := runscript+'Group By ' + ListField + ',' +TimeKey;


{      runscript := 'select parent,to_char(newdate,''mm''),sum(sales)'#13#10;
      runscript := runscript + 'from customer,fact'#13#10;
      runscript := runscript + 'where customer.customer = fact.customer'#13#10;
      runscript := runscript + 'group by parent,to_char(newdate,''mm'')';
 }

{  runscript := 'select parent,newdate,sum(sales)'+#13#10;
  runscript := runscript + 'from customer,fact'#13#10;
      runscript := runscript + 'where customer.customer = fact.customer'#13#10;
  runscript := runscript + 'group by parent,newdate';
}

     Listbox1.Items.Text := runscript;

     query1.DatabaseName := DatabaseName;
     with query1 do
     begin
          Close;
          query1.SQL.Text := runscript;
          Open;
     end;
     DecisionCube1.DataSet := query1;
     DecisionGrid1.DecisionSource := decisionsource1;
     Pivot.DecisionSource := decisionsource1;
     form8.DecisionGraph1.DecisionSource := decisionsource1;

end;

function TForm4.CurrentFactTable: string;
var fact :string;
begin
     if RdoNone.Checked then
        fact := FactTableListbox.Items[FactFieldCombobox.ItemIndex];
     if RdoMonth.Checked then
        fact := EditMonth.Text;
     if RdoYear.Checked then
        fact := EditYear.Text;
     CurrentFactTable := fact;
end;

function TForm4.ListField: string;
var p :nodeptr;
    st :string;
begin
      p := HeadSelectedField;
      while p <> nil do
      begin
           st := st + p^.field;
           if p^.next <> nil then st := st + ',';
           p := p^.next;
      end;
      ListField := st;
end;

function TForm4.ListTable: string;
var st :string;
    i :integer;
begin
     for i := 0 to TableUsedListbox.Items.Capacity-1 do
     begin
          st := st + TableUsedListBox.Items[i] + ',';
     end;
     if setcondition = true then
        for i := 0 to ConditionTableListbox.Items.Capacity-1 do
        begin
             st := st + ConditionTableListbox.Items[i] + ',';
        end;

        st := st + CurrentFactTable;
{        st := st + FactTableListbox.Items[FactFieldCombobox.ItemIndex];}

     ListTable := st;
end;

function TForm4.ListJoin: string;
var st :string;
    i :integer;
    p :JoinNodeptr;
    father :string;
begin
     for i := 0 to TableUsedListbox.Items.Capacity-2 do
     begin
          p := HeadTableJoinField;
          while p^.son <> TableUsedListBox.Items[i] do p := p^.next;
          if p^.father = '' then father := CurrentFactTable
                            else father := p^.father;
          st := st +'('+ p^.son+'.'+p^.field+ ' = '+father+'.'+p^.field +')'+ ' and'#13#10;
     end;

     if setcondition = true then
         for i := 0 to ConditionTableListbox.Items.Capacity-1 do
         begin
              p := HeadTableJoinField;
              while p^.son <> ConditionTableListBox.Items[i] do p := p^.next;
              if p^.father = '' then father := CurrentFactTable
                                else father := p^.father;
              st := st +'('+ p^.son+'.'+p^.field+ ' = '+father+'.'+p^.field +')'+ ' and'#13#10;
         end;

     p := HeadTableJoinField;
     while p^.son <> TableUsedListBox.Items[TableUsedListbox.Items.Capacity-1] do p := p^.next;
     if p^.father = '' then father := CurrentFactTable
                       else father := p^.father;
     st := st +'('+ p^.son+'.'+p^.field+ ' = '+father+'.'+p^.field+')';

     ListJoin := st;
end;

function TForm4.TimeKey: string;
var i :integer;
    key :string;
begin
     SonTable.Active := false;
     SonTable.DatabaseName := Databasename;
     SonTable.TableName := FactTableListbox.Items[FactFieldCombobox.ItemIndex];
     SonTable.Active := true;
     for i:=0 to SonTable.FieldDefList.Count-1 do
     begin
          if (SonTable.FieldDefList.FieldDefs[i].DataType = ftDate) or
             (SonTable.FieldDefList.FieldDefs[i].DataType = ftDateTime) then
             key := SonTable.FieldDefList.FieldDefs[i].name
     end;
     TimeKey := key;
end;

procedure TForm4.BtSetTimeClick(Sender: TObject);
begin
     if listbox1.Items.Count <> 0 then
        Decisioncube1.ShowCubeDialog;
end;

procedure TForm4.BtSQLClick(Sender: TObject);
begin
     if ShowSQL = false then
     begin
          listbox1.Visible := true;
          if Switchmode = English then
             form4.BtSQL.Caption := 'Close SQL'
          else form4.BtSQL.Caption  := 'ปิดคำสั่ง SQL';
          ShowSQL := true;
     end else
     begin
          listbox1.Visible := false;
          if Switchmode = English then
             form4.BtSQL.Caption := 'SQL Script'
          else form4.BtSQL.Caption  := 'คำสั่ง SQL';
          ShowSQL := false;
     end;
end;

procedure TForm4.BtConditionClick(Sender: TObject);
begin
     EditCondition := false;
     form6.showmodal;
end;

procedure TForm4.BTClearConClick(Sender: TObject);
begin
     form6.BtClearClick(sender);
end;

procedure TForm4.clearComponent;
begin
     form5 := Tform5.Create(self);
     form6 := Tform6.Create(self);
     DimLabel.Caption := '';
     ConditionLabel.Caption := '';
     Listbox1.Clear;
     DecisionGrid1.DecisionSource := Decisionsource2;
     Pivot.DecisionSource := Decisionsource2;
     form8.DecisionGraph1.DecisionSource := decisionsource2;
end;

procedure TForm4.FactFieldComboBoxChange(Sender: TObject);
begin
     if (form4.DimLabel.Caption = '') or (form4.FactFieldComboBox.Text = '') then
        form4.BtQuery.Enabled := false
     else form4.BtQuery.Enabled := true;

end;

procedure TForm4.BitBtViewClick(Sender: TObject);
begin
     form5.showmodal;
end;

procedure TForm4.Print1Click(Sender: TObject);
var start,stop,i : integer;
begin
     PrintDialog1.Options := [poPageNums, poSelection,poWarning];
     PrintDialog1.FromPage := 1;
     PrintDialog1.MinPage := 1;
     PrintDialog1.ToPage := 1;
     PrintDialog1.MaxPage := 1;
     if PrintDialog1.Execute then
     begin{ determine the range the user wants to print }
    with PrintDialog1 do
     begin
        if PrintRange = prAllPages then
        begin
            Start := MinPage - 1;
            Stop := MaxPage - 1;
        end
        else if PrintRange = prSelection then
        begin
             Start := 1;
             Stop := Start;
        end
        else  { PrintRange = prPageNums }
        begin
             Start := FromPage - 1;
             Stop := ToPage - 1;
        end;
     end;
     { now, print the pages }
     with Printer do
     begin
          BeginDoc;
          for I := Start to Stop do
          begin
               DecisionGrid1.PaintTo(Handle, 20, 20);
               if I <> Stop then
                  NewPage;
          end;
          EndDoc;
     end;
  end;

end;

procedure TForm4.Graph1Click(Sender: TObject);
begin
     form8.showmodal;
end;

procedure TForm4.English1Click(Sender: TObject);
begin
     form4.SwitchToEnglish;
     form2.SwitchToEnglish;
     SwitchMode := English;
end;

procedure TForm4.Thai1Click(Sender: TObject);
begin
     form4.SwitchToThai;
     form2.SwitchToThai;
     SwitchMode := Thai;
end;

procedure TForm4.SwitchToEnglish;
begin
     form4.Groupbox3.Caption := '       view       ';
     form4.GroupBox1.Caption := '  Constraint  ';
     form4.GroupBox2.Caption := '  Select Measure  ';
     form4.BtCondition.Caption := 'Set Condition';
     form4.BTClearCon.Caption := 'Clear Condition';
     form4.BtSetTime.Caption := 'Setting';
     form4.BtQuery.Caption := 'Query';
     form4.BtSQL.Caption  := 'SQL Script';

     form4.GroupBox4.Caption := ' Aggregation Table ';
     form4.RdoNone.Caption := 'None';
     form4.RdoMonth.Caption := 'Month';
     form4.RdoYear.Caption := 'Year';

     Mainmenu1.Items.Items[0].Caption := '&File';
     Mainmenu1.Items.Items[0].Items[0].Caption := '&Create Model...';
     Mainmenu1.Items.Items[0].Items[1].Caption := '&Load Model...';
     Mainmenu1.Items.Items[0].Items[3].Caption := '&Print';
     Mainmenu1.Items.Items[0].Items[5].Caption := 'E&xit';

     Mainmenu1.Items.Items[1].Caption := '&Graph';

     Mainmenu1.Items.Items[2].Caption := '&Language';
     Mainmenu1.Items.Items[2].Items[0].Caption := '&English';
     Mainmenu1.Items.Items[2].Items[1].Caption := '&Thai';

     form5.Caption := 'Select Diminsion Table';
     form5.Label1.Caption := 'Dimensions';
     form5.Label2.Caption := 'Fields';
     form5.BtAdd.Caption := 'Add';
     form5.BtRem.Caption := 'Remove';
     form5.BtOk.Caption := 'Ok';

     form6.Caption := 'Set Condition';
     form6.Label1.Caption := 'Dimensions';
     form6.Label2.Caption := 'Fields';
     form6.GroupBox2.Caption := '  Condition  ';
     form6.BtAnd.Caption := 'and';
     form6.BtOr.Caption := 'or';
     form6.BtClear.Caption := 'Clear';
     form6.BtOk.Caption := 'Ok';
     form6.BtCancel.Caption := 'Cancel';

     form8.Caption := 'Graph';
end;

procedure TForm4.SwitchToThai;
begin
     form4.Groupbox3.Caption := '       มุมมอง       ';
     form4.GroupBox1.Caption := '  เงื่อนไข  ';
     form4.GroupBox2.Caption := '  เลือกตัววัด  ';
     form4.BtCondition.Caption := 'กำหนดเงื่อนไข';
     form4.BTClearCon.Caption := 'ลบเงื่อนไข';
     form4.BtSetTime.Caption := 'เวลา';
     form4.BtQuery.Caption := 'ถาม';
     form4.BtSQL.Caption  := 'คำสั่ง SQL';

     form4.GroupBox4.Caption := ' ตาราง Aggregation ';
     form4.RdoNone.Caption := 'ไม่มี';
     form4.RdoMonth.Caption := 'รายเดือน';
     form4.RdoYear.Caption := 'รายปี';

     Mainmenu1.Items.Items[0].Caption := 'แฟ้ม';
     Mainmenu1.Items.Items[0].Items[0].Caption := 'สร้างโมเดล...';
     Mainmenu1.Items.Items[0].Items[1].Caption := 'เปิดโมเดล...';
     Mainmenu1.Items.Items[0].Items[3].Caption := 'พิมพ์...';
     Mainmenu1.Items.Items[0].Items[5].Caption := 'จบการทำงาน';

     Mainmenu1.Items.Items[1].Caption := 'กราฟ';

     Mainmenu1.Items.Items[2].Caption := 'เลือกภาษา';
     Mainmenu1.Items.Items[2].Items[0].Caption := 'อังกฤษ';
     Mainmenu1.Items.Items[2].Items[1].Caption := 'ไทย';

     form5.Caption := 'เลือกตารางไดเมนชั่น';
     form5.Label1.Caption := 'ไดเมนชั่น';
     form5.Label2.Caption := 'ฟิลด์';
     form5.BtAdd.Caption := 'เพิ่ม';
     form5.BtRem.Caption := 'ลบ';
     form5.BtOk.Caption := 'ตกลง';

     form6.Caption := 'กำหนดเงื่อนไข';
     form6.Label1.Caption := 'ไดเมนชั่น';
     form6.Label2.Caption := 'ฟิลด์';
     form6.GroupBox2.Caption := '  เงื่อนไข  ';
     form6.BtAnd.Caption := 'and';
     form6.BtOr.Caption := 'or';
     form6.BtClear.Caption := 'ล้าง';
     form6.BtOk.Caption := 'ตกลง';
     form6.BtCancel.Caption := 'ยกเลิก';

     form8.Caption := 'กราฟ';
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
     Switchmode := English;
end;


end.
