// SecureShellIO.cpp: implementation of the CSecureShellIO class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "SecureShellIO.h"
#include "SecureMisc.h"
#include "MD5.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Packet Type
//////////////////////////////////////////////////////////////////////
const int	PHASE_INIT	=				0;
const int	PHASE_SSH_RECEIVE_PACKET =	1;

const int	SSH_MSG_DISCONNECT	=		1;
const int	SSH_SMSG_PUBLIC_KEY	=		2;
const int	SSH_CMSG_SESSION_KEY =		3;	
const int	SSH_CMSG_USER =				4;
const int	SSH_CMSG_AUTH_PASSWORD =	9;
const int	SSH_CMSG_REQUEST_PTY =		10;
const int	SSH_CMSG_EXEC_SHELL	=		12;
const int	SSH_SMSG_SUCCESS =			14;
const int	SSH_SMSG_FAILURE =			15;
const int	SSH_CMSG_STDIN_DATA	=		16;
const int	SSH_SMSG_STDOUT_DATA =		17;
const int	SSH_SMSG_STDERR_DATA =		18;
const int	SSH_SMSG_EXITSTATUS	=		20;
const int	SSH_CMSG_EXIT_CONFIRMATION= 33;

//
// encryption types
//
const int SSH_CIPHER_NONE = 0;	// No encryption						//not supported on thor
const int SSH_CIPHER_IDEA = 1;  // IDEA in CFB mode				//Supported on thor, iplemented !
const int SSH_CIPHER_DES  = 2;  // DES in CBC mode						//not supported on thor
const int SSH_CIPHER_3DES = 3;  // Triple-DES in CBC mode			//Supported on thor, not implemented !
const int SSH_CIPHER_TSS  = 4;  // An experimental stream cipher		//not supported on thor
const int SSH_CIPHER_RC4  = 5;  // RC4
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
IMPLEMENT_DYNCREATE(CSecureShellIO, CObject)


CSecureShellIO::CSecureShellIO()
{
	m_pSocket = NULL;
	m_pDataInput = new CByteArray();
	phase = 0;
	lastPacketReceive = new CSecurePacket();
	encryption = false;
	term = NULL;
}



CSecureShellIO::~CSecureShellIO()
{

}

int CSecureShellIO::Connect(CString Host, UINT Port, CString Name, CString Passwd)
{
	
	if (m_pSocket != NULL) {	// Check for have user m_pSocket
		delete m_pSocket;
		m_pSocket = NULL;
		return 0;
	}

	// Create New Socket
	m_pSocket = new CSecureShellSocket(this);

	if (!m_pSocket->Create()) {
		AfxMessageBox("Socket creation failed");
		return 0;
	} 

	// Connect to the host
	if (!m_pSocket->Connect(Host,Port))
	{   
		if (m_pSocket->GetLastError() != WSAEWOULDBLOCK)
		{                                
			CString strError;
			strError.LoadString(m_pSocket->GetLastError());
			delete m_pSocket;
			m_pSocket = NULL;
			return 0;
		}
	}

	m_strUser = Name;
	m_strPasswd = Passwd;
//	m_pSocket->Init();
// packet_set_connection(		
	CSecurePacket::encryption = encryption =  false;
	return 1;
}

void CSecureShellIO::OnReceive(CSecureShellSocket* pSocket)
{
	static char szBuf[256];
	int nRet;

//	EnterCriticalSection(&CriticalSection);
	while ((nRet = pSocket->Receive(szBuf,256,0)) > 0)
	{
		insertDataInput(szBuf,nRet);
	}
	CSecurePacket* packet;
	while ( (packet=HandleBytes()) != NULL)
	{
		if ((packet != NULL) && (m_pDataInput->GetSize() >=0))
		{
			lastPacketReceive = packet;
			CByteArray* result = HandlePacket(lastPacketReceive->GetType(),lastPacketReceive->GetData());
			if (result != NULL) 
				ShowString(result);
		} 
	}
//	LeaveCriticalSection(&CriticalSection);
	return;


}

void CSecureShellIO::insertDataInput(char data [], int size)
{
	CByteArray* TempInput = new CByteArray();
	TempInput->SetSize(size);
	for (int i=0;i<size;i++)
		TempInput->SetAt(i,data[i]);
	m_pDataInput->Append(*TempInput);

}

CSecurePacket* CSecureShellIO::HandleBytes()
{
	CString TextSend("SSH-1.5-Chart Ssh 1.1\r");
	switch(phase) 
	{	
 	case PHASE_INIT:
		{
			phase++;
			m_pSocket->Send(TextSend,TextSend.GetLength(),0);
//			CByteArray* data = CSecureMisc::CreateString(TextSend);
//			BYTE packet_type = (BYTE) SSH_SMSG_STDOUT_DATA;
//			CSshPacket* firstLine = CreatePacket(packet_type,data);
//			return firstLine;
			m_pDataInput->RemoveAll();
			return NULL;
		}
	
	case PHASE_SSH_RECEIVE_PACKET : 
		{
		CSecurePacket* result =  lastPacketReceive->GetPacketFromBytes(m_pDataInput);
		return result;
		}	
	}
	return NULL;

}


CByteArray* CSecureShellIO::HandlePacket(BYTE packet_type, CByteArray * packetData)
{
	int offset = 0;
	int i;
	CString str;
	CByteArray* strBytes;
//	AfxMessageBox("Packet In");
	switch(packet_type) {
			
	case SSH_MSG_DISCONNECT: 
		{
			AfxMessageBox("Error");
			CString	str = CSecureMisc::GetString(packetData);
			AfxMessageBox(str);
			CByteArray* strBytes ;
			for (i=0;i<str.GetLength();i++)
				strBytes->Add((BYTE) str.GetAt(offset++));
			m_pSocket->Close();
			return NULL;//strBytes;
		}
			
	case SSH_SMSG_PUBLIC_KEY:
		{
			CByteArray* anti_spoofing_cookie = new CByteArray();			//8 bytes
			CByteArray* server_key_bits = new CByteArray();					//32-bit int
			CByteArray* server_key_public_exponent = new CByteArray();		//mp-int
			CByteArray* server_key_public_modulus = new CByteArray();		//mp-int
			CByteArray* host_key_bits = new CByteArray();					//32-bit int
			CByteArray* host_key_public_exponent = new CByteArray();		//mp-int
			CByteArray* host_key_public_modulus = new CByteArray();			//mp-int
			CByteArray* protocol_flags = new CByteArray();					//32-bit int
			CByteArray* supported_ciphers_mask = new CByteArray();			//32-bit int
			CByteArray* supported_authentications_mask = new CByteArray();	//32-bit int

			for(i=0;i<=7;i++) anti_spoofing_cookie->Add(packetData->GetAt(offset++));
			for(i=0;i<=3;i++) server_key_bits->Add(packetData->GetAt(offset++));
			server_key_public_exponent = CSecureMisc::GetMpInt(offset,packetData); //boffset is not modified :-(
			offset += server_key_public_exponent->GetSize() +2;
			server_key_public_modulus = CSecureMisc::GetMpInt(offset,packetData);
			offset += server_key_public_modulus->GetSize() +2;
			for(i=0;i<=3;i++) host_key_bits->Add(packetData->GetAt(offset++));
			host_key_public_exponent = CSecureMisc::GetMpInt(offset,packetData);
			offset += host_key_public_exponent->GetSize()+2;
			host_key_public_modulus = CSecureMisc::GetMpInt(offset,packetData); // boffset can not be modified (Java = crap Language)
			offset += host_key_public_modulus->GetSize()+2;
			for(i=0;i<4;i++) protocol_flags->Add(packetData->GetAt(offset++));
			for(i=0;i<4;i++) supported_ciphers_mask->Add(packetData->GetAt(offset++));
			for(i=0;i<4;i++) supported_authentications_mask->Add(packetData->GetAt(offset++));

			// we have completely received the PUBLIC_KEY
			// we prepare the answer ...

		 	Send_SSH_CMSG_SESSION_KEY(	anti_spoofing_cookie,
										server_key_public_modulus,
										host_key_public_modulus,
										supported_ciphers_mask,
										server_key_public_exponent,
										host_key_public_exponent);

			return NULL;
		}
		break;
	case SSH_SMSG_SUCCESS :
//		AfxMessageBox("SSH_SMSG_SUCCESS ");
			if (LastPacketSentType==SSH_CMSG_SESSION_KEY) { //we have succefully sent the session key !! (at last :-) )
				Send_SSH_CMSG_USER();
				break;
			}

			if (LastPacketSentType==SSH_CMSG_AUTH_PASSWORD) {// password correct !!!
				//yahoo
//				AfxMessageBox("login succesful");

				//now we have to start the interactive session ...
	 			Send_SSH_CMSG_REQUEST_PTY(); //request a pseudo-terminal
//				str = new String("\nLogin & password accepted\r\n");
//				StrByte = new byte[str.length()];
//				str.getBytes(0, str.length(),	StrByte, 0);
//				return(StrByte);
				break;
				}

			if (LastPacketSentType==SSH_CMSG_REQUEST_PTY) {// pty accepted !!
//				AfxMessageBox("to start shell");
				Send_SSH_CMSG_EXEC_SHELL(); //we start a shell
				break;
			}
	case SSH_SMSG_FAILURE:
//			AfxMessageBox("SSH_SMSG_FAILURE");
			if (LastPacketSentType==SSH_CMSG_AUTH_PASSWORD) {// password incorrect ???
				AfxMessageBox("failed to log");
/*				System.out.println("failed to log");
				str = new String("\nLogin & password not accepted\r\n");
				disconnect();
				StrByte = new byte[str.length()];
				str.getBytes(0, str.length(),	StrByte, 0);
				return(StrByte);
*/			}
			if (LastPacketSentType==SSH_CMSG_USER) { // authentication is needed for the given user (in most cases that's true)
				Send_SSH_CMSG_AUTH_PASSWORD();
				break;
			}
			if (LastPacketSentType==SSH_CMSG_REQUEST_PTY) {// pty not accepted !!
				break;
			}
		break;
	case SSH_SMSG_STDOUT_DATA: //receive some data from the server
			if (LastPacketSentType==SSH_CMSG_EXEC_SHELL) {// pty accepted !!
//				AfxMessageBox("Shell now Started");
				term = new CVT100();
			}
			str = CSecureMisc::GetString(packetData);
			strBytes = new CByteArray();
			for (i=0;i<str.GetLength();i++)
				strBytes->Add((BYTE) str.GetAt(offset++));
			return strBytes;		

	case SSH_SMSG_STDERR_DATA: //receive some error data from the server

			//	if(debug > 1) 
		str = "Error : " + CSecureMisc::GetString(packetData);
//		AfxMessageBox(str);
			//System.out.println("SshIO.handlePacket : " + "STDERR_DATA " + str );
			//StrByte = new byte[str.length()];
			//str.getBytes(0, str.length(),	StrByte, 0);
			//return(StrByte);
		break;
			
	case SSH_SMSG_EXITSTATUS: //sent by the server to indicate that the client program has terminated.
			
			//32-bit int   exit status of the command
//			int value = (packetData[0]<<24)+(packetData[1]<<16)+(packetData[2]<<8)+(packetData[3]);
			Send_SSH_CMSG_EXIT_CONFIRMATION();
//			System.out.println("SshIO : Exit status " + value );
			disconnect();
			break;

	}
//	AfxMessageBox("Not Have Case ");
	return NULL;//packetData;	
}

CByteArray* CSecureShellIO::Send_SSH_CMSG_SESSION_KEY(CByteArray * anti_spoofing_cookie,
													  CByteArray * server_key_public_modulus, 
													  CByteArray * host_key_public_modulus, 
													  CByteArray * supported_ciphers_mask, 
													  CByteArray * server_key_public_exponent, 
													  CByteArray * host_key_public_exponent)
{
    // create the session id
	//	session_id = MD5(hostkey->n || servkey->n || cookie) //protocol V 1.5. (we use this one)
	//	session_id = MD5(servkey->n || hostkey->n || cookie) //protocol V 1.1.(Why is it different ??)
	//
	CByteArray* session_id = new CByteArray();
		session_id->Append(*host_key_public_modulus);
		session_id->Append(*server_key_public_modulus);
		session_id->Append(*anti_spoofing_cookie);

	CByteArray* Hash_MD5 = CMD5::Hash(session_id);

	//	SSH_CMSG_SESSION_KEY : Sent by the client
	//	    1 byte       cipher_type (must be one of the supported values)
	// 	    8 bytes      anti_spoofing_cookie (must match data sent by the server)
	//	    mp-int       double-encrypted session key (uses the session-id)
	//	    32-bit int   protocol_flags
	//
	CByteArray* StrByte = new CByteArray();
	BYTE	cipher_type;
	cipher_type = (BYTE) SSH_CIPHER_3DES;
	if ( (((1 << cipher_type) & 0xff) & supported_ciphers_mask->GetAt(3)) == 0)
	{
		AfxMessageBox(" SshIO : Encryption method not supported ");
//		CString Str("SshIo: Encryption method not supported \n");
//		for (int i=0;i<Str.GetLength();i++)
//			StrByte->Add((BYTE)Str[i]);
//		return(StrByte);
	}
	// 	anti_spoofing_cookie : the same 
    //      double_encrypted_session_key :
	//		32 bytes of random bits
	//		Xor the 16 first bytes with the session-id
	//		encrypt with the server_key_public (small) then the host_key_public(big) using RSA.
	CByteArray* random_bits1 = new CByteArray();
	CByteArray* random_bits2 = new CByteArray();
	random_bits1->SetSize(16);
	random_bits2->SetSize(16);
	
	srand( (unsigned)time( NULL ) );

	random_bits2 = CMD5::Hash(rand());
	random_bits1 = CMD5::Hash(rand());

	CByteArray* session_key = new CByteArray();
	session_key->Append(*random_bits1);
	session_key->Append(*random_bits2);

	CByteArray* session_keyXored = CSecureMisc::XORArrayOfBytes(random_bits1,Hash_MD5);
	session_keyXored->Append(*random_bits2);

	CSecureShellView *pView = CSecureShellView::GetView();
	pView->SetWindowText(NULL);
	Show("Please Wait for Encryption key ....");
	pView->HideCaret();

	// double encryption
	CByteArray* encrypted_session_key = CSecureCrypto::encrypteRSAPkcs1Twice(session_keyXored,
																		server_key_public_exponent,
																		server_key_public_modulus,
																		host_key_public_exponent,
																		host_key_public_modulus);
	for (int k=0;k<char_h;k++)
		for (int j=0;j<char_w;j++)
			pView->CharArray[j][k] = ' ';
	pView->SetWindowText(NULL);
	int test = encrypted_session_key->GetSize();
	// protocol_flags  : protocol extension
	CByteArray* protocol_flags = new CByteArray();
	protocol_flags->SetSize(4);			//32-bit int
	for (int i=0;i<4;i++)
		protocol_flags->SetAt(i,0);
	int length =	1 +			// cipher_type
					anti_spoofing_cookie->GetSize() +
					encrypted_session_key->GetSize() +
					protocol_flags->GetSize();

	CByteArray* data = new CByteArray();
	data->SetSize(length);
	int boffset = 0;
	data->SetAt(boffset++,(BYTE) cipher_type);
	for (i =0 ; i< 8; i++) data->SetAt(boffset++,anti_spoofing_cookie->GetAt(i));
	for (i =0 ; i< encrypted_session_key->GetSize(); i++) data->SetAt(boffset++,encrypted_session_key->GetAt(i));
	for (i =0 ; i< 4; i++) data->SetAt(boffset++,protocol_flags->GetAt(i));


	BYTE packet_type = SSH_CMSG_SESSION_KEY;
	CSecurePacket* packet = CreatePacket(packet_type,data);
	SendPacket(packet);

	if (cipher_type == (BYTE) SSH_CIPHER_3DES) {
			encryption=true;
			CSecurePacket::encryption = encryption;
			CSecurePacket::cryptoSend = new CSecureCrypto(session_key);
			CSecurePacket::cryptoRecv = new CSecureCrypto(session_key);
		}

	return NULL;

}//Send_SSH_CMSG_SESSION_KEY

CByteArray* CSecureShellIO::Send_SSH_CMSG_USER()
{
	CByteArray* data = CSecureMisc::CreateString(m_strUser);
	BYTE packet_type = (BYTE) SSH_CMSG_USER;
	CSecurePacket* packet = CreatePacket(packet_type, data);
	SendPacket(packet);
	return NULL;
	

}

CByteArray* CSecureShellIO::Send_SSH_CMSG_REQUEST_PTY()
{
	CByteArray* termType = CSecureMisc::CreateString("vt100");//termType);
		CByteArray* row = new CByteArray();
		row->Add(0);
		row->Add(0);
		row->Add(0);
		row->Add(24);
		CByteArray* col = new CByteArray();
		col->Add(0);
		col->Add(0);
		col->Add(0);
		col->Add(80);
		CByteArray* XPixels = new CByteArray();
		XPixels->Add(0);
		XPixels->Add(0);
		XPixels->Add(0);
		XPixels->Add(0);
		CByteArray* YPixels = new CByteArray();
		YPixels->Add(0);
		YPixels->Add(0);
		YPixels->Add(0);
		YPixels->Add(0);
		CByteArray* terminalModes = new CByteArray();
		terminalModes->Add(0);

		CByteArray* data = new CByteArray();
		for (int i=0; i<termType->GetSize(); i++) data->Add(termType->GetAt(i));
		for (i=0; i<row->GetSize(); i++) data->Add(row->GetAt(i));
		for (i=0; i<col->GetSize(); i++) data->Add(col->GetAt(i));
		for (i=0; i<XPixels->GetSize(); i++) data->Add(XPixels->GetAt(i));
		for (i=0; i<YPixels->GetSize(); i++) data->Add(YPixels->GetAt(i));
		for (i=0; i<terminalModes->GetSize(); i++) data->Add(terminalModes->GetAt(i));

		BYTE packet_type =  (BYTE) SSH_CMSG_REQUEST_PTY;

		CSecurePacket* packet = CreatePacket(packet_type, data);
		SendPacket(packet);
		return NULL;
} //Send_SSH_CMSG_REQUEST_PTY

CByteArray* CSecureShellIO::Send_SSH_CMSG_EXEC_SHELL()
{
	CByteArray* data = new CByteArray();
	BYTE packet_type = (BYTE)SSH_CMSG_EXEC_SHELL;
	CSecurePacket* packet = CreatePacket(packet_type, data);
	SendPacket(packet);
	LastPacketSentType = packet_type;
	return NULL;
} //Send_SSH_CMSG_EXEC_SHELL

CByteArray* CSecureShellIO::Send_SSH_CMSG_AUTH_PASSWORD()
{
	CByteArray* data = CSecureMisc::CreateString(m_strPasswd);
	BYTE packet_type = (BYTE) SSH_CMSG_AUTH_PASSWORD;
	CSecurePacket* packet = CreatePacket(packet_type, data);
	SendPacket(packet);
	return NULL;

}

CSecurePacket* CSecureShellIO::CreatePacket(BYTE newtype, CByteArray * data)
{
	return	new CSecurePacket(newtype,data);
}

void CSecureShellIO::SendPacket(CSecurePacket * packet)
{
	Send(packet->GetBytes());
	LastPacketSentType = packet->GetType();

}

void CSecureShellIO::Send(CByteArray * buf)
{
	char	szBuf[1024];
	for (int i=0;i<buf->GetSize();i++)
		szBuf[i] = buf->GetAt(i);
	m_pSocket->Send(szBuf,buf->GetSize());

}



CByteArray* CSecureShellIO::Send_SSH_CMSG_STDIN_DATA(CString str)
{
	CByteArray* data = CSecureMisc::CreateString(str);
	BYTE packet_type = (BYTE) SSH_CMSG_STDIN_DATA;
	CSecurePacket* packet = CreatePacket(packet_type, data);
	SendPacket(packet);
	return NULL;

}

void CSecureShellIO::ShowString(CByteArray * data)
{
	CString printData;
	CSecureShellView *pView = CSecureShellView::GetView();

	if (term != NULL)
		term->displaybytes(data,data->GetSize());
//	pView->SetWindowText(NULL);
	pView->Show();

//	pView->Display(data);

}

void CSecureShellIO::Show(LPCSTR lpFormat,...)
{
	CSecureShellView *pView = CSecureShellView::GetView();
	pView->Display(lpFormat);

}


CByteArray* CSecureShellIO::Send_SSH_CMSG_EXIT_CONFIRMATION()
{
	CByteArray* data = new CByteArray();
	BYTE packet_type = SSH_CMSG_EXIT_CONFIRMATION;
	CSecurePacket* packet = CreatePacket(packet_type, data);
	SendPacket(packet);
	return NULL;

}

void CSecureShellIO::disconnect()
{
	m_pSocket->Close();
	m_pSocket = NULL;
	CSecureShellView *pView = CSecureShellView::GetView();
	pView->start = false;
	AfxMessageBox("Now Exit!");
	CSecurePacket::encryption = encryption =  false;
}
