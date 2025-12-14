// RegisterInfoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "RegisterInfoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CRegisterInfoDlg dialog


CRegisterInfoDlg::CRegisterInfoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CRegisterInfoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CRegisterInfoDlg)
	m_department = _T("");
	m_faculty = _T("");
	m_register_surnamethai = _T("");
	m_register_namethai = _T("");
	m_student_code = _T("");
	m_student_curriculum = _T("");
	m_student_level = _T("");
	m_subject_name = _T("");
	m_term_study = _T("");
	m_year_study = _T("");
	m_title_name = _T("");
	m_subject_id = _T("");
	m_lab_credit = 0;
	m_lec_credit = 0;
	m_sum_credit = 0;
	//}}AFX_DATA_INIT
}


void CRegisterInfoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CRegisterInfoDlg)
	DDX_Text(pDX, IDC_DEPARTMENT, m_department);
	DDX_Text(pDX, IDC_FACULTY, m_faculty);
	DDX_Text(pDX, IDC_REGISTER_SURNAMETHAI, m_register_surnamethai);
	DDX_Text(pDX, IDC_REGISTER_NAMETHAI, m_register_namethai);
	DDX_Text(pDX, IDC_STUDENT_CODE, m_student_code);
	DDX_Text(pDX, IDC_STUDENT_CURRICULUM, m_student_curriculum);
	DDX_Text(pDX, IDC_STUDENT_LEVEL, m_student_level);
	DDX_Text(pDX, IDC_SUBJECT_NAME, m_subject_name);
	DDX_Text(pDX, IDC_TERM_STUDY, m_term_study);
	DDX_Text(pDX, IDC_YEAR_STUDY, m_year_study);
	DDX_CBString(pDX, IDC_TITLE_NAME, m_title_name);
	DDX_Text(pDX, IDC_SUBJECT_ID, m_subject_id);
	DDX_Control(pDX, IDC_REGISTER_MSFLEXGRID, m_registerfg);
	DDX_Text(pDX, IDC_LAB_CREDIT, m_lab_credit);
	DDX_Text(pDX, IDC_LEC_CREDIT, m_lec_credit);
	DDX_Text(pDX, IDC_SUM_CREDIT, m_sum_credit);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CRegisterInfoDlg, CDialog)
	//{{AFX_MSG_MAP(CRegisterInfoDlg)
	ON_BN_CLICKED(ID_OK, OnOk)
	ON_BN_CLICKED(IDC_ADD_REGISTER_SUBJECT, OnAddRegisterSubject)
	ON_BN_CLICKED(IDC_DELETE_REGISTER_SUBJECT, OnDeleteRegisterSubject)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CRegisterInfoDlg message handlers
BOOL CRegisterInfoDlg::OnInitDialog()
{
if (m_CSelectStdIdDlg.DoModal()==IDCANCEL)
{
//MessageBox("DDDDD");
	CDialog::OnCancel();

}
else
{
Row=0;
	//	m_CStdset.SetDefaulConnect(m_CSelectStdIdDlg.m_sql);
	//	MessageBox(m_CStdset.GetDefaultConnect());
	if(m_CStdset.IsOpen())
	{
	m_CStdset.Close();
	}
		try    
		{ 
	//	MessageBox(m_CSelectStdIdDlg.m_sql);
		m_CStdset.Open(NULL,m_CSelectStdIdDlg.m_sql,NULL );    
		}   
		catch( CDBException* e )    
		{
		 AfxMessageBox("ไม่สามารถเปิดฐานข้อมูลได้",//+ e->m_strError,   
                      MB_ICONEXCLAMATION );
       //Delete the incomplete recordset object        delete m_pSet;
     // m_pSet = NULL;        
		e->Delete();
		CDialog::OnCancel();
		//	CDialog::OnOK();
		}
  if(m_CStdset.IsOpen())
	{	
	if(m_CStdset.IsBOF( )) // if no slect record
	{
		MessageBox("ไม่พบนักศึกษาที่เลือก");
		m_CStdset.Close();
//		CDialog::OnOK();
		CDialog::OnCancel();
	}
	} 
	
	if(m_CStdset.IsOpen())
	{
	m_term_study=m_CSelectStdIdDlg.m_term;
	m_year_study=m_CSelectStdIdDlg.m_academic_year;

	m_student_code=m_CStdset.m_Std_Id;
	m_title_name=m_CStdset.m_Std_title_thai;
	m_register_namethai=m_CStdset.m_Std_Name_thai;
	m_register_surnamethai=m_CStdset.m_Std_Surname_thai;
	UpdateData(FALSE);
	}
}	
	return TRUE;

}

void CRegisterInfoDlg::OnOk() 
{
	// TODO: Add your control notification handler code here
	if(m_CStdset.IsOpen())
	{
	m_CStdset.Close();
	}
	CDialog::OnOK();
	return;
}

void CRegisterInfoDlg::OnAddRegisterSubject() 
{
	// TODO: Add your control notification handler code here
//	UpdateData(TRUE);

	if(m_CSubjectSelDlg.DoModal()==IDOK)
	{
	if (m_CSubject.IsOpen())
	{
		m_CSubject.Close();
	}
	m_CSubject.Open(NULL,"Select * from subject where Subject_Id='"+m_CSubjectSelDlg.m_subject_id+"'",NULL);
	if (m_CSubject.IsBOF())
		{
		MessageBox("ค้นหาวิชาไม่พบกรุณาตรวจสอบรหัสวิชาใหม่อีกครั้ง");
		m_CSubject.Close();
		}

	if (m_CSubject.IsOpen())
	{

		m_subject_id=m_CSubject.m_Subject_Id;
		m_subject_name=m_CSubject.m_Subject_Name_Thai;	
		m_lab_credit=m_CSubject.m_Subject_Lab_Credit;
		m_lec_credit=m_CSubject.m_Subject_Lec_Credit;
		m_sum_credit=m_CSubject.m_Subject_Sum_Credit;
	//MessageBox("วิชา"+m_subject_name);
	//	int Row=1;
	//	CString Str;
	//	Str.Format("%d",No);
		
	//	m_registerfg.SetTextMatrix(1,0,Str);
		Row++;
		m_registerfg.SetTextMatrix(Row,0,m_CSubject.m_Subject_Id);
		m_registerfg.SetTextMatrix(Row,1,m_CSubject.m_Subject_Name_Thai);
		
		CString Str2;
		Str2.Format("%d",m_CSubject.m_Subject_Sum_Credit);
	
		m_registerfg.SetTextMatrix(Row,2,Str2);

		CString Str3;
		Str3.Format("%d",m_CSubject.m_Subject_Lec_Credit);
		m_registerfg.SetTextMatrix(Row,3,Str3);
		
		CString Str4;
		Str4.Format("%d",m_CSubject.m_Subject_Lab_Credit);
		m_registerfg.SetTextMatrix(Row,4,Str4);
		
		UpdateData(FALSE);
			//m_CSubject.m_Subject
	}

	}

}

void CRegisterInfoDlg::OnDeleteRegisterSubject() 
{
	// TODO: Add your control notification handler code here
	if (Row>0)
	{
	m_registerfg.RemoveItem(m_registerfg.GetRowSel());
	Row--;
	}
}
