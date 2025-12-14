#if !defined(AFX_FACULTY_H__0A7D94F6_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
#define AFX_FACULTY_H__0A7D94F6_FCA9_11D2_95C8_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Faculty.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFaculty recordset

class CFaculty : public CRecordset
{
public:
	CFaculty(CDatabase* pDatabase = NULL);
	DECLARE_DYNAMIC(CFaculty)

// Field/Param Data
	//{{AFX_FIELD(CFaculty, CRecordset)
	CString	m_Faculty_Id;
	CString	m_Faculty_Name_thai;
	CString	m_Faculty_Name_Eng;
	CString	m_Faculty_Description;
	//}}AFX_FIELD


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFaculty)
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

#endif // !defined(AFX_FACULTY_H__0A7D94F6_FCA9_11D2_95C8_00E029377C4C__INCLUDED_)
