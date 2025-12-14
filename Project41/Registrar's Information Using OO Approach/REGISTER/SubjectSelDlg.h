#if !defined(AFX_SUBJECTSELDLG_H__5D7C7B01_FC8A_11D2_95C8_00E029377C4C__INCLUDED_)
#define AFX_SUBJECTSELDLG_H__5D7C7B01_FC8A_11D2_95C8_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SubjectSelDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSubjectSelDlg dialog

class CSubjectSelDlg : public CDialog
{
// Construction
public:
	CSubjectSelDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSubjectSelDlg)
	enum { IDD = IDD_SUBJECT_SELECT_DIALOG };
	CString	m_subject_id;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSubjectSelDlg)
	virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSubjectSelDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SUBJECTSELDLG_H__5D7C7B01_FC8A_11D2_95C8_00E029377C4C__INCLUDED_)
