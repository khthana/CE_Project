#if !defined(AFX_STDINFODLG_H__9A950321_F27B_11D2_9599_00E029377C4C__INCLUDED_)
#define AFX_STDINFODLG_H__9A950321_F27B_11D2_9599_00E029377C4C__INCLUDED_

#include "StdAddDlg.h"	// Added by ClassView
#include "StdSelectDlg.h"	// Added by ClassView
#include "StdEditDlg.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StdinfoDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStdinfoDlg dialog

class CStdinfoDlg : public CDialog
{
// Construction
public:
	CStdinfoDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CStdinfoDlg)
	enum { IDD = IDD_STDINFORMATION_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStdinfoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CStdinfoDlg)
	afx_msg void OnReturn();
	afx_msg void OnAdd();
	afx_msg void OnRemove();
	afx_msg void OnEdit();
	afx_msg void OnCheck();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CStdEditDlg m_CStdEditDlg;
	CStdSelectDlg m_CStdSelectDlg;
	CStdAddDlg m_CStdAddDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDINFODLG_H__9A950321_F27B_11D2_9599_00E029377C4C__INCLUDED_)
