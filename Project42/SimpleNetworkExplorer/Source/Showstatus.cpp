// Showstatus.cpp : implementation file
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"
#include "Showstatus.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// Showstatus dialog


Showstatus::Showstatus(CWnd* pParent /*=NULL*/)
	: CDialog(Showstatus::IDD, pParent)
{
	//{{AFX_DATA_INIT(Showstatus)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void Showstatus::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(Showstatus)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(Showstatus, CDialog)
	//{{AFX_MSG_MAP(Showstatus)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// Showstatus message handlers

void Showstatus::updatedata(CString ip,int type)
{
	if (type == 3)
		{
		DoModal();
		}
	else
		{
		IPshow = ip;
		typetoshow = type;
		}
}

void Showstatus::show()
{	
	CStatic testing;
	RECT rect1;
	if (typetoshow == 1)
		{
		rect1.top = 30;
		rect1.bottom = 50;
		rect1.left = 70;
		rect1.right = 130;
		testing.Create("test",WS_VISIBLE|SS_RIGHT,rect1,this,9000);
		}
		

}
