unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, ComCtrls, GIFImage;

type
    TAddStatus = (AddDimension,AddFact,AddAgreFactMonth,AddAgreFactYear);

  TForm2 = class(TForm)
    BtRemDim: TButton;
    BtAddFact: TButton;
    BtRemFact: TButton;
    FactFieldListBox: TListBox;
    BtSave: TButton;
    MainMenu1: TMainMenu;
    NewModel1: TMenuItem;
    New1: TMenuItem;
    Save: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    BtAddDim: TButton;
    FactTableListBox: TListBox;
    SaveAS1: TMenuItem;
    BtSaveAs: TButton;
    SaveDialog: TSaveDialog;
    Open1: TMenuItem;
    N2: TMenuItem;
    OpenDialog: TOpenDialog;
    DimTV: TTreeView;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    View1: TMenuItem;
    English1: TMenuItem;
    Thai1: TMenuItem;
    Manual: TButton;
    GroupBox3: TGroupBox;
    BtMonth: TButton;
    BtYear: TButton;
    EditMonth: TEdit;
    EditYear: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    AgreCheckBox: TCheckBox;
    Panel2: TPanel;
    GIFImage1: TGIFImage;
    procedure BtAddDimClick(Sender: TObject);
    procedure BtRemDimClick(Sender: TObject);
    procedure BtAddFactClick(Sender: TObject);
    procedure BtRemFactClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure BtSaveAsClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure SaveAS1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure DimTVClick(Sender: TObject);
    procedure DimTVDblClick(Sender: TObject);
    procedure Thai1Click(Sender: TObject);
    procedure English1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure manualClick(Sender: TObject);
    procedure AgreCheckBoxClick(Sender: TObject);
    procedure BtMonthClick(Sender: TObject);
    procedure BtYearClick(Sender: TObject);
  private
    { Private declarations }
    procedure SaveModel;
    procedure LoadModel;
  public
    { Public declarations }
    procedure SwitchToThai;
    procedure SwitchToEnglish;
  end;

var
  Form2: TForm2;
  AddStatus :TAddStatus;
  SaveStr :string;
  SaveReady , LoadReady :boolean;

  ModelDatabaseName :string;

  ModelFileHandle : textfile;
  ModelFileName :string;
  ModelTVFileName :string;

  DimTVSelected :boolean;


implementation

uses Unit3, Unit1, Unit7, Unit4, Unit5;

{$R *.DFM}

procedure TForm2.New1Click(Sender: TObject);
begin
     ModelDatabaseName := '';
     SaveReady := false;

     form3 := Tform3.Create(self);

     if Switchmode = English then
        ModelFileName := InputBox('Create New Model','Enter your model''s name : ','')
     else
        ModelFileName := InputBox('สร้างโมเดลใหม่','กรุณาป้อนชื่อโมเดล : ','');

     if ModelFileName <> '' then
     begin

          ModelFileName := ModelFileName + '.tam';
          ModelTVFileName := ModelFileName + '~';
          if SwitchMode = English then
             Form2.Caption := 'Create Model - ' + ModelFileName
          else
              Form2.Caption := 'สร้างโมเดล - ' + ModelFileName;

          DimTV.Items.Clear;
          FactFieldListBox.Clear;
          FactTableListBox.Clear;
          Label1.Caption := '0';
          Label2.Caption := '0';

          EditMonth.Text := '';
          EditYear.Text := '';
          AgreCheckbox.State := CbUnchecked;
          Groupbox3.Visible := false;

          Panel1.Visible := false;
     end;
end;

procedure TForm2.BtAddDimClick(Sender: TObject);
begin
     AddStatus := AddDimension;

     if SwitchMode = English then
        form3.Caption := 'Add Dimension'
     else form3.Caption := 'เพิ่มไดเมนชั่น';

     form3.FieldListBox.Enabled := false;
     form3.showmodal;
end;

procedure TForm2.BtRemDimClick(Sender: TObject);
begin
{level}
     if  (DimTV.Items.Count <> 0) and DimTVSelected then
         DimTv.Items.Delete(DimTV.selected);

     DimTVSelected := false;

     label1.Caption := IntToStr(DimTV.Items.Count);
end;

procedure TForm2.BtAddFactClick(Sender: TObject);
begin
     AddStatus := AddFact;

     if SwitchMode = English then
        form3.Caption := 'Add Fact Field'
     else form3.Caption := 'เพิ่มตัววัด';

     form3.FieldListBox.Enabled := true;
     form3.showmodal;
end;

procedure TForm2.BtRemFactClick(Sender: TObject);
begin
     if  (FactFieldListbox.Items.Capacity <> 0) and (FactFieldListbox.Selected[FactFieldListbox.ItemIndex]) then
     begin
         FactFieldListbox.Items.Delete(FactFieldListbox.ItemIndex);
         FactTableListbox.Items.Delete(FactTableListbox.ItemIndex);
     end;
     label2.Caption := IntToStr(FactFieldListbox.Items.Capacity);
end;

procedure TForm2.BtSaveClick(Sender: TObject);
begin

     if (EditMonth.Text = '') and (EditYear.Text = '') then
     begin
          AgreCheckbox.State := CbUnchecked;
          Groupbox3.Visible := false;
     end;

     if SaveReady = false then
     begin
          SaveDialog.FileName := ModelFileName;
          if SaveDialog.Execute then
          begin
               ModelFileName := SaveDialog.FileName;
               ModelTVFileName := ModelFileName + '~';

               SaveModel;

               Form2.Caption := 'Create Model - ' + ModelFileName;
               SaveReady := true;
          end;
     end else
     begin
          SaveModel;
     end;
end;

procedure TForm2.SaveClick(Sender: TObject);    {dup}
begin

     if (EditMonth.Text = '') and (EditYear.Text = '') then
     begin
          AgreCheckbox.State := CbUnchecked;
          Groupbox3.Visible := false;
     end;

     if SaveReady = false then
     begin
          SaveDialog.FileName := ModelFileName;
          if SaveDialog.Execute then
          begin
               ModelFileName := SaveDialog.FileName;
               ModelTVFileName := ModelFileName + '~';

               SaveModel;

               Form2.Caption := 'Create Model - ' + ModelFileName;
               SaveReady := true;
          end;
     end else
     begin
          SaveModel;
     end;
end;

procedure TForm2.BtSaveAsClick(Sender: TObject);
begin

     if (EditMonth.Text = '') and (EditYear.Text = '') then
     begin
          AgreCheckbox.State := CbUnchecked;
          Groupbox3.Visible := false;
     end;

     SaveDialog.FileName := ModelFileName;
     if SaveDialog.Execute then
     begin
          ModelFileName := SaveDialog.FileName;
          ModelTVFileName := ModelFileName + '~';

          SaveModel;

          Form2.Caption := 'Create Model - ' + ModelFileName;
     end;
end;

procedure TForm2.SaveAS1Click(Sender: TObject);      {dup}
begin

     if (EditMonth.Text = '') and (EditYear.Text = '') then
     begin
          AgreCheckbox.State := CbUnchecked;
          Groupbox3.Visible := false;
     end;

     SaveDialog.FileName := ModelFileName;
     if SaveDialog.Execute then
     begin
          ModelFileName := SaveDialog.FileName;
          ModelTVFileName := ModelFileName + '~';

          SaveModel;

          Form2.Caption := 'Create Model - ' + ModelFileName;
     end;
end;

procedure TForm2.Exit1Click(Sender: TObject);
begin
     close;
end;

procedure TForm2.SaveModel;
begin
{level}
     SaveStr := ':DBName:'#13#10 + ModelDatabaseName + #13#10;

     SaveStr := SaveStr + ':FactMonth:'#13#10;
     if AgreCheckbox.state = Cbchecked then
        SaveStr := SaveStr + EditMonth.Text + #13#10
     else SaveStr := SaveStr + '' + #13#10;

     SaveStr := SaveStr + ':FactYear:'#13#10;
     if AgreCheckbox.state = Cbchecked then
        SaveStr := SaveStr + EditYear.Text + #13#10
     else SaveStr := SaveStr + '' + #13#10;

     SaveStr := SaveStr + ':FactField:'#13#10 + FactFieldListbox.Items.Text;
     SaveStr := SaveStr + ':FactTable:'#13#10 + FactTableListbox.Items.Text;

     assignfile(ModelFileHandle,ModelFileName);
     rewrite(ModelFileHandle);
     write(ModelFileHandle,SaveStr);
     closefile(ModelFileHandle);

     DimTV.SaveToFile(ModelTVFileName);

end;

procedure TForm2.LoadModel;
var st :string;
begin
     assignfile(ModelFileHandle,ModelFileName);
     reset(ModelFileHandle);

     Readln(ModelFileHandle, st);              {:DBName:}
     if st = ':DBName:' then
     begin
          FactFieldListBox.Clear;
          FactTableListBox.Clear;

          Readln(ModelFileHandle,st);
          ModelDatabaseName := st;

          Readln(ModelFileHandle,st);          {:FactMonth:}
          Readln(ModelFileHandle,st);
          EditMonth.Text := st;

          Readln(ModelFileHandle,st);          {:FactYear:}
          Readln(ModelFileHandle,st);
          EditYear.Text := st;

          if (EditMonth.Text <> '') or (EditYear.Text <> '') then
          begin
               AgreCheckbox.State := Cbchecked;
               Groupbox3.Visible := true;
          end else
          begin
               AgreCheckbox.State := CbUnchecked;
               Groupbox3.Visible := false;
          end;

          Readln(ModelFileHandle,st);          {:FactField:}
          Readln(ModelFileHandle,st);
          while st <> ':FactTable:' do
          begin
               FactFieldListbox.Items.Add(st);
               Readln(ModelFileHandle,st);
          end;

          while not Eof(ModelFileHandle) do
          begin
               Readln(ModelFileHandle,st);
               FactTableListbox.Items.Add(st);
          end;
          closefile(ModelFileHandle);

          DimTV.LoadFromFile(ModelTVFileName);
{          if DimTV.Items.Count = 0 then DimTV.Refresh;}

          LoadReady := true;
     end
     else LoadReady := false;

end;

procedure TForm2.Open1Click(Sender: TObject);
begin
     if OpenDialog.Execute then
     begin
        ModelFileName := OpenDialog.FileName;
        ModelTVFileName := ModelFileName + '~';
        LoadReady := false;
        LoadModel;

        if LoadReady then  {if LoadReady = true}
        begin
             SaveReady := True;
             if SwitchMode = English then
                Form2.Caption := 'Create Model - ' + ModelFileName
             else
                 Form2.Caption := 'สร้างโมเดล - ' + ModelFileName;
             Form2.Label1.Caption := InttoStr(DimTV.Items.Count);
             Form2.Label2.Caption := InttoStr(FactFieldListbox.Items.Count);
             Panel1.Visible := false;

             form3 := Tform3.Create(self);
{form3 Connect}
             form3.AliasCombo.Text := ModelDatabaseName;

             form3.EnableComponent;
             form3.ListTable;

             form7 := Tform7.Create(self);
             form7.AliasCombo.Text := ModelDatabaseName;

        end
 {if LoadReady = false}
        else
        begin
           if Switchmode = English then
              MessageDlg('Cannot read this file.'+ #13#10 + 'This is not a valid tam file, or its format is not currently supported',mtError,[mbOK],0)
           else MessageDlg('ไม่สามารถอ่านไฟล์นี้ได้'+ #13#10 + 'เนื่องจากรูปแบบไม่ถูกต้อง',mtError,[mbOK],0);
        end;
     end;
end;


procedure TForm2.DimTVClick(Sender: TObject);
begin
     DimTVSelected := true;
end;


procedure TForm2.DimTVDblClick(Sender: TObject);
var    MyTreeNode :TTreenode;
       i :integer;
       stop :boolean;
begin
     Stop := false;
     if DimTV.Items.Count <> 0 then
     begin
          if DimTV.Selected.HasChildren = false then
          repeat
                form7.ListTable;
                if form7.TableListBox.Items.Count <> 0 then       {if exist related table}
                begin
                     if form7.TableListBox.Items.Count = 1 then   {add Auto}
                     begin
                          form7.Tablelistbox.ItemIndex := 0;
                          if (form7.TableListBox.Items.Count <> 0) then
                          begin
                               form2.DimTV.Items.AddChild(Form2.DimTV.selected,form7.TableListBox.Items[form7.TableListBox.ItemIndex]);
                               form2.Label1.Caption := IntToStr(form2.DimTV.Items.Count);
                          end;

                          MyTreenode := DimTV.Selected;
                          MyTreenode := Mytreenode.getFirstChild;
                          DimTV.Selected := Mytreenode;
                     end  else           {if > 1 add manual}
                     begin
                          i := DimTV.Items.Count;
                          form7.showmodal;
                          if DimTV.Items.Count > i then
                          begin
                               MyTreenode := DimTV.Selected;
                               MyTreenode := Mytreenode.getFirstChild;
                               DimTV.Selected := Mytreenode;
                          end else stop := true;
                     end;
                end;
          until stop or (form7.TableListBox.Items.Count = 0)
     end;

end;

procedure TForm2.SwitchToThai;
begin
     form2.BtAddDim.Caption := 'เพิ่มไดเมนชั่น';
     form2.BtRemDim.Caption := 'ลบไดเมนชั่น';
     form2.BtAddFact.Caption := 'เพิ่มตัววัด';
     form2.BtRemFact.Caption := 'ลบตัววัด';
     form2.GroupBox1.Caption := ' ไดเมนชั่น ';
     form2.GroupBox2.Caption := ' ตัววัด ';
     form2.BtSave.Caption := 'บันทึก';
     form2.BtSaveAs.Caption := 'บันทึกเป็น...';
     form2.Label3.Caption := 'รายการ';
     form2.Label4.Caption := 'รายการ';
     Form2.Caption := 'สร้างโมเดล - ' + ModelFileName;

     form2.GroupBox3.Caption := ' เลือกตาราง Aggregation ';
     form2.BtMonth.Caption := 'รายเดือน';
     form2.BtYear.Caption := 'รายปี';

     form3.Label1.Caption := 'ชื่อฐานข้อมูล';
     form3.BtConnect.Caption := 'เชื่อมต่อ';
     form3.Label4.Caption := 'ตาราง';
     form3.Label5.Caption := 'ฟิลด์';
     form3.BtSelect.Caption := 'เลือก';
     form3.BtCancel.Caption := 'ยกเลิก';

     form7.Label1.Caption := 'ชื่อฐานข้อมูล';
     form7.BtConnect.Caption := 'เชื่อมต่อ';
     form7.Label2.Caption := 'ตาราง';
     form7.Label3.Caption := 'ฟิลด์';
     form7.BtSelect.Caption := 'เลือก';
     form7.BtCancel.Caption := 'ยกเลิก';

     Mainmenu1.Items.Items[0].Caption := 'แฟ้ม';
     Mainmenu1.Items.Items[0].Items[0].Caption := 'สร้าง...';
     Mainmenu1.Items.Items[0].Items[1].Caption := 'เปิด...';
     Mainmenu1.Items.Items[0].Items[3].Caption := 'บันทึก';
     Mainmenu1.Items.Items[0].Items[4].Caption := 'บันทึกเป็น...';
     Mainmenu1.Items.Items[0].Items[6].Caption := 'จบการทำงาน';

     Mainmenu1.Items.Items[1].Caption := 'เลือกภาษา';
     Mainmenu1.Items.Items[1].Items[0].Caption := 'อังกฤษ';
     Mainmenu1.Items.Items[1].Items[1].Caption := 'ไทย';

end;

procedure TForm2.SwitchToEnglish;
begin
     form2.BtAddDim.Caption := 'Add Dimension';
     form2.BtRemDim.Caption := 'Remove Dimension';
     form2.BtAddFact.Caption := 'Add Fact Field';
     form2.BtRemFact.Caption := 'Remove Fact Field';
     form2.GroupBox1.Caption := ' Dimensions ';
     form2.GroupBox2.Caption := ' Fact Fields ';
     form2.BtSave.Caption := 'Save';
     form2.BtSaveAs.Caption := 'Save As...';
     form2.Label3.Caption := 'items';
     form2.Label4.Caption := 'items';
     Form2.Caption := 'Create Model - ' + ModelFileName;

     form2.GroupBox3.Caption := ' Select Aggregation Table ';
     form2.BtMonth.Caption := 'Month';
     form2.BtYear.Caption := 'Year';

     form3.Label1.Caption := 'Database Alias';
     form3.BtConnect.Caption := 'Connect';
     form3.Label4.Caption := 'List of Tables';
     form3.Label5.Caption := 'List of Fields';
     form3.BtSelect.Caption := 'Select';
     form3.BtCancel.Caption := 'Cancel';

     form7.Label1.Caption := 'Database Alias';
     form7.BtConnect.Caption := 'Connect';
     form7.Label2.Caption := 'List of Tables';
     form7.Label3.Caption := 'List of Fields';
     form7.BtSelect.Caption := 'Select';
     form7.BtCancel.Caption := 'Cancel';

     Mainmenu1.Items.Items[0].Caption := '&File';
     Mainmenu1.Items.Items[0].Items[0].Caption := '&New...';
     Mainmenu1.Items.Items[0].Items[1].Caption := '&Open...';
     Mainmenu1.Items.Items[0].Items[3].Caption := '&Save';
     Mainmenu1.Items.Items[0].Items[4].Caption := 'Save &As...';
     Mainmenu1.Items.Items[0].Items[6].Caption := 'E&xit';

     Mainmenu1.Items.Items[1].Caption := '&Language';
     Mainmenu1.Items.Items[1].Items[0].Caption := '&English';
     Mainmenu1.Items.Items[1].Items[1].Caption := '&Thai';
end;

procedure TForm2.Thai1Click(Sender: TObject);
begin
     form2.SwitchToThai;
     form4.SwitchToThai;
     SwitchMode := Thai;
end;


procedure TForm2.English1Click(Sender: TObject);
begin
     form2.SwitchToEnglish;
     form4.SwitchToEnglish;
     SwitchMode := English;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
     if SwitchMode = English then
        form2.SwitchToEnglish
     else form2.SwitchToThai;
end;

procedure TForm2.manualClick(Sender: TObject);
begin
     if DimTV.Items.Count <> 0 then
     begin
          if DimTV.Selected.HasChildren = false then
          begin
               if SwitchMode = English then
                  form7.Caption := 'Add Snow Flake Table to - ' + DimTV.Selected.Text
               else
                   form7.Caption := 'เพิ่มตารางลูก - ' + DimTV.Selected.Text;

               form7.ListTable;
               form7.showmodal;
          end;

     end;
end;

procedure TForm2.AgreCheckBoxClick(Sender: TObject);
begin
     if AgreCheckbox.State = CbChecked then
          groupbox3.Visible := true;
     if AgreCheckbox.State = CbUnchecked then
          Groupbox3.Visible := false;
end;

procedure TForm2.BtMonthClick(Sender: TObject);
begin
     AddStatus := AddAgreFactMonth;

     if SwitchMode = English then
        form3.Caption := 'Select Aggregation Table (by month)'
     else form3.Caption := 'เลือกตารางรายเดือน';

     form3.FieldListBox.Enabled := false;
     form3.showmodal;
end;

procedure TForm2.BtYearClick(Sender: TObject);
begin
     AddStatus := AddAgreFactYear;

     if SwitchMode = English then
        form3.Caption := 'Select Aggregation Table (by year)'
     else form3.Caption := 'เลือกตารางรายปี';

     form3.FieldListBox.Enabled := false;
     form3.showmodal;

end;

end.
