#if !defined(AFX_MULTIPLEVALUEDLG_H__333883CD_14DF_11D4_9351_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEVALUEDLG_H__333883CD_14DF_11D4_9351_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// multiplevaluedlg.h : header file
//
#include "MultipleValueGraphDlg.h"


/////////////////////////////////////////////////////////////////////////////
// multiplevaluedlg thread

class multiplevaluedlg : public CWinThread
{
	DECLARE_DYNCREATE(multiplevaluedlg)
protected:
	multiplevaluedlg();           // protected constructor used by dynamic creation

// Attributes
public:
	CMultipleValueGraphDlg multiplevaluegraphdlg;
	bool* testmutualex;
	int processID;
	CString IP;
	CString time;
	CStringArray* ValueList;

// Operations
public:
	void SetParam(int,bool*,CString,CString,CStringArray*);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(multiplevaluedlg)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	virtual int Run();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~multiplevaluedlg();

	// Generated message map functions
	//{{AFX_MSG(multiplevaluedlg)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEVALUEDLG_H__333883CD_14DF_11D4_9351_00E02947F59E__INCLUDED_)
