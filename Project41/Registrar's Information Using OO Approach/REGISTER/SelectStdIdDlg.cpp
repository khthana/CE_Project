// SelectStdIdDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "SelectStdIdDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelectStdIdDlg dialog


CSelectStdIdDlg::CSelectStdIdDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectStdIdDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectStdIdDlg)
	m_Std_Id = _T("");
	m_term = _T("");
	m_academic_year = _T("");
	//}}AFX_DATA_INIT
}


void CSelectStdIdDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectStdIdDlg)
	DDX_Text(pDX, IDC_STUDENTID, m_Std_Id);
	DDX_Text(pDX, IDC_TERM, m_term);
	DDX_Text(pDX, IDC_ACADEMIC_YEAR, m_academic_year);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectStdIdDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectStdIdDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectStdIdDlg message handlers

void CSelectStdIdDlg::OnOK() 
{
	// TODO: Add extra validation here
	UpdateData(TRUE);
	if (m_Std_Id==_T(""))
	{
	MessageBox("กรุณาใส่รหัสนักศึกษาเพื่อทำการลงทะเบียน?","ลงทะเบียน",MB_OK|MB_ICONQUESTION);
	}
	else
	{
	m_sql="[dbo].[Student] where Std_Id ='"+m_Std_Id+"'";	
//	MessageBox(m_sql);
//	MessageBox(m_term+m_academic_year);

	m_Std_Id="";
	UpdateData(FALSE);
	CDialog::OnOK();
	}
}
