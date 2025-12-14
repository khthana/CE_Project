//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXScreen Implementation ]
// Author:         [ Danny Farley - danny@jags.co.uk ]
// Contributions:  [ Chris Barnes, Paul Lord ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXScreen::CDXScreen()
{
	m_lpDD = NULL;
	m_lpDDSFront = NULL;
	m_lpDDSBack = NULL;
	m_lpDDPalette = NULL;
	m_lpClipper = NULL;
	m_ZBuffer = NULL;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXScreen::CDXScreen(void *hWnd, DWORD Width, DWORD Height, DWORD BPP, BOOL bVGA)
{
	CreateFullScreen(hWnd, Width, Height, BPP, bVGA);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXScreen::CDXScreen(void *hWnd, int Width, int Height)
{
	CreateWindowed(hWnd, Width, Height);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXScreen::~CDXScreen(void)
{
	if(m_lpDD != NULL) m_lpDD->RestoreDisplayMode();
	delete m_lpDDSBack;
	delete m_lpDDSFront;
	RELEASE(m_ZBuffer);
	RELEASE(m_lpClipper);
	RELEASE(m_lpDDPalette);
	RELEASE(m_lpDD);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen CreateWindowed
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXScreen::CreateWindowed(void *hWnd, int Width, int Height)
{
	HRESULT rval;
	DWORD dwFlags;
	DDSURFACEDESC ddsd;
	HDC hDC;

	m_lpDD = NULL;
	m_bFullScreen = FALSE;
	m_lpDDPalette = NULL;
	m_dwPixelWidth = Width;
	m_dwPixelHeight = Height;
	m_hWnd = hWnd;

	hDC = GetDC(NULL);
	m_BPP = GetDeviceCaps(hDC, PLANES) * GetDeviceCaps(hDC, BITSPIXEL);
	ReleaseDC(NULL, hDC);

	dwFlags = DDSCL_NORMAL;

	LPDIRECTDRAW lpDD;

	rval = DirectDrawCreate(NULL, &lpDD, NULL);
	if(rval != DD_OK) DDError(rval, hWnd);

	rval = lpDD->QueryInterface(IID_IDirectDraw2, (LPVOID*)&m_lpDD);
	if(rval != DD_OK) DDError(rval, hWnd);

	RELEASE(lpDD);

	rval = m_lpDD->SetCooperativeLevel(hWnd, dwFlags);
	if(rval != DD_OK) DDError(rval, hWnd);

	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_CAPS;
	ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;

	m_lpDDSFront = new CDXSurface();
	m_lpDDSBack = new CDXSurface();

	rval = m_lpDD->CreateSurface(&ddsd, &m_lpDDSFront->m_lpDDS, NULL);
	if(rval != DD_OK) DDError(rval, hWnd);

	ddsd.dwFlags = DDSD_CAPS | DDSD_WIDTH | DDSD_HEIGHT;    
	ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	ddsd.dwWidth = Width;
	ddsd.dwHeight = Height;

	rval = m_lpDD->CreateSurface( &ddsd, &m_lpDDSBack->m_lpDDS, NULL );
	if(rval != DD_OK) DDError(rval, hWnd);

	// Create the window clipper
	rval = m_lpDD->CreateClipper(0, &m_lpClipper, NULL);
	if(rval != DD_OK) DDError(rval, hWnd);

	rval = m_lpClipper->SetHWnd(0, hWnd);
	if(rval != DD_OK) DDError(rval, hWnd);

	rval = m_lpDDSFront->m_lpDDS->SetClipper(m_lpClipper);
	if(rval != DD_OK) DDError(rval, hWnd);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen CreateFullScreen
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXScreen::CreateFullScreen(void *hWnd, DWORD Width, DWORD Height, DWORD BPP, BOOL bVGA)
{
	HRESULT rval;
	DWORD dwFlags;
	DDSURFACEDESC ddsd;
	DDSCAPS ddscaps;

	m_lpDD = NULL;
	m_bFullScreen = TRUE;
	m_lpDDPalette = NULL;
	m_dwPixelWidth = Width;
	m_dwPixelHeight = Height;
	m_BPP = BPP;
	m_hWnd = hWnd;

	dwFlags = DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN | DDSCL_ALLOWREBOOT | DDSCL_ALLOWMODEX;

	LPDIRECTDRAW lpDD;

	rval = DirectDrawCreate(NULL, &lpDD, NULL);
	if(rval != DD_OK) DDError(rval, hWnd);

	rval = lpDD->QueryInterface(IID_IDirectDraw2, (LPVOID*)&m_lpDD);
	if(rval != DD_OK) DDError(rval, hWnd);

	RELEASE(lpDD);

	rval = m_lpDD->SetCooperativeLevel(hWnd, dwFlags);
	if(rval != DD_OK) DDError(rval, hWnd);

	if(bVGA) rval = m_lpDD->SetDisplayMode(m_dwPixelWidth, m_dwPixelHeight, m_BPP, 0, DDSDM_STANDARDVGAMODE);
	else rval = m_lpDD->SetDisplayMode(m_dwPixelWidth, m_dwPixelHeight, m_BPP, 0, 0);
	if(rval != DD_OK) DDError(rval, hWnd);

	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
	ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE |
												DDSCAPS_FLIP |
												DDSCAPS_COMPLEX;
	ddsd.dwBackBufferCount = 1;

	m_lpDDSFront = new CDXSurface;
	m_lpDDSBack = new CDXSurface;

	rval = m_lpDD->CreateSurface(&ddsd, &m_lpDDSFront->m_lpDDS, NULL);
	if(rval != DD_OK) DDError(rval, hWnd);

	ddscaps.dwCaps = DDSCAPS_BACKBUFFER;

	rval = m_lpDDSFront->m_lpDDS->GetAttachedSurface(&ddscaps, &m_lpDDSBack->m_lpDDS);
	if(rval != DD_OK) DDError(rval, hWnd);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Flip - swaps the front and back buffers
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXScreen::Flip(void)
{
	HRESULT rval;

	if(m_bFullScreen)
	{
		rval = m_lpDDSFront->m_lpDDS->Flip(NULL, DDFLIP_WAIT);
		if(rval == DDERR_SURFACELOST) Restore();
	}
	else
	{
		RECT Window;
		POINT pt;

		GetClientRect(m_hWnd, &Window);
		pt.x = pt.y = 0;
		ClientToScreen(m_hWnd, &pt);
		OffsetRect(&Window, pt.x, pt.y);

		rval = m_lpDDSFront->m_lpDDS->Blt(&Window, m_lpDDSBack->m_lpDDS, NULL, DDBLT_WAIT, NULL);
		if(rval == DDERR_SURFACELOST) Restore();
	}

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Fill - fills the back buffer with a colour
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::Fill(DWORD FillColor)
{
	DDBLTFX ddBltFx;

	ddBltFx.dwSize = sizeof(DDBLTFX);
	ddBltFx.dwFillColor = FillColor;
	m_lpDDSBack->m_lpDDS->Blt(NULL, NULL, NULL, DDBLT_WAIT | DDBLT_COLORFILL, &ddBltFx);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen LoadBitmap - loads a bitmap straight onto the back buffer
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXScreen::LoadBitmap(const char* szFilename)
{
	if(szFilename == NULL) return FALSE;
  if(DDReLoadBitmap(m_lpDDSBack->m_lpDDS, szFilename) != DD_OK) return FALSE;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen LoadPalette - loads a palette from a bitmap file
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXScreen::LoadPalette(const char* szFilename)
{
	if(szFilename == NULL) return FALSE;
	m_lpDDPalette = DDLoadPalette(m_lpDD, szFilename);
	if(m_lpDDPalette == NULL) return FALSE;
  m_lpDDSFront->m_lpDDS->SetPalette(m_lpDDPalette);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen Restore - restores the front buffer if it is lost
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::Restore(void)
{
  if(m_lpDDSFront->m_lpDDS != NULL && m_lpDDSFront->m_lpDDS->IsLost() != DD_OK)
  {
    m_lpDDSFront->m_lpDDS->Restore();
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen SetColor - sets the r,g,b value of a single color
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::SetColor(int col, int r, int g, int b)
{
	PALETTEENTRY pe[1];

	m_lpDDPalette->GetEntries(0, col, 1, pe);
	pe[0].peRed = r;
	pe[0].peGreen = g;
	pe[0].peBlue = b;
	m_lpDDPalette->SetEntries(0, col, 1, pe);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen GetColor - returns the r,g,b values of a single color
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::GetColor(int col, int *r, int *g, int *b)
{
	PALETTEENTRY pe[1];

	m_lpDDPalette->GetEntries(0, col, 1, pe);
	*r = pe[0].peRed;
	*g = pe[0].peGreen;
	*b = pe[0].peBlue;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen SetPalette - sets the palette
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::SetPalette(int Start, int Count, LPPALETTEENTRY lpPE)
{
	m_lpDDPalette->SetEntries(0, Start, Count, lpPE);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen GetPalette - returns the palette
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::GetPalette(int Start, int Count, LPPALETTEENTRY lpPE)
{
	m_lpDDPalette->GetEntries(0, Start, Count, lpPE);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen FillPalette - sets the whole palette to one color
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::FillPalette(int r, int g, int b)
{
	PALETTEENTRY pe[256];

	m_lpDDPalette->GetEntries(0, 0, 256, pe);

	for(int i = 1; i < 256; i++)
	{
		pe[i].peRed = r;
		pe[i].peGreen = g;
		pe[i].peBlue = b;
	}
	m_lpDDPalette->SetEntries(0, 0, 256, pe);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen GrayScale - converts the palette to monochrome
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::GreyScale(void)
{
	PALETTEENTRY pe[256];
	int total, grey;

	m_lpDDPalette->GetEntries(0, 0, 256, pe);

	for(int i = 1; i < 256; i++)
	{
		total = pe[i].peRed + pe[i].peGreen + pe[i].peBlue;
		grey = total / 3;

		pe[i].peRed = grey;
		pe[i].peGreen = grey;
		pe[i].peBlue = grey;
	}
	m_lpDDPalette->SetEntries(0, 0, 256, pe);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen FadeIn - smoothly fades to the specified palette
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::FadeIn(int delay, LPPALETTEENTRY lpPE)
{
	PALETTEENTRY pe[256];

	m_lpDDPalette->GetEntries(0, 0, 256, pe);

	for(int j = 1; j < 84; j++)
	{
		for(int i = 1; i < 256; i++)
		{
			// Red
			if(pe[i].peRed > (lpPE[i].peRed+5)) pe[i].peRed -= 3;
			else if(pe[i].peRed < (lpPE[i].peRed-5)) pe[i].peRed += 3;
			else pe[i].peRed = lpPE[i].peRed;

			// Green
			if(pe[i].peGreen > (lpPE[i].peGreen+5)) pe[i].peGreen -= 3;
			else if(pe[i].peGreen < (lpPE[i].peGreen-5)) pe[i].peGreen += 3;
			else pe[i].peGreen = lpPE[i].peGreen;

			// Blue
			if(pe[i].peBlue > (lpPE[i].peBlue+5)) pe[i].peBlue -= 3;
			else if(pe[i].peBlue < (lpPE[i].peBlue-5)) pe[i].peBlue += 3;
			else pe[i].peBlue = lpPE[i].peBlue;

			// Add a delay here for slower fades
			for(long d = 0; d < delay*100; d++) ;
		}
		m_lpDDPalette->SetEntries(0, 0, 256, pe);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen FadeOut - fades to black, about 0-10 for the delay is usual
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::FadeOut(int delay)
{
	PALETTEENTRY pe[256];

	m_lpDDPalette->GetEntries(0, 0, 256, pe);

	for(int j = 1; j < 84; j++)
	{
		for(int i = 1; i < 256; i++)
		{
			// Red
			if(pe[i].peRed > 5) pe[i].peRed -= 3;
			else pe[i].peRed = 0;

			// Green
			if(pe[i].peGreen > 5) pe[i].peGreen -= 3;
			else pe[i].peGreen = 0;

			// Blue
			if(pe[i].peBlue > 5) pe[i].peBlue -= 3;
			else pe[i].peBlue = 0;

			// Add a delay here for slower fades
			for(long d = 0; d < delay*100; d++) ;
		}
		m_lpDDPalette->SetEntries(0, 0, 256, pe);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXScreen FadeTo - fades to a specified color
//////////////////////////////////////////////////////////////////////////////////
void CDXScreen::FadeTo(int r, int g, int b, int delay)
{
	PALETTEENTRY pe[256];

	m_lpDDPalette->GetEntries(0, 0, 256, pe);

	for(int j = 1; j < 84; j++)
	{
		for(int i = 1; i < 256; i++)
		{
			// Red
			if(pe[i].peRed > r+5) pe[i].peRed -= 3;
			else if(pe[i].peRed < r-5) pe[i].peRed += 3;
			else pe[i].peRed = r;

			// Green
			if(pe[i].peGreen > g+5) pe[i].peGreen -= 3;
			else if(pe[i].peGreen < g-5) pe[i].peGreen += 3;
			else pe[i].peGreen = g;

			// Blue
			if(pe[i].peBlue > b+5) pe[i].peBlue -= 3;
			else if(pe[i].peBlue < b-5) pe[i].peBlue += 3;
			else pe[i].peBlue = b;

			// Add a delay here for slower fades
			for(long d = 0; d < delay*100; d++) ;
		}
		m_lpDDPalette->SetEntries(0, 0, 256, pe);
	}
}
