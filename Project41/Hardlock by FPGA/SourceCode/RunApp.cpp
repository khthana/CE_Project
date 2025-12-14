//---------------------------------------------------------------------------
#include <process.h>
#include <stdio.h>
#include <vcl\vcl.h>
#pragma hdrstop

#include "RunApp.h"
#include "ReadFileEnc.cpp"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TRunProg *RunProg;
//---------------------------------------------------------------------------
__fastcall TRunProg::TRunProg(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TRunProg::RunButtonClick(TObject *Sender)
{
    int result;
    EncryptionFile DecrypttoRun;
    RunProg->Hide();
    DecrypttoRun.DecryptFile();
    result = spawnl(P_WAIT, "File.dat", "File.dat", NULL);
    DecrypttoRun.EncryptFile("File.dat");
    RunProg->Show();
}
//---------------------------------------------------------------------------