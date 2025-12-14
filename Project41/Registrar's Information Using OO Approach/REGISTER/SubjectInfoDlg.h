#if !defined(AFX_SUBJECTINFODLG_H__4EF6CC61_FA72_11D2_95B4_00E029377C4C__INCLUDED_)
#define AFX_SUBJECTINFODLG_H__4EF6CC61_FA72_11D2_95B4_00E029377C4C__INCLUDED_

#include "SubjectDlg.h"	// Added by ClassView
#include "SubjectAddDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SubjectInfoDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSubjectInfoDlg dialog

class CSubjectInfoDlg : public CDialog
{
// Construction
public:
	CSubjectInfoDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSubjectInfoDlg)
	enum { IDD = IDD_SUBJECTINFO_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSubjectInfoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSubjectInfoDlg)
	afx_msg void OnAddsubject();
	afx_msg void OnEditsubject();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CSubjectAddDlg m_CSubjectAddDlg;
	void SaveToDatabase();
	CSubjectDlg m_CSubjectDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SUBJECTINFODLG_H__4EF6CC61_FA72_11D2_95B4_00E029377C4C__INCLUDED_)
