// Subject.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "Subject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSubject

IMPLEMENT_DYNAMIC(CSubject, CRecordset)

CSubject::CSubject(CDatabase* pdb)
	: CRecordset(pdb)
{
	//{{AFX_FIELD_INIT(CSubject)
	m_Subject_Id = _T("");
	m_Year_Study = _T("");
	m_Subject_Category = _T("");
	m_Subject_Group = _T("");
	m_Subject_Name_Thai = _T("");
	m_Subject_Name_Eng = _T("");
	m_Subject_Sum_Credit = 0;
	m_Subject_Lec_Credit = 0;
	m_Subject_Lab_Credit = 0;
	m_Faculty_Id = _T("");
	m_Dept_Id = _T("");
	m_Subject_Description = _T("");
	m_nFields = 12;
	//}}AFX_FIELD_INIT
	m_nDefaultType = snapshot;
}


CString CSubject::GetDefaultConnect()
{
	
	return _T("ODBC;DSN=REGISTERDATA;UID=SA;PWD=;");
}

CString CSubject::GetDefaultSQL()
{
	return _T("[dbo].[subject]");
}

void CSubject::DoFieldExchange(CFieldExchange* pFX)
{
	//{{AFX_FIELD_MAP(CSubject)
	pFX->SetFieldType(CFieldExchange::outputColumn);
	RFX_Text(pFX, _T("[Subject_Id]"), m_Subject_Id);
	RFX_Text(pFX, _T("[Year_Study]"), m_Year_Study);
	RFX_Text(pFX, _T("[Subject_Category]"), m_Subject_Category);
	RFX_Text(pFX, _T("[Subject_Group]"), m_Subject_Group);
	RFX_Text(pFX, _T("[Subject_Name_Thai]"), m_Subject_Name_Thai);
	RFX_Text(pFX, _T("[Subject_Name_Eng]"), m_Subject_Name_Eng);
	RFX_Long(pFX, _T("[Subject_Sum_Credit]"), m_Subject_Sum_Credit);
	RFX_Long(pFX, _T("[Subject_Lec_Credit]"), m_Subject_Lec_Credit);
	RFX_Long(pFX, _T("[Subject_Lab_Credit]"), m_Subject_Lab_Credit);
	RFX_Text(pFX, _T("[Faculty_Id]"), m_Faculty_Id);
	RFX_Text(pFX, _T("[Dept_Id]"), m_Dept_Id);
	RFX_Text(pFX, _T("[Subject_Description]"), m_Subject_Description);
	//}}AFX_FIELD_MAP
}

/////////////////////////////////////////////////////////////////////////////
// CSubject diagnostics

#ifdef _DEBUG
void CSubject::AssertValid() const
{
	CRecordset::AssertValid();
}

void CSubject::Dump(CDumpContext& dc) const
{
	CRecordset::Dump(dc);
}
#endif //_DEBUG
