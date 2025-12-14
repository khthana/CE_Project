// Emulation.cpp: implementation of the CEmulation class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SecureShell.h"
#include "Emulation.h"
#include "SecureShellView.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
int CEmulation::width = 0;
int CEmulation::height = 0;

CEmulation::CEmulation()
{
    foreground = WHITE;
    background = BLACK;
    row = 0;
    column = 0;
}

CEmulation::~CEmulation()
{

}


void CEmulation::clearcoord(int row1, int col1, int row2, int col2)
{
	CSecureShellView *pView = CSecureShellView::GetView();
		pView->drawBackground(0,0,250,250, background);
		if ( row1 == row2) {
			pView->drawBackground(col1*7,(row1)*18,(col2-col1+1)*10,20, background);
			return;
		}
		pView->drawBackground(col1*7,row1*18,(char_w-col1)*10,20, background);
		if ( (row2-row1) > 1) {
			for (int i = row1+1; i < row2; i++){
				pView->drawBackground(0,(i)*18,char_w*10,20, background);
		}
	}
	pView->drawBackground(0,(row2)*18,(col2+1)*10,20, background);



/*	owner.bgr.setColor(background);
    if ( row1 == row2) {
		owner.bgr.fillRect(col1 * owner.chw, ( row1 )*owner.chh, (col2 - col1 + 1)*owner.chw, owner.chh);
		return;
	}

	owner.bgr.fillRect(col1 * owner.chw, ( row1 )*owner.chh, (char_w - col1)*owner.chw, owner.chh);

	if ( (row2-row1) > 1) {
		for (int i = row1+1; i < row2; i++){
			owner.bgr.fillRect(0, ( i )*owner.chh, char_w*owner.chw, owner.chh);
		}
	}

	owner.bgr.fillRect(0, ( row2 )*owner.chh, ( col2 + 1 )*owner.chw, owner.chh);
*/
}

void CEmulation::clearscreen()
{
	CSecureShellView *pView = CSecureShellView::GetView();
		pView->SetWindowText(NULL);
	//		pView->drawBackground(0,0,250,250, background);

/*	owner.bgr.setColor(background);
	owner.bgr.fillRect(0,0,width,height);
	*/
}

void CEmulation::displaych(char c)
{
	CSecureShellView *pView = CSecureShellView::GetView();
		pView->drawForeground(c,column,row,foreground,background);

}

void CEmulation::displaybytes(CByteArray* b, int len)
{

}

void CEmulation::scrollup(int ScrollTop, int ScrollBottom)
{
	CSecureShellView *pView = CSecureShellView::GetView();
		pView->SetWindowText(NULL);
		pView->All = true;
}

void CEmulation::scrolldown(int ScrollTop, int ScrollBottom)
{

}
