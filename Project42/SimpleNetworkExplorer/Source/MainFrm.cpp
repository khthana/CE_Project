// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "NetworkDiagramDlg.h"
#include "QueryForm.h"
#include "MainFrm.h"
#include "MonitorFormControl.h"
#include "SNMPcontroller1.h"
#include "GetNameByAddress.h"
#include "EnterIPforGraphDlg.h"
#include "RouterController.h"
#include "monitorthread.h"
//#include "MultipleIPGraphInput.h"
#include "multipleip.h"
//#include "MultipleValueGraphInputDlg.h"
#include "multiplevalue.h"
//#include "QueryForm2.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNCREATE(CMainFrame, CFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_COMMAND(ID_EXPLORER_DISPLAYDIAGRAM, OnExplorerDisplaydiagram)
	ON_COMMAND(ID_MONITOR_MONITORDATA, OnMonitorMonitordata)
	ON_COMMAND(ID_RETRIEVEMIB_RETRIEVINGDATA, OnRetrievemibRetrievingdata)
	ON_COMMAND(ID_EXPLORER_GETNAMEBYIPADDRESS, OnExplorerGetnamebyipaddress)
	ON_COMMAND(ID_MONITOR_SHOWGRAPH, OnMonitorShowgraph)
	ON_COMMAND(ID_EXPLORER_STARTEXPLORER_STARTEXPLORERBYROUTER, OnExplorerStartexplorerStartexplorerbyrouter)
	ON_COMMAND(ID_MONITOR_SHOWMULTIPLEIPGRAPH, OnMonitorShowmultipleipgraph)
	ON_COMMAND(ID_MONITOR_SHOWMULTIPLEVALUEGRAPH, OnMonitorShowmultiplevaluegraph)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	// TODO: add member initialization code here
	
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create
	}

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}

	// TODO: Delete these three lines if you don't want the toolbar to
	//  be dockable
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);

	return 0;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers


void CMainFrame::OnExplorerDisplaydiagram() 
{
	CNetworkDiagramDlg NetworkDiagramDialog;
	NetworkDiagramDialog.DoModal();
}

void CMainFrame::OnMonitorMonitordata() 
{
	if (initprocess > 1)
		{
		initprocess = false;
		}
	if (initprocess)
		{
		processID += 100;
		}
	else
		{
		processID = 100;
		}
	if (mutualex > 1)
		{
		mutualex = false;
		}
	initprocess = true;
//	MonitorFormControl monitor;
//	monitor.setmutualex(processID,&mutualex);
//	monitor.DoModal();	
	CWinThread* thread = AfxBeginThread(RUNTIME_CLASS(monitorthread),0,0,CREATE_SUSPENDED,NULL);
//	_ASSERTE(thread && thread->IsKindOf(RUNTIME_CLASS(multithreadcontroller));
	monitorthread* st = (monitorthread *) thread;
	st->SetParam(processID,&mutualex);
	st->ResumeThread();
}

void CMainFrame::OnRetrievemibRetrievingdata() 
{
	CString IP;
	CString OID;
	CString Instance;
	CString Community;
	SNMPcontroller snmpquery;
	CEdit message;
	QueryForm query;
	query.DoModal();
	IP = query.IP;
	OID = query.OID;
	Instance = query.Instance;
	Community = query.Community;
	if (snmpquery.SNMPopenagent(IP,OID,Instance,Community))
		{message.MessageBox(snmpquery.querydata);}	
	else {message.MessageBox("not support");}

}

void CMainFrame::OnExplorerGetnamebyipaddress() 
{
	CGetNameByAddress GetNameDialog;
	GetNameDialog.DoModal();
}

void CMainFrame::OnMonitorShowgraph() 
{	
	if (initprocess > 1)
		{
		initprocess = false;
		}
	if (initprocess)
		{
		processID += 100;
		}
	else
		{
		processID = 100;
		}
	if (mutualex > 1)
		{
		mutualex = false;
		}
	CEnterIPforGraphDlg EnterIPDlg;
	EnterIPDlg.setmutualex(processID,&mutualex);
	EnterIPDlg.DoModal();
}

void CMainFrame::OnExplorerStartexplorerStartexplorerbyrouter() 
{
	RouterController rtcontrol;
	rtcontrol.DoModal();
	CNetworkDiagramDlg netdlg;
	netdlg.DoModal();
}

void CMainFrame::OnMonitorShowmultipleipgraph() 
{
	if (initprocess > 1)
		{
		initprocess = false;
		}
	if (initprocess)
		{
		processID += 100;
		}
	else
		{
		processID = 100;
		}
	if (mutualex > 1)
		{
		mutualex = false;
		}
//	CMultipleIPGraphInput thedialog;
//	thedialog.setmutual(processID,&mutualex);
//	thedialog.Create(IDD_Multiple_IP_Graph_Input,NULL);
//	thedialog.ShowWindow(SW_SHOW);
	CWinThread* thread = AfxBeginThread(RUNTIME_CLASS(multipleip),0,0,CREATE_SUSPENDED,NULL);
//	_ASSERTE(thread && thread->IsKindOf(RUNTIME_CLASS(multithreadcontroller));
	multipleip* st = (multipleip *) thread;
	st->SetParam(processID,&mutualex);
	st->ResumeThread();

}

void CMainFrame::OnMonitorShowmultiplevaluegraph() 
{
		if (initprocess > 1)
		{
		initprocess = false;
		}
	if (initprocess)
		{
		processID += 100;
		}
	else
		{
		processID = 100;
		}
	if (mutualex > 1)
		{
		mutualex = false;
		}
//	CMultipleValueGraphInputDlg thedialog;
//	thedialog.setmutual(processID,&mutualex);
//	thedialog.Create(IDD_MultipleValueGraphInput,NULL);
//	thedialog.ShowWindow(SW_SHOW);
	CWinThread* thread = AfxBeginThread(RUNTIME_CLASS(multiplevalue),0,0,CREATE_SUSPENDED,NULL);
//	_ASSERTE(thread && thread->IsKindOf(RUNTIME_CLASS(multithreadcontroller));
	multiplevalue* st = (multiplevalue *) thread;
	st->SetParam(processID,&mutualex);
	st->ResumeThread();
}
