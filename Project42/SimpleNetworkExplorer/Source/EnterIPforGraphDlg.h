#if !defined(AFX_ENTERIPFORGRAPHDLG_H__3D3DBAD5_0B76_11D4_933C_00E02947F59E__INCLUDED_)
#define AFX_ENTERIPFORGRAPHDLG_H__3D3DBAD5_0B76_11D4_933C_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// EnterIPforGraphDlg.h : header file
//

#include "MonitorFormControl.h"

/////////////////////////////////////////////////////////////////////////////
// CGraphDialog dialog

class CEnterIPforGraphDlg : public CDialog
{
// Construction
public:
	bool* testmutualex;
	int processID;
	void setmutualex(int,bool*);
	CEnterIPforGraphDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CEnterIPforGraphDlg)
	enum { IDD = IDD_EnterIPAddressforGraph };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

//Attribute

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEnterIPforGraphDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Methods

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CEnterIPforGraphDlg)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ENTERIPFORGRAPHDLG_H__3D3DBAD5_0B76_11D4_933C_00E02947F59E__INCLUDED_)
