// SecurePacket.h: interface for the CSecurePacket class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECUREPACKET_H__4F7E8FA4_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECUREPACKET_H__4F7E8FA4_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "SecureCrypto.h"

class CSecurePacket  
{
public:
	CSecurePacket();
	CSecurePacket(BYTE newtype,CByteArray* newdata);
	virtual ~CSecurePacket();

// Attributes
public:
	CByteArray* GetData();
	BYTE GetType();
	CByteArray* GetBytes();
	void SetBlock();
	BOOL checkCrc();
	static BOOL encryption;
	int packet_length;
	void setPacketFromDecryptedBlock();
	CByteArray* block;
	CByteArray* DecryptedBlock;
	CByteArray* EncryptedBlock;
	static CSecureCrypto* cryptoRecv;
	static CSecureCrypto* cryptoSend;
	CByteArray* packet_length_array;
	CByteArray* padding;
	CByteArray* data;
	CByteArray* crc_array;
	BYTE packet_type;

	CSecurePacket* GetPacketFromBytes(CByteArray *buff);

};

#endif // !defined(AFX_SECUREPACKET_H__4F7E8FA4_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
