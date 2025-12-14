#if !defined(AFX_ROUTERCONTROLLER_H__7A900A71_0D06_11D4_B2F2_002018384C47__INCLUDED_)
#define AFX_ROUTERCONTROLLER_H__7A900A71_0D06_11D4_B2F2_002018384C47__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// RouterController.h : header file
//
#include "SNMPcontroller1.h"
#include "SimpleNetworkExplorer.h"	// Added by ClassView
/////////////////////////////////////////////////////////////////////////////
// RouterController dialog

class RouterController : public CDialog
{
// Construction
public:
	CStatic label[4];
	CStatic data[3];
	CString nextrthop;
	ipfield getnextrt(CString,CString,CString);
	ipfield getnextip(CString,CString,CString);
	void getnexthoprouter(CString,CString);
	CString oldip;
	CString oldif;
	ipfield rtlist[50];
	ipfield rtnextlist[50];
	int rtindex;
	int rtnextindex;
	SNMPcontroller snmpcontrol;
	ipfield getip(CString,CString,CString,CString);
	RouterController(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(RouterController)
	enum { IDD = IDD_GetRouterIP };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(RouterController)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(RouterController)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ROUTERCONTROLLER_H__7A900A71_0D06_11D4_B2F2_002018384C47__INCLUDED_)
