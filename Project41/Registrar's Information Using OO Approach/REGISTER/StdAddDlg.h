#if !defined(AFX_STDADDDLG_H__94A5BED1_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
#define AFX_STDADDDLG_H__94A5BED1_F4DE_11D2_959B_00E029377C4C__INCLUDED_

#include "Stdset.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StdAddDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStdAddDlg dialog

class CStdAddDlg : public CDialog
{
// Construction
public:
	CStdAddDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CStdAddDlg)
	enum { IDD = IDD_STDADD_DIALOG };
	CString	m_stdadd_addrborder;
	CString	m_stdadd_addrcode;
	CString	m_stdadd_addrdistinct;
	CString	m_stdadd_addrfax;
	CString	m_stdadd_addrno;
	CString	m_stdadd_addrpager;
	CString	m_stdadd_addrprovince;
	CString	m_stdadd_addrroad;
	CString	m_stdadd_addrsoi;
	CString	m_stdadd_addrtel;
	CString	m_stdadd_birthday;
	CString	m_stdadd_caddrborder;
	CString	m_stdadd_caddrcode;
	CString	m_stdadd_caddrdistinct;
	CString	m_stdadd_caddrfax;
	CString	m_stdadd_caddrno;
	CString	m_stdadd_caddrprovince;
	CString	m_stdadd_caddrroad;
	CString	m_stdadd_caddrsoi;
	CString	m_stdadd_caddrtel;
	CString	m_stdadd_citizen;
	CString	m_stdadd_nameeng;
	CString	m_stdadd_namethai;
	CString	m_stdadd_nation;
	CString	m_stdadd_stdno;
	CString	m_stdadd_religion;
	CString	m_stdadd_sex;
	CString	m_stdadd_surnameeng;
	CString	m_stdadd_surnamethai;
	CString	m_stdadd_titleeng;
	CString	m_stdadd_titlethai;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStdAddDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CStdAddDlg)
	afx_msg void OnExit();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CStdset m_CStdset;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDADDDLG_H__94A5BED1_F4DE_11D2_959B_00E029377C4C__INCLUDED_)
