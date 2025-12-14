#if !defined(AFX_MULTIPLEIPDLG_H__333883CC_14DF_11D4_9351_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEIPDLG_H__333883CC_14DF_11D4_9351_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// multipleipdlg.h : header file
//
#include "MultipleIPGraphDlg.h"


/////////////////////////////////////////////////////////////////////////////
// multipleipdlg thread

class multipleipdlg : public CWinThread
{
	DECLARE_DYNCREATE(multipleipdlg)
protected:
	multipleipdlg();           // protected constructor used by dynamic creation

// Attributes
public:
	CMultipleIPGraphDlg multipleipgraphdlg;
	bool* testmutualex;
	int processID;
	CStringArray* IPList;
	CString theValue;
	CString time;
// Operations
public:
	void SetParam(int,bool*,CString,CString,CStringArray*);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(multipleipdlg)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	virtual int Run();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~multipleipdlg();

	// Generated message map functions
	//{{AFX_MSG(multipleipdlg)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEIPDLG_H__333883CC_14DF_11D4_9351_00E02947F59E__INCLUDED_)
