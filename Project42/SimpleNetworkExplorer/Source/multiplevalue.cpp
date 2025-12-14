// multiplevalue.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "multiplevalue.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// multiplevalue

IMPLEMENT_DYNCREATE(multiplevalue, CWinThread)

multiplevalue::multiplevalue()
{
}

multiplevalue::~multiplevalue()
{
}

BOOL multiplevalue::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int multiplevalue::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(multiplevalue, CWinThread)
	//{{AFX_MSG_MAP(multiplevalue)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// multiplevalue message handlers

void multiplevalue::SetParam(int tpid,bool* ttstmutual)
{
	processID = tpid;
	testmutualex = ttstmutual;
	multiplevaluegraph.setmutual(processID,testmutualex);

}

int multiplevalue::Run() 
{
	multiplevaluegraph.Create(IDD_MultipleValueGraphInput,NULL);
	multiplevaluegraph.ShowWindow(SW_SHOW);
		
	return CWinThread::Run();
}
