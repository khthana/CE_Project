// SnmpAgentView.cpp : implementation of the CSnmpAgentView class
//

#include "stdafx.h"
#include "SnmpAgent.h"

#include "SnmpAgentDoc.h"
#include "SnmpAgentView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentView

IMPLEMENT_DYNCREATE(CSnmpAgentView, CEditView)

BEGIN_MESSAGE_MAP(CSnmpAgentView, CEditView)
	//{{AFX_MSG_MAP(CSnmpAgentView)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentView construction/destruction

CSnmpAgentView::CSnmpAgentView()
{
}

CSnmpAgentView::~CSnmpAgentView()
{
}

BOOL CSnmpAgentView::PreCreateWindow(CREATESTRUCT& cs)
{
	return CEditView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentView drawing

void CSnmpAgentView::OnDraw(CDC* pDC)
{
	CSnmpAgentDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
}

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentView diagnostics

#ifdef _DEBUG
void CSnmpAgentView::AssertValid() const
{
	CEditView::AssertValid();
}

void CSnmpAgentView::Dump(CDumpContext& dc) const
{
	CEditView::Dump(dc);
}

void CSnmpAgentView::Display(LPCSTR lpFormat,...)
{
	CEdit& ed = GetEditCtrl();
	if (ed.GetLineCount() > 1000)
	{
		// Empty the whole thing
		SetWindowText(NULL);
	}
	
	va_list Marker;
	static char szBuf[256];
	
	// Write text to string
	// and append to edit control
	va_start(Marker, lpFormat);
	vsprintf(szBuf, lpFormat, Marker);
	va_end(Marker);
	ed.SetSel(-1,-1);
	ed.ReplaceSel(szBuf);
	
}

CSnmpAgentView* CSnmpAgentView::GetView()
{
	CFrameWnd *pFrame = (CFrameWnd *)(AfxGetApp()->m_pMainWnd);
	CView *pView = pFrame->GetActiveView();
	if (!pView)
		return NULL;
	if (!pView->IsKindOf(RUNTIME_CLASS(CSnmpAgentView)))
		return NULL;
	return (CSnmpAgentView *)pView;

}

CSnmpAgentDoc* CSnmpAgentView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CSnmpAgentDoc)));
	return (CSnmpAgentDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSnmpAgentView message handlers
