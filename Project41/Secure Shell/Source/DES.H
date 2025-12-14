// DES.h: interface for the CDES class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DES_H__71FF3625_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_DES_H__71FF3625_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
#define PERM_OP(a,b,t,n,m) ((t)=((((a)>>(n))^(b))&(m)),\
	(b)^=(t),\
	(a)^=((t)<<(n)))

#define IP(l,r,t) \
	PERM_OP(r,l,t, 4,0x0f0f0f0f); \
	PERM_OP(l,r,t,16,0x0000ffff); \
	PERM_OP(r,l,t, 2,0x33333333); \
	PERM_OP(l,r,t, 8,0x00ff00ff); \
	PERM_OP(r,l,t, 1,0x55555555);

#define FP(l,r,t) \
	PERM_OP(l,r,t, 1,0x55555555); \
	PERM_OP(r,l,t, 8,0x00ff00ff); \
	PERM_OP(l,r,t, 2,0x33333333); \
	PERM_OP(r,l,t,16,0x0000ffff); \
	PERM_OP(l,r,t, 4,0x0f0f0f0f);

#define HPERM_OP(a,t,n,m) ((t)=((((a)<<(16-(n)))^(a))&(m)),\
	(a)=(a)^(t)^(t>>(16-(n))))



class CDES  
{
// Construction
public:
	CDES();
	virtual ~CDES();
	
// Attributes
public:
	CDWordArray key_schedule;

protected:
	DWORD IV1;
	DWORD IV0;

// Operations

public:
	void Decrypt(DWORD l,DWORD r,DWORD output[]);
	void Encrypt(DWORD l,DWORD r,DWORD output[]);
	CByteArray* Encrypt(CByteArray* in);
	CByteArray* Decrypt(CByteArray* in);
	static const DWORD des_SPtrans[8][64];
	static const DWORD des_skb[8][64];
	void SetKey(CByteArray* key);
};

#endif // !defined(AFX_DES_H__71FF3625_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
