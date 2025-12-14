// DepartmentAddDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "DepartmentAddDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDepartmentAddDlg dialog


CDepartmentAddDlg::CDepartmentAddDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDepartmentAddDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDepartmentAddDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CDepartmentAddDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDepartmentAddDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDepartmentAddDlg, CDialog)
	//{{AFX_MSG_MAP(CDepartmentAddDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDepartmentAddDlg message handlers
