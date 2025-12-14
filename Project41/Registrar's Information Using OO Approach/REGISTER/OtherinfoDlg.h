#if !defined(AFX_OTHERINFODLG_H__0A7D94F0_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
#define AFX_OTHERINFODLG_H__0A7D94F0_FCA9_11D2_95C8_00E029377C4C__INCLUDED_

#include "FacultyDlg.h"	// Added by ClassView
#include "FacultyfnDlg.h"	// Added by ClassView
#include "DepartmentfnDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// OtherinfoDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// COtherinfoDlg dialog

class COtherinfoDlg : public CDialog
{
// Construction
public:
	COtherinfoDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(COtherinfoDlg)
	enum { IDD = IDD_INFORMATIONS };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COtherinfoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(COtherinfoDlg)
	afx_msg void OnFaculty();
	afx_msg void OnExit();
	afx_msg void OnDepartment();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CDepartmentfnDlg m_CDepartmentfnDlg;
	CFacultyfnDlg m_CFacultyfnDlg;
	CFacultyDlg m_CFacultyDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_OTHERINFODLG_H__0A7D94F0_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
