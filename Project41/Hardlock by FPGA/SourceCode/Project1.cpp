//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("ApplicationLock.cpp", MainWindows);
USERES("Project1.res");
USEFORM("Config.cpp", ConfigurationWindows);
USEUNIT("ReadiniFile.cpp");
USEUNIT("WrteiniFile.cpp");
USEFORM("EnterPassWord.cpp", EnterPassWindows);
USEUNIT("ReadFileEnc.cpp");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
		Application->Initialize();
		Application->CreateForm(__classid(TEnterPassWindows), &EnterPassWindows);
		Application->CreateForm(__classid(TMainWindows), &MainWindows);
		Application->CreateForm(__classid(TConfigurationWindows), &ConfigurationWindows);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------
