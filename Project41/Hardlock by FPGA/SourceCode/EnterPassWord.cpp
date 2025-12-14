//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop
#include "ApplicationLock.h"
#include "EnterPassWord.h"
#include "ReadiniFile.cpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TEnterPassWindows *EnterPassWindows;
//---------------------------------------------------------------------------
__fastcall TEnterPassWindows::TEnterPassWindows(TComponent* Owner)
	: TForm(Owner)
{
	Password->PasswordChar='*';
 	Password->MaxLength=7;
}
//---------------------------------------------------------------------------
void __fastcall TEnterPassWindows::OkPassButtonClick(TObject *Sender)
{
	String Passwrd;
    ReadiniFile PasswordCheck;
    PasswordCheck.RdiniFile("Password.cfg","[password]");
    Passwrd=Password->Text;
    if (Passwrd==PasswordCheck.Value)
    {
        EnterPassWindows->Hide();
    	MainWindows->Show();
    }else
    {
        Password->Text="";
    	StatusCheck->SimpleText="Incorrect password";
    }
}

//---------------------------------------------------------------------------
void __fastcall TEnterPassWindows::CancelPassButtonClick(TObject *Sender)
{
	Password->Text="";
}
//---------------------------------------------------------------------------