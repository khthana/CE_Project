#ifndef _Bubble_DirectDraw_
#define _Bubble_DirectDraw_

#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>
#include "usr_type.h"

#define BLOCK_WIDE	34 //pixel
#define BLOCK_HIGH	34 //pixel

class CBubbleDD
{
private:
	LPDIRECTDRAW		lpDD;			// DirectDraw Object
	LPDIRECTDRAWSURFACE	lpDDSPrimary;	// DirectDraw Primary Surface
	LPDIRECTDRAWSURFACE	lpDDSBack;		// DirectDraw Back Buffer
	LPDIRECTDRAWSURFACE lpDDSBuffer;	// Third Buffer, size equal Back Buffer
	LPDIRECTDRAWSURFACE	lpDDSSource;	// Offscreen Surface for source Bitmap
	LPDIRECTDRAWPALETTE	lpDDPallete;	// DirectDraw palette

	HRESULT init_value;	// initial DirectDraw last result

	int width, height, bpp;

	void init_var();	// initial all variable before use

	void DestroyDD();	// Destroy all DirectDraw relate
	HRESULT RestoreAll();	// Restore all lost surface

	void BltSrc2Back(int _x,int _y,int _top,int _bottom,int _left ,int _right);
	void BltSrc2Buffer(int _x,int _y,int _top,int _bottom,int _left ,int _right);

public:
	CBubbleDD(HWND _hwnd, int _width, int _height, int _bpp);
	~CBubbleDD();

	BOOL InitSuccess();	// question is init DirectDraw success

	void Char2Buffer(int _x, int _y, const CHAR_BASE &_c);
	void BltBuffer2Back();

	void OnlyChar2Back(int _x, int _y, int _limit_top, const CHAR_BASE &_c);

	void BoomNum( int x,int y ,int boom_num);

	void Flip();
};

#endif 