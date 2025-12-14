// SimpleNetworkExplorerView.h : interface of the CSimpleNetworkExplorerView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SIMPLENETWORKEXPLORERVIEW_H__811CCD40_0338_11D4_9323_00E02947F59E__INCLUDED_)
#define AFX_SIMPLENETWORKEXPLORERVIEW_H__811CCD40_0338_11D4_9323_00E02947F59E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CSimpleNetworkExplorerView : public CView
{
protected: // create from serialization only
	CSimpleNetworkExplorerView();
	DECLARE_DYNCREATE(CSimpleNetworkExplorerView)

// Attributes
public:
	CSimpleNetworkExplorerDoc* GetDocument();

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSimpleNetworkExplorerView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSimpleNetworkExplorerView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSimpleNetworkExplorerView)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in SimpleNetworkExplorerView.cpp
inline CSimpleNetworkExplorerDoc* CSimpleNetworkExplorerView::GetDocument()
   { return (CSimpleNetworkExplorerDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SIMPLENETWORKEXPLORERVIEW_H__811CCD40_0338_11D4_9323_00E02947F59E__INCLUDED_)
