// dibview.h : interface of the CDibView class
//
// This is a part of the Microsoft Foundation Classes C++ library.
// Copyright (C) 1992-1998 Microsoft Corporation
// All rights reserved.
//
// This source code is only intended as a supplement to the
// Microsoft Foundation Classes Reference and related
// electronic documentation provided with the library.
// See these sources for detailed information regarding the
// Microsoft Foundation Classes product.

#include "DibOper.h"	// Added by ClassView
class CDibView : public CScrollView
{
protected: // create from serialization only
	CDibView();
	DECLARE_DYNCREATE(CDibView)


// Attributes
public:
	double model_buff[32];
	double target_buff[32];
 //   CString DATAtemp;
//	double old_target[32];
	int asctoint(char cnum);

	CDibDoc* GetDocument()
		{
			ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CDibDoc)));
			return (CDibDoc*) m_pDocument;
		}

// Operations
public:
	
	
// Implementation
public:


	//CUIntArray buff;
	virtual ~CDibView();
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view

	virtual void OnInitialUpdate();
	virtual void OnActivateView(BOOL bActivate, CView* pActivateView,
					CView* pDeactiveView);

// Printing support
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);

// Generated message map functions
protected:
	//{{AFX_MSG(CDibView)
	afx_msg void OnEditCopy();
	afx_msg void OnUpdateEditCopy(CCmdUI* pCmdUI);
	afx_msg void OnEditPaste();
	afx_msg void OnUpdateEditPaste(CCmdUI* pCmdUI);
	afx_msg LRESULT OnDoRealize(WPARAM wParam, LPARAM lParam);  // user message
//	afx_msg void OnToolRgbvalue();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnToolMatching();
	afx_msg void OnUpdateToolDatabase(CCmdUI* pCmdUI);
	afx_msg void OnToolDatabase();
	afx_msg void OnOptionSetboxcolor();
	afx_msg void OnOptionRotatebox();

  //}}AFX_MSG
	DECLARE_MESSAGE_MAP()

private:

	float HisIntersectH(double target_buff[19],double model_buff[19]);
	float HisIntersectAVG(double target_buff[32],double model_buff[32]);
	int boxWidth,boxHeight;
	//UINT boxSize;
	COLORREF boxColor;
	int MaxSize;
	//CString buffer;
	CString target;

	//default value for threshold
	CString origin;
	int threshold;

	CString detail;
	// save database or not
	BOOL m_database;
	// show result dialog or not
	BOOL show;

	double Target_Size;
	double Model_Size;
	double Old_Target;

	void Rgbvalue();
    void GetThreshold();
	ToScreen InitHistogram(ToScreen bu);
	CString CountHistogram(ToScreen hisbuff);
};

/////////////////////////////////////////////////////////////////////////////
