//{{AFX_INCLUDES()
#include "msflexgrid.h"
//}}AFX_INCLUDES
#if !defined(AFX_REGISTERINFODLG_H__FEC053C0_F82E_11D2_95AA_00E029377C4C__INCLUDED_)
#define AFX_REGISTERINFODLG_H__FEC053C0_F82E_11D2_95AA_00E029377C4C__INCLUDED_

#include "SelectStdIdDlg.h"	// Added by ClassView
#include "Stdset.h"	// Added by ClassView
#include "Subject.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// RegisterInfoDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CRegisterInfoDlg dialog

#include "SubjectSelDlg.h"	// Added by ClassView
class CRegisterInfoDlg : public CDialog
{
// Construction
public:
	CRegisterInfoDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CRegisterInfoDlg)
	enum { IDD = IDD_REGISTERINFO_DIALOG };
	CString	m_department;
	CString	m_faculty;
	CString	m_register_surnamethai;
	CString	m_register_namethai;
	CString	m_student_code;
	CString	m_student_curriculum;
	CString	m_student_level;
	CString	m_subject_name;
	CString	m_term_study;
	CString	m_year_study;
	CString	m_title_name;
	CString	m_subject_id;
	CMSFlexGrid	m_registerfg;
	int		m_lab_credit;
	int		m_lec_credit;
	int		m_sum_credit;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CRegisterInfoDlg)
	
	virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CRegisterInfoDlg)
	afx_msg void OnOk();
	afx_msg void OnAddRegisterSubject();
	afx_msg void OnDeleteRegisterSubject();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	int Row;
	CSubjectSelDlg m_CSubjectSelDlg;
	CSubject m_CSubject;
	CStdset m_CStdset;
	CSelectStdIdDlg m_CSelectStdIdDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_REGISTERINFODLG_H__FEC053C0_F82E_11D2_95AA_00E029377C4C__INCLUDED_)
