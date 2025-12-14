/////////////////////////////////////////////////////////////////////////////
// File Name:	DX_Surface.cpp
// Author:		Tiwakorn Komut
// Source File:	DX_Surface Implementation
// Date:		14/02/2000
/////////////////////////////////////////////////////////////////////////////
#include "DX.h"

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Constructor
/////////////////////////////////////////////////////////////////////////////
DX_Surface::DX_Surface (void)
{
	Initialise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Destructor
/////////////////////////////////////////////////////////////////////////////
DX_Surface::~DX_Surface (void)
{
	Finalise ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Initialise
/////////////////////////////////////////////////////////////////////////////
void DX_Surface::Initialise (void)
{
	m_Surface = NULL;
	m_Font = NULL;
	m_Filename = NULL;

	ZeroMemory (&m_Desc, sizeof (DDSURFACEDESC));
	m_Desc.dwSize = sizeof (DDSURFACEDESC);

	m_Width = 0;
	m_Height = 0;
	SetRect (&m_SrcRect, 0, 0, 0, 0);
	SetRect (&m_DestRect, 0, 0, 0, 0);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Finalise
/////////////////////////////////////////////////////////////////////////////
void DX_Surface::Finalise (void)
{
	DeleteObject (m_Font);
	SAFE_RELEASE (m_Surface);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Create
// Desc: Create Primary Surface
//		 It necessary  to set m_Desc before call this method
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Create (DX_Screen* engine)
{
	HRESULT rval;

	Finalise ();

	// Create the surface
	if (FAILED (rval = engine->GetDD ()->CreateSurface (&m_Desc, &m_Surface, NULL)))
		return rval;

	if (FAILED (rval = m_Surface->GetSurfaceDesc (&m_Desc)))
		return rval;

	// Initialise some variables
	m_Width = m_Desc.dwWidth;
	m_Height = m_Desc.dwHeight;
	SetRect (&m_SrcRect, 0, 0, m_Width, m_Height);
	SetRect (&m_DestRect, 0, 0, m_Width, m_Height);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Create
// Desc: Create Off-Screen Surface
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Create (DX_Screen* engine, int width, int height)
{
	Finalise ();
	Initialise ();

	// Initialiese some variables
	m_Width = width;
	m_Height = height;
	SetRect (&m_SrcRect, 0, 0, m_Width, m_Height);
	SetRect (&m_DestRect, 0, 0, m_Width, m_Height);

	// Set the surface description
	m_Desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
	m_Desc.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	m_Desc.dwWidth = m_Width;
	m_Desc.dwHeight = m_Height;

	// Create the surface
	return engine->GetDD ()->CreateSurface (&m_Desc, &m_Surface, NULL);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface LoadBitmap
// Desc: Crate Off-Screen from bitmap file
//       and load bit map file's content into this surface
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::LoadBitmap (DX_Screen* engine, const char* filename)
{
	HRESULT rval;
	HBITMAP hbm;
	BITMAP bm;

	Finalise ();
	Initialise ();

	// Try to load bitmap from a resource
	hbm = (HBITMAP)LoadImage (GetModuleHandle (NULL), filename, IMAGE_BITMAP, 0, 0, LR_CREATEDIBSECTION);

	// Try to load the bitmap from a file
	if (hbm == NULL)
		hbm = (HBITMAP)LoadImage (NULL, filename, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE | LR_CREATEDIBSECTION);

	if (hbm == NULL)
		return E_FAIL;

	// Get the size of the bitmap
	GetObject (hbm, sizeof (bm), &bm);

	// Create a DirectDrawSurface for this bitmap
	m_Desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
	m_Desc.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	m_Desc.dwWidth = bm.bmWidth;
	m_Desc.dwHeight = bm.bmHeight;

	if (FAILED (rval = engine->GetDD ()->CreateSurface (&m_Desc, &m_Surface, NULL)))
		return rval;

	CopyBitmap (hbm, 0, 0, 0, 0);
	DeleteObject (hbm);

	// Initialise some variables
	m_Filename = filename;
	m_Width = m_Desc.dwWidth;
	m_Height = m_Desc.dwHeight;
	SetRect (&m_SrcRect, 0, 0, m_Width, m_Height);
	SetRect (&m_DestRect, 0, 0, m_Width, m_Height);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface CopyBitmap
// Desc: Copy content of bitmap file onto surface
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::CopyBitmap (HBITMAP hbm, int x, int y, int dx, int dy)
{
	HDC Image;
	HDC hdc;
	BITMAP bm;
	HRESULT rval;

	if (hbm == NULL || m_Surface == NULL)
		return E_FAIL;

	// Make sure this surface is restored
	m_Surface->Restore ();

	// Select bitmap into a MemoryDC so we can use it
	Image = CreateCompatibleDC (NULL);
	if (!Image)
		return E_FAIL;
	SelectObject (Image, hbm);

	// Get size of the bitmap
	GetObject (hbm, sizeof (bm), &bm);
	dx = dx == 0 ? bm.bmWidth : dx;
	dy = dy == 0 ? bm.bmHeight : dy;

	// Get size of surface
	m_Desc.dwSize = sizeof (DDSURFACEDESC);
	m_Desc.dwFlags = DDSD_HEIGHT | DDSD_WIDTH;
	m_Surface->GetSurfaceDesc (&m_Desc);

	rval = m_Surface->GetDC (&hdc);
	if (rval == DD_OK)
	{
		StretchBlt (hdc, 0, 0, m_Desc.dwWidth, m_Desc.dwHeight, Image, x, y, dx, dy, SRCCOPY);
		m_Surface->ReleaseDC (hdc);
	}

	DeleteDC (Image);

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Restore
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Restore (void)
{
	return m_Surface->Restore ();
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Lock
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Lock (void)
{
	ZeroMemory (&m_Desc, sizeof (DDSURFACEDESC));
	m_Desc.dwSize = sizeof (DDSURFACEDESC);
	return m_Surface->Lock (NULL, &m_Desc, DDLOCK_WAIT, NULL);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface UnLock
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::UnLock (void)
{
	return m_Surface->Unlock (NULL);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Fill
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Fill (DWORD color)
{
	DDBLTFX bltfx;

	bltfx.dwSize = sizeof (DDBLTFX);
	bltfx.dwFillColor = color;
	return m_Surface->Blt (NULL, NULL, NULL, DDBLT_WAIT | DDBLT_COLORFILL, &bltfx);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface SetColorKey
// Desc: Set to black color key
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::SetColorKey (void)
{
	DDCOLORKEY ddck;
	
	// Set transparent range
	ddck.dwColorSpaceLowValue = 0;
	ddck.dwColorSpaceHighValue = 0;
	
	return m_Surface->SetColorKey (DDCKEY_SRCBLT, &ddck);
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface SetFont
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::SetFont (const char* FontName, int Width, int Height, int Attributes)
{
	m_Font = CreateFont (Height, Width,
						 0, 0,
						 Attributes,
						 FALSE,
						 FALSE,
						 FALSE,
						 ANSI_CHARSET,
						 OUT_DEFAULT_PRECIS,
						 CLIP_DEFAULT_PRECIS,
						 NONANTIALIASED_QUALITY,
						 VARIABLE_PITCH,
						 FontName);

	if (m_Font == NULL)
		return E_FAIL;
	else 
		return S_OK;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Screen TextXY
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::TextXY (int x, int y, COLORREF col, const char* pString)
{
	HDC hdc;
	HRESULT rval;

	if (FAILED (rval = m_Surface->GetDC (&hdc)))
		return rval;

	SelectObject (hdc, m_Font);
	SetBkMode (hdc, TRANSPARENT);
	SetTextColor (hdc, col);
	if (!TextOut (hdc, x, y, pString, strlen (pString)))
	{
		m_Surface->ReleaseDC (hdc);
		return E_FAIL;
	}

	// Release DC and return value
	m_Surface->ReleaseDC (hdc);
	return DD_OK;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface Draw
// Desc: Use Blit
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::Draw (DX_Surface* Dest, DWORD Flags)
{
	HRESULT rval;

	rval = Dest->m_Surface->Blt (&m_DestRect, m_Surface, &m_SrcRect, Flags, NULL);
	if (rval == DDERR_SURFACELOST)
		Restore ();

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface DrawFast
// Desc: Use BltFast
/////////////////////////////////////////////////////////////////////////////
HRESULT DX_Surface::DrawFast (int X, int Y, DX_Surface* Dest, DWORD Flags)
{
	HRESULT rval;

	rval = Dest->m_Surface->BltFast (X, Y, m_Surface, &m_SrcRect, Flags);
	if (rval == DDERR_SURFACELOST)
		Restore ();

	return rval;
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface SetSrc
/////////////////////////////////////////////////////////////////////////////
void DX_Surface::SetSrc (int x, int y, int width, int height)
{
	// Get Width and Height of m_SrcRect
	int w = m_SrcRect.right - m_SrcRect.left;
	int h = m_SrcRect.bottom - m_SrcRect.top;

	// Edit m_SrcRect
	m_SrcRect.left = x;
	m_SrcRect.top = y;

	if (width == 0 && height == 0)
	{
		m_SrcRect.right = x + w;
		m_SrcRect.bottom = y + h;
	}
	else
	{
		m_SrcRect.right = x + width;
		m_SrcRect.bottom = y + height;
	}
}

/////////////////////////////////////////////////////////////////////////////
// DX_Surface SetDest
/////////////////////////////////////////////////////////////////////////////
void DX_Surface::SetDest (int x, int y, int width, int height)
{
	// Get Width and Height of m_DestRect
	int w = m_DestRect.right - m_DestRect.left;
	int h = m_DestRect.bottom - m_DestRect.top;

	// Edit m_DestRect
	m_DestRect.left = x;
	m_DestRect.top = y;

	if (width == 0 && height == 0)
	{
		m_DestRect.right = x + w;
		m_DestRect.bottom = y + h;
	}
	else
	{
		m_DestRect.right = x + width;
		m_DestRect.bottom = y + height;
	}
}