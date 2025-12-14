#if !defined(AFX_IP_INPUT_H__64C13739_0346_11D4_9323_00E02947F59E__INCLUDED_)
#define AFX_IP_INPUT_H__64C13739_0346_11D4_9323_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// IP_input.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// IP_input dialog

class IP_input : public CDialog
{
// Construction
public:
	CString getcommunity();
	CString getlast();
	CString getfirst();
	char Community[16];
	char IPlasttext[16];
	char IPfirsttext[16];
	IP_input(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(IP_input)
	enum { IDD = IDD_IP_input };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(IP_input)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL
// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(IP_input)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_IP_INPUT_H__64C13739_0346_11D4_9323_00E02947F59E__INCLUDED_)
