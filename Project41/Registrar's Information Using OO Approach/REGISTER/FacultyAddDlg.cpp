// FacultyAddDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "FacultyAddDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFacultyAddDlg dialog


CFacultyAddDlg::CFacultyAddDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFacultyAddDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFacultyAddDlg)
	m_faculty_description = _T("");
	m_faculty_id = _T("");
	m_faculty_nameeng = _T("");
	m_faculty_namethai = _T("");
	//}}AFX_DATA_INIT
}


void CFacultyAddDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFacultyAddDlg)
	DDX_Text(pDX, IDC_FACULTY_DESCRIPTION, m_faculty_description);
	DDX_Text(pDX, IDC_FACULTY_ID, m_faculty_id);
	DDX_Text(pDX, IDC_FACULTY_NAME_ENG, m_faculty_nameeng);
	DDX_Text(pDX, IDC_FACULTY_NAME_THAI, m_faculty_namethai);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CFacultyAddDlg, CDialog)
	//{{AFX_MSG_MAP(CFacultyAddDlg)
	ON_BN_CLICKED(IDC_ADDFACULTY, OnAddfaculty)
	ON_BN_CLICKED(IDC_EXITFACULTY, OnExitfaculty)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFacultyAddDlg message handlers

void CFacultyAddDlg::OnAddfaculty() 
{
	// TODO: Add your control notification handler code here
 		UpdateData(TRUE);
if( !m_CFaculty.IsOpen( ))    
	{
	m_CFaculty.Open();
	}	
	m_CFaculty.AddNew();
 	SaveToDatabase();
 	m_CFaculty.Update();
	
}

void CFacultyAddDlg::SaveToDatabase()
{
	UpdateData(TRUE);
	m_CFaculty.m_Faculty_Id=m_faculty_id;
	m_CFaculty.m_Faculty_Name_thai=m_faculty_namethai;
	m_CFaculty.m_Faculty_Name_Eng=m_faculty_nameeng;
	m_CFaculty.m_Faculty_Description=m_faculty_description;
}

void CFacultyAddDlg::OnExitfaculty() 
{
	// TODO: Add your control notification handler code here
OnOK();	
}
