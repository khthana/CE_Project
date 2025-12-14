// SecureShellView.h : interface of the CSecureShellView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SECURESHELLVIEW_H__93830991_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
#define AFX_SECURESHELLVIEW_H__93830991_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "SecureShellIO.h"
class CSecureShellDoc;


class CSecureShellView : public CEditView
{
protected: // create from serialization only
	CSecureShellView();
	DECLARE_DYNCREATE(CSecureShellView)

// Attributes
public:
	CSecureShellDoc* GetDocument();
	CSecureShellIO* SshIO;
	char	CharArray[80][24];
	int		Foregnd[80][24];
	int		Backgnd[80][24];
	int		row;
	int		column;

// Operations
public:
	void Display(LPCSTR lpFormat,...);
	void Display(CByteArray *data);
	static CSecureShellView* GetView();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSecureShellView)
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
	void Show();
	BOOL All;
	CFont m_Font;
	void drawForeground(char c,int x, int y,int fcolor ,int bcolor);
	void drawBackground(int x,int y,int width, int high,int color);
	static BOOL start;
	virtual ~CSecureShellView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSecureShellView)
	afx_msg void OnConnectLogin();
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnConnectDisconnect();
	afx_msg void OnPaint();
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in SecureShellView.cpp
inline CSecureShellDoc* CSecureShellView::GetDocument()
   { return (CSecureShellDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SECURESHELLVIEW_H__93830991_E4CE_11D2_BEDE_0000E8D7086B__INCLUDED_)
