#if !defined(AFX_SECURESHELLSOCKET_H__4F7E8FA2_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURESHELLSOCKET_H__4F7E8FA2_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// SecureShellSocket.h : header file
//
class CSecureShellIO;


/////////////////////////////////////////////////////////////////////////////
// CSecureShellSocket command target

class CSecureShellSocket : public CAsyncSocket
{
// Attributes
		DECLARE_DYNAMIC(CSecureShellSocket);

public:
	CSecureShellIO*	m_pSshIO;

// Operations
public:
	CSecureShellSocket(CSecureShellIO* pSshIO);
	virtual ~CSecureShellSocket();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSecureShellSocket)
	public:
	virtual void OnReceive(int nErrorCode);
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(CSecureShellSocket)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SECURESHELLSOCKET_H__4F7E8FA2_E4DF_11D2_BEDE_0000E8D7086B__INCLUDED_)
