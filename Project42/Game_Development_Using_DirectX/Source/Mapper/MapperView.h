// MapperView.h : interface of the CMapperView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAPPERVIEW_H__242CDA4D_0695_11D4_857E_96A44DCF5271__INCLUDED_)
#define AFX_MAPPERVIEW_H__242CDA4D_0695_11D4_857E_96A44DCF5271__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

///////////////////////////////////////////
// My code goes here.
///////////////////////////////////////////
#include "MapperConst.h"

class CMapperView : public CScrollView
{
protected: // create from serialization only
	CMapperView();
	DECLARE_DYNCREATE(CMapperView)

// Attributes
public:
	CMapperDoc* GetDocument();

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMapperView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	virtual void OnInitialUpdate(); // called first time after construct
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMapperView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	void InvertRect (CDC* pDC, CPoint ptFrom, CPoint ptTo);
	void InvertLine (CDC* pDC, CPoint ptFrom, CPoint ptTo);
	void UpdateMap (CDC* pDC, int i1, int j1, int i2, int j2, int flags);
	void DrawBlock (CDC* pDC, int i, int j, COLORREF color, int flags);
	void DrawGrid (CDC* pDC);

	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	BLOCKSTATUS m_Map[MAX_BLOCK][MAX_BLOCK];
	CPoint m_ptTo;
	CPoint m_ptFrom;
	BOOL m_bTracking;
	//{{AFX_MSG(CMapperView)
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in MapperView.cpp
inline CMapperDoc* CMapperView::GetDocument()
   { return (CMapperDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAPPERVIEW_H__242CDA4D_0695_11D4_857E_96A44DCF5271__INCLUDED_)
