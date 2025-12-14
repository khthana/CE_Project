#if !defined(AFX_MONITORTHREAD_H__24174034_136D_11D4_B30E_002018384C47__INCLUDED_)
#define AFX_MONITORTHREAD_H__24174034_136D_11D4_B30E_002018384C47__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// monitorthread.h : header file
//
#include "MonitorFormControl.h"


/////////////////////////////////////////////////////////////////////////////
// monitorthread thread

class monitorthread : public CWinThread
{
	DECLARE_DYNCREATE(monitorthread)
protected:
	monitorthread();           // protected constructor used by dynamic creation

// Attributes
public:

// Operations
public:
	MonitorFormControl monitoring;
	bool* testmutualex;
	int processID;
	void SetParam(int,bool*);
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(monitorthread)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	virtual int Run();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~monitorthread();

	// Generated message map functions
	//{{AFX_MSG(monitorthread)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MONITORTHREAD_H__24174034_136D_11D4_B30E_002018384C47__INCLUDED_)
