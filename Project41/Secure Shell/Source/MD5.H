// MD5.h: interface for the CMD5 class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MD5_H__71FF3627_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_MD5_H__71FF3627_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "MessageDigest.h"

class CMD5  : public CMessageDigest 
{
// Construction
public:
	CMD5();
	virtual ~CMD5();
	
// Attributes
public:
	static const int HASH_LENGTH;
	static const int DATA_LENGTH;

protected:
	CUIntArray *Digest;
	CUIntArray *Data;
	CByteArray *Temp;

// Operations
public:
	static CByteArray* Hash(CByteArray * message);
	static CByteArray* Hash( CString message);
	static void byte2int(CUIntArray* dst, int dst_off, CByteArray* src, int src_off, int lenn);
	int Hash_Length();
	int Data_Length();
	void MD_Transform();
	void MD_Reset();
	CString Name();

protected:
	static UINT FF(UINT a,UINT b,UINT c,UINT d,UINT k,UINT s,UINT t);
	static UINT GG(UINT a,UINT b,UINT c,UINT d,UINT k,UINT s,UINT t);
	static UINT HH(UINT a,UINT b,UINT c,UINT d,UINT k,UINT s,UINT t);
	static UINT II(UINT a,UINT b,UINT c,UINT d,UINT k,UINT s,UINT t);
 	static UINT F(UINT x,UINT y,UINT z);
	static UINT G(UINT x,UINT y,UINT z);
	static UINT H(UINT x,UINT y,UINT z);
	static UINT I(UINT x,UINT y,UINT z);
	void Transform(CUIntArray* M);
	
private:
	void MD5_Init();
	CByteArray* MD_Digest();
};

#endif // !defined(AFX_MD5_H__71FF3627_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
