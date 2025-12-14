// Mapper.h : main header file for the MAPPER application
//

#if !defined(AFX_MAPPER_H__242CDA45_0695_11D4_857E_96A44DCF5271__INCLUDED_)
#define AFX_MAPPER_H__242CDA45_0695_11D4_857E_96A44DCF5271__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CMapperApp:
// See Mapper.cpp for the implementation of this class
//

class CMapperApp : public CWinApp
{
public:
	CMapperApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMapperApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CMapperApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAPPER_H__242CDA45_0695_11D4_857E_96A44DCF5271__INCLUDED_)
