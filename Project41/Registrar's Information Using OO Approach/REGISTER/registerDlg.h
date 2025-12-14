// registerDlg.h : header file
//

#if !defined(AFX_REGISTERDLG_H__1BEDF397_F219_11D2_9597_00E029377C4C__INCLUDED_)
#define AFX_REGISTERDLG_H__1BEDF397_F219_11D2_9597_00E029377C4C__INCLUDED_

#include "Stdset.h"	// Added by ClassView
#include "MainDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CRegisterDlg dialog

class CRegisterDlg : public CDialog
{
// Construction
public:
	CString m_UidPass;
//	CString m_Idpass;
//	CString m_Uidpass;
	CRegisterDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CRegisterDlg)
	enum { IDD = IDD_REGISTER_DIALOG };
	CString	m_Login;
	CString	m_Password;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CRegisterDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CRegisterDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:

	CMainDlg m_CMainDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_REGISTERDLG_H__1BEDF397_F219_11D2_9597_00E029377C4C__INCLUDED_)
