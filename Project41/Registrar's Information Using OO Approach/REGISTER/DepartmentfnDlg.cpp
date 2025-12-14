// DepartmentfnDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "DepartmentfnDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDepartmentfnDlg dialog


CDepartmentfnDlg::CDepartmentfnDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDepartmentfnDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDepartmentfnDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CDepartmentfnDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDepartmentfnDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDepartmentfnDlg, CDialog)
	//{{AFX_MSG_MAP(CDepartmentfnDlg)
	ON_BN_CLICKED(IDC_FACULTY_ADD, OnFacultyAdd)
	ON_BN_CLICKED(IDC_FACULTY_EDIT_DIALOG, OnFacultyEditDialog)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDepartmentfnDlg message handlers

void CDepartmentfnDlg::OnFacultyAdd() 
{
	// TODO: Add your control notification handler code here
	m_CDepartmentAddDlg.DoModal();
}

void CDepartmentfnDlg::OnFacultyEditDialog() 
{
	// TODO: Add your control notification handler code here
	m_CDepartmentDlg.DoModal();
}
