program hrclient;

uses
  Forms,
  MainMenu in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\MainMenu.pas' {Form9},
  timeEntry in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\timeEntry.pas' {Form3},
  departmentEdit in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\departmentEdit.pas' {Form4},
  absentEntry in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\absentEntry.pas' {Form5},
  emp_dataEntry in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\emp_dataEntry.pas' {Form2},
  empInfo in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\empInfo.pas' {Form7},
  departmentsEmp in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\departmentsEmp.pas' {Form8},
  personal_info in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\personal_info.pas' {Form11},
  empedu in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\empedu.pas' {Form13},
  emp_earning in '..\..\..\..\..\..\Program Files\Borland\Delphi4\Projects\userinterface1\emp_earning.pas' {Form14};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.Run;
end.
