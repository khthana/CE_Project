unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, DBTables;


type
  TForm1 = class(TForm)
    Label29: TLabel;
    Label30: TLabel;
    edit2: TEdit;
    Edit1: TEdit;
    Button11: TButton;
    Button1: TButton;
    room_items: TComboBox;
    com_items: TComboBox;
    Type_Items: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    admin_iD : string[10];
    status : string;
    function changedate(strdate:string):Tdate;
    procedure updateType_Items;
    procedure updateRoom_Items;
    procedure updateCom_Items;
    function  encode ( text :string ):string;
  end;
var
  Form1: TForm1;
implementation
uses unit2,unit3;
{$R *.DFM}
function Tform1.encode ( text :string ):string;
var
   temp1,temp2 : string[1];
   i : integer;
   TempChar1,TempChar2 :char;
begin
     for i := 0 to (length(text)-1)div 2  do
     begin
          TempChar1 := text [1+i];
          TempChar2 := text[length(text)-i];
        asm
            mov ah,TempChar1;
            mov al,TempChar2;
            add al,ah;
            mov TempChar1,al;

            mov ah,TempChar1;
            mov al,TempChar2;
            sub al,ah;
            mov TempChar2,al;
        end;
        text[i+1] := TempChar1;
        text[length(text)-i] := Tempchar2;
     end;
     encode := text;
end;
procedure Tform1.updateType_Items;
begin
     type_items.Clear;
     form3.query1.close;
     form3.query1.sql.Text := 'select * from type';
     form3.query1.Open;
     form3.query1.First;
     while not form3.query1.Eof do
     begin
          type_items.Items.Add(form3.query1.fieldvalues['type_name']);
          form3.query1.Next;
     end;
end;
procedure Tform1.updateRoom_Items;
begin
     room_items.Clear;
     form3.query1.close;
     form3.query1.sql.Text := 'select * from room';
     form3.query1.Open;
     form3.query1.First;
     while not form3.query1.Eof do
     begin
          room_items.Items.Add(form3.query1.fieldvalues['room_name']);
          form3.query1.Next;
     end;
end;
procedure Tform1.updateCom_Items;
var
   temp1,temp2 :string;
begin
     com_items.Clear;
     form3.query1.close;
     form3.query1.sql.Text := 'select com_id,com_name from company';
     form3.query1.Open;
     form3.query1.First;
     while not form3.query1.Eof do
     begin
          temp1 := form3.query1.fieldvalues['com_id'];
          temp2 := form3.query1.fieldvalues['com_name'];
          com_items.Items.Add( temp1 +' : ' +temp2);
          form3.query1.Next;
     end;
end;
function Tform1.Changedate(StrDate :string):Tdate;
var
   i1,i2,i3,temp1:integer;
   StrMonth,StrDay,StrYear,Stemp :string ;
begin
     StrMonth := '  ';
     StrDay := '  ';
     StrYear := '    ';
     i1:=0;
     repeat
          inc(i1);
          if StrDate[i1] = '/' then
             for i3 := 1 to i1-1 do
                 StrMonth[i3] := StrDate[i3];
     until StrDate[i1] = '/';
     i2 := i1 ;
     repeat
           inc(i2);
          if StrDate[i2] = '/' then
             for i3 := 1 to i2-1-i1 do
                 Strday[i3] := StrDate[i1+i3];
     until StrDate[i2] = '/';
     temp1 := 1;
     for i3 := i2+1 to length(strdate) do
       begin
            StrYear[temp1] := StrDate[i3];
            inc(temp1);
       end;
     //if strtoint(StrYear) >
     changedate := strtodate(StrDay +'/' +StrMonth +'/' +StrYear );
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     form1.Close;
     form2.Close;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
     TRY
{     form3.query1.SQL.clear;
     form3.Query1.SQL.Add ('select status from Tadmin where ID = :id and password = :password');
     form3.query1.ParamByName('id').asstring := edit1.text;
     form3.query1.ParamByName('password').asstring := edit2.text;
     form3.Query1.open;
// check can pass or not
     if (form3.Query1.RecordCount = 1) and ((form3.Query1.FieldValues['status'] = 'TA')or(form3.Query1.FieldValues['status'] = 'AD')) then
     begin }
     ///////////////////////////////////////////////////////login
     form3.database1.Params.Clear;
     form3.database1.Params.Add('Database Name=data_stores ');
     form3.database1.Params.Add('User Name='+edit1.Text);
     form3.database1.Params.Add('PASSWORD='+edit2.Text);
     form3.database1.Open;
     form2.query1.close;
     form2.query1.SQL.Clear;
     form2.query1.sql.Add(' use data_stores set dateformat dmy ');
     form2.query1.ExecSQL;

// check again
     form3.Query1.close;
     form3.query1.SQL.clear;
     form3.Query1.SQL.Add ('select status from Tadmin where ID = :id and password = :password');
     form3.query1.ParamByName('id').asstring := edit1.text;
     form3.query1.ParamByName('password').asstring := encode(edit2.text);
     form3.Query1.open;
// check can pass or not
     if (form3.Query1.RecordCount = 1) and ((form3.Query1.FieldValues['status'] = 'TA')or(form3.Query1.FieldValues['status'] = 'AD')) then
     begin

          status := form3.Query1.FieldValues['status'];
          admin_id := edit1.text;

// add to all Items
   // Type_Items
//     type_items.clear;
      updateType_items;
// Room_Items
      updateRoom_items;
// com_Items
      updateCom_Items;
      form1.Visible:=false;
      form2.visible := true;
     end //end if can pass
     else
     begin
         showmessage('Login incorrect');
         form3.Database1.Close;
         exit;
     end;
except
      //edit2.Clear;
      on EDBEngineError do MessageDlg('Login incorrect',mtError,[mbOK],0);
      //edit1.Clear;
 end;
end;

end.
