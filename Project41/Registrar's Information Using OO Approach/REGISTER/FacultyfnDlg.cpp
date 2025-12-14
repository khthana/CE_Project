// FacultyfnDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "FacultyfnDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFacultyfnDlg dialog


CFacultyfnDlg::CFacultyfnDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFacultyfnDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFacultyfnDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CFacultyfnDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFacultyfnDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CFacultyfnDlg, CDialog)
	//{{AFX_MSG_MAP(CFacultyfnDlg)
	ON_BN_CLICKED(IDC_ADDFACULTY, OnAddfaculty)
	ON_BN_CLICKED(IDC_EDIT_FACULTY, OnEditFaculty)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFacultyfnDlg message handlers

void CFacultyfnDlg::OnAddfaculty() 
{
	// TODO: Add your control notification handler code here
m_CFacultyAddDlg.DoModal();
}

void CFacultyfnDlg::OnEditFaculty() 
{
	// TODO: Add your control notification handler code here
	m_CFacultyDlg.DoModal();
}

void CFacultyfnDlg::OnCancel() 
{
	// TODO: Add extra cleanup here
	
	CDialog::OnCancel();
}
