unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBTables, Db, Mask, DBCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    Query1: TQuery;
    Table1: TTable;
    Query2: TQuery;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Temp : String;

implementation

uses Unit5, Unit1;

{$R *.DFM}

Function  FindQuery(qryQuery :TQuery ; FieldIndex : integer ; KeyValue : Variant):Boolean;
var       CurRec : longint;
Begin
          with qryQuery do
          begin
               First;
               CurRec := 0;
               MoveBy(CurRec);
               while(Fields[FieldIndex].value <> KeyValue) and (CurRec <= RecordCount)do
               begin
                    CurRec := CurRec + 1;
                    Next;
               end;
               if Fields[FieldIndex].Value <> KeyValue
               then
                   Result := false
               else
                   Result := true;
                   Last;
          end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var       Key : String;
begin
          If (Edit1.Text = '') or (Edit2.Text = '')
          then
              If (Edit1.Text = '') and (Edit2.Text = '')
              then MessageDlg('Please insert your User Name and Password',mtWarning,[mbOK],0)
              else
                  If Edit1.Text = ''
                 then MessageDlg('Please insert your User Name',mtWarning,[mbOK],0)
                 else MessageDlg('Please insert your Password',mtWarning,[mbOK],0)
          else
          begin
               Key := Edit1.Text;
               Query1.Open;
               If FindQuery(Query1,0,Key) <> true
               then begin
                         MessageDlg('Incorrect User Name',mtError,[mbOK],0);
                         Edit1.Text := '';
                         Edit2.Text := '';
                    end
               else
                    begin
                        with Query2 do
                        begin
                             Close;
                             ParamByName('MyParameter').AsString := Edit1.Text;
                             Open;
                        end;
                        If Edit2.Text = DBEdit1.Text
                        then
                           begin
                                //Form3.Show;
                                //Form3.DBEdit1.Text := Form2.DBEdit2.Text;
                                //Form3.DBEdit2.Text := Form2.Edit1.Text;
                                //Form3.DBEdit3.Text := Form2.DBEdit3.Text;
                                Form5.Show;
                                Form5.DBEdit1.Text := Form2.DBEdit2.Text;
                                Form5.DBEdit2.Text := Form2.Edit1.Text;
                                Form5.DBEdit3.Text := Form2.DBEdit3.Text;
                                Edit1.Text := '';
                                Edit2.Text := '';
                                Form2.close;
                           end
                        else
                        begin
                            MessageDlg('Incorrect Password',mtError,[mbOK],0);
                            Edit1.Text := '';
                            Edit2.Text := '';
                        end;
                   end;
          end;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
     If Edit1.Text <> '' then
     begin
          Label2.Visible := True;
          Edit2.Visible := True;
     end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
          Edit1.Text := '';
          Edit2.Text := '';
          Form2.Close;
          Form1.Show;
end;

end.
