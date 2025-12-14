#if !defined(AFX_SELECTSTDIDDLG_H__FEC053C2_F82E_11D2_95AA_00E029377C4C__INCLUDED_)
#define AFX_SELECTSTDIDDLG_H__FEC053C2_F82E_11D2_95AA_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectStdIdDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectStdIdDlg dialog

class CSelectStdIdDlg : public CDialog
{
// Construction
public:
	CString m_sql;
	CSelectStdIdDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectStdIdDlg)
	enum { IDD = IDD_SELECTSTDID_DIALOG };
	CString	m_Std_Id;
	CString	m_term;
	CString	m_academic_year;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectStdIdDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectStdIdDlg)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTSTDIDDLG_H__FEC053C2_F82E_11D2_95AA_00E029377C4C__INCLUDED_)
