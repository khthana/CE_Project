// StdinfoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "StdinfoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStdinfoDlg dialog


CStdinfoDlg::CStdinfoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CStdinfoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CStdinfoDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CStdinfoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CStdinfoDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CStdinfoDlg, CDialog)
	//{{AFX_MSG_MAP(CStdinfoDlg)
	ON_BN_CLICKED(IDC_RETURN, OnReturn)
	ON_BN_CLICKED(IDC_ADD, OnAdd)
	ON_BN_CLICKED(IDC_REMOVE, OnRemove)
	ON_BN_CLICKED(IDC_EDIT, OnEdit)
	ON_BN_CLICKED(IDC_CHECK, OnCheck)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStdinfoDlg message handlers

void CStdinfoDlg::OnReturn() 
{
	// TODO: Add your control notification handler code here
	OnOK();
}

void CStdinfoDlg::OnAdd() 
{
	// TODO: Add your control notification handler code here
	m_CStdAddDlg.DoModal();
}

void CStdinfoDlg::OnRemove() 
{
	// TODO: Add your control notification handler code here
	m_CStdSelectDlg.DoModal();
}

void CStdinfoDlg::OnEdit() 
{
	// TODO: Add your control notification handler code here
//	m_CStdSelectDlg.DoModal();
	m_CStdEditDlg.DoModal();
}

void CStdinfoDlg::OnCheck() 
{
	// TODO: Add your control notification handler code here
	m_CStdSelectDlg.DoModal();	
}
