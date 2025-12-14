#if !defined(AFX_DEPARTMENTADDDLG_H__E9AEAE23_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
#define AFX_DEPARTMENTADDDLG_H__E9AEAE23_FCC3_11D2_95CA_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DepartmentAddDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDepartmentAddDlg dialog

class CDepartmentAddDlg : public CDialog
{
// Construction
public:
	CDepartmentAddDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDepartmentAddDlg)
	enum { IDD = IDD_DEPARTMENT_ADD_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDepartmentAddDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDepartmentAddDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEPARTMENTADDDLG_H__E9AEAE23_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
