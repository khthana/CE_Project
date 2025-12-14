// VT100.h: interface for the CVT100 class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_VT100_H__157F4262_E57D_11D2_BE7E_002018571AA5__INCLUDED_)
#define AFX_VT100_H__157F4262_E57D_11D2_BE7E_002018571AA5__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
#include "Emulation.h"


class CVT100  : public CEmulation
{
public:
	void changecolor();
	void cleararray();
	void clearcoord(int row1, int col1, int row2, int col2);
	void clearscreen();
	void scrollup(int top, int bottom);
	void translate(char c);
	void displaych(char c);
	void displaybytes(CByteArray* b,int len);
	void clearArray();
	CVT100();
	virtual ~CVT100();
	
//	int	column;
//	int	row;
//	int	foreground;
//	int	background;

protected: 
/*	static int width;
	static int height;
	static int char_w;
	static int char_h;
*/
private :
	int		color[16];
	char	CharArray[char_w][char_h];
	int		Foregnd[char_w][char_h];
	int		Backgnd[char_w][char_h];
	int		currentForeground ;
	int		currentBackground ;

	int		HoldFore;
	int		HoldBack;
	BOOL escapeon;
	int Parameter;
	int Value[10];

	int ScrollTop;
	int ScrollBottom;
	int columnhold;
	int rowhold;
	BOOL brighthold;
	BOOL inversehold;
	BOOL firstchar;
	BOOL bracket;
	BOOL bright;
	BOOL inverse;
	int Foresave;
	int Backsave;


};

#endif // !defined(AFX_VT100_H__157F4262_E57D_11D2_BE7E_002018571AA5__INCLUDED_)
