#if !defined(AFX_QUERYFORM_H__56B52F76_03BC_11D4_9325_00E02947F59E__INCLUDED_)
#define AFX_QUERYFORM_H__56B52F76_03BC_11D4_9325_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// QueryForm.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// QueryForm dialog

class QueryForm : public CDialog
{
// Construction
public:
	char IP[16];
	char OID[30];
	char Instance[16];
	char Community[10];
	QueryForm(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(QueryForm)
	enum { IDD = IDD_QueryDlg };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(QueryForm)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(QueryForm)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_QUERYFORM_H__56B52F76_03BC_11D4_9325_00E02947F59E__INCLUDED_)
