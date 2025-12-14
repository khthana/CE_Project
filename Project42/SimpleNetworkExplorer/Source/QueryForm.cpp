// QueryForm.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "QueryForm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// QueryForm dialog


QueryForm::QueryForm(CWnd* pParent /*=NULL*/)
	: CDialog(QueryForm::IDD, pParent)
{
	//{{AFX_DATA_INIT(QueryForm)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void QueryForm::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(QueryForm)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(QueryForm, CDialog)
	//{{AFX_MSG_MAP(QueryForm)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// QueryForm message handlers
void QueryForm::OnOK() 
{
	// TODO: Add extra validation here

	GetDlgItemText(IDC_IP,IP,16);
	GetDlgItemText(IDC_OID,OID,30);
	GetDlgItemText(IDC_Instance,Instance,16);
	GetDlgItemText(IDC_Community,Community,10);
	CDialog::OnOK();
}

