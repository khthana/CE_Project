#if !defined(AFX_TESTSOCK_H__1D479DA2_83CE_11D2_AA9B_008048FBB1F4__INCLUDED_)
#define AFX_TESTSOCK_H__1D479DA2_83CE_11D2_AA9B_008048FBB1F4__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// TestSock.h : header file
//



/////////////////////////////////////////////////////////////////////////////
// TestSock command target

class TestSock : public CAsyncSocket
{
// Attributes
public:

// Operations
public:
	TestSock();
	virtual ~TestSock();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(TestSock)
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(TestSock)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TESTSOCK_H__1D479DA2_83CE_11D2_AA9B_008048FBB1F4__INCLUDED_)
