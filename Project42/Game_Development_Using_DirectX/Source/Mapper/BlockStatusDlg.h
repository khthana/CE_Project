#if !defined(AFX_BLOCKSTATUSDLG_H__242CDA55_0695_11D4_857E_96A44DCF5271__INCLUDED_)
#define AFX_BLOCKSTATUSDLG_H__242CDA55_0695_11D4_857E_96A44DCF5271__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// BlockStatusDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CBlockStatusDlg dialog

class CBlockStatusDlg : public CDialog
{
// Construction
public:
	CBlockStatusDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CBlockStatusDlg)
	enum { IDD = IDD_BLOCKSTATUS };
	int		m_i;
	int		m_j;
	int		m_Level;
	int		m_Reserved;
	int		m_Type;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CBlockStatusDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CBlockStatusDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_BLOCKSTATUSDLG_H__242CDA55_0695_11D4_857E_96A44DCF5271__INCLUDED_)
