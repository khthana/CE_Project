#if !defined(AFX_STDEDITDLG_H__94A5BED3_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
#define AFX_STDEDITDLG_H__94A5BED3_F4DE_11D2_959B_00E029377C4C__INCLUDED_

#include "StdSelectDlg.h"	// Added by ClassView
#include "Stdset.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StdEditDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStdEditDlg dialog

class CStdEditDlg : public CDialog
{
// Construction
public:
	void RestoreFromDatabase();
	void SaveToDatabase();
	CStdEditDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CStdEditDlg)
	enum { IDD = IDD_STDEDIT_DIALOG };
	CString	m_stdedit_namethai;
	CString	m_stdedit_surnamethai;
	CString	m_stdedit_nameeng;
	CString	m_stdedit_surnameeng;
	CString	m_stdedit_no;
	CString	m_stdedit_titleeng;
	CString	m_stdedit_titlethai;
	CString	m_stdedit_sex;
	CString	m_stdedit_birthday;
	CString	m_stdedit_religion;
	CString	m_stdedit_nation;
	CString	m_stdedit_citizen;
	CString	m_stdedit_addrborder;
	CString	m_stdedit_addrcode;
	CString	m_stdedit_addrdistinct;
	CString	m_stdedit_addrfax;
	CString	m_stdedit_addrno;
	CString	m_stdedit_addrpager;
	CString	m_stdedit_addrprovince;
	CString	m_stdedit_addrroad;
	CString	m_stdedit_addrsoi;
	CString	m_stdedit_addrtel;
	CString	m_stdedit_caddrborder;
	CString	m_stdedit_caddrcode;
	CString	m_stdedit_caddrdistinct;
	CString	m_stdedit_caddrfax;
	CString	m_stdedit_caddrno;
	CString	m_stdedit_caddrprovince;
	CString	m_stdedit_caddrroad;
	CString	m_stdedit_caddrsoi;
	CString	m_stdedit_caddrtel;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStdEditDlg)
virtual BOOL OnInitDialog();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CStdEditDlg)
	virtual void OnOK();
	afx_msg void OnStdeditPrevious();
	afx_msg void OnStdeditNext();
	afx_msg void OnExit();
	afx_msg void OnCancel();
	afx_msg void OnDelete();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CStdset m_CStdset;
	CStdSelectDlg m_CStdSelectDlg;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDEDITDLG_H__94A5BED3_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
