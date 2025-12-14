// SecureCrypto.cpp: implementation of the CSecureCrypto class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "SecureCrypto.h"
#include "BigNumber.h"
#include "SecureMisc.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
CSecureCrypto::CSecureCrypto()
{

}

CSecureCrypto::CSecureCrypto(CByteArray* C3DESKey)
{
	Cipher3DES = new C3DES();
	Cipher3DES->SetKey(C3DESKey);
}

CSecureCrypto::~CSecureCrypto()
{

}

CByteArray* CSecureCrypto::encrypteRSAPkcs1Twice(CByteArray * clearData, CByteArray * server_key_public_exponent, CByteArray * server_key_public_modulus, CByteArray * host_key_public_exponent, CByteArray * host_key_public_modulus)
{
	CByteArray *DataOut = new CByteArray();
      /* Server Public key has smaller modulus. */
	
	if (server_key_public_modulus->GetSize() <= host_key_public_modulus->GetSize()) {

		clearData = CSecureCrypto::encrypteRSA(clearData,server_key_public_exponent,server_key_public_modulus);
		clearData = CSecureCrypto::encrypteRSA(clearData,host_key_public_exponent,host_key_public_modulus);

		DataOut->SetSize(clearData->GetSize()+2);

		DataOut->SetAt(1,(8*clearData->GetSize() )& 0xff);
		DataOut->SetAt(0,((8*clearData->GetSize() )>>8)& 0xff);

		for(int i=0; i<host_key_public_modulus->GetSize();i++)
			DataOut->SetAt(i+2,clearData->GetAt(i));
		return DataOut;
	}
	else 
	{
		clearData = CSecureCrypto::encrypteRSA(clearData,host_key_public_exponent,host_key_public_modulus);
		clearData = CSecureCrypto::encrypteRSA(clearData,server_key_public_exponent,server_key_public_modulus);
		DataOut->SetSize(clearData->GetSize()+2);
		DataOut->SetAt(1,(8*clearData->GetSize() )& 0xff);
		DataOut->SetAt(0,((8*clearData->GetSize() )>>8)& 0xff);
		for(int i=0; i<server_key_public_modulus->GetSize();i++)
			DataOut->SetAt(i+2,clearData->GetAt(i));
		return DataOut;
	}
}


CByteArray* CSecureCrypto::encrypteRSA(CByteArray * clearData, CByteArray * exponent, CByteArray * modulus)
{
	// set encrytionBlock
	CByteArray* EncryptionBlock = new CByteArray(); 
	EncryptionBlock->SetSize(modulus->GetSize());
	EncryptionBlock->SetAt(0,0);
	EncryptionBlock->SetAt(1,2);
	int offset = 2;

	for(int i=2; i < (EncryptionBlock->GetSize() - clearData->GetSize() - 1); i++) 
		EncryptionBlock->SetAt(offset++,CSecureMisc::getNotZeroRandomByte());

	EncryptionBlock->SetAt(offset++,0);

	for(i=0; i<clearData->GetSize(); i++) 
		EncryptionBlock->SetAt(offset++,clearData->GetAt(i));


	CBigNumber *m,*e, *message;
	CByteArray* messageByte = new CByteArray();

	messageByte->SetSize(modulus->GetSize());
	m = new CBigNumber(modulus);
	e = new CBigNumber(exponent);
	message = new CBigNumber(EncryptionBlock);

	int tmp1 = m->GetAt(0);
	int tmp11 = m->Size;
	int tmp2 = e->GetAt(0);
	int tmp21 = e->Size;
	int msg1 = message->GetAt(0);
	int msg2 = message->Size;

	message = message->ModPow(e,m);

	CByteArray* messageByteTemp = message->ToByteArray();


	messageByte ->SetSize(modulus->GetSize());

	int tempOffset = messageByteTemp->GetSize()-1;
	for (i=messageByte->GetSize()-1;i>=0;i--)
			messageByte->SetAt(i,messageByteTemp->GetAt(tempOffset--));

	return messageByte;

}

CByteArray* CSecureCrypto::Encrypt(CByteArray * Data)
{
	return Cipher3DES->Encrypt(Data);	

}

CByteArray* CSecureCrypto::Decrypt(CByteArray * Data)
{
	return Cipher3DES->Decrypt(Data);	

}
