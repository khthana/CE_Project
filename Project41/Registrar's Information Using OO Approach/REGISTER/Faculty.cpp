// Faculty.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "Faculty.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFaculty

IMPLEMENT_DYNAMIC(CFaculty, CRecordset)

CFaculty::CFaculty(CDatabase* pdb)
	: CRecordset(pdb)
{
	//{{AFX_FIELD_INIT(CFaculty)
	m_Faculty_Id = _T("");
	m_Faculty_Name_thai = _T("");
	m_Faculty_Name_Eng = _T("");
	m_Faculty_Description = _T("");
	m_nFields = 4;
	//}}AFX_FIELD_INIT
	m_nDefaultType = snapshot;
}


CString CFaculty::GetDefaultConnect()
{
	return _T("ODBC;DSN=REGISTERDATA;UID=SA;PWD=;");
}

CString CFaculty::GetDefaultSQL()
{
	return _T("[dbo].[Faculty]");
}

void CFaculty::DoFieldExchange(CFieldExchange* pFX)
{
	//{{AFX_FIELD_MAP(CFaculty)
	pFX->SetFieldType(CFieldExchange::outputColumn);
	RFX_Text(pFX, _T("[Faculty_Id]"), m_Faculty_Id);
	RFX_Text(pFX, _T("[Faculty_Name_thai]"), m_Faculty_Name_thai);
	RFX_Text(pFX, _T("[Faculty_Name_Eng]"), m_Faculty_Name_Eng);
	RFX_Text(pFX, _T("[Faculty_Description]"), m_Faculty_Description);
	//}}AFX_FIELD_MAP
}

/////////////////////////////////////////////////////////////////////////////
// CFaculty diagnostics

#ifdef _DEBUG
void CFaculty::AssertValid() const
{
	CRecordset::AssertValid();
}

void CFaculty::Dump(CDumpContext& dc) const
{
	CRecordset::Dump(dc);
}
#endif //_DEBUG
