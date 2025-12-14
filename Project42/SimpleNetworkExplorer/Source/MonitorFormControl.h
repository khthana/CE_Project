#if !defined(AFX_MONITORFORMCONTROL_H__56B52F74_03BC_11D4_9325_00E02947F59E__INCLUDED_)
#define AFX_MONITORFORMCONTROL_H__56B52F74_03BC_11D4_9325_00E02947F59E__INCLUDED_

#include "newshowingmonitordata.h"	// Added by ClassView
#include "SimpleNetworkExplorer.h"	// Added by ClassView

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MonitorFormControl.h : header file
//
#include "SNMPcontroller1.h"
/////////////////////////////////////////////////////////////////////////////
// MonitorFormControl dialog

class MonitorFormControl : public CDialog
{
// Construction
public:
	int intervalnumber;
	bool testinterval;
	int Intervaltime;
	bool openagent;
	void freemutual();
	bool testmutual();
	int processID;
	bool* mutualex;
	void setmutualex(int,bool*);
	UINT Gettotalunicastout();
	UINT Gettotalunicastin();
	UINT Gettotalmulticastout();
	UINT Gettotalmulticastin();
	UINT Gettotalpacketout();
	UINT Gettotalpacketin();
	UINT Getunicastoutrate();
	UINT Getunicastinrate();
	UINT Getmulticastoutrate();
	UINT Getmulticastinrate();
	UINT Getpacketoutrate();
	UINT Getpacketinrate();
	UINT Getifspeed();
	UINT Gettotalerrorout();
	UINT Gettotalerrorin();
	UINT Gettotalout();
	UINT Gettotalin();
	void stopmon();
	void startmon(CString);
	UINT Geterroroutrate();
	UINT Geterrorinrate();
	UINT Getoutrate();
	UINT Getinrate();
	newshowingmonitordata show1;
	UINT totalerout;
	UINT totalerin;
	UINT erinrate;
	UINT eroutrate;
	UINT outrate;
	UINT inrate;
	UINT totalout;
	UINT totalin;
	UINT pktinrate;
	UINT totalpktin;
	UINT tpktin;
	UINT pktoutrate;
	UINT totalpktout;
	UINT tpktout;
	UINT unicastinrate;
	UINT totalunicastin;
	UINT unicastoutrate;
	UINT totalunicastout;
	UINT multicastinrate;
	UINT totalmulticastin;
	UINT multicastoutrate;
	UINT totalmulticastout;
	UINT ifspeed;
//	CStatic message1[20];
	CString targetip;
	monitordata getinfo(CString,int);
	int ifnumber;
	void updatedata(CString);
	monitordata initif(CString,int);
	int collectifnum(CString);
	void collectif(CString);
	monitordata monitoringdata[50];
	monitordata changedata[50];
	SNMPcontroller snmpcollect;
	MonitorFormControl(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(MonitorFormControl)
	enum { IDD = IDD_MonitorForm };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(MonitorFormControl)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(MonitorFormControl)
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MONITORFORMCONTROL_H__56B52F74_03BC_11D4_9325_00E02947F59E__INCLUDED_)
