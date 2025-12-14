#if !defined(AFX_MAINDLG_H__EC59F5D1_F226_11D2_9597_00E029377C4C__INCLUDED_)
#define AFX_MAINDLG_H__EC59F5D1_F226_11D2_9597_00E029377C4C__INCLUDED_

#include "StdinfoDlg.h"	// Added by ClassView
#include "RegisterInfoDlg.h"	// Added by ClassView
#include "SubjectDlg.h"	// Added by ClassView
#include "CurriculumDlg.h"	// Added by ClassView
#include "SubjectInfoDlg.h"	// Added by ClassView
#include "OtherinfoDlg.h"
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MainDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMainDlg dialog

class CMainDlg : public CDialog
{
// Construction
public:
	CMainDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CMainDlg)
	enum { IDD = IDD_MAIN_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CMainDlg)
	afx_msg void OnQuit();
	afx_msg void OnBiography();
	afx_msg void OnRegister();
	afx_msg void OnSubject();
	afx_msg void OnCurriculum();
	afx_msg void OnInformation();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	COtherinfoDlg m_COtherinfoDlg;
	CSubjectInfoDlg m_CSubjectInfoDlg;

	CCurriculumDlg m_CCurriculumDlg;

	CRegisterInfoDlg m_CRegisterInfoDlg;
	CStdinfoDlg m_CStdinfoDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINDLG_H__EC59F5D1_F226_11D2_9597_00E029377C4C__INCLUDED_)
