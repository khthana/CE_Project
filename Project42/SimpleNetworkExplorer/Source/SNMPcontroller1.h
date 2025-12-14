#if !defined(AFX_SNMPCONTROLLER1_H__B8AF7255_05F4_11D4_B2C2_002018384C47__INCLUDED_)
#define AFX_SNMPCONTROLLER1_H__B8AF7255_05F4_11D4_B2C2_002018384C47__INCLUDED_

#include "winsock2.h"
#include "SimpleNetworkExplorer.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SNMPcontroller1.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// SNMPcontroller dialog

class SNMPcontroller : public CDialog
{
// Construction
public:
	CString querytype;
	void SNMPgetnext(CString,CString,CString);
	CStatic IP;
	CStatic Status;
	CString snmpcommunityname;
	int ipnum;
	ipfields iplist[1000];
	void update(ipfields*,int,CString);
	bool SNMPopenagent(CString,CString,CString,CString);
	snmpdata SNMPgetdesc(CString);
	int stringtobyte(CString);
	interfacedata ifgetdata(int,CString,CString,int);
	char chr(byte);
	CString ipinttostr(ipfields);
	ipfields collectip(CString);
	int ifallince(CString,CString,UINT);
	interfacedata initif();
	CString querydata;
	SNMPcontroller(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(SNMPcontroller)
	enum { IDD = IDD_SNMP };
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(SNMPcontroller)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(SNMPcontroller)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SNMPCONTROLLER1_H__B8AF7255_05F4_11D4_B2C2_002018384C47__INCLUDED_)
