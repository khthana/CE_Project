unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,unit1,
  Grids, DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    panal1: TPanel;
    panal2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBEdit5: TDBEdit;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses unit4,main;

{$R *.DFM}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Main.Func1 := False ;
     action := caFree ;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var a : variant ;
    b : string[7] ;
    c : string ;
begin
     a := InttoStr(radiogroup1.ItemIndex) ;
     b := datamodule1.Query1.FieldValues['BKCODE'] ;
     c := datamodule1.Query1.Text ;
     with datamodule1 do
     begin
          query1.Close ;
          query1.SQL.Clear ;
          query1.SQL.Add('Update LIBBK2 Set STATUS = '+ ''''+a+''''+ ' Where BKCODE = ' +''''+ b +'''' ) ;
          query1.ExecSQL ;
          query1.SQL.Clear ;
          query1.SQL.Add(c) ;
          query1.open ;
          bitbtn1.Enabled := false ;
     end;
     edit1.text := inttostr(datamodule1.Query1.RecordCount) ;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
     Tform4.Create(self) ;

end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
     close ;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
     datamodule1.Query1.Close ;
     datamodule1.Query1.SQL.Clear ;
     datamodule1.Query1.SQL.Add('SELECT * FROM libbk2 ORDER BY BKCALL DESC ') ;
     datamodule1.Query1.open ;
     if datamodule1.Query1.FieldValues['STATUS'] = null then
        radiogroup1.ItemIndex := -1
     else
        radiogroup1.ItemIndex := datamodule1.Query1.FieldValues['STATUS'] ;
     edit1.text := inttostr(datamodule1.Query1.RecordCount) ;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
     if datamodule1.Query1.FieldValues['STATUS'] = null then
        radiogroup1.ItemIndex := -1
     else
        radiogroup1.ItemIndex := datamodule1.Query1.FieldValues['STATUS'] ;
     bitbtn1.Enabled := false ;
end;

procedure TForm2.RadioGroup1Click(Sender: TObject);
begin
     bitbtn1.Enabled := true ;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
     datamodule1.Query1.Close ;
     datamodule1.Query1.SQL.Clear ;
     datamodule1.Query1.SQL.Add('SELECT * FROM libbk2 ORDER BY BKCALL DESC ') ;
     datamodule1.Query1.open ;
     if datamodule1.Query1.FieldValues['STATUS'] = null then
        radiogroup1.ItemIndex := -1
     else
        radiogroup1.ItemIndex := datamodule1.Query1.FieldValues['STATUS'] ;

     edit1.text := inttostr(datamodule1.Query1.RecordCount) ;
     bitbtn1.Enabled := false ;
     
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
edit1.text := inttostr(datamodule1.Query1.RecordCount) ;
end;

end.
