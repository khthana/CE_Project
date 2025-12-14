#if !defined(AFX_STDSELECTDLG_H__94A5BED2_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
#define AFX_STDSELECTDLG_H__94A5BED2_F4DE_11D2_959B_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StdSelectDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStdSelectDlg dialog

class CStdSelectDlg : public CDialog
{
// Construction
public:
	CString m_sql;
	CStdSelectDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CStdSelectDlg)
	enum { IDD = IDD_STDSELECT_DIALOG };
	CString	m_Code1;
	CString	m_Name;
	int		m_Select;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStdSelectDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CStdSelectDlg)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDSELECTDLG_H__94A5BED2_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
