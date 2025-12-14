#if !defined(AFX_MULTIPLEVALUE_H__333883C9_14DF_11D4_9351_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEVALUE_H__333883C9_14DF_11D4_9351_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// multiplevalue.h : header file
//
#include "MultipleValueGraphInputDlg.h"


/////////////////////////////////////////////////////////////////////////////
// multiplevalue thread

class multiplevalue : public CWinThread
{
	DECLARE_DYNCREATE(multiplevalue)
protected:
	multiplevalue();           // protected constructor used by dynamic creation

// Attributes
public:
	CMultipleValueGraphInputDlg multiplevaluegraph;
	bool* testmutualex;
	int processID;

// Operations
public:
	void SetParam(int,bool*);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(multiplevalue)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	virtual int Run();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~multiplevalue();

	// Generated message map functions
	//{{AFX_MSG(multiplevalue)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEVALUE_H__333883C9_14DF_11D4_9351_00E02947F59E__INCLUDED_)
