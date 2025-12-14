// Bridge.h : main header file for the BRIDGE application
//

#if !defined(AFX_BRIDGE_H__B6C02665_DFD3_11D3_AF75_000000000000__INCLUDED_)
#define AFX_BRIDGE_H__B6C02665_DFD3_11D3_AF75_000000000000__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CBridgeApp:
// See Bridge.cpp for the implementation of this class
//

class CBridgeApp : public CWinApp
{
public:
	CBridgeApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CBridgeApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CBridgeApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_BRIDGE_H__B6C02665_DFD3_11D3_AF75_000000000000__INCLUDED_)
