// monitorthread.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "monitorthread.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// monitorthread

IMPLEMENT_DYNCREATE(monitorthread, CWinThread)

monitorthread::monitorthread()
{
}

monitorthread::~monitorthread()
{
}

BOOL monitorthread::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int monitorthread::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(monitorthread, CWinThread)
	//{{AFX_MSG_MAP(monitorthread)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// monitorthread message handlers

void monitorthread::SetParam(int tpid,bool* ttstmutual)
{
	processID = tpid;
	testmutualex = ttstmutual;
	monitoring.setmutualex(processID,testmutualex);
///////////////////////////////////////////
// temp
	//monitoring.DoModal();
///////////////////////////////////

}

int monitorthread::Run() 
{
	// TODO: Add your specialized code here and/or call the base class
//	monitoring.DoModal();
	monitoring.Create(IDD_MonitorForm,NULL);
	monitoring.ShowWindow(SW_SHOW);
	return CWinThread::Run();
}
