// multiplevaluedlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "multiplevaluedlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// multiplevaluedlg

IMPLEMENT_DYNCREATE(multiplevaluedlg, CWinThread)

multiplevaluedlg::multiplevaluedlg()
{
}

multiplevaluedlg::~multiplevaluedlg()
{
}

BOOL multiplevaluedlg::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int multiplevaluedlg::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(multiplevaluedlg, CWinThread)
	//{{AFX_MSG_MAP(multiplevaluedlg)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// multiplevaluedlg message handlers

void multiplevaluedlg::SetParam(int tpid,bool* ttstmutual,CString tip,CString ttime,CStringArray* tvaluelist)
{

	testmutualex = ttstmutual;
	processID = tpid;
	IP = tip;
	time = ttime;
	ValueList = tvaluelist;
	multiplevaluegraphdlg.setmutual(processID,testmutualex);
	multiplevaluegraphdlg.setvalue(IP,ValueList,time);
}

int multiplevaluedlg::Run() 
{
	multiplevaluegraphdlg.Create(IDD_MultipleValueGraphDlg,NULL);
	multiplevaluegraphdlg.ShowWindow(SW_SHOW);
	
	return CWinThread::Run();
}
