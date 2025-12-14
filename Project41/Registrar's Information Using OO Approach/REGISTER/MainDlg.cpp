// MainDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "MainDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainDlg dialog


CMainDlg::CMainDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMainDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMainDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CMainDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMainDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CMainDlg, CDialog)
	//{{AFX_MSG_MAP(CMainDlg)
	ON_BN_CLICKED(IDC_QUIT, OnQuit)
	ON_BN_CLICKED(IDC_BIOGRAPHY, OnBiography)
	ON_BN_CLICKED(IDC_REGISTER, OnRegister)
	ON_BN_CLICKED(IDC_SUBJECT, OnSubject)
	ON_BN_CLICKED(IDC_CURRICULUM, OnCurriculum)
	ON_BN_CLICKED(IDC_INFORMATION, OnInformation)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMainDlg message handlers

void CMainDlg::OnQuit() 
{
	// TODO: Add your control notification handler code here
	OnOK();
}

void CMainDlg::OnBiography() 
{
	// TODO: Add your control notification handler code here
m_CStdinfoDlg.DoModal();		
}

void CMainDlg::OnRegister() 
{
	// TODO: Add your control notification handler code here
	m_CRegisterInfoDlg.DoModal();
}

void CMainDlg::OnSubject() 
{
	// TODO: Add your control notification handler code here
m_CSubjectInfoDlg.DoModal();	
}

void CMainDlg::OnCurriculum() 
{
	// TODO: Add your control notification handler code here
m_CCurriculumDlg.DoModal();		
}

void CMainDlg::OnInformation() 
{
	// TODO: Add your control notification handler code here
	m_COtherinfoDlg.DoModal();	
}
