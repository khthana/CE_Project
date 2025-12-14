// CurriculumDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "CurriculumDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCurriculumDlg dialog


CCurriculumDlg::CCurriculumDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCurriculumDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCurriculumDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CCurriculumDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCurriculumDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCurriculumDlg, CDialog)
	//{{AFX_MSG_MAP(CCurriculumDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCurriculumDlg message handlers
