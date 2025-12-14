// Stdset.cpp : implementation file
//

#include "stdafx.h"
#include "register.h"
#include "Stdset.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStdset

IMPLEMENT_DYNAMIC(CStdset, CRecordset)

CStdset::CStdset(CDatabase* pdb)
	: CRecordset(pdb)
{
	//{{AFX_FIELD_INIT(CStdset)
	m_Std_Id = _T("");
	m_Std_Name_thai = _T("");
	m_Std_title_thai = _T("");
	m_Std_Surname_thai = _T("");
	m_Std_name_Eng = _T("");
	m_Std_title_Eng = _T("");
	m_Std_Surname_Eng = _T("");
	m_Std_Sex = _T("");
	m_Std_Birthday = _T("");
	m_xx = _T("");
	m_Std_Religion = _T("");
	m_Std_Citizen = _T("");
	m_Std_Nation = _T("");
	m_Std_Addrborder = _T("");
	m_Std_Addrcode = _T("");
	m_Std_Addrdistinct = _T("");
	m_Std_Addrfax = _T("");
	m_Std_Addrno = _T("");
	m_Std_Addrpager = _T("");
	m_Std_Addrprovince = _T("");
	m_Std_Addrroad = _T("");
	m_Std_Addrsoi = _T("");
	m_Std_Addrtel = _T("");
	m_Std_Caddrborder = _T("");
	m_Std_Caddrcode = _T("");
	m_Std_Caddrdistinct = _T("");
	m_Std_Caddrfax = _T("");
	m_Std_Caddrno = _T("");
	m_Std_Caddrprovince = _T("");
	m_Std_Caddrroad = _T("");
	m_Std_Caddrsoi = _T("");
	m_Std_Caddrtel = _T("");
	m_nFields = 32;
	
	//}}AFX_FIELD_INIT
	m_nDefaultType = snapshot;
	m_Connect=_T("ODBC;DSN=REGISTERDATA;UID=SA;PWD=;");
}


CString CStdset::GetDefaultConnect()
{
	return m_Connect;//_T("ODBC;DSN=REGISTERDATA");
}

CString CStdset::GetDefaultSQL()
{
//	sql="select * from student";
	return sql;//_T("[dbo].[Student]");
}

void CStdset::DoFieldExchange(CFieldExchange* pFX)
{
	//{{AFX_FIELD_MAP(CStdset)
	pFX->SetFieldType(CFieldExchange::outputColumn);
	RFX_Text(pFX, _T("[Std_Id]"), m_Std_Id);
	RFX_Text(pFX, _T("[Std_Name_thai]"), m_Std_Name_thai);
	RFX_Text(pFX, _T("[Std_title_thai]"), m_Std_title_thai);
	RFX_Text(pFX, _T("[Std_Surname_thai]"), m_Std_Surname_thai);
	RFX_Text(pFX, _T("[Std_name_Eng]"), m_Std_name_Eng);
	RFX_Text(pFX, _T("[Std_title_Eng]"), m_Std_title_Eng);
	RFX_Text(pFX, _T("[Std_Surname_Eng]"), m_Std_Surname_Eng);
	RFX_Text(pFX, _T("[Std_Sex]"), m_Std_Sex);
	RFX_Text(pFX, _T("[Std_Birthday]"), m_Std_Birthday);
	RFX_Text(pFX, _T("[xx]"), m_xx);
	RFX_Text(pFX, _T("[Std_Religion]"), m_Std_Religion);
	RFX_Text(pFX, _T("[Std_Citizen]"), m_Std_Citizen);
	RFX_Text(pFX, _T("[Std_Nation]"), m_Std_Nation);
	RFX_Text(pFX, _T("[Std_Addrborder]"), m_Std_Addrborder);
	RFX_Text(pFX, _T("[Std_Addrcode]"), m_Std_Addrcode);
	RFX_Text(pFX, _T("[Std_Addrdistinct]"), m_Std_Addrdistinct);
	RFX_Text(pFX, _T("[Std_Addrfax]"), m_Std_Addrfax);
	RFX_Text(pFX, _T("[Std_Addrno]"), m_Std_Addrno);
	RFX_Text(pFX, _T("[Std_Addrpager]"), m_Std_Addrpager);
	RFX_Text(pFX, _T("[Std_Addrprovince]"), m_Std_Addrprovince);
	RFX_Text(pFX, _T("[Std_Addrroad]"), m_Std_Addrroad);
	RFX_Text(pFX, _T("[Std_Addrsoi]"), m_Std_Addrsoi);
	RFX_Text(pFX, _T("[Std_Addrtel]"), m_Std_Addrtel);
	RFX_Text(pFX, _T("[Std_Caddrborder]"), m_Std_Caddrborder);
	RFX_Text(pFX, _T("[Std_Caddrcode]"), m_Std_Caddrcode);
	RFX_Text(pFX, _T("[Std_Caddrdistinct]"), m_Std_Caddrdistinct);
	RFX_Text(pFX, _T("[Std_Caddrfax]"), m_Std_Caddrfax);
	RFX_Text(pFX, _T("[Std_Caddrno]"), m_Std_Caddrno);
	RFX_Text(pFX, _T("[Std_Caddrprovince]"), m_Std_Caddrprovince);
	RFX_Text(pFX, _T("[Std_Caddrroad]"), m_Std_Caddrroad);
	RFX_Text(pFX, _T("[Std_Caddrsoi]"), m_Std_Caddrsoi);
	RFX_Text(pFX, _T("[Std_Caddrtel]"), m_Std_Caddrtel);
	//}}AFX_FIELD_MAP
}

/////////////////////////////////////////////////////////////////////////////
// CStdset diagnostics

#ifdef _DEBUG
void CStdset::AssertValid() const
{
	CRecordset::AssertValid();
}

void CStdset::Dump(CDumpContext& dc) const
{
	CRecordset::Dump(dc);
}
#endif //_DEBUG

void CStdset::SetDefaulConnect(CString Uidpass)
{
 m_Connect=_T("ODBC;DSN=REGISTERDATA")+Uidpass;
}

