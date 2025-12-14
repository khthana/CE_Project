// SimpleNetworkExplorer.h : main header file for the SIMPLENETWORKEXPLORER application
//

#if !defined(AFX_SIMPLENETWORKEXPLORER_H__811CCD38_0338_11D4_9323_00E02947F59E__INCLUDED_)
#define AFX_SIMPLENETWORKEXPLORER_H__811CCD38_0338_11D4_9323_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols
#define SUPPORTNO 100
#define NOTSUPPORTNO 200
#define NETWORKNO 20
#define INTERFACENO 20
#define ALLNODE 200

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerApp:
// See SimpleNetworkExplorer.cpp for the implementation of this class
//
#include <stdio.h>
#include <stdlib.h>

class CSimpleNetworkExplorerApp : public CWinApp
{
public:
	CSimpleNetworkExplorerApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSimpleNetworkExplorerApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CSimpleNetworkExplorerApp)
	afx_msg void OnAppAbout();
	afx_msg void OnExplorerStartexplorer();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SIMPLENETWORKEXPLORER_H__811CCD38_0338_11D4_9323_00E02947F59E__INCLUDED_)

typedef struct ipfield {
	int field1;
	int field2;
	int field3;
	int field4;
}ipfields;
typedef struct SNMPdata{
	CString nodename;
	CString nodedesc;
	int nodeservice;
	int ifnumber;
	}snmpdata;
typedef struct Interfacedata{
	int ifindex;
	CString IP;
	CString subnet;
	int iftype;
	int ifspeed;
	}interfacedata;
typedef struct Nodedata{
	snmpdata nodeindex;
	interfacedata ifdata[20];
	}nodedata;
typedef struct networklists{
	ipfields netadd;
	ipfields netclass;
	int nettype;
	}network;
typedef struct DNSlookup{
	CString nodename;
	CString IP;
	CString subnet;
	}dnslookup;

typedef struct monitorlists{
	UINT ifindex;
	UINT inoct;
	UINT outoct;
	UINT inerror;
	UINT outerror;
	UINT inmltcst;
	UINT outmltcst;
	UINT inunicst;
	UINT outunicst;
	}monitordata;

class datacollector{
public:
	void networkcollect(network*,int);
	void supportcollect(nodedata*,int,dnslookup*,int);
//	void unsupportcollect(CString*,int);
	CString ipinttostr(ipfields);
	char chr(byte);
};
