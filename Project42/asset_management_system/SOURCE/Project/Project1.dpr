program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {company_add},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit6_1 in 'Unit6_1.pas' {Form6_1},
  Unit2_2 in 'Unit2_2.pas' {Form2_2},
  Unit2_3 in 'Unit2_3.pas' {Form2_3},
  Unit7_1 in 'Unit7_1.pas' {Form7_1},
  Unit7_2 in 'Unit7_2.pas' {Form7_2},
  Unit7_3 in 'Unit7_3.pas' {Form7_3},
  Unit7_4 in 'Unit7_4.pas' {Form7_4},
  Unit7_5 in 'Unit7_5.pas' {Form7_5},
  Unit7_6 in 'Unit7_6.pas' {Form7_6},
  Unit2_4 in 'Unit2_4.pas' {Form2_4},
  Unit10 in 'Unit10.pas' {Form10},
  Unit9 in 'Unit9.pas' {Form9_a},
  Unit7_7 in 'Unit7_7.pas' {Form7_7},
  Unit7_8 in 'Unit7_8.pas' {Form7_8},
  Unit7 in 'Unit7.pas' {user},
  Unit8 in 'Unit8.pas' {adduser},
  Unit_store in 'Unit_store.pas' {Form11},
  Unit12 in 'Unit12.pas' {Form12};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm9_a, Form9_a);
  Application.Run;
end.
