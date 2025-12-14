// OtherinfoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "OtherinfoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// COtherinfoDlg dialog


COtherinfoDlg::COtherinfoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(COtherinfoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(COtherinfoDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void COtherinfoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(COtherinfoDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(COtherinfoDlg, CDialog)
	//{{AFX_MSG_MAP(COtherinfoDlg)
	ON_BN_CLICKED(IDC_FACULTY, OnFaculty)
	ON_BN_CLICKED(IDC_EXIT, OnExit)
	ON_BN_CLICKED(IDC_DEPARTMENT, OnDepartment)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COtherinfoDlg message handlers

void COtherinfoDlg::OnFaculty() 
{
	// TODO: Add your control notification handler code here
m_CFacultyfnDlg.DoModal();
}

void COtherinfoDlg::OnExit() 
{
	// TODO: Add your control notification handler code here
	OnOK();
}

void COtherinfoDlg::OnDepartment() 
{
	// TODO: Add your control notification handler code here
	m_CDepartmentfnDlg.DoModal();
}
