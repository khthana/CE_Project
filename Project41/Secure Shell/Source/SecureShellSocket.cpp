// SecureShellSocket.cpp : implementation file
//

#include "stdafx.h"
#include "SecureShell.h"
#include "SecureShellSocket.h"
#include "SecureShellIO.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSecureShellSocket

CSecureShellSocket::CSecureShellSocket(CSecureShellIO* pSshIO)
{
	m_pSshIO = pSshIO;
}

CSecureShellSocket::~CSecureShellSocket()
{
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(CSecureShellSocket, CAsyncSocket)
	//{{AFX_MSG_MAP(CSecureShellSocket)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0

/////////////////////////////////////////////////////////////////////////////
// CSecureShellSocket member functions
IMPLEMENT_DYNAMIC(CSecureShellSocket, CAsyncSocket)

void CSecureShellSocket::OnReceive(int nErrorCode) 
{
	// TODO: Add your specialized code here and/or call the base class
	
	CAsyncSocket::OnReceive(nErrorCode);
	m_pSshIO->OnReceive(this);
}
