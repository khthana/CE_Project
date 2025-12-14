#if !defined(AFX_TESTING_H__64C1373D_0346_11D4_9323_00E02947F59E__INCLUDED_)
#define AFX_TESTING_H__64C1373D_0346_11D4_9323_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// testing.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// testing dialog

class testing : public CDialog
{
// Construction
public:
	testing(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(testing)
	enum { IDD = IDD_test1 };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(testing)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(testing)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TESTING_H__64C1373D_0346_11D4_9323_00E02947F59E__INCLUDED_)
