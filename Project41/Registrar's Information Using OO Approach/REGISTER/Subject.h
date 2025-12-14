#if !defined(AFX_SUBJECT_H__15297B91_FA3C_11D2_95B4_00E029377C4C__INCLUDED_)
#define AFX_SUBJECT_H__15297B91_FA3C_11D2_95B4_00E029377C4C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Subject.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSubject recordset

class CSubject : public CRecordset
{
public:
	CSubject(CDatabase* pDatabase = NULL);
	DECLARE_DYNAMIC(CSubject)

// Field/Param Data
	//{{AFX_FIELD(CSubject, CRecordset)
	CString	m_Subject_Id;
	CString	m_Year_Study;
	CString	m_Subject_Category;
	CString	m_Subject_Group;
	CString	m_Subject_Name_Thai;
	CString	m_Subject_Name_Eng;
	long	m_Subject_Sum_Credit;
	long	m_Subject_Lec_Credit;
	long	m_Subject_Lab_Credit;
	CString	m_Faculty_Id;
	CString	m_Dept_Id;
	CString	m_Subject_Description;
	//}}AFX_FIELD


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSubject)
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

#endif // !defined(AFX_SUBJECT_H__15297B91_FA3C_11D2_95B4_00E029377C4C__INCLUDED_)
