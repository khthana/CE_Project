/////////////////////////////////////////////////////////////////////////////
// File Name:	DX.h
// Author:		Tiwakorn Komut
// Source File:	Main Header File
// Date:		15/03/2000
// Comment:		Concept from CDX Library 1.6
//				Microsoft DirectX SDK 6.0
/////////////////////////////////////////////////////////////////////////////
#ifndef DX_H
#define DX_H

#include <stdio.h>
#include <d3drm.h>

/////////////////////////////////////////////////////////////////////////////
// Defined Types
/////////////////////////////////////////////////////////////////////////////
// macros
#define SAFE_RELEASE(x)		if (x != NULL) { x->Release(); x = NULL; }
#define SAFE_DELETE(x)		if (x != NULL) { delete x; x = NULL; }
#define MSG(hwnd, msg)		MessageBox (hwnd, msg, "Application Message", MB_OK)

// Application constants
#define MAX_D3DDRIVERS		5			// max Direct3D drivers
#define MAX_DDDRIVERS		5			// max DirectDraw drivers
#define MAX_MODES			40			// max Display modes
#define MAX_MODEWIDTH		1024		// max display mode width that application allow
#define MAX_MODEHEIGHT		768			// max display mode height that application allow
#define MIN_BPP				16			// min display mode bpp that application allow
#define DEFAULT_WIDTH		640			// display mode Width that choosed as default
#define DEFAULT_HEIGHT		480			// display mode Height that choosed as default
#define DEFAULT_BPP			16			// display mode BPP that choosed as default
#define VALUE_ERROR			-10			// error value
#define VALUE_YOUDECIDE		-20			// choosed automatically by application

/////////////////////////////////////////////////////////////////////////////
// DX_Surface
/////////////////////////////////////////////////////////////////////////////
class DX_Surface
{
public:
// Methods
	DX_Surface (void);									// Constructor
	~DX_Surface (void);									// Destructor

	void Initialise (void);								// Init class
	void Finalise (void);								// Clean class

	HRESULT Create (LPDIRECTDRAW);						// Create primary surface by m_Desc
	HRESULT Create (LPDIRECTDRAW, int, int);			// Create pure Off-Screen
	HRESULT LoadBitmap (LPDIRECTDRAW, const char*);	// Create Off-Screen from bitmap
														// and copy content of bitmap onto it
	HRESULT CopyBitmap (HBITMAP, int, int, int, int);
	HRESULT Restore (void);
	HRESULT Lock (void);								// Lock surface and fill in m_Desc
	HRESULT UnLock (void);								// Un-lock surface
	HRESULT Fill (DWORD);								// Fill color into surface
	HRESULT SetColorKey (void);							// Set to black color key
	HRESULT SetFont (const char*, int, int, int Attributes = FW_NORMAL);	
														// Set font
	HRESULT TextXY (int X, int Y, COLORREF, const char*);	
														// Draw text
	virtual HRESULT Draw (LPDIRECTDRAWSURFACE Dest, DWORD flags);	
														// Blit
	virtual HRESULT DrawFast (int X, int Y, LPDIRECTDRAWSURFACE Dest, DWORD flags);
														// Blit fast
	void SetSrc (int x, int y, int width = 0, int height = 0);
	void SetDest (int x, int y, int width = 0, int height = 0);
	int GetWidth (void)		{ return m_Width; }
	int GetHeight (void)	{ return m_Height; }
	LPDIRECTDRAWSURFACE GetSurface (void)	{ return m_Surface; }

public:
// Attributes
	LPDIRECTDRAWSURFACE		m_Surface;
	DDSURFACEDESC			m_Desc;
	DDSCAPS					m_Caps;

	int						m_Width;					// Width of surface
	int						m_Height;					// Height of surface
	RECT					m_SrcRect;					// Rect that describe source surface
	RECT					m_DestRect;					// Rect that describe dest surface
	HFONT					m_Font;						// Font handle
	const char*				m_Filename;					// Name of BMP file that has been loaded
};

#endif