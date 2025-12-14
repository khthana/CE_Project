//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop
#include "ApplicationLock.h"
#include "Config.h"
#include "ReadiniFile.cpp"
#include "WrteiniFile.cpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TConfigurationWindows *ConfigurationWindows;
//---------------------------------------------------------------------------
__fastcall TConfigurationWindows::TConfigurationWindows(TComponent* Owner)
	: TForm(Owner)
{
 OldPass->PasswordChar='*';
 OldPass->MaxLength=7;
 NewPass->PasswordChar='*';
 NewPass->MaxLength=7;
 ConfirmPass->PasswordChar='*';
 ConfirmPass->MaxLength=7;
 }
//---------------------------------------------------------------------------
void __fastcall TConfigurationWindows::ResetPasswordClick(TObject *Sender)
{
     OldPass->Text="";
     NewPass->Text="";
     ConfirmPass->Text="";
     ConfigurationWindows->Close();
}
//---------------------------------------------------------------------------
void __fastcall TConfigurationWindows::OkPasswordClick(TObject *Sender)
{
 String OldPassText,NewPassText,ConfirmPassText;
 ReadiniFile PasswordOld;
 ChangeiniFile WritePassword;
     PasswordOld.RdiniFile("Password.cfg","[password]");
     NewPassText = NewPass->Text;
     ConfirmPassText = ConfirmPass->Text;
     OldPassText = OldPass->Text;
     if ((NewPassText==ConfirmPassText)&&(OldPassText==PasswordOld.Value))
     {
        WritePassword.NewValue=NewPassText;
        WritePassword.WrtiniFile("Password.cfg","[password]");
     	OldPass->Text="";
     	NewPass->Text="";
     	ConfirmPass->Text="";
      	ConfigurationWindows->Close();
     }
     else
     {
     	OldPass->Text="";
     	NewPass->Text="";
     	ConfirmPass->Text="";
     	StatusBar->SimpleText="Error Password";
     }
}
//---------------------------------------------------------------------------