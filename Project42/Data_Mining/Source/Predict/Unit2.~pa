unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    AddDateEd: TEdit;
    Label2: TLabel;
    AddNumberEd: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    SubmitBtn: TButton;
    AddBtn: TButton;
    Button1: TButton;
    procedure SubmitBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.SubmitBtnClick(Sender: TObject);
var
  s : string;
  NextDay : TDateTime;
begin
  if (ComboBox1.Text = '') or
     (ComboBox2.Text = '') then
  begin
     MessageDlg('Missing Input !  ' +
     'Please specify value for every input field.', mtError,[mbOK],0);
     Exit;
  end
  else begin
    s := ComboBox1.Text + ComboBox2.Text;
  end;
  with Form1.PRIZETABLE do
  begin
    Append;
    FieldByName('PDATE').AsString := AddDateEd.Text;
    FieldByName('PRIZE').AsInteger := StrToInt(s);
    FieldByName('PNUMBER').AsInteger := StrToInt(AddNumberEd.Text);
    Post;
  end;{with table}
  //Next Data Number
  Unit1.NextDataNumber := Unit1.NextDataNumber + 1;
  //Next Reward Date
  NextDay := StrToDate(AddDateEd.Text);
  Form1.FindNextRewardDay(NextDay);
  Unit1.LastDay := DateToStr(NextDay);
  SubmitBtn.Enabled := False;
  AddBtn.Enabled := True;
  Form1.Refresh;
end;

procedure TForm2.AddBtnClick(Sender: TObject);
begin
  ComboBox1.ItemIndex := -1;
  ComboBox2.ItemIndex := -1;
  AddNumberEd.Text := IntToStr(Unit1.NextDataNumber);
  AddDateEd.Text := Unit1.LastDay;
  AddBtn.Enabled := False;
  SubmitBtn.Enabled := True;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  AddDateEd.Text := Unit1.LastDay;
  AddNumberEd.Text := IntToStr(Unit1.NextDataNumber);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex := -1;
  ComboBox2.ItemIndex := -1;
  ComboBox1.SetFocus;
  AddDateEd.Text := Unit1.LastDay;
  AddNumberEd.Text := IntToStr(Unit1.NextDataNumber);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.Close;
end;

end.
