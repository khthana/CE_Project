//{{AFX_INCLUDES()
#include "msflexgrid.h"
//}}AFX_INCLUDES
#if !defined(AFX_SUBJECTDLG_H__B8180C81_F837_11D2_95AB_00E029377C4C__INCLUDED_)
#define AFX_SUBJECTDLG_H__B8180C81_F837_11D2_95AB_00E029377C4C__INCLUDED_

#include "Subject.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SubjectDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSubjectDlg dialog

class CSubjectDlg : public CDialog
{
// Construction
public:
	CSubjectDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSubjectDlg)
	enum { IDD = IDD_SUBJECT_DIALOG };
	CString	m_category;
	CString	m_group;
	CString	m_subject_dept;
	CString	m_subject_dept_id;
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
	//{{AFX_VIRTUAL(CSubjectDlg)
	virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSubjectDlg)
	afx_msg void OnUpdateSubject();
	afx_msg void OnExitSubject();
	afx_msg void OnDeleteSubject();
	afx_msg void OnMovePrev();
	afx_msg void OnMoveNext();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	void SaveToDatabase();
	void RestorefromDatabase();
	CSubject m_CSubject;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SUBJECTDLG_H__B8180C81_F837_11D2_95AB_00E029377C4C__INCLUDED_)
