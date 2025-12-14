// 3DES.h: interface for the C3DES class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_3DES_H__71FF3624_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_3DES_H__71FF3624_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "DES.h"

class C3DES  
{
// Construction
public:
	C3DES();
	virtual ~C3DES();
	
// Attributes
public:
	CDWordArray key_schedule;
	CDES* DES1;
	CDES* DES2;
	CDES* DES3;

// Operations
public:
	void SetKey(CByteArray *key);
	CByteArray* Decrypt(CByteArray* in);
	CByteArray* Encrypt(CByteArray* in);
};

#endif // !defined(AFX_3DES_H__71FF3624_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
