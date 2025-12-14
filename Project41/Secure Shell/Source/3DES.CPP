// 3DES.cpp: implementation of the C3DES class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "3DES.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

C3DES::C3DES()
{
	DES1 = new CDES();
	DES2 = new CDES();
	DES3 = new CDES();
}

C3DES::~C3DES()
{

}

CByteArray* C3DES::Encrypt(CByteArray * in)
{
	in = DES1->Encrypt(in);
	in = DES2->Decrypt(in);
	in = DES3->Encrypt(in);
	return in;
}

CByteArray* C3DES::Decrypt(CByteArray * in)
{
	in = DES3->Decrypt(in);
	in = DES2->Encrypt(in);
	in = DES1->Decrypt(in);
	return in;

}

void C3DES::SetKey(CByteArray * key)
{
    CByteArray* subKey = new CByteArray();
	subKey->SetSize(8);
	int offset = 0;
	for (int i=0;i<8;i++)
		subKey->SetAt(i,key->GetAt(offset++));
	DES1->SetKey(subKey);

    for (i = 0;i<8;i++)
		subKey->SetAt(i,key->GetAt(offset++));
	DES2->SetKey(subKey);

    
	for (i = 0;i<8;i++)		
		subKey->SetAt(i,key->GetAt(offset++));
	DES3->SetKey(subKey);

}
