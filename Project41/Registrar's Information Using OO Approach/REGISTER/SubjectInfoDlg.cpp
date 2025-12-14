// SubjectInfoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "SubjectInfoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSubjectInfoDlg dialog


CSubjectInfoDlg::CSubjectInfoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSubjectInfoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSubjectInfoDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSubjectInfoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSubjectInfoDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSubjectInfoDlg, CDialog)
	//{{AFX_MSG_MAP(CSubjectInfoDlg)
	ON_BN_CLICKED(IDC_ADDSUBJECT, OnAddsubject)
	ON_BN_CLICKED(IDC_EDITSUBJECT, OnEditsubject)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSubjectInfoDlg message handlers

void CSubjectInfoDlg::OnAddsubject() 
{
	// TODO: Add your control notification handler code here
	m_CSubjectAddDlg.DoModal();
}

void CSubjectInfoDlg::OnEditsubject() 
{
	// TODO: Add your control notification handler code here
	m_CSubjectDlg.DoModal();
}

void CSubjectInfoDlg::SaveToDatabase()
{

}
