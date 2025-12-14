// SnmpAgentView.h : interface of the CSnmpAgentView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SNMPAGENTVIEW_H__F4E51E4D_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
#define AFX_SNMPAGENTVIEW_H__F4E51E4D_8162_11D2_AA9B_008048FBB1F4__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

class CSnmpAgentView : public CEditView
{
protected: // create from serialization only
	CSnmpAgentView();
	DECLARE_DYNCREATE(CSnmpAgentView)

// Attributes
public:
	CSnmpAgentDoc* GetDocument();

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSnmpAgentView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSnmpAgentView();
	static CSnmpAgentView*  GetView();
	void Display(LPCSTR lpFormat,...);
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSnmpAgentView)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in SnmpAgentView.cpp
inline CSnmpAgentDoc* CSnmpAgentView::GetDocument()
   { return (CSnmpAgentDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SNMPAGENTVIEW_H__F4E51E4D_8162_11D2_AA9B_008048FBB1F4__INCLUDED_)
