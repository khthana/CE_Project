#ifndef _Bubble_DirectDraw_
#define _Bubble_DirectDraw_

#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>
#include <ddutil.h>
//#define BLOCK_WIDE	34 //pixel
//#define BLOCK_HIGH	34 //pixel

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
	BOOL	blt_yet;
	void init_var();	// initial all variable before use
	void DestroyDD();	// Destroy all DirectDraw relate
	HRESULT RestoreAll();	// Restore all lost surface


	int currentx,currenty;	//position of current scroll
public:
	CBubbleDD(HWND _hwnd, int _width, int _height, int _bpp);
	~CBubbleDD();

	BOOL init_success();	// question is init DirectDraw success

//	void Char2Buffer(int _x, int _y, const CHAR_BASE &_c);
	
//	void BltBuffer2Back();
	void Flip();

	void BltSource2Buffer();
	void Scrollingx(int step);
	void Scrollingy(int step);
	void BltBuffer2Back4Part();
	void BltSource2Back(int x,int y,int left,int top ,int right ,int bottom );
};

#endif 