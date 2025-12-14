// SecureCrypto.h: interface for the CSecureCrypto class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECURECRYPTO_H__4F7E8FA5_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURECRYPTO_H__4F7E8FA5_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_

#include "3DES.h"	// Added by ClassView
#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CSecureCrypto  
{
public:
	CByteArray* Decrypt(CByteArray* Data);
	CByteArray* Encrypt(CByteArray* Data);
	C3DES* Cipher3DES;
	static CByteArray* encrypteRSA(CByteArray* clearData,CByteArray* exponent,CByteArray* modulus);
	static CByteArray* encrypteRSAPkcs1Twice(CByteArray* clearData,CByteArray* server_key_public_exponent,CByteArray* server_key_public_modulus,CByteArray* host_key_public_exponent,CByteArray* host_key_public_modulus);
	CSecureCrypto();
	CSecureCrypto(CByteArray* C3DESKey);
	virtual ~CSecureCrypto();

};

#endif // !defined(AFX_SECURECRYPTO_H__4F7E8FA5_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
