// multipleipdlg.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "multipleipdlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// multipleipdlg

IMPLEMENT_DYNCREATE(multipleipdlg, CWinThread)

multipleipdlg::multipleipdlg()
{
}

multipleipdlg::~multipleipdlg()
{
}

BOOL multipleipdlg::InitInstance()
{
	// TODO:  perform and per-thread initialization here
	return TRUE;
}

int multipleipdlg::ExitInstance()
{
	// TODO:  perform any per-thread cleanup here
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(multipleipdlg, CWinThread)
	//{{AFX_MSG_MAP(multipleipdlg)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// multipleipdlg message handlers

void multipleipdlg::SetParam(int tpid,bool* ttstmutual,CString ttime,CString tthevalue,CStringArray* tiplist)
{
	testmutualex = ttstmutual;
	processID = tpid;
	IPList = tiplist;
	theValue = tthevalue;
	time = ttime;
	multipleipgraphdlg.setmutual(processID,testmutualex);
	multipleipgraphdlg.setvalue(IPList,theValue,time);
}

int multipleipdlg::Run() 
{
	multipleipgraphdlg.Create(IDD_MultipleIPGraphDlg,NULL);
	multipleipgraphdlg.ShowWindow(SW_SHOW);
	
	return CWinThread::Run();
}
