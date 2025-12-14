// MapperView.cpp : implementation of the CMapperView class
//

#include "stdafx.h"
#include "Mapper.h"

#include "MapperDoc.h"
#include "MapperView.h"

///////////////////////////////////////////
// My code goes here.
///////////////////////////////////////////
#include "BlockStatusDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMapperView

IMPLEMENT_DYNCREATE(CMapperView, CScrollView)

BEGIN_MESSAGE_MAP(CMapperView, CScrollView)
	//{{AFX_MSG_MAP(CMapperView)
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONUP()
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CScrollView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMapperView construction/destruction

CMapperView::CMapperView()
{
	// TODO: add construction code here
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	m_bTracking = FALSE;
}

CMapperView::~CMapperView()
{
}

BOOL CMapperView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CScrollView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CMapperView drawing

void CMapperView::OnDraw(CDC* pDC)
{
	CMapperDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	// TODO: add draw code for native data here
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	DrawGrid (pDC);
	UpdateMap (pDC, 0, 0, MAX_BLOCK - 1, MAX_BLOCK - 1, UPDATE_NORMAL);
}

void CMapperView::OnInitialUpdate()
{
	CScrollView::OnInitialUpdate();

	//CSize sizeTotal;
	// TODO: calculate the total size of this view
	//sizeTotal.cx = sizeTotal.cy = 100;
	//SetScrollSizes(MM_TEXT, sizeTotal);
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	SetScrollSizes (MM_TEXT,
					CSize (MAX_BLOCK*BLOCK + OFFSET*2, MAX_BLOCK*BLOCK + OFFSET*2),
					CSize (OFFSET, OFFSET),
					CSize (BLOCK, BLOCK));
	ScrollToPosition (CPoint (0, 0));

	CMapperDoc* pDOC;
	pDOC = GetDocument ();
	
	int i, j;
	for (i = 0; i < MAX_BLOCK; i++)
		for (j = 0; j < MAX_BLOCK; j++)
		{
			m_Map[i][j].type = pDOC->m_Map[i][j].type;
			m_Map[i][j].level = pDOC->m_Map[i][j].level;
			m_Map[i][j].reserved = pDOC->m_Map[i][j].reserved;
		}
}

/////////////////////////////////////////////////////////////////////////////
// CMapperView printing

BOOL CMapperView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CMapperView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CMapperView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CMapperView diagnostics

#ifdef _DEBUG
void CMapperView::AssertValid() const
{
	CScrollView::AssertValid();
}

void CMapperView::Dump(CDumpContext& dc) const
{
	CScrollView::Dump(dc);
}

CMapperDoc* CMapperView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CMapperDoc)));
	return (CMapperDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMapperView message handlers

void CMapperView::DrawGrid(CDC *pDC)
{
	CFont font;
	font.CreatePointFont (100, _T ("Arial"));
	CFont* pOldFont = pDC->SelectObject (&font);

	int i;
	for (i = 0; i <= MAX_BLOCK; i++)
	{
		// vertical grid
		pDC->MoveTo (CPoint (i*BLOCK + OFFSET, OFFSET));
		pDC->LineTo (CPoint (i*BLOCK + OFFSET, OFFSET + MAX_BLOCK*BLOCK));

		// horizontal grid
		pDC->MoveTo (CPoint (OFFSET, i*BLOCK + OFFSET));
		pDC->LineTo (CPoint (OFFSET + MAX_BLOCK*BLOCK, i*BLOCK + OFFSET));	

		// index
		CString str;
		str.Format (_T ("%d"), i);

		if (i % 5 == 0)
		{
			// vertical index
			pDC->TextOut (OFFSET/2, i*BLOCK + OFFSET, str);
			pDC->TextOut (OFFSET/2 + OFFSET + MAX_BLOCK*BLOCK, i*BLOCK + OFFSET, str);

			// horizontal index
			pDC->TextOut (i*BLOCK + OFFSET, OFFSET/2, str);
			pDC->TextOut (i*BLOCK + OFFSET, OFFSET/2 + OFFSET + MAX_BLOCK*BLOCK, str);
		}
	}
	pDC->SelectObject (pOldFont);

	CPen pen;
	pen.CreatePen (PS_SOLID, 1, RGB (150, 150, 150));
	CPen* pOldPen = pDC->SelectObject (&pen);

	for (i = 0; i <= MAX_BLOCK; i++)
	{
		if (i % 5 == 0)
		{
		// vertical main grid
		pDC->MoveTo (CPoint (i*BLOCK + OFFSET, OFFSET));
		pDC->LineTo (CPoint (i*BLOCK + OFFSET, OFFSET + MAX_BLOCK*BLOCK));

		// horizontal main grid
		pDC->MoveTo (CPoint (OFFSET, i*BLOCK + OFFSET));
		pDC->LineTo (CPoint (OFFSET + MAX_BLOCK*BLOCK, i*BLOCK + OFFSET));
		}
	}
	pDC->SelectObject (pOldPen);
}

void CMapperView::DrawBlock(CDC *pDC, int i, int j, COLORREF color, int flags)
{
	CBrush brush;
	brush.CreateSolidBrush (color);
	CBrush* pOldBrush = pDC->SelectObject (&brush);

	CPen pen;
	pen.CreatePen (PS_NULL, 1, RGB (0, 0, 0));
	CPen* pOldPen = pDC->SelectObject (&pen);

	int l, r, t, b;
	if (flags == UPDATE_NORMAL)
	{
		l = j*BLOCK + OFFSET + 1;
		r = j*BLOCK + OFFSET + BLOCK + 1;
		t = i*BLOCK + OFFSET + 1;
		b = i*BLOCK + OFFSET + BLOCK + 1;
	}
	else
	{
		CPoint pt;
		pt = GetScrollPosition ();

		l = j*BLOCK + OFFSET - pt.x + 1;
		r = j*BLOCK + OFFSET + BLOCK + 1 - pt.x;
		t = i*BLOCK + OFFSET - pt.y + 1;
		b = i*BLOCK + OFFSET + BLOCK + 1 - pt.y;
	}
	pDC->Rectangle (l, t, r, b);
	pDC->SelectObject (pOldBrush);
	pDC->SelectObject (pOldPen);
}

void CMapperView::UpdateMap(CDC *pDC, int i1, int j1, int i2, int j2, int flags)
{
	int r, g, b;
	
	int i, j;
	for (i = i1; i <= i2; i++)
		for (j = j1; j <= j2; j++)
		{
			switch (m_Map[i][j].type)
			{
			case TYPE_NORMAL:
				r = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				g = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				b = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				break;

			case TYPE_BLOCKED:
				r = 0;
				g = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST1;
				b = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST1;
				break;

			case TYPE_GRASS:
				r = COLOR_CONST1;
				g = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				b = COLOR_CONST1;
				break;

			case TYPE_WATER:
				r = COLOR_CONST1;
				g = COLOR_CONST1;
				b = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				break;

			case TYPE_BUILDING:
				r = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				g = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				b = COLOR_CONST1;
				break;

			case TYPE_SPECIAL:
				r = COLOR_FACTOR*m_Map[i][j].level + COLOR_CONST2;
				g = COLOR_CONST1;
				b = COLOR_CONST1;
				break;
			}
			if (m_Map[i][j].type != TYPE_NONE)
				DrawBlock (pDC, i, j, RGB (r, g, b), flags);
		}
}

void CMapperView::InvertLine(CDC *pDC, CPoint ptFrom, CPoint ptTo)
{
	int nOldMode = pDC->SetROP2 (R2_NOT);
	pDC->MoveTo (ptFrom);
	pDC->LineTo (ptTo);
	pDC->SetROP2 (nOldMode);
}

void CMapperView::InvertRect(CDC *pDC, CPoint ptFrom, CPoint ptTo)
{
	InvertLine (pDC, ptFrom, CPoint (ptTo.x, ptFrom.y));
	InvertLine (pDC, ptFrom, CPoint (ptFrom.x, ptTo.y));
	InvertLine (pDC, CPoint (ptFrom.x, ptTo.y), ptTo);
	InvertLine (pDC, CPoint (ptTo.x, ptFrom.y), ptTo);
}

void CMapperView::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	CPoint pt;
	pt = GetScrollPosition ();

	if (pt.x + point.x - OFFSET >= 0 &&
		pt.x + point.x - OFFSET <= MAX_BLOCK*BLOCK &&
		pt.y + point.y - OFFSET >= 0 &&
		pt.y + point.y - OFFSET <= MAX_BLOCK*BLOCK)
	{
		m_ptFrom = point;
		m_ptTo = point;
		m_bTracking = TRUE;
	}
	
	CScrollView::OnLButtonDown(nFlags, point);
}

void CMapperView::OnMouseMove(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	if (m_bTracking)
	{
		CPoint pt;
		pt = GetScrollPosition ();

		if (pt.x + point.x - OFFSET >= 0 &&
			pt.x + point.x - OFFSET <= MAX_BLOCK*BLOCK &&
			pt.y + point.y - OFFSET >= 0 &&
			pt.y + point.y - OFFSET <= MAX_BLOCK*BLOCK)
		{
			CClientDC dc (this);
			InvertRect (&dc, m_ptFrom, m_ptTo);
			InvertRect (&dc, m_ptFrom, point);
			m_ptTo = point;
		}
	}
	
	CScrollView::OnMouseMove(nFlags, point);
}

void CMapperView::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	///////////////////////////////////////////
	// My code goes here.
	///////////////////////////////////////////
	int i1, j1, i2, j2;
	CPoint pt;

	if (m_bTracking)
	{
		m_bTracking = FALSE;

		CPoint pt;
		pt = GetScrollPosition ();
		CClientDC dc (this);
		if (pt.x + point.x - OFFSET >= 0 &&
			pt.x + point.x - OFFSET <= MAX_BLOCK*BLOCK &&
			pt.y + point.y - OFFSET >= 0 &&
			pt.y + point.y - OFFSET <= MAX_BLOCK*BLOCK)
			InvertRect (&dc, m_ptFrom, point);
		else
			InvertRect (&dc, m_ptFrom, m_ptTo);

		pt = GetScrollPosition ();
		i1 = (m_ptFrom.y + pt.y - OFFSET)/BLOCK;
		j1 = (m_ptFrom.x + pt.x - OFFSET)/BLOCK;
		i2 = (m_ptTo.y + pt.y - OFFSET)/BLOCK;
		j2 = (m_ptTo.x + pt.x - OFFSET)/BLOCK;
		
		int tmp;
		if (i1 > i2)
		{
			tmp = i1;
			i1 = i2;
			i2 = tmp;
		}
		if (j1 > j2)
		{
			tmp = j1;
			j1 = j2;
			j2 = tmp;
		}

		i1 = i1 < 0 ? 0 : i1;
		j1 = j1 < 0 ? 0 : j1;
		i2 = i2 < 0 ? 0 : i2;
		j2 = j2 < 0 ? 0 : j2;
		i1 = i1 >= MAX_BLOCK ? MAX_BLOCK - 1 : i1;
		j1 = j1 >= MAX_BLOCK ? MAX_BLOCK - 1 : j1;
		i2 = i2 >= MAX_BLOCK ? MAX_BLOCK - 1 : i2;
		j2 = j2 >= MAX_BLOCK ? MAX_BLOCK - 1 : j2;

		CBlockStatusDlg dlg;
		if (i1 == i2 && j1 == j2)
		{
			dlg.m_i = i1;
			dlg.m_j = j1;
			dlg.m_Type = m_Map[i1][j1].type;
			dlg.m_Level = m_Map[i1][j1].level;
			dlg.m_Reserved = m_Map[i1][j1].reserved;
		}
		else
		{
			dlg.m_i = -1;
			dlg.m_j = -1;
			dlg.m_Level = -1;
			dlg.m_Reserved = -1;
		}

		if (dlg.DoModal () == IDOK)
		{
			CMapperDoc* pDOC;
			pDOC = GetDocument ();

			int i, j;
			for (i = i1; i <= i2; i++)
				for (j = j1; j <= j2; j++)
				{
					pDOC->m_Map[i][j].type = m_Map[i][j].type = dlg.m_Type;
					pDOC->m_Map[i][j].level = m_Map[i][j].level = dlg.m_Level;
					pDOC->m_Map[i][j].reserved = m_Map[i][j].reserved = dlg.m_Reserved;
				}
			pDOC->SetModifiedFlag (TRUE);
		}

		CClientDC dc1 (this);
		UpdateMap (&dc1, i1, j1, i2, j2, UPDATE_CONVERT);
	}
	
	CScrollView::OnLButtonUp(nFlags, point);
}