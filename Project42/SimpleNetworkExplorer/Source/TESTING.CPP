// testing.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "testing.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// testing dialog


testing::testing(CWnd* pParent /*=NULL*/)
	: CDialog(testing::IDD, pParent)
{
	//{{AFX_DATA_INIT(testing)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void testing::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(testing)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(testing, CDialog)
	//{{AFX_MSG_MAP(testing)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// testing message handlers
