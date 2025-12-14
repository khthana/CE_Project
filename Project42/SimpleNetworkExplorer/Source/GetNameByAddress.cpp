// GetNameByAddress.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "GetNameByAddress.h"
#include "winsock2.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGetNameByAddress dialog


CGetNameByAddress::CGetNameByAddress(CWnd* pParent /*=NULL*/)
	: CDialog(CGetNameByAddress::IDD, pParent)
{
	//{{AFX_DATA_INIT(CGetNameByAddress)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CGetNameByAddress::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CGetNameByAddress)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CGetNameByAddress, CDialog)
	//{{AFX_MSG_MAP(CGetNameByAddress)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGetNameByAddress message handlers

void CGetNameByAddress::OnOK() 
{
	CString Name;
	char IPAddress[16]; 
	GetDlgItemText(IDC_IPAddress,IPAddress,16);	
	Name = GetNameByIPAddress(IPAddress);
	MessageBox(Name);
	CDialog::OnOK();
}

///////////////////////////////////////////////////////////////////////
// Methods

// This methode to get name of that IP Address
CString CGetNameByAddress::GetNameByIPAddress(CString IPAddress)
{
	WORD wVersionRequested; 
	WSADATA wsaData; 
	int Err;
	wVersionRequested = MAKEWORD(1, 1); 
	Err = WSAStartup (wVersionRequested, &wsaData);
	// To Initialize the window socket.

	CString Name;
	struct hostent * pHost;
	unsigned long ui_addr; 
	ui_addr = (long)inet_addr(IPAddress);

	pHost =gethostbyaddr((char *)&ui_addr,sizeof(ui_addr),AF_INET);
	// To get the Host from IP Address
	if (pHost!= NULL) 
	{
//		MessageBox(pHost->h_name);
		Name =pHost->h_name;  
	}
	else
	{
		MessageBox("Could not resolve this IP.");
	}
	WSACleanup(); 
	return Name;
}
