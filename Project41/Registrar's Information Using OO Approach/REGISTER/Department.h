#if !defined(AFX_DEPARTMENT_H__E9AEAE21_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
#define AFX_DEPARTMENT_H__E9AEAE21_FCC3_11D2_95CA_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Department.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDepartment recordset

class CDepartment : public CRecordset
{
public:
	CDepartment(CDatabase* pDatabase = NULL);
	DECLARE_DYNAMIC(CDepartment)

// Field/Param Data
	//{{AFX_FIELD(CDepartment, CRecordset)
	CString	m_Dept_Id;
	CString	m_Dept_Name_Thai;
	CString	m_Dept_Name_Eng;
	CString	m_Dept_Description;
	CString	m_Faculty_name;
	//}}AFX_FIELD


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDepartment)
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

#endif // !defined(AFX_DEPARTMENT_H__E9AEAE21_FCC3_11D2_95CA_00E029377C4C__INCLUDED_)
