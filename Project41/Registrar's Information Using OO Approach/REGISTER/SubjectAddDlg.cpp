// SubjectAddDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "SubjectAddDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSubjectAddDlg dialog


CSubjectAddDlg::CSubjectAddDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSubjectAddDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSubjectAddDlg)
	m_category = _T("");
	m_group = _T("");
	m_subject_dept_id = _T("");
	m_subject_dept = _T("");
	m_subject_description = _T("");
	m_subject_faculty = _T("");
	m_subject_faculty_id = _T("");
	m_subject_id = _T("");
	m_subject_lab_credit = 0;
	m_subject_lec_credit = 0;
	m_subject_name_eng = _T("");
	m_subject_name_thai = _T("");
	m_subject_sum_credit = 0;
	m_year_study = _T("");
	//}}AFX_DATA_INIT
}


void CSubjectAddDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSubjectAddDlg)
	DDX_CBString(pDX, IDC_CATEGORY, m_category);
	DDX_CBString(pDX, IDC_GROUP, m_group);
	DDX_CBString(pDX, IDC_SUBJECT_DEPT_ID, m_subject_dept_id);
	DDX_Text(pDX, IDC_SUBJECT_DEPT, m_subject_dept);
	DDX_Text(pDX, IDC_SUBJECT_DESCRIPTION, m_subject_description);
	DDX_Text(pDX, IDC_SUBJECT_FACULTY, m_subject_faculty);
	DDX_CBString(pDX, IDC_SUBJECT_FACULTY_ID, m_subject_faculty_id);
	DDX_Text(pDX, IDC_SUBJECT_ID, m_subject_id);
	DDX_Text(pDX, IDC_SUBJECT_LAB_CREDIT, m_subject_lab_credit);
	DDX_Text(pDX, IDC_SUBJECT_LEC_CREDIT, m_subject_lec_credit);
	DDX_Text(pDX, IDC_SUBJECT_NAME_ENG, m_subject_name_eng);
	DDX_Text(pDX, IDC_SUBJECT_NAME_THAI, m_subject_name_thai);
	DDX_Text(pDX, IDC_SUBJECT_SUM_CREDIT, m_subject_sum_credit);
	DDX_Text(pDX, IDC_YEAR_STUDY, m_year_study);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSubjectAddDlg, CDialog)
	//{{AFX_MSG_MAP(CSubjectAddDlg)
	ON_BN_CLICKED(IDC_ADD_SUBJECT, OnAddSubject)
	ON_BN_CLICKED(IDC_EXIT_SUBJECT, OnExitSubject)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSubjectAddDlg message handlers

void CSubjectAddDlg::OnAddSubject() 
{
	// TODO: Add your control notification handler code here
	int iResults;
	iResults=MessageBox("เพิ่มวิชา?","ยืนยันการแก้ไข",MB_YESNO|MB_ICONQUESTION);
	if (iResults==IDYES)
	{
	//	MessageBox("YES");

	if (!m_CSubject.IsOpen())
	{
		m_CSubject.Open();
	}
	m_CSubject.AddNew();
	SaveToDatabase();
	m_CSubject.Update();
	
	m_category = _T("");
	m_group = _T("");
	m_subject_dept_id = _T("");
	m_subject_dept = _T("");
	m_subject_description = _T("");
	m_subject_faculty = _T("");
	m_subject_faculty_id = _T("");
	m_subject_id = _T("");
	m_subject_lab_credit = 0;
	m_subject_lec_credit = 0;
	m_subject_name_eng = _T("");
	m_subject_name_thai = _T("");
	m_subject_sum_credit = 0;
	m_year_study = _T("");
	UpdateData(FALSE);
	}
}

void CSubjectAddDlg::SaveToDatabase()
{
	UpdateData(TRUE);
	m_CSubject.m_Subject_Id=m_subject_id;
	m_CSubject.m_Subject_Name_Thai=m_subject_name_thai;
	m_CSubject.m_Subject_Name_Eng=m_subject_name_eng;
	m_CSubject.m_Subject_Category=m_category;
	m_CSubject.m_Subject_Group=m_group;
	m_CSubject.m_Year_Study=m_year_study;
	m_CSubject.m_Subject_Sum_Credit=m_subject_sum_credit;
	m_CSubject.m_Subject_Lec_Credit=m_subject_lec_credit;
	m_CSubject.m_Subject_Lab_Credit=m_subject_lab_credit;
	m_CSubject.m_Faculty_Id=m_subject_faculty_id;
	m_CSubject.m_Dept_Id=m_subject_dept_id;
	m_CSubject.m_Subject_Description=m_subject_description;
	UpdateData(FALSE);

	
}

void CSubjectAddDlg::OnExitSubject() 
{
	// TODO: Add your control notification handler code here
	if (m_CSubject.IsOpen())
	{
	m_CSubject.Close();
	}
	CDialog::OnOK();

}
