// SecureShell.h : main header file for the SECURESHELL application
//

#if !defined(AFX_SECURESHELL_H__93830989_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURESHELL_H__93830989_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CSecureShellApp:
// See SecureShell.cpp for the implementation of this class
//

class CSecureShellApp : public CWinApp
{
public:
	CSecureShellApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSecureShellApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSecureShellApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SECURESHELL_H__93830989_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
