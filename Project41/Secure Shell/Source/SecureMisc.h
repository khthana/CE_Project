// SecureMisc.h: interface for the CSecureMisc class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECUREMISC_H__71FF3621_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECUREMISC_H__71FF3621_E524_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CSecureMisc  
{
public:
	CSecureMisc();
	virtual ~CSecureMisc();
	
// Attributes
public:

// Operations
public:
	static BYTE getNotZeroRandomByte();
	static CByteArray* XORArrayOfBytes(CByteArray* a,CByteArray* b);
	static CByteArray* GetMpInt(int offset,CByteArray* byteArray);
	static CString GetString(CByteArray* byteArray);
	static unsigned long crc32(CByteArray* s,int len);
	static CByteArray* CreateString(CString Input);

private:
	static long crc32_tab[];};

#endif // !defined(AFX_SECUREMISC_H__71FF3621_E524_11D2_BEDE_0000E8D7086B__INCLUDED_)
