// DepartmentDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "DepartmentDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDepartmentDlg dialog


CDepartmentDlg::CDepartmentDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDepartmentDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDepartmentDlg)
	m_department_description = _T("");
	m_department_faculty_name = _T("");
	m_department_id = _T("");
	m_department_nameeng = _T("");
	m_department_namethai = _T("");
	//}}AFX_DATA_INIT
}


void CDepartmentDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDepartmentDlg)
	DDX_Text(pDX, IDC_DEPARTMENT_DESCRIPTION, m_department_description);
	DDX_Text(pDX, IDC_DEPARTMENT_FACULTY_NAME, m_department_faculty_name);
	DDX_Text(pDX, IDC_DEPARTMENT_ID, m_department_id);
	DDX_Text(pDX, IDC_DEPARTMENT_NAME_ENG, m_department_nameeng);
	DDX_Text(pDX, IDC_DEPARTMENT_NAME_THAI, m_department_namethai);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDepartmentDlg, CDialog)
	//{{AFX_MSG_MAP(CDepartmentDlg)
	ON_BN_CLICKED(IDC_EXITDEPARTMENT, OnExitdepartment)
	ON_BN_CLICKED(IDC_DEPT_MOVE_NEXT, OnDeptMoveNext)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDepartmentDlg message handlers
//Class.ccp
BOOL CDepartmentDlg::OnInitDialog()
{
	if (!m_CDepartment.IsOpen())
	{
		m_CDepartment.Open();
	}
	RestoreFromDatabase();

	return TRUE;
}
void CDepartmentDlg::OnExitdepartment() 
{
	// TODO: Add your control notification handler code here
	OnCancel();
}

void CDepartmentDlg::OnDeptMoveNext() 
{
	// TODO: Add your control notification handler code here
if(!m_CDepartment.IsEOF())
{
	m_CDepartment.MoveNext();
//	MessageBox("Next");
}	

	RestoreFromDatabase();
// Move back if EOF
	if(m_CDepartment.IsEOF())
	{
	m_CDepartment.MovePrev();
//	MessageBox("pppp");
	}		
}

void CDepartmentDlg::RestoreFromDatabase()
{
	m_department_id=m_CDepartment.m_Dept_Id;
	m_department_nameeng=m_CDepartment.m_Dept_Name_Eng;
	m_department_namethai=m_CDepartment.m_Dept_Name_Thai;
	m_department_description=m_CDepartment.m_Dept_Description;
	m_department_faculty_name=m_CDepartment.m_Faculty_name;
	UpdateData(FALSE);
}
