#if !defined(AFX_FACULTYADDDLG_H__0338C711_FCAC_11D2_95C8_00E029377C4C__INCLUDED_)
#define AFX_FACULTYADDDLG_H__0338C711_FCAC_11D2_95C8_00E029377C4C__INCLUDED_

#include "Faculty.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FacultyAddDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFacultyAddDlg dialog

class CFacultyAddDlg : public CDialog
{
// Construction
public:
	CFacultyAddDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CFacultyAddDlg)
	enum { IDD = IDD_FACULTY_ADD_DIALOG };
	CString	m_faculty_description;
	CString	m_faculty_id;
	CString	m_faculty_nameeng;
	CString	m_faculty_namethai;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFacultyAddDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CFacultyAddDlg)
	afx_msg void OnAddfaculty();
	afx_msg void OnExitfaculty();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	void SaveToDatabase();
	CFaculty m_CFaculty;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FACULTYADDDLG_H__0338C711_FCAC_11D2_95C8_00E029377C4C__INCLUDED_)
