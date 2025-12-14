#if !defined(AFX_GETNAMEBYADDRESS_H__25C9B37A_0614_11D4_932F_00E02947F59E__INCLUDED_)
#define AFX_GETNAMEBYADDRESS_H__25C9B37A_0614_11D4_932F_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// GetNameByAddress.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CGetNameByAddress dialog

class CGetNameByAddress : public CDialog
{
// Construction
public:
	CGetNameByAddress(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CGetNameByAddress)
	enum { IDD = IDD_GetNamebyAddress };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGetNameByAddress)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Methodes
public:
	CString GetNameByIPAddress(CString IPAddress);

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CGetNameByAddress)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GETNAMEBYADDRESS_H__25C9B37A_0614_11D4_932F_00E02947F59E__INCLUDED_)
