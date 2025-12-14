// SimpleNetworkExplorerView.cpp : implementation of the CSimpleNetworkExplorerView class
//

#include "stdafx.h"
#include "SimpleNetworkExplorer.h"

#include "SimpleNetworkExplorerDoc.h"
#include "SimpleNetworkExplorerView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView

IMPLEMENT_DYNCREATE(CSimpleNetworkExplorerView, CView)

BEGIN_MESSAGE_MAP(CSimpleNetworkExplorerView, CView)
	//{{AFX_MSG_MAP(CSimpleNetworkExplorerView)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView construction/destruction

CSimpleNetworkExplorerView::CSimpleNetworkExplorerView()
{
	// TODO: add construction code here

}

CSimpleNetworkExplorerView::~CSimpleNetworkExplorerView()
{
}

BOOL CSimpleNetworkExplorerView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView drawing

void CSimpleNetworkExplorerView::OnDraw(CDC* pDC)
{
	CSimpleNetworkExplorerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	// TODO: add draw code for native data here
}

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView printing

BOOL CSimpleNetworkExplorerView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CSimpleNetworkExplorerView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CSimpleNetworkExplorerView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView diagnostics

#ifdef _DEBUG
void CSimpleNetworkExplorerView::AssertValid() const
{
	CView::AssertValid();
}

void CSimpleNetworkExplorerView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CSimpleNetworkExplorerDoc* CSimpleNetworkExplorerView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CSimpleNetworkExplorerDoc)));
	return (CSimpleNetworkExplorerDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSimpleNetworkExplorerView message handlers
