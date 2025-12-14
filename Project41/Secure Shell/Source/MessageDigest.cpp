// MessageDigest.cpp: implementation of the CMessageDigest class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "MessageDigest.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CMessageDigest::CMessageDigest()
{
	m_Buffer = new CByteArray();
}

CMessageDigest::~CMessageDigest()
{

}

long CMessageDigest::BitCount()
{
	return m_BitCount;
}


CByteArray* CMessageDigest::Buffer()
{
	return m_Buffer;
}


int CMessageDigest::BufferOffset()
{
	return m_BufferOffset;
}



int CMessageDigest::Length()
{
	return Hash_Length();
}


void CMessageDigest::Reset()
{
	m_BitCount = 0;
	m_BufferOffset = 0;
	MD_Reset();
}	



CByteArray* CMessageDigest::Digest()
{
	CByteArray* R = MD_Digest();
	Reset();
	return R;
}

void CMessageDigest::AddToDigest(CByteArray* data, int off, int len)
{
	int datalen = Data_Length();
	m_BitCount += ((long) len << 3);	// bits = byte * 8
	
	while (len >= (datalen - m_BufferOffset))  // 1 loop for not over than 
	{
		for (int i=m_BufferOffset;i<(datalen - m_BufferOffset);i++)	// insert not over 512
		{
			m_Buffer->SetAt(i,(data->GetAt(off+i)));
		}
		
		MD_Transform();

		len -= (datalen - m_BufferOffset);		// len - len of byte hash
		off += (datalen - m_BufferOffset);
		m_BufferOffset = 0;
	}

	if (len > 0) {
		for (int i=m_BufferOffset;i<len;i++)
			m_Buffer->SetAt(i,(data->GetAt(off+i)));
		m_BufferOffset += len;
	}
}




void CMessageDigest::Add(CString Message)
{
	CByteArray* Data = new CByteArray();
	for (int i=0;i<Message.GetLength();i++)
		Data->Add((BYTE) Message[i]);
	AddToDigest(Data,0,Data->GetSize());
	
}

void CMessageDigest::Add(CByteArray* Data)
{
	AddToDigest(Data,0,Data->GetSize());
}

void CMessageDigest::Add(CByteArray * Data, int offset, int length)
{
	AddToDigest(Data,offset,length);
}

void CMessageDigest::Add(CString Message, int offset, int length)
{
	CByteArray* Data = new CByteArray();
	for (int i=offset;i<length;i++)
		Data->Add((BYTE) Message[i]);
	AddToDigest(Data,0,length);
}

CByteArray* CMessageDigest::Hash(CByteArray * message, CMessageDigest* md)
{
	md->Add(message);
	return md->Digest();

}

CByteArray * CMessageDigest::Hash(CString message, CMessageDigest * md)
{
	md->Add(message);
	return md->Digest();
}

void CMessageDigest::BufferSetSize(int Size)
{
	m_Buffer->SetSize(Size);
}
