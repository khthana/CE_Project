// Emulation.h: interface for the CEmulation class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_EMULATION_H__157F4263_E57D_11D2_BE7E_002018571AA5__INCLUDED_)
#define AFX_EMULATION_H__157F4263_E57D_11D2_BE7E_002018571AA5__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

//#include "SecureShellView.h"
//////////////////////////////////////////////////////////////////////
const int	BLACK		RGB(0,0,0);
const int	RED			RGB(255,0,0);
const int	GREEN		RGB(0,255,255);
const int	YELLOW		RGB(255,255,0);
const int	BLUE		RGB(0,0,255);
const int	MAGENTA		RGB(255,0,255);
const int	CYAN		RGB(0,0,255);
const int	LIGHTGRAY	RGB(192,192,192);
const int	WHITE		RGB(255,255,255);

//////////////////////////////////////////////////////////////////////
const int char_w = 80;
const int char_h = 24;

class CEmulation  
{
public:
	CEmulation();
	virtual ~CEmulation();

protected :
//	static void initClass(CSecureShellView* parent);
//	static CSecureShellView* owner;
	static int width;
	static int height;
//	static int char_w;
//	static int char_h;
public :
	void scrolldown(int ScrollTop, int ScrollBottom);
	void scrollup(int ScrollTop, int ScrollBottom );
	void displaybytes(CByteArray* b, int len);
	void displaych(char c);
	void clearscreen();
	void clearcoord(int row1, int col1, int row2, int col2);
	int column;
	int row;
	int foreground;
	int background;

};

#endif // !defined(AFX_EMULATION_H__157F4263_E57D_11D2_BE7E_002018571AA5__INCLUDED_)
