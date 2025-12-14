#if !defined(AFX_STDSET_H__5BA70220_F662_11D2_95A2_00E029377C4C__INCLUDED_)
#define AFX_STDSET_H__5BA70220_F662_11D2_95A2_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Stdset.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStdset recordset

class CStdset : public CRecordset
{
public:
	void SetDefaulConnect(CString Uidpass);
	CString m_Connect;
	CString sql;
	CStdset(CDatabase* pDatabase = NULL);
	DECLARE_DYNAMIC(CStdset)

// Field/Param Data
	//{{AFX_FIELD(CStdset, CRecordset)
	CString	m_Std_Id;
	CString	m_Std_Name_thai;
	CString	m_Std_title_thai;
	CString	m_Std_Surname_thai;
	CString	m_Std_name_Eng;
	CString	m_Std_title_Eng;
	CString	m_Std_Surname_Eng;
	CString	m_Std_Sex;
	CString	m_Std_Birthday;
	CString	m_xx;
	CString	m_Std_Religion;
	CString	m_Std_Citizen;
	CString	m_Std_Nation;
	CString	m_Std_Addrborder;
	CString	m_Std_Addrcode;
	CString	m_Std_Addrdistinct;
	CString	m_Std_Addrfax;
	CString	m_Std_Addrno;
	CString	m_Std_Addrpager;
	CString	m_Std_Addrprovince;
	CString	m_Std_Addrroad;
	CString	m_Std_Addrsoi;
	CString	m_Std_Addrtel;
	CString	m_Std_Caddrborder;
	CString	m_Std_Caddrcode;
	CString	m_Std_Caddrdistinct;
	CString	m_Std_Caddrfax;
	CString	m_Std_Caddrno;
	CString	m_Std_Caddrprovince;
	CString	m_Std_Caddrroad;
	CString	m_Std_Caddrsoi;
	CString	m_Std_Caddrtel;
	//}}AFX_FIELD


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStdset)
	public:
	virtual CString GetDefaultConnect();    // Default connection string
	virtual CString GetDefaultSQL();    // Default SQL for Recordset
	virtual void DoFieldExchange(CFieldExchange* pFX);  // RFX support
	//}}AFX_VIRTUAL

// Implementation
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDSET_H__5BA70220_F662_11D2_95A2_00E029377C4C__INCLUDED_)
