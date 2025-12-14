// StdSelectDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "StdSelectDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStdSelectDlg dialog


CStdSelectDlg::CStdSelectDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CStdSelectDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CStdSelectDlg)
	m_Code1 = _T("");
	m_Name = _T("");
	m_Select = 2;
	//}}AFX_DATA_INIT
}


void CStdSelectDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CStdSelectDlg)
	DDX_Text(pDX, IDC_CODE1, m_Code1);
	DDX_Text(pDX, IDC_SELECTNAME, m_Name);
	DDX_Radio(pDX, IDC_STDID, m_Select);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CStdSelectDlg, CDialog)
	//{{AFX_MSG_MAP(CStdSelectDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStdSelectDlg message handlers

void CStdSelectDlg::OnOK() 
{
	// TODO: Add extra validation here
	UpdateData(TRUE);
	switch (m_Select)
	{
	case 
		//select name
		0:m_sql="[dbo].[Student] where Std_Id ='"+m_Code1+"'";
	//	MessageBox(m_sql);
		break;
	case
		1:m_sql="[dbo].[Student] where Std_Name_thai='"+m_Name+"'";
	//	MessageBox(m_sql);
		break;
	case
		2:m_sql="[dbo].[Student]  order by Std_Id";
	//	MessageBox(m_sql);
		break;
	}
	CDialog::OnOK();
}
