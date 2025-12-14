// BigNumber.h: interface for the CBigNumber class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_BIGNUMBER_H__71FF3626_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_BIGNUMBER_H__71FF3626_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CBigNumber : public CWordArray  
{
// Construction
public:
	CBigNumber(CByteArray* data);
	CBigNumber(int length);
	virtual ~CBigNumber();
	
// Attributes
public:
	int Size;

// Operations
public:

public:
	CBigNumber* ModPow(CBigNumber* power,CBigNumber* modulus);
	CBigNumber* Sub(CBigNumber* value);
	int GreaterEqual(CBigNumber* compare);
	CBigNumber* ModMult(CBigNumber* multiple,CBigNumber* modulus);
	int MostBitValue();
	CBigNumber* Adder(CBigNumber *data);
	CByteArray * ToByteArray();

};

#endif // !defined(AFX_BIGNUMBER_H__71FF3626_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
