//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#include <string.h>
#pragma hdrstop

#include "ApplicationLock.h"
#include "Config.h"
#include "EnterPassWord.h"
#include "ReadFileEnc.cpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TMainWindows *MainWindows;
//---------------------------------------------------------------------------
__fastcall TMainWindows::TMainWindows(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::OpenFileMenuClick(TObject *Sender)
{
  TFileName NameOfFile;
  OpenFileDialog -> Filter = "Executable files|*.EXE;*.COM";
  if (OpenFileDialog -> Execute())
  {
  	NameOfFile = OpenFileDialog->FileName;
    StatusBarMain->SimpleText=NameOfFile;
    EncryptButton->Enabled = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::ExitMenuClick(TObject *Sender)
{
    MainWindows->Close();
    EnterPassWindows->Close();
}
//---------------------------------------------------------------------------

void __fastcall TMainWindows::EncryptButtonClick(TObject *Sender)
{
    int L;
    char Name[50]={'\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',
                   '\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',
                   '\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',
                   '\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0','\0',
                   '\0','\0'};
    String FileName;
    FileName=StatusBarMain->SimpleText;
    L=FileName.Length();
    for(int i=1;i<L+2;i++)
    Name[i-1]=FileName[i];
    EncryptionFile En;
    En.EncryptFile(Name);
    StatusBarMain->SimpleText="Complete";
    EncryptButton->Enabled=false;
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::ConfigurationMenuClick(TObject *Sender)
{
 	ConfigurationWindows->Show();
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::MainWindowDestroy(TObject *Sender)
{
	EnterPassWindows->Close();
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::MainWindowClose(TObject *Sender,
	TCloseAction &Action)
{
    EnterPassWindows->Close();
}
//---------------------------------------------------------------------------
void __fastcall TMainWindows::CancelButtonClick(TObject *Sender)
{
	EncryptButton->Enabled=false;
    StatusBarMain->SimpleText="";
}
//---------------------------------------------------------------------------
