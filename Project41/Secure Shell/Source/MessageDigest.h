// MessageDigest.h: interface for the CMessageDigest class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MESSAGEDIGEST_H__71FF3628_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_MESSAGEDIGEST_H__71FF3628_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CMessageDigest  
{
// Construction
public:
	CMessageDigest();
	virtual ~CMessageDigest();
	
// Attributes
public:

private:
	int m_BufferOffset;
	CByteArray* m_Buffer;
	long m_BitCount;

// Operations
public:
	static CByteArray * Hash(CString message,CMessageDigest * md);
	static CByteArray* Hash(CByteArray* message, CMessageDigest* md);
	void Add(CString Message,int offset,int length);
	void Add(CByteArray* Data,int offset,int length);
	void Add(CByteArray* Data);
	void Add(CString Message);
	void AddToDigest(CByteArray* data, int Buf_Off,int len);
	void Reset();
	CByteArray* Digest();
	CByteArray* Buffer();
	int Length();
	int BufferOffset();
	long BitCount();

protected:
	void BufferSetSize(int Size);

// Abstract
public:
	virtual CByteArray* MD_Digest() = 0;
	virtual void MD_Reset() = 0;
	virtual void MD_Transform() = 0;
	virtual int Data_Length() = 0;
	virtual CString Name() = 0;
	virtual int Hash_Length() = 0;

};

#endif // !defined(AFX_MESSAGEDIGEST_H__71FF3628_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
