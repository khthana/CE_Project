#if !defined(AFX_SUBJECTADDDLG_H__4EF6CC62_FA72_11D2_95B4_00E029377C4C__INCLUDED_)
#define AFX_SUBJECTADDDLG_H__4EF6CC62_FA72_11D2_95B4_00E029377C4C__INCLUDED_

#include "Subject.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SubjectAddDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSubjectAddDlg dialog

class CSubjectAddDlg : public CDialog
{
// Construction
public:
	CSubject m_CSubject;
	CSubjectAddDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSubjectAddDlg)
	enum { IDD = IDD_SUBJECTADD_DIALOG };
	CString	m_category;
	CString	m_group;
	CString	m_subject_dept_id;
	CString	m_subject_dept;
	CString	m_subject_description;
	CString	m_subject_faculty;
	CString	m_subject_faculty_id;
	CString	m_subject_id;
	int		m_subject_lab_credit;
	int		m_subject_lec_credit;
	CString	m_subject_name_eng;
	CString	m_subject_name_thai;
	int		m_subject_sum_credit;
	CString	m_year_study;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSubjectAddDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSubjectAddDlg)
	afx_msg void OnAddSubject();
	afx_msg void OnExitSubject();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	void SaveToDatabase();
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SUBJECTADDDLG_H__4EF6CC62_FA72_11D2_95B4_00E029377C4C__INCLUDED_)
