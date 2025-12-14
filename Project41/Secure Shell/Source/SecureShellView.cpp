// SecureShellView.cpp : implementation of the CSecureShellView class
//

#include "stdafx.h"
#include "SecureShell.h"

#include "SecureShellDoc.h"
#include "SecureShellView.h"
#include "LoginDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView

IMPLEMENT_DYNCREATE(CSecureShellView, CEditView)

BEGIN_MESSAGE_MAP(CSecureShellView, CEditView)
	//{{AFX_MSG_MAP(CSecureShellView)
	ON_COMMAND(ID_CONNECT_LOGIN, OnConnectLogin)
	ON_WM_CHAR()
	ON_COMMAND(ID_CONNECT_DISCONNECT, OnConnectDisconnect)
	ON_WM_PAINT()
	ON_WM_KEYDOWN()
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CEditView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CEditView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CEditView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView construction/destruction

CSecureShellView::CSecureShellView()
{
	// TODO: add construction code here
	m_Font.CreateFont(-12, 0,0,0,0,0,0,0,0,0,0,0,0, "Courier New");
	for (int i=0;i<char_h;i++)
		for (int j=0;j<char_w;j++)
			CharArray[j][i] = ' ';
	All = false;

}

CSecureShellView::~CSecureShellView()
{
}

BOOL CSecureShellView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	BOOL bPreCreated = CEditView::PreCreateWindow(cs);
	cs.style &= ~(WS_HSCROLL|WS_VSCROLL);	// Enable word-wrapping
//	cs.style &= ~(ES_AUTOHSCROLL|WS_HSCROLL);	// Enable word-wrapping
//	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW | CS_OWNDC ,NULL);
//	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW ,NULL);
	return bPreCreated;
}

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView drawing

void CSecureShellView::OnDraw(CDC* pDC)
{
	CSecureShellDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);

	// TODO: add draw code for native data here
//	CPaintDC pdc(this); // device context for painting
	
	// TODO: Add your message handler code here
	CRect rc;
	GetClientRect(rc);

//	CDC	dc;
//	pDC->CreateCompatibleDC(CDC::FromHandle(pdc.m_ps.hdc));
	
//	static char buf[2000];
	pDC->SelectObject(m_Font);	
//	pdc.SetBkColor(RGB(255,255,0));
	CSize sz = pDC->GetTextExtent("0", 1);
//
	if (!All) {
		rc = CRect(rc.TopLeft().x,rc.TopLeft().y +(sz.cy)*row,rc.BottomRight().x,rc.BottomRight().y);
		CString X;
		for (int i=0;i<char_w;i++) 
			X += CharArray[i][row];
		pDC->DrawText(X,char_w,rc,DT_LEFT);
	} else {
		for (int i=0;i<char_h;i++) {
			CString X;
			for (int j=0;j<char_w;j++) {
				X += CharArray[j][i];
			}
			pDC->DrawText(X,char_w,rc,DT_LEFT);		
			rc = CRect(rc.TopLeft().x,rc.TopLeft().y +sz.cy-1,rc.BottomRight().x,rc.BottomRight().y);
		}
		All = false;
	}	
}

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView printing

BOOL CSecureShellView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default CEditView preparation
	return CEditView::OnPreparePrinting(pInfo);
}

void CSecureShellView::OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo)
{
	// Default CEditView begin printing.
	CEditView::OnBeginPrinting(pDC, pInfo);
}

void CSecureShellView::OnEndPrinting(CDC* pDC, CPrintInfo* pInfo)
{
	// Default CEditView end printing
	CEditView::OnEndPrinting(pDC, pInfo);
}

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView diagnostics

#ifdef _DEBUG
void CSecureShellView::AssertValid() const
{
	CEditView::AssertValid();
}

void CSecureShellView::Dump(CDumpContext& dc) const
{
	CEditView::Dump(dc);
}

CSecureShellDoc* CSecureShellView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CSecureShellDoc)));
	return (CSecureShellDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSecureShellView message handlers

BOOL	CSecureShellView::start = false;
void CSecureShellView::OnConnectLogin() 
{
	// TODO: Add your command handler code here
	CLoginDlg LoginDlg;
	if ( LoginDlg.DoModal() == IDOK ) {
		if (SshIO != NULL)
			SshIO = NULL;
		SshIO = new CSecureShellIO();
		SshIO->Connect(LoginDlg.m_strHost,LoginDlg.m_nPort,LoginDlg.m_strUser,LoginDlg.m_strPasswd);
		start = true;
	}

}

CSecureShellView* CSecureShellView::GetView()
{
	CFrameWnd *pFrame = (CFrameWnd *)(AfxGetApp()->m_pMainWnd);
	CView *pView = pFrame->GetActiveView();
	if (!pView)
		return NULL;
	if (!pView->IsKindOf(RUNTIME_CLASS(CSecureShellView)))
		return NULL;
	return (CSecureShellView *)pView;


}

void CSecureShellView::Display(CByteArray* data)
{
	CEdit& ed = GetEditCtrl();
	if (ed.GetLineCount() > 1000)
	{
		// Empty the whole thing
		SetWindowText(NULL);
	}
	
	CString out;
	for (int i=0;i<data->GetSize();i++)
		out += (char) data->GetAt(i);
		ed.SetSel(-1,-1);
		ed.ReplaceSel(out);

}

void CSecureShellView::Display(LPCSTR lpFormat,...)
{
	CEdit& ed = GetEditCtrl();
	if (ed.GetLineCount() > 1000)
	{
		// Empty the whole thing
		SetWindowText(NULL);
	}
	
	va_list Marker;
	static char szBuf[300];
	
	// Write text to string
	// and append to edit control
	va_start(Marker, lpFormat);
	vsprintf(szBuf, lpFormat, Marker);
	va_end(Marker);
	ed.SetSel(-1,-1);
	ed.ReplaceSel(szBuf);
	
}

void CSecureShellView::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	// TODO: Add your message handler code here and/or call default
	
//	CEditView::OnChar(nChar, nRepCnt, nFlags);
	if (start) 
	{
		CString iChar((char)nChar);
		if (SshIO != NULL)
			SshIO->Send_SSH_CMSG_STDIN_DATA(iChar);
	}

/*	CRect	rect(20,25,50,50);
	CBrush	brush(RGB(255,255,0));//RGB(255,255,0));
	CDC*	pDC = GetDC();

	pDC->SetBkMode(TRANSPARENT);
	pDC->FillRect(rect,&brush);
	pDC->SetTextColor(RGB(255,0,0));
	pDC->TextOut(30,30,"asjfdkljasdklf");
	ReleaseDC(pDC);
*/	
}


void CSecureShellView::drawBackground(int x,int y,int width, int high,int color)
{
	CRect	rect(x-3,y-3,3,3);
	CBrush	brush(color);//RGB(255,255,0));
	CDC*	pDC = GetDC();

//	CBrush*	pOldBrush = pDC->SelectObject(&brush);
//	pDC->SetMapMode(MM_ISOTROPIC);
	pDC->SetBkMode(TRANSPARENT);
	pDC->FillRect(rect,&brush);
//	pDC->SelectObject(pOldBrush);
	ReleaseDC(pDC);

}

void CSecureShellView::drawForeground(char c,int x, int y,int fcolor ,int bcolor)
{
//	CDC*	pDC = GetDC();
	CharArray[x][y] = c;

//	SetWindowText(NULL);
	column = x;
	row  = y;
//	CDC*	dc = GetDC();
//	OnDraw(dc);
//	OnPaint();
//	ReleaseDC(dc);

//	pDC->SetMapMode(MM_ISOTROPIC);
//	pDC->SetBkMode(TRANSPARENT);
//	pDC->SetTextColor(color);
//	pDC->TextOut(x,y,c);
//	ReleaseDC(pDC);

//	Display(&c);
}

void CSecureShellView::OnConnectDisconnect() 
{
	// TODO: Add your command handler code here
	if (SshIO != NULL)
	{
		SshIO->m_pSocket->Close();
		SshIO->m_pSocket = NULL;
	}
	CSecureShellView *pView = CSecureShellView::GetView();
	pView->start = false;
	
}

void CSecureShellView::OnPaint() 
{
//	CPaintDC dc(this); // device context for painting
	CPaintDC pdc(this); // device context for painting
	
	// TODO: Add your message handler code here
	CRect rc;
	GetClientRect(rc);

	CDC	dc;
	dc.CreateCompatibleDC(CDC::FromHandle(pdc.m_ps.hdc));
	
//	static char buf[2000];
	pdc.SelectObject(m_Font);	
//	pdc.SetBkColor(RGB(255,255,0));
	CSize sz = dc.GetTextExtent("0", 1);
//
	

	for (int i=0;i<char_h;i++) {
		CString X;
		for (int j=0;j<char_w;j++) {
			X += CharArray[j][i];
		}
//		rc.OffsetRect(rc.TopLeft().x,rc.TopLeft().y+sz.cy-1);		
		pdc.DrawText(X,char_w,rc,DT_LEFT);		
		rc = CRect(rc.TopLeft().x,rc.TopLeft().y +sz.cy-1,rc.BottomRight().x,rc.BottomRight().y);
	}
	
	// TODO: Add your message handler code here
	
	// Do not call CEditView::OnPaint() for painting messages
}

void CSecureShellView::Show()
{
	SetWindowText(NULL);

	CPaintDC pdc(this); // device context for painting
	
	// TODO: Add your message handler code here
	CRect rc;
	GetClientRect(rc);

	CDC	dc;
	dc.CreateCompatibleDC(CDC::FromHandle(pdc.m_ps.hdc));
	
//	static char buf[2000];
	pdc.SelectObject(m_Font);	
//	pdc.SetBkColor(RGB(255,255,0));
	CSize sz = dc.GetTextExtent("0", 1);
//
	

	for (int i=0;i<char_h;i++) {
		CString X;
		for (int j=0;j<char_w;j++) {
			X += CharArray[j][i];
		}
//		rc.OffsetRect(rc.TopLeft().x,rc.TopLeft().y+sz.cy-1);		
		pdc.DrawText(X,char_w,rc,DT_LEFT);		
		rc = CRect(rc.TopLeft().x,rc.TopLeft().y +sz.cy-1,rc.BottomRight().x,rc.BottomRight().y);
	}
	

}

void CSecureShellView::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	// TODO: Add your message handler code here and/or call default
/*	CString iChar;
	if (start) 
	{
		switch (nChar)
		{
		case VK_UP :
			iChar +=((char) 0x10);
			if (SshIO != NULL)
				SshIO->Send_SSH_CMSG_STDIN_DATA(iChar);
		case VK_RIGHT:
			iChar += ((char) 0x27);
			if (SshIO != NULL)
				SshIO->Send_SSH_CMSG_STDIN_DATA(iChar);
		case VK_DOWN:
			iChar += ((char) 0x28);
			if (SshIO != NULL)
				SshIO->Send_SSH_CMSG_STDIN_DATA(iChar);
		case VK_LEFT:
			iChar += ((char) 0x25);
			if (SshIO != NULL)
				SshIO->Send_SSH_CMSG_STDIN_DATA(iChar);		
		}
	}
	*/
//	CEditView::OnKeyDown(nChar, nRepCnt, nFlags);
}
