// SecureShellDoc.h : interface of the CSecureShellDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECURESHELLDOC_H__9383098F_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURESHELLDOC_H__9383098F_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000


class CSecureShellDoc : public CDocument
{
protected: // create from serialization only
	CSecureShellDoc();
	DECLARE_DYNCREATE(CSecureShellDoc)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSecureShellDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSecureShellDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSecureShellDoc)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SECURESHELLDOC_H__9383098F_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
