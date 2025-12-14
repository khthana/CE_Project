// BigNumber.cpp: implementation of the CBigNumber class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "BigNumber.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CBigNumber::CBigNumber(CByteArray* data) : CWordArray()
{

	Size = (int) ((data->GetSize()+1)/2);
	this->SetSize(Size+1);

	this->SetAt(0,Size);

	int offset = data->GetSize();
	offset--;
	for (int i=1; i<Size ;i++) 
		this->SetAt(i,(data->GetAt(offset--)&0xff) |
					   ((data->GetAt(offset--)&0xff)<<8));

	if (data->GetSize() & 1 == 1)
		this->SetAt(Size,data->GetAt(offset)&0x00ff);
	else
		this->SetAt(Size,(data->GetAt(offset--)&0xff) |
					   ((data->GetAt(offset)&0xff)<<8));

}

CBigNumber::CBigNumber(int length) : CWordArray() //length of short
{
	this->SetSize(length+1);
	this->Size = length;
	this->SetAt(0,length);
	for (int i=1;i<=length;i++)
		this->SetAt(i,0);
}

CBigNumber::~CBigNumber()
{

}

CByteArray * CBigNumber::ToByteArray()
{
	CByteArray* data = new CByteArray();
	data->SetSize(this->GetAt(0)*2);
	int offset = data->GetSize();
	offset--;

	for (int i=1;i<=Size;i++) {
		data->SetAt(offset--,(BYTE)(this->GetAt(i)&0xff));
		data->SetAt(offset--,(BYTE)(this->GetAt(i)>>8)&0xff);
	}
	return data;
}

CBigNumber* CBigNumber::Adder(CBigNumber* data)
{
    int i;		// this -> r1, data -> r2
    long stuff = 0;
	CBigNumber *result = new CBigNumber(0);

    for (i = 1 ;; i++) {
	if (i <= this->GetAt(0))
	    stuff += this->GetAt(i);
	if (i <= data->GetAt(0))
	    stuff += data->GetAt(i);

	if (i > this->GetAt(0) && i > this->GetAt(0) ) {
		if (stuff & 0xFFFFU) result->Add(stuff & 0xFFFFU);
	    break;	
	}
	else
		result->Add(stuff & 0xFFFFU);

	stuff >>= 16;
    }
	result->Size = result->GetSize()-1;
	result->SetAt(0,result->Size);
	return result;
}

int CBigNumber::MostBitValue()
{
    int i;
    int j;
    unsigned short n;

    for (i=this->GetAt(0); i>0; i--)
	if (this->GetAt(i))
	    break;

    j = (i-1)*16;
    n = this->GetAt(i);
    if (n & 0xFF00) j += 8, n >>= 8;
    if (n & 0x00F0) j += 4, n >>= 4;
    if (n & 0x000C) j += 2, n >>= 2;
    if (n & 0x0002) j += 1, n >>= 1;

    return j;

}


int CBigNumber::GreaterEqual(CBigNumber * compare)
{
    int i;

    if (this->GetAt(0) < compare->GetAt(0))
		i = compare->GetAt(0);
    else
		i = this->GetAt(0);

    while (i > 0) {
	unsigned short n1 = (i > this->GetAt(0) ? 0 : this->GetAt(i));
	unsigned short n2 = (i > compare->GetAt(0) ? 0 : compare->GetAt(i));

	if (n1 > n2) {
	    return 1;		       /* r1 > r2 */
	} else if (n1 < n2) {
	    return 0;		       /* r1 < r2 */
	}

	i--;
    }

    return 1;		
}

CBigNumber* CBigNumber::Sub(CBigNumber * value)
{
    int i;
    long stuff = 0;
	CBigNumber *result = new CBigNumber(0);

    for (i = 1 ;; i++) {
	if (i <= this->GetAt(0))
	    stuff += this->GetAt(i);
	if (i <= value->GetAt(0))
	    stuff -= value->GetAt(i);

	if (i > this->GetAt(0) && i > value->GetAt(0)) {
		if (stuff & 0xFFFFU) result->Add(stuff & 0xFFFFU);
		break;
	}
	else
		result->Add(stuff & 0xFFFFU);
	stuff = stuff<0 ? -1 : 0;
    }
	result->Size = result->GetSize()-1;
	result->SetAt(0,result->Size);
	return result;

}

CBigNumber* CBigNumber::ModMult(CBigNumber * multiple, CBigNumber * modulus)
{
	CBigNumber* Zero = new CBigNumber(0);
	CBigNumber* result = new CBigNumber(modulus->GetAt(0));
	CBigNumber* temp = new CBigNumber(modulus->GetAt(0)+1);
	CBigNumber* tmp2 = new CBigNumber(modulus->GetAt(0)+1);
    int bit, bits, digit, smallbit;

//	temp = multiple->Adder(Zero);

    for (int i=1; i<=result->GetAt(0); i++)
	result->SetAt(i,0);		       /* result := 0 */
    for (i=1; i<=temp->GetAt(0); i++)
	temp->SetAt(i,(i > multiple->GetAt(0) ? 0 : multiple->GetAt(i)));   /* temp := r2 */


    
	bits = 1+this->MostBitValue();

    for (bit = 0; bit < bits; bit++) {
	digit = 1 + bit / 16;
	smallbit = bit % 16;

	if (digit <= this->GetAt(0) && (this->GetAt(digit) & (1<<smallbit))) {
	    tmp2 = temp->Adder(result);
	    if (tmp2->GreaterEqual(modulus))
			result = tmp2->Sub(modulus);
	    else
			result = tmp2->Adder(Zero);
	}

	tmp2 = temp->Adder(temp);
	if (tmp2->GreaterEqual(modulus))
	    temp = tmp2->Sub(modulus);
	else
	    temp = tmp2->Adder(Zero);
    }
	return result;
}



CBigNumber* CBigNumber::ModPow(CBigNumber * power, CBigNumber * modulus)
{
	CBigNumber* Zero = new CBigNumber(0);
	CBigNumber* temp = new CBigNumber(modulus->GetAt(0)+1);
	CBigNumber* tmp2 = new CBigNumber(modulus->GetAt(0)+1);
    int i;
    int bit, bits, digit, smallbit;

	CBigNumber* result = new CBigNumber(modulus->GetAt(0));
    for ( i=1; i<=result->GetAt(0); i++)
	result->SetAt(i,(i==1));	       /* result := 1 */
    for (i=1; i<=temp->GetAt(0); i++)
	temp->SetAt(i,(i > this->GetAt(0) ? 0 : this->GetAt(i)));   /* temp := r1 */


	bits = 1+power->MostBitValue();

    for (bit = 0; bit < bits; bit++) {
	digit = 1 + bit / 16;
	smallbit = bit % 16;

	if (digit <= power->GetAt(0) && (power->GetAt(digit) & (1<<smallbit))) {
	    tmp2 = temp->ModMult(result, modulus);
	    result = tmp2->Adder(Zero);
	}

	tmp2 = temp->ModMult(temp, modulus);
	temp = tmp2->Adder(Zero);
    }

	return result;
}
