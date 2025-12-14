#if !defined(AFX_FACULTYFNDLG_H__CCCC2F01_FCB8_11D2_95C9_00E029377C4C__INCLUDED_)
#define AFX_FACULTYFNDLG_H__CCCC2F01_FCB8_11D2_95C9_00E029377C4C__INCLUDED_

#include "FacultyDlg.h"	// Added by ClassView
#include "FacultyAddDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FacultyfnDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFacultyfnDlg dialog

class CFacultyfnDlg : public CDialog
{
// Construction
public:
	CFacultyfnDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CFacultyfnDlg)
	enum { IDD = IDD_FACULTY_FUNCTION_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFacultyfnDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CFacultyfnDlg)
	afx_msg void OnAddfaculty();
	afx_msg void OnEditFaculty();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CFacultyAddDlg m_CFacultyAddDlg;
	CFacultyDlg m_CFacultyDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FACULTYFNDLG_H__CCCC2F01_FCB8_11D2_95C9_00E029377C4C__INCLUDED_)
