// FacultyDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "FacultyDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFacultyDlg dialog


CFacultyDlg::CFacultyDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFacultyDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFacultyDlg)
	m_faculty_description = _T("");
	m_faculty_id = _T("");
	m_faculty_nameeng = _T("");
	m_faculty_namethai = _T("");
	//}}AFX_DATA_INIT
}


void CFacultyDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFacultyDlg)
	DDX_Text(pDX, IDC_FACULTY_DESCRIPTION, m_faculty_description);
	DDX_Text(pDX, IDC_FACULTY_ID, m_faculty_id);
	DDX_Text(pDX, IDC_FACULTY_NAME_ENG, m_faculty_nameeng);
	DDX_Text(pDX, IDC_FACULTY_NAME_THAI, m_faculty_namethai);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CFacultyDlg, CDialog)
	//{{AFX_MSG_MAP(CFacultyDlg)
	ON_BN_CLICKED(IDC_EXITFACULTY, OnExitfaculty)
	ON_BN_CLICKED(IDC_DELETEFACULTY, OnDeletefaculty)
	ON_BN_CLICKED(IDC_UPDATEFACULTY, OnUpdatefaculty)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFacultyDlg message handlers
BOOL CFacultyDlg::OnInitDialog()
{
	if (!m_CFaculty.IsOpen())
	{
		m_CFaculty.Open();
	}
	RestoreformDatabase();
	return TRUE;
}

void CFacultyDlg::RestoreformDatabase()
{
	m_faculty_id=m_CFaculty.m_Faculty_Id;
	m_faculty_namethai=m_CFaculty.m_Faculty_Name_thai;
	m_faculty_nameeng=m_CFaculty.m_Faculty_Name_Eng;
	m_faculty_description=m_CFaculty.m_Faculty_Description;
	UpdateData(FALSE);
}

void CFacultyDlg::SaveToDatabase()
{
	UpdateData(TRUE);
	m_CFaculty.m_Faculty_Id=m_faculty_id;
	m_CFaculty.m_Faculty_Name_thai=m_faculty_namethai;
	m_CFaculty.m_Faculty_Name_Eng=m_faculty_nameeng;
	m_CFaculty.m_Faculty_Description=m_faculty_description;

}

//DEL void CFacultyDlg::OnAddfaculty() 
//DEL {
//DEL 	// TODO: Add your control notification handler code here
//DEL 	m_CFaculty.AddNew();
//DEL 	SaveToDatabase();
//DEL 	m_CFaculty.Update();
//DEL }

void CFacultyDlg::OnExitfaculty() 
{
	// TODO: Add your control notification handler code here
	OnOK();
}

void CFacultyDlg::OnDeletefaculty() 
{
	// TODO: Add your control notification handler code here
		int i;
	i=MessageBox("ลบข้อมูล?","ยืนยันการลบ",MB_YESNO|MB_ICONQUESTION);
	if (i==IDYES)
	{

	m_CFaculty.Delete();
	m_CFaculty.Requery();
	RestoreformDatabase();
	}
}

void CFacultyDlg::OnUpdatefaculty() 
{
	// TODO: Add your control notification handler code here
	int iResults;
	iResults=MessageBox("แก้ไขข้อมูล?","ยืนยันการแก้ไข",MB_YESNO|MB_ICONQUESTION);
	if (iResults==IDYES)
	{

m_CFaculty.Edit();
SaveToDatabase();
m_CFaculty.Update();

	}
}
