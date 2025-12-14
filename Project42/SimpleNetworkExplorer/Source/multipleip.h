#if !defined(AFX_MULTIPLEIP_H__333883C8_14DF_11D4_9351_00E02947F59E__INCLUDED_)
#define AFX_MULTIPLEIP_H__333883C8_14DF_11D4_9351_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// multipleip.h : header file
//

#include "MultipleIPGraphInput.h"

/////////////////////////////////////////////////////////////////////////////
// multipleip thread

class multipleip : public CWinThread
{
	DECLARE_DYNCREATE(multipleip)
protected:
	multipleip();           // protected constructor used by dynamic creation

// Attributes
public:

// Operations
public:
//	void SetParam();
	CMultipleIPGraphInput multipleipgraph;
	bool* testmutualex;
	int processID;
	void SetParam(int,bool*);
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(multipleip)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	virtual int Run();
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~multipleip();

	// Generated message map functions
	//{{AFX_MSG(multipleip)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MULTIPLEIP_H__333883C8_14DF_11D4_9351_00E02947F59E__INCLUDED_)
