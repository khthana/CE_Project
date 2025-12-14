// SecureShellIO.h: interface for the CSecureShellIO class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECURESHELLIO_H__4F7E8FA3_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURESHELLIO_H__4F7E8FA3_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "SecureShellSocket.h"
#include "SecurePacket.h"
#include "SecureShellView.h"
#include "VT100.h"	// Added by ClassView



class CSecureShellIO : public CObject  
{
	DECLARE_DYNCREATE(CSecureShellIO)

public:
	CSecureShellIO();
	virtual ~CSecureShellIO();

// Attributes
public:
	void Show(LPCSTR lpFormat,...);
	void disconnect();
	CByteArray* Send_SSH_CMSG_EXIT_CONFIRMATION();
	CVT100* term;
	void telnetParse(CByteArray* b,int index,int len);
	CByteArray* Send_SSH_CMSG_STDIN_DATA(CString str);
	void ShowString(CByteArray * data);
	void Send(CByteArray * buf);
	BOOL encryption;
	void SendPacket(CSecurePacket * packet);
	CSecurePacket* CreatePacket(BYTE newtype, CByteArray* data);
	CByteArray* Send_SSH_CMSG_AUTH_PASSWORD();
	CByteArray* Send_SSH_CMSG_EXEC_SHELL();
	CByteArray* Send_SSH_CMSG_REQUEST_PTY();
	CByteArray* Send_SSH_CMSG_USER();
	BYTE LastPacketSentType;
	CByteArray* Send_SSH_CMSG_SESSION_KEY(CByteArray* anti_spoofing_cookie,CByteArray* server_key_public_modulus,CByteArray* host_key_public_modulus,CByteArray* supported_ciphers_mask,CByteArray* server_key_public_exponent,CByteArray* host_key_public_exponent);
	CByteArray* HandlePacket(BYTE packet_type, CByteArray * packetData);
	CSecurePacket* lastPacketReceive;
	CSecurePacket* HandleBytes();
	void insertDataInput(char data[],int size);
	void OnReceive(CSecureShellSocket* pSocket);
	CString m_strPasswd;
	CString m_strUser;
	int Connect(CString Host, UINT Port,CString Name,CString Passwd);
	int phase;
	CByteArray* m_pDataInput;
	CSecureShellSocket*	m_pSocket;


};

#endif // !defined(AFX_SECURESHELLIO_H__4F7E8FA3_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
