#if !defined(AFX_FACULTYDLG_H__0A7D94F5_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
#define AFX_FACULTYDLG_H__0A7D94F5_FCA9_11D2_95C8_00E029377C4C__INCLUDED_

#include "Faculty.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FacultyDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFacultyDlg dialog

class CFacultyDlg : public CDialog
{
// Construction
public:
	void SaveToDatabase();
	void RestoreformDatabase();
	CFacultyDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CFacultyDlg)
	enum { IDD = IDD_FACULTY_DIALOG };
	CString	m_faculty_description;
	CString	m_faculty_id;
	CString	m_faculty_nameeng;
	CString	m_faculty_namethai;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFacultyDlg)
	virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CFacultyDlg)
	afx_msg void OnExitfaculty();
	afx_msg void OnDeletefaculty();
	afx_msg void OnUpdatefaculty();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CFaculty m_CFaculty;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FACULTYDLG_H__0A7D94F5_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
