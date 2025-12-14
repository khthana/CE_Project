// SnmpAgent.h : main header file for the SNMPAGENT application
//

#if !defined(AFX_SNMPAGENT_H__F4E51E45_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
#define AFX_SNMPAGENT_H__F4E51E45_8162_11D2_AA9B_008048FBB1F4__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentApp:
// See SnmpAgent.cpp for the implementation of this class
//

class CSnmpAgentApp : public CWinApp
{
public:
	CSnmpAgentApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSnmpAgentApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSnmpAgentApp)
	afx_msg void OnAppAbout();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SNMPAGENT_H__F4E51E45_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
