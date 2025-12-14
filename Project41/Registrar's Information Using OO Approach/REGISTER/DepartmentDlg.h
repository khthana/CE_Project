#if !defined(AFX_DEPARTMENTDLG_H__E9AEAE22_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
#define AFX_DEPARTMENTDLG_H__E9AEAE22_FCC3_11D2_95CA_00E029377C4C__INCLUDED_

#include "Department.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DepartmentDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDepartmentDlg dialog

class CDepartmentDlg : public CDialog
{
// Construction
public:
	CDepartmentDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDepartmentDlg)
	enum { IDD = IDD_DEPARTMENT_EDIT_DIALOG };
	CString	m_department_description;
	CString	m_department_faculty_name;
	CString	m_department_id;
	CString	m_department_nameeng;
	CString	m_department_namethai;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDepartmentDlg)
//Class.h
	virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDepartmentDlg)
	afx_msg void OnExitdepartment();
	afx_msg void OnDeptMoveNext();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CDepartment m_CDepartment;
	void RestoreFromDatabase();
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEPARTMENTDLG_H__E9AEAE22_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
