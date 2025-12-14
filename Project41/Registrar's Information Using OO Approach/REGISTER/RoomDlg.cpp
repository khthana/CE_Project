// RoomDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "RoomDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CRoomDlg dialog


CRoomDlg::CRoomDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CRoomDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CRoomDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CRoomDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CRoomDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CRoomDlg, CDialog)
	//{{AFX_MSG_MAP(CRoomDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CRoomDlg message handlers
