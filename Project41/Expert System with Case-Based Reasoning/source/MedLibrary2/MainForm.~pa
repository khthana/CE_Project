unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMedForm = class(TForm)
    Label1: TLabel;
    MedNo: TEdit;
    Label2: TLabel;
    MedName: TEdit;
    EnterButton: TButton;
    ShowButton: TButton;
    CancelButton: TButton;
    PreviousButton: TButton;
    NextButton: TButton;
    LoadButton: TButton;
    SaveButton: TButton;
    ExitButton: TButton;
    Label3: TLabel;
    MedDetail: TEdit;
    Label4: TLabel;
    MedAdult: TEdit;
    MedYouth: TEdit;
    Label5: TLabel;
    procedure ExitButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ShowButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
    MedicineRecord = record
                     MedNo : byte;
                     MedName : String[30];
                     Detail : String[255];
                     Adult : String[255];
                     Youth : String[255];
                     End;
var
   MedLib : Array[1..255] of MedicineRecord;
   MedIndex : byte;
   MedForm: TMedForm;
   FileName : String;

implementation

uses LoadMed, SaveMed;


{$R *.DFM}

procedure TMedForm.ExitButtonClick(Sender: TObject);
begin
     MedForm.Close;
end;

procedure TMedForm.EnterButtonClick(Sender: TObject);
var
   No : byte;
   Error : integer;
   TempStr : String;
begin
     If (MedNo.Text <> '') and (MedName.Text <> '') then
     begin
     Val(MedNo.Text,No,Error);
     MedLib[No].MedNo := No;
     MedLib[No].MedName := MedName.Text;
     MedLib[No].Detail := MedDetail.Text;
     MedLib[No].Adult := MedAdult.Text;
     MedLib[No].Youth := MedYouth.Text;
     If No = MedIndex then
     begin
          Inc(MedIndex);
          Str(MedIndex,TempStr);
          MedNo.Text := TempStr;
          MedName.Text := '';
          MedDetail.Text := '';
          MedAdult.Text := '';
          MedYouth.Text := '';
     end;
     end;
end;

procedure TMedForm.FormCreate(Sender: TObject);
begin
     MedIndex := 1;
end;

procedure TMedForm.FormShow(Sender: TObject);
var
   TempStr : String;
begin
     Str(MedIndex,TempStr);
     MedNo.Text := TempStr;
end;

procedure TMedForm.CancelButtonClick(Sender: TObject);
begin
     MedNo.Text := '';
     MedName.Text := '';
end;

procedure TMedForm.ShowButtonClick(Sender: TObject);
var
   No :  byte;
   Error : integer;
begin
     If MedNo.Text <> '' then
     begin
          Val(MedNo.Text,No,Error);
          If No < MedIndex then
          begin
             MedName.Text := MedLib[No].MedName;
             MedDetail.Text := MedLib[No].Detail;
             MedAdult.Text := MedLib[No].Adult;
             MedYouth.Text := MedLib[No].Youth;
          end;
     end;
end;

procedure TMedForm.LoadButtonClick(Sender: TObject);
begin
     LoadForm.show;
     MedForm.hide;
end;

procedure TMedForm.SaveButtonClick(Sender: TObject);
begin
     SaveForm.show;
     MedForm.hide;
end;

procedure TMedForm.PreviousButtonClick(Sender: TObject);
var
   No : byte;
   Error : integer;
   TempStr : String;
begin
     Val(MedNo.Text,No,Error);
     Dec(No);
     Str(No,TempStr);
     If (No > 0) and (No < MedIndex) then
     begin
        MedName.Text := MedLib[No].MedName;
        MedDetail.Text := MedLib[No].Detail;
        MedAdult.Text := MedLib[No].Adult;
        MedYouth.Text := MedLib[No].Youth;
        MedNo.Text := TempStr;
     end;
end;

procedure TMedForm.NextButtonClick(Sender: TObject);
var
   No : byte;
   Error : integer;
   TempStr : String;
begin
     Val(MedNo.Text,No,Error);
     Inc(No);
     Str(No,TempStr);
     If (No < MedIndex) then
     begin
        MedName.Text := MedLib[No].MedName;
        MedDetail.Text := MedLib[No].Detail;
        MedAdult.Text := MedLib[No].Adult;
        MedYouth.Text := MedLib[No].Youth;
        MedNo.Text := TempStr;
     end
     Else If No = MedIndex then
     begin
          MedName.Text := '';
          MedDetail.Text := '';
          MedAdult.Text := '';
          MedYouth.Text := '';
          MedNo.Text := TempStr;
     end;
end;






end.
