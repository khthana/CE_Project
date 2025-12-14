unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, OleCtrls;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    FileExitItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    FileExit1: TAction;
    HelpAbout1: TAction;
    ToolBar2: TToolBar;
    ImageList1: TImageList;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    Report1: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    Rep1: TAction;
    Rep2: TAction;
    Rep3: TAction;
    Rep4: TAction;
    Tools1: TMenuItem;
    Update1: TMenuItem;
    Check1: TMenuItem;
    ToolUpdate: TAction;
    ToolCheck: TAction;
    SearchEdit: TMenuItem;
    ToolShow: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Rep5: TAction;
    Rep6: TAction;
    Rep7: TAction;
    Rep8: TAction;
    N12: TMenuItem;
    N22: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure Rep1Execute(Sender: TObject);
    procedure Rep2Execute(Sender: TObject);
    procedure Rep3Execute(Sender: TObject);
    procedure Rep4Execute(Sender: TObject);
    procedure ToolShowExecute(Sender: TObject);
    procedure ToolCheckExecute(Sender: TObject);
    procedure ToolUpdateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rep5Execute(Sender: TObject);
    procedure Rep6Execute(Sender: TObject);
    procedure Rep7Execute(Sender: TObject);
    procedure Rep8Execute(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Func1,Func2,Func3 : boolean ;

implementation

{$R *.DFM}

uses About,unit2,unit9, Unit5, Unit6, Unit7, Unit8,unit3,Unit1;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Rep1Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('Select *');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''T%''') ;
          query3.SQL.Add('Order by BKCALL DESC') ;
          query3.open ;
     end ;
     quickreport5.preview ;
end;

procedure TMainForm.Rep2Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('Select YEAR_LOST,BKCALL,BKCODE,BKGROUP,BKNAME');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''T%''') ;
          query3.SQL.Add('Order by YEAR_LOST,BKCALL DESC') ;
          query3.open ;
     end ;
     quickreport6.preview ;
end;

procedure TMainForm.Rep3Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('SELECT BKGROUP,COUNT(*)');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''T%''') ;
          query3.SQL.Add('GROUP BY BKGROUP') ;
          query3.SQL.Add('ORDER BY BKGROUP DESC') ;
          query3.open ;
     end ;
     quickreport7.preview ;
end;

procedure TMainForm.Rep4Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('SELECT YEAR_LOST,BKGROUP,COUNT(*)');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''T%''') ;
          query3.SQL.Add('GROUP BY YEAR_LOST,BKGROUP') ;
          query3.SQL.Add('ORDER BY YEAR_LOST,BKGROUP DESC') ;
          query3.open ;
     end ;
     quickreport8.preview ;
end;

procedure TMainForm.ToolShowExecute(Sender: TObject);
begin
     if not func1 then
     begin
          tform2.create(self) ;
          func1 := true ;
     end;
end;

procedure TMainForm.ToolCheckExecute(Sender: TObject);
begin
     if not func2 then
     begin
          Tform3.create(self) ;
          func2 := true ;
     end;
end;

procedure TMainForm.ToolUpdateExecute(Sender: TObject);
begin
     if not func3 then
     begin
          Tform9.create(self) ;
          func3 := true ;
     end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var Pname : string ;
begin
     getdir(0,Pname) ;
     Pname := Pname + '\db_a' ;
     datamodule1.Database1.Close ;
     datamodule1.Table1.Active := false ;
     datamodule1.Database1.Params.Text := 'PATH='+ Pname;
end;

procedure TMainForm.Rep5Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('Select *');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''E%''') ;
          query3.SQL.Add('Order by BKCALL DESC') ;
          query3.open ;
     end ;
     quickreport5.preview ;
end;

procedure TMainForm.Rep6Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('Select YEAR_LOST,BKCALL,BKCODE,BKGROUP,BKNAME');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''E%''') ;
          query3.SQL.Add('Order by YEAR_LOST,BKCALL DESC') ;
          query3.open ;
     end ;
     quickreport6.preview ;
end;

procedure TMainForm.Rep7Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('SELECT BKGROUP,COUNT(*)');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''E%''') ;
          query3.SQL.Add('GROUP BY BKGROUP') ;
          query3.SQL.Add('ORDER BY BKGROUP DESC') ;
          query3.open ;
     end ;
     quickreport7.preview ;
end;

procedure TMainForm.Rep8Execute(Sender: TObject);
begin
     with datamodule1 do
     begin
          query3.Close ;
          query3.SQL.Clear ;
          query3.SQL.Add('SELECT YEAR_LOST,BKGROUP,COUNT(*)');
          query3.SQL.Add('From LIBBK2') ;
          query3.SQL.Add('Where STATUS = ''1'' and BKCODE like ''E%''') ;
          query3.SQL.Add('GROUP BY YEAR_LOST,BKGROUP') ;
          query3.SQL.Add('ORDER BY YEAR_LOST,BKGROUP DESC') ;
          query3.open ;
     end ;
     quickreport8.preview ;
end;

end.
