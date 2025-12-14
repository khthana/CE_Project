// multipleip.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "multipleip.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// multipleip

IMPLEMENT_DYNCREATE(multipleip, CWinThread)

multipleip::multipleip()
{
}

multipleip::~multipleip()
{
}

BOOL multipleip::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int multipleip::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(multipleip, CWinThread)
	//{{AFX_MSG_MAP(multipleip)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// multipleip message handlers

void multipleip::SetParam(int tpid,bool* ttstmutual)
{
	processID = tpid;
	testmutualex = ttstmutual;
	multipleipgraph.setmutual(processID,testmutualex);

}

int multipleip::Run() 
{
	multipleipgraph.Create(IDD_Multiple_IP_Graph_Input,NULL);
	multipleipgraph.ShowWindow(SW_SHOW);
	
	return CWinThread::Run();
}
