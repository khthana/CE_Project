#if !defined(AFX_DEPARTMENTFNDLG_H__E9AEAE24_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
#define AFX_DEPARTMENTFNDLG_H__E9AEAE24_FCC3_11D2_95CA_00E029377C4C__INCLUDED_

#include "DepartmentAddDlg.h"	// Added by ClassView
#include "DepartmentDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DepartmentfnDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDepartmentfnDlg dialog

class CDepartmentfnDlg : public CDialog
{
// Construction
public:
	CDepartmentfnDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDepartmentfnDlg)
	enum { IDD = IDD_DEPARTMENT_FUNCTION_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDepartmentfnDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDepartmentfnDlg)
	afx_msg void OnFacultyAdd();
	afx_msg void OnFacultyEditDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CDepartmentDlg m_CDepartmentDlg;
	CDepartmentAddDlg m_CDepartmentAddDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEPARTMENTFNDLG_H__E9AEAE24_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
