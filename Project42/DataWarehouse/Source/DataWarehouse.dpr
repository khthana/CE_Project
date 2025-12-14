program DataWarehouse;

uses
  Forms,
  Unit2 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit2.pas' {Form2},
  Unit3 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit3.pas' {Form3},
  Unit1 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit1.pas' {Form1},
  Unit4 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit4.pas' {Form4},
  Unit5 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit5.pas' {Form5},
  Unit6 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit6.pas' {Form6},
  Unit7 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit7.pas' {Form7},
  Unit8 in '..\..\DataWarehouse\tammy\version_oracle\ora9_complete\Unit8.pas' {Form8};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
