// IP_input.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "IP_input.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// IP_input dialog


IP_input::IP_input(CWnd* pParent /*=NULL*/)
	: CDialog(IP_input::IDD, pParent)
{
	//{{AFX_DATA_INIT(IP_input)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void IP_input::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(IP_input)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(IP_input, CDialog)
	//{{AFX_MSG_MAP(IP_input)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// IP_input message handlers

void IP_input::OnOK() 
{	//char tcommunity[16];
	//char tfirst[16];
	//char tlast[16];
	GetDlgItemText(IDC_TEXT1,IPfirsttext,16);
	GetDlgItemText(IDC_TEXT2,IPlasttext,16);
	GetDlgItemText(IDC_TEXT3,Community,16);
//	MessageBox(Community);
//	IPfirsttext = tfirst;
//	IPlasttext = tlast;
//	Community = tcommunity;
	CDialog::OnOK();
}

CString IP_input::getfirst()
{
	CString returnvalue;
	returnvalue = IPfirsttext;
	return returnvalue;
}

CString IP_input::getlast()
{
	CString returnvalue;
	returnvalue = IPlasttext;
	return returnvalue;
}

CString IP_input::getcommunity()
{
	CString returnvalue;
	returnvalue = Community;
//	MessageBox(Community);
	return returnvalue;
}
