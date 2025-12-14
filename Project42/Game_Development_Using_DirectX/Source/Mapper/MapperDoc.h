// MapperDoc.h : interface of the CMapperDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAPPERDOC_H__242CDA4B_0695_11D4_857E_96A44DCF5271__INCLUDED_)
#define AFX_MAPPERDOC_H__242CDA4B_0695_11D4_857E_96A44DCF5271__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

///////////////////////////////////////////
// My code goes here.
///////////////////////////////////////////
#include "MapperConst.h"

class CMapperDoc : public CDocument
{
protected: // create from serialization only
	CMapperDoc();
	DECLARE_DYNCREATE(CMapperDoc)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMapperDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	BLOCKSTATUS m_Map[MAX_BLOCK][MAX_BLOCK];
	virtual ~CMapperDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CMapperDoc)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAPPERDOC_H__242CDA4B_0695_11D4_857E_96A44DCF5271__INCLUDED_)
