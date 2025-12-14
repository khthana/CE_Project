// SimpleNetworkExplorer.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"

#include "MainFrm.h"
#include "SimpleNetworkExplorerDoc.h"
#include "SimpleNetworkExplorerView.h"
#include <winsock2.h>
#include "vbs.h"
#include "UdpClient.h"
#include "PINGcontroller1.h"
#include "NetworkDiagramDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerApp

BEGIN_MESSAGE_MAP(CSimpleNetworkExplorerApp, CWinApp)
	//{{AFX_MSG_MAP(CSimpleNetworkExplorerApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
	ON_COMMAND(ID_EXPLORER_STARTEXPLORER, OnExplorerStartexplorer)
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerApp construction

CSimpleNetworkExplorerApp::CSimpleNetworkExplorerApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CSimpleNetworkExplorerApp object

CSimpleNetworkExplorerApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerApp initialization

BOOL CSimpleNetworkExplorerApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	// Change the registry key under which our settings are stored.
	// TODO: You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("Local AppWizard-Generated Applications"));

	LoadStdProfileSettings();  // Load standard INI file options (including MRU)

	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.

	CSingleDocTemplate* pDocTemplate;
	pDocTemplate = new CSingleDocTemplate(
		IDR_MAINFRAME,
		RUNTIME_CLASS(CSimpleNetworkExplorerDoc),
		RUNTIME_CLASS(CMainFrame),       // main SDI frame window
		RUNTIME_CLASS(CSimpleNetworkExplorerView));
	AddDocTemplate(pDocTemplate);

	// Parse command line for standard shell commands, DDE, file open
	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);

	// Dispatch commands specified on the command line
	if (!ProcessShellCommand(cmdInfo))
		return FALSE;

	// The one and only window has been initialized, so show and update it.
	m_pMainWnd->ShowWindow(SW_SHOW);
	m_pMainWnd->ShowWindow(SW_SHOWMAXIMIZED);
	m_pMainWnd->UpdateWindow();

	return TRUE;
}


/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
		// No message handlers
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// App command to run the dialog
void CSimpleNetworkExplorerApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerApp message handlers


void CSimpleNetworkExplorerApp::OnExplorerStartexplorer() 
{
	PINGcontroller PingController;
	PingController.DoModal();
	CNetworkDiagramDlg DiagramDialog;
	DiagramDialog.DoModal();
}

void datacollector::networkcollect(network networklist[30],int networkindex)
{	int netindex = 0;
	CString rowdata;
	CString netaddtemp;
	CString netmsktemp;
	CStdioFile networkfile("network.txt",CFile::modeCreate|CFile::modeWrite| CFile::typeText );
	for (netindex = 0; netindex < networkindex; netindex++)
	{
		if (ipinttostr(networklist[netindex].netadd) != "127.0.0.0")
		{
		netaddtemp = ipinttostr(networklist[netindex].netadd);
		//rowdata += "//";
		netmsktemp = ipinttostr(networklist[netindex].netclass);
		//rowdata += "//";
		if (netaddtemp != netmsktemp)
			{
			rowdata = netaddtemp + "//" + netmsktemp + "//";
			switch(networklist[netindex].nettype){
				case 1:
					rowdata += "Other";
					break;
				case 3:
					rowdata += "hdh1822";
					break;
				case 4:
					rowdata += "ddn-x25";
					break;
				case 5:
					rowdata += "rfc877-x25";
					break;
				case 6:
					rowdata += "Ethernet";
					break;
				case 7:
					rowdata += "Ethernet";
					break;
				case 8:
					rowdata += "Token bus";
					break;
				case 9:
					rowdata += "Token ring";
					break;
				case 10:
					rowdata += "MAN";
					break;
				case 11:
					rowdata += "StarLan";
					break;
				case 15:
					rowdata += "FDDI";
					break;
				case 17:
					rowdata += "SDLC";
					break;
				case 19:
					rowdata += "E1";
					break;
				case 20:
					rowdata += "Basic ISDN";
					break;
				case 21:
					rowdata += "Primary ISDN";
					break;
				case 22:
					rowdata += "Point to Point-serial";
					break;
				case 23:
					rowdata += "PPP";
					break;
				case 24:
					rowdata += "SWLoopback";
					break;
				case 26:
					rowdata += "Ethernet";
					break;
				case 27:
					rowdata += "Slip";
					break;
				case 32:
					rowdata += "Frame relay";
					break;
				case 33:
					rowdata += "RS232";
					break;
				case 37:
					rowdata += "ATM";
					break;
				case 39:
					rowdata += "SONET";
					break;
				case 40:
					rowdata += "X.25";
					break;
				case 48:
					rowdata += "Modem";
					break;
				case 53:
					rowdata +=  "Ethernet";//"PropVirtual";
					break;
				case 54:
					rowdata += "PropMultiplexor";
					break;
				default:
					rowdata += "other";
					break;
			}
	if (netindex < networkindex-1)
		rowdata += "\n";
	networkfile.WriteString(rowdata);
	}
	}
	}
	networkfile.Close();
	return;
}

void datacollector::supportcollect(nodedata supportlist[300],int supportindex,dnslookup dnslist[900],int dnsindex)
{	int supindex;
	int ifindex;
	int tdnsindex;
	CString rowdata;
	char notemp[2];
	char ifnum[2];
	CStdioFile supportfile("support.txt",CFile::modeCreate|CFile::modeWrite| CFile::typeText );
	for (supindex = 0;supindex < supportindex;supindex++)
	{
	rowdata = supportlist[supindex].nodeindex.nodename + "//";
	if (supportlist[supindex].nodeindex.nodeservice > 64)
		{rowdata += "Computer//";}
		else
		{
			if (supportlist[supindex].nodeindex.nodeservice == 64)
				{rowdata += "Other//";}
				else 
					{
						if (supportlist[supindex].nodeindex.nodeservice == 6)
							{rowdata += "Router//";}
							else 
								{
								if (supportlist[supindex].nodeindex.nodeservice == 2)
									{rowdata += "Switch//";}
									else
									{
										rowdata += "Other//";
									}
								}
					}

		}
		_itoa(supportlist[supindex].nodeindex.ifnumber,ifnum,10);
		rowdata += ifnum;

	for (ifindex = 0;ifindex < 20;ifindex++)
		{
			rowdata += "//@";
			_itoa(ifindex,notemp,10);
			rowdata += notemp;
			rowdata += "//";
			if (supportlist[supindex].ifdata[ifindex].IP != "127.0.0.1")
				{
				rowdata += supportlist[supindex].ifdata[ifindex].IP;
				}
			rowdata += "//";
			switch ( supportlist[supindex].ifdata[ifindex].iftype ){
				case 1:
					rowdata += "Other";
					break;
				case 3:
					rowdata += "hdh1822";
					break;
				case 4:
					rowdata += "ddn-x25";
					break;
				case 5:
					rowdata += "rfc877-x25";
					break;
				case 6:
					rowdata += "Ethernet";
					break;
				case 7:
					rowdata += "Ethernet";
					break;
				case 8:
					rowdata += "Token bus";
					break;
				case 9:
					rowdata += "Token ring";
					break;
				case 10:
					rowdata += "MAN";
					break;
				case 11:
					rowdata += "StarLan";
					break;
				case 15:
					rowdata += "FDDI";
					break;
				case 17:
					rowdata += "SDLC";
					break;
				case 19:
					rowdata += "E1";
					break;
				case 20:	
					rowdata += "Basic ISDN";
					break;
				case 21:
					rowdata += "Primary ISDN";
					break;
				case 22:	
					rowdata += "Point to Point-serial";
					break;
				case 23:
					rowdata += "PPP";
					break;
			//	case 24:
			//		rowdata += "SWLoopback";
			//		break;
				case 26:
					rowdata += "Ethernet";
					break;
				case 27:
					rowdata += "Slip";
					break;
				case 32:
					rowdata += "Frame relay";
					break;
				case 33:
					rowdata += "RS232";
					break;
				case 37:
					rowdata += "ATM";
					break;
				case 39:
					rowdata += "SONET";
					break;
				case 40:
					rowdata += "X.25";
						break;
				case 48:
					rowdata += "Modem";
					break;
				case 53:
					rowdata +=  "Ethernet";//"PropVirtual";
					break;
				case 54:
					rowdata += "PropMultiplexor";
					break;
				default:
					rowdata += "other";
					break;
				}
			rowdata += "//";
			if (supportlist[supindex].ifdata[ifindex].IP != "127.0.0.1")
				{
				rowdata += supportlist[supindex].ifdata[ifindex].subnet;
			}
		
		}
	if (supindex < supportindex-1)
		rowdata += "\n";
	supportfile.WriteString(rowdata);
	}
	for (tdnsindex = 0;tdnsindex < dnsindex; tdnsindex++)
	{
	if (tdnsindex == 0)
		supportfile.WriteString("\n");
	rowdata = dnslist[tdnsindex].nodename;
	rowdata += "//Unsupport//1//@0//";
	rowdata += dnslist[tdnsindex].IP;
	rowdata += "////";
	rowdata += dnslist[tdnsindex].subnet;
	if (tdnsindex < (dnsindex -1))
		rowdata += "\n";
	supportfile.WriteString(rowdata);
	}
	supportfile.Close();
	return;
}


CString datacollector::ipinttostr(ipfields inip){
	CString returnip;
	int divtemp;
	char iptemp;
	int iplength;
	bool empty = true;
	divtemp = inip.field1/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;
	empty = false;}
	divtemp = (inip.field1/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{
		if (empty == false)
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field1 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field2/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field2/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field2 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field3/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field3/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field3 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	returnip += '.';
	divtemp = inip.field4/100;
	if ( divtemp > 0 )
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	divtemp = (inip.field4/10)%10;
	if (divtemp > 0)
	{ iptemp = chr(divtemp);
	returnip += iptemp;}
	else{iplength = strlen(returnip);
		if (returnip.GetAt(iplength - 1) != '.')
		{iptemp = chr(divtemp);
		returnip += iptemp;}
	}
	divtemp = inip.field4 % 10;
	iptemp = chr(divtemp);
	returnip += iptemp;
	return returnip;
}

char datacollector::chr(byte inconvert)
{	char chrret;
	switch(inconvert){
	case 0:
		chrret = '0';
		break;
	case 1:
		chrret = '1';
		break;
	case 2:
		chrret = '2';
		break;
	case 3:
		chrret = '3';
		break;
	case 4:
		chrret = '4';
		break;
	case 5:
		chrret = '5';
		break;
	case 6:
		chrret = '6';
		break;
	case 7:
		chrret = '7';
		break;
	case 8:
		chrret = '8';
		break;
	case 9:
		chrret = '9';
		break;}
	return chrret;
}

