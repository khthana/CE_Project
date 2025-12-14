// Department.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "Department.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDepartment

IMPLEMENT_DYNAMIC(CDepartment, CRecordset)

CDepartment::CDepartment(CDatabase* pdb)
	: CRecordset(pdb)
{
	//{{AFX_FIELD_INIT(CDepartment)
	m_Dept_Id = _T("");
	m_Dept_Name_Thai = _T("");
	m_Dept_Name_Eng = _T("");
	m_Dept_Description = _T("");
	m_Faculty_name = _T("");
	m_nFields = 5;
	//}}AFX_FIELD_INIT
	m_nDefaultType = snapshot;
}


CString CDepartment::GetDefaultConnect()
{
	return _T("ODBC;DSN=REGISTERDATA");
}

CString CDepartment::GetDefaultSQL()
{
	return _T("[dbo].[Department]");
}

void CDepartment::DoFieldExchange(CFieldExchange* pFX)
{
	//{{AFX_FIELD_MAP(CDepartment)
	pFX->SetFieldType(CFieldExchange::outputColumn);
	RFX_Text(pFX, _T("[Dept_Id]"), m_Dept_Id);
	RFX_Text(pFX, _T("[Dept_Name_Thai]"), m_Dept_Name_Thai);
	RFX_Text(pFX, _T("[Dept_Name_Eng]"), m_Dept_Name_Eng);
	RFX_Text(pFX, _T("[Dept_Description]"), m_Dept_Description);
	RFX_Text(pFX, _T("[Faculty_name]"), m_Faculty_name);
	//}}AFX_FIELD_MAP
}

/////////////////////////////////////////////////////////////////////////////
// CDepartment diagnostics

#ifdef _DEBUG
void CDepartment::AssertValid() const
{
	CRecordset::AssertValid();
}

void CDepartment::Dump(CDumpContext& dc) const
{
	CRecordset::Dump(dc);
}
#endif //_DEBUG
//Class.ccp
