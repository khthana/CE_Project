//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXSurface Implementation ]
// Author:         [ Danny Farley - danny@jags.co.uk ]
// Contributions:  [ Chris Barnes, Bil Simser ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"
#include "math.h"

const float PI = 3.1415927;

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSurface::CDXSurface(void)
{
	m_lpDDS = NULL;
	m_DC = NULL;
	m_Font = NULL;
	Screen = NULL;

	m_ColorKey = -1;
	DestRect.top = 0;
	DestRect.left = 0;
	DestRect.bottom = 0;
	DestRect.right = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSurface::CDXSurface(CDXScreen *pScreen, int Width, int Height)
{
	Create(pScreen, Width, Height);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSurface::CDXSurface(CDXScreen *pScreen, const char *szFilename)
{
	Create(pScreen, szFilename);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXSurface::~CDXSurface()
{
	RELEASE(m_lpDDS);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Create
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSurface::Create(CDXScreen *pScreen, int Width, int Height)
{
	HRESULT rval;

	ZeroMemory(&m_DDSD, sizeof(m_DDSD));
	m_DDSD.dwSize = sizeof(m_DDSD);
	m_DDSD.dwFlags = DDSD_CAPS | DDSD_HEIGHT |DDSD_WIDTH;
	m_DDSD.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	m_DDSD.dwWidth = Width;
	m_DDSD.dwHeight = Height;

	rval = pScreen->m_lpDD->CreateSurface(&m_DDSD, &m_lpDDS, NULL);
	if(rval != DD_OK)
	{
		DDError(rval, pScreen->m_hWnd);
		return FALSE;
	}

	m_DC = NULL;
	m_Font = NULL;
	m_pFilename = NULL;
	Screen = pScreen;
	m_ColorKey = -1;

	m_PixelWidth = Width;
	m_PixelHeight = Height;

	DestRect.top = 0;
	DestRect.left = 0;
	DestRect.bottom = m_PixelHeight;
	DestRect.right = m_PixelWidth;

	SrcRect.top = 0;
	SrcRect.left = 0;
	SrcRect.bottom = m_PixelHeight;
	SrcRect.right = m_PixelWidth;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Create
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSurface::Create(CDXScreen *pScreen, const char *szFilename)
{
	if(szFilename == NULL) return FALSE;

  m_lpDDS = DDLoadSizeBitmap(pScreen->m_lpDD, szFilename, &m_PixelWidth, &m_PixelHeight);
	if(m_lpDDS == NULL) return FALSE;

	m_DC = NULL;
	m_Font = NULL;
	m_pFilename = szFilename;
	Screen = pScreen;
	m_ColorKey = -1;

	DestRect.top = 0;
	DestRect.left = 0;
	DestRect.bottom = m_PixelHeight;
	DestRect.right = m_PixelWidth;

	SrcRect.top = 0;
	SrcRect.left = 0;
	SrcRect.bottom = m_PixelHeight;
	SrcRect.right = m_PixelWidth;
	
	ZeroMemory(&m_DDSD, sizeof(m_DDSD));
	m_DDSD.dwSize = sizeof(m_DDSD);
	m_DDSD.dwFlags = DDSD_CAPS | DDSD_HEIGHT |DDSD_WIDTH;
	m_DDSD.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	m_DDSD.dwWidth = m_PixelWidth;
	m_DDSD.dwHeight = m_PixelHeight;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Draw
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::Draw(CDXSurface* lpDDest)
{
	HRESULT rval;

  rval = lpDDest->m_lpDDS->Blt(&DestRect, m_lpDDS, &SrcRect, DDBLT_WAIT, NULL);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawFast
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawFast(int X, int Y, CDXSurface* lpDDest)
{
	HRESULT rval;

	rval = lpDDest->m_lpDDS->BltFast(X, Y, m_lpDDS, &SrcRect, DDBLTFAST_WAIT);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawTrans
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawTrans(int X, int Y, CDXSurface* lpDDest)
{
	HRESULT rval;

	rval = lpDDest->m_lpDDS->BltFast(X, Y, m_lpDDS, &SrcRect, DDBLTFAST_WAIT | DDBLTFAST_SRCCOLORKEY);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawClipped
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawClipped(int X, int Y, CDXSurface* lpDDest, LPRECT ClipRect)
{
	HRESULT rval;
	RECT ModSrc = SrcRect;
	Clip(&X, &Y, &ModSrc, ClipRect);

	rval = lpDDest->m_lpDDS->BltFast(X, Y, m_lpDDS, &ModSrc, DDBLTFAST_WAIT | DDBLTFAST_SRCCOLORKEY);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawWindowed
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawWindowed(CDXSurface* lpDDest)
{
	HRESULT rval;
	RECT Window;
	GetClientRect(Screen->m_hWnd, &Window);
	ClientToScreen(Screen->m_hWnd, (LPPOINT)&Window);
	ClientToScreen(Screen->m_hWnd, (LPPOINT)&Window+1);

	rval = lpDDest->m_lpDDS->Blt(&Window, m_lpDDS, NULL, DDBLT_WAIT, NULL);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawScaled
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawScaled(int X, int Y, float Factor, CDXSurface* lpDDS)
{
	HRESULT rval;

	DestRect.top = Y;
	DestRect.left = X;
	DestRect.bottom = (Y + m_PixelHeight) * Factor;
	DestRect.right = (X + m_PixelWidth) * Factor;

  rval = lpDDS->m_lpDDS->Blt(&DestRect, m_lpDDS, &SrcRect, DDBLT_WAIT | DDBLT_KEYSRC, NULL);
	if(rval == DDERR_SURFACELOST) Restore();

	return rval;
}

#define DEG2RAD(x) (x*(float)PI/(float)180)

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawRotated
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::DrawRotated(int X, int Y, double Angle, CDXSurface* Dest)
{
	// NOT IMPLEMENTED
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawHFlip
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawHFlip(int X, int Y, CDXSurface* Dest)
{
	DDBLTFX ddBltFx;

	ddBltFx.dwSize = sizeof(DDBLTFX);
	ddBltFx.dwDDFX = DDBLTFX_MIRRORLEFTRIGHT;
	return m_lpDDS->Blt(NULL, NULL, NULL, DDBLT_DDFX | DDBLT_WAIT, &ddBltFx);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface DrawVFlip
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::DrawVFlip(int X, int Y, CDXSurface* Dest)
{
	DDBLTFX ddBltFx;

	ddBltFx.dwSize = sizeof(DDBLTFX);
	ddBltFx.dwDDFX = DDBLTFX_MIRRORUPDOWN;
	return m_lpDDS->Blt(NULL, NULL, NULL, DDBLT_DDFX | DDBLT_WAIT, &ddBltFx);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface SetDest
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::SetDest(int t, int l, int b, int r)
{
	DestRect.top = t;
	DestRect.left = l;
	DestRect.bottom = b;
	DestRect.right = r;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface SetSrc
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::SetSrc(int t, int l, int b, int r)
{
	SrcRect.top = t;
	SrcRect.left = l;
	SrcRect.bottom = b;
	SrcRect.right = r;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface ColorKey
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::ColorKey(int col)
{
	DDCOLORKEY ddck;

	m_ColorKey = col;
	ddck.dwColorSpaceLowValue = col;
	ddck.dwColorSpaceHighValue = col;

	m_lpDDS->SetColorKey(DDCKEY_SRCBLT, &ddck);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Restore
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::Restore(void)
{
	m_lpDDS->Restore();
	DDReLoadBitmap(m_lpDDS, m_pFilename);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Lock
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::Lock(void)
{
	ZeroMemory(&m_DDSD, sizeof(m_DDSD));
	m_DDSD.dwSize = sizeof(m_DDSD);
	return m_lpDDS->Lock(NULL, &m_DDSD, DDLOCK_WAIT, NULL);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface UnLock
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSurface::UnLock(void)
{
	return m_lpDDS->Unlock(&m_DDSD);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface GetDC
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::GetDC()
{
	m_lpDDS->GetDC(&m_DC);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface ReleaseDC
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::ReleaseDC()
{
	m_lpDDS->ReleaseDC(m_DC);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface ChangeFont
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::ChangeFont(const char* FontName, int Width, int Height, int Attributes)
{
	m_Font = CreateFont(Height, Width,
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
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface SelectFont
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::SetFont(void)
{
	SelectObject(m_DC, m_Font);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface TextOut
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::TextXY(int x, int y, COLORREF col, LPCTSTR pString)
{
	SetBkMode(m_DC, TRANSPARENT);
	SetTextColor(m_DC, col);
	TextOut(m_DC, x, y, pString, strlen(pString));
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface PutPixel
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::PutPixel(int X, int Y, int Col)
{
	BYTE *Bitmap = (BYTE*)m_DDSD.lpSurface;
	Bitmap[Y * m_DDSD.lPitch + X] = Col;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface GetPixel
//////////////////////////////////////////////////////////////////////////////////
int CDXSurface::GetPixel(int X, int Y)
{
	BYTE *Bitmap = (BYTE*)m_DDSD.lpSurface;
	return Bitmap[Y * m_DDSD.lPitch + X];
}

//////////////////////////////////////////////////////////////////////////////////
// Swap - swaps two integers
//////////////////////////////////////////////////////////////////////////////////
void Swap(int *a, int *b)
{
	int Temp = *a;
	*a = *b;
	*b = Temp;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Rect
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::Rect(int X1, int Y1, int X2, int Y2, int Col)
{
	int i;
 
	for( i = X1; i < X2; i++ )
	{
		PutPixel( i, Y1, Col );
		PutPixel( i, Y2, Col );
	}

	for( i = Y1; i < Y2; i++ )
	{
		PutPixel( X1, i, Col );
		PutPixel( X2, i, Col );
	}
 
	PutPixel( X1, Y1, Col );
	PutPixel( X2, Y2, Col );
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface FillRect
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::FillRect(int X1, int Y1, int X2, int Y2, int Col)
{
	DDBLTFX ddbltfx;
	RECT Rect = { X1, Y1, X2, Y2 };
	
	ddbltfx.dwSize = sizeof(ddbltfx);
	ddbltfx.dwFillColor = Col;

	m_lpDDS->Blt(&Rect, NULL, NULL, DDBLT_WAIT | DDBLT_COLORFILL, &ddbltfx);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Line
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::Line(int X1, int Y1, int X2, int Y2, int Col)
{
	double xStep, yStep, X, Y;
	int xLength, yLength, xCount, yCount;

	xLength = abs(X2 - X1);
	yLength = abs(Y2 - Y1);

	if(xLength == 0) VLine(Y1, Y2, X1, Col);
	else if(yLength == 0) HLine(X1, X2, Y1, Col);

	else if(xLength > yLength)
	{
		if(X1 > X2)
		{
			Swap(&X1, &X2);
			Swap(&Y1, &Y2);
		}

		yStep = (double)(Y2 - Y1) / (double)(X2 - X1);
		Y = Y1;

		for(xCount = X1; xCount <= X2; xCount++)
		{
			PutPixel(xCount, (int)Y, Col);
			Y += yStep;
		}
	}
	else
	{
		if(Y1 > Y2)
		{
			Swap(&X1, &X2);
			Swap(&Y1, &Y2);
		}

		xStep = (double)(X2 - X1) / (double)(Y2 - Y1);
		X = X1;

		for(yCount = Y1; yCount <= Y2; yCount++)
		{
			PutPixel((int)X, yCount, Col);
			X += xStep;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface VLine
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::VLine(int Y1, int Y2, int X, int Col)
{
	BYTE *Bitmap = (BYTE*)m_DDSD.lpSurface;

	for( int i = Y1; i < Y2; i++ )
		Bitmap[i * m_DDSD.lPitch + X] = Col;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface HLine
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::HLine(int X1, int X2, int Y, int Col)
{
	for(int i = X1; i < X2; i++)
		PutPixel(i, Y, Col);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Circle
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::Circle(int X, int Y, int Radius, int Col)
{
	int iX, iY;
	float Angle;

	for (Angle = 0; Angle < 2*PI; Angle+= PI/180) 
	{
		iX = X + ((float)Radius * cos(Angle));
		iY = Y + ((float)Radius * sin(Angle));
		PutPixel(iX, iY, Col);
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSurface Fill
//////////////////////////////////////////////////////////////////////////////////
void CDXSurface::Fill(DWORD FillColor)
{
	DDBLTFX ddBltFx;

	ddBltFx.dwSize = sizeof(DDBLTFX);
	ddBltFx.dwFillColor = FillColor;
	m_lpDDS->Blt(NULL, NULL, NULL, DDBLT_WAIT | DDBLT_COLORFILL, &ddBltFx);
}

//////////////////////////////////////////////////////////////////////////////////
// Clip - clips a destination rectange and modifys X,Y coords appropriatly
//////////////////////////////////////////////////////////////////////////////////
void Clip(int *DestX, int *DestY, RECT *SrcRect, RECT *DestRect)
{
	// If it's partly off the right side of the screen
	if(*DestX + (SrcRect->right - SrcRect->left) > DestRect->right)
		SrcRect->right -= *DestX + (SrcRect->right-SrcRect->left) - DestRect->right;

	// Partly off the left side of the screen
	if(*DestX < DestRect->left)
	{
		SrcRect->left += DestRect->left - *DestX;
		*DestX = DestRect->left;
	}

	// Partly off the top of the screen
	if(*DestY < DestRect->top)
	{
		SrcRect->top += DestRect->top - *DestY;
		*DestY = DestRect->top;
	}

	// If it's partly off the bottom side of the screen
	if(*DestY + (SrcRect->bottom - SrcRect->top) > DestRect->bottom)
	SrcRect->bottom -= ((SrcRect->bottom-SrcRect->top)+*DestY) - DestRect->bottom;

	return;
}
