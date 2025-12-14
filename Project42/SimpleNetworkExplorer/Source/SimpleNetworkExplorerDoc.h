// SimpleNetworkExplorerDoc.h : interface of the CSimpleNetworkExplorerDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SIMPLENETWORKEXPLORERDOC_H__811CCD3E_0338_11D4_9323_00E02947F59E__INCLUDED_)
#define AFX_SIMPLENETWORKEXPLORERDOC_H__811CCD3E_0338_11D4_9323_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CSimpleNetworkExplorerDoc : public CDocument
{
protected: // create from serialization only
	CSimpleNetworkExplorerDoc();
	DECLARE_DYNCREATE(CSimpleNetworkExplorerDoc)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSimpleNetworkExplorerDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSimpleNetworkExplorerDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSimpleNetworkExplorerDoc)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SIMPLENETWORKEXPLORERDOC_H__811CCD3E_0338_11D4_9323_00E02947F59E__INCLUDED_)
