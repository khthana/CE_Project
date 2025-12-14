//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXSprite Implementation ]
// Author:         [ Danny Farley - danny@jags.co.uk ]
// Contributions:  [ Harold L. Blankenship ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSprite::CDXSprite(CDXTile* pTile)
{
	Create(pTile);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXSprite::CDXSprite(CDXScreen *pScreen, const char* Filename, int w, int h, int num)
{
	Create(pScreen, Filename, w, h, num);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXSprite::~CDXSprite(void)
{
	m_Tile = NULL;
	m_Next = NULL;
	m_Prev = NULL;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Create - creates a sprite object
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSprite::Create(CDXTile* pTile)
{
	if(pTile == NULL) return FALSE;

	m_PosX = m_PosY = 0;
	m_VelX = m_VelY = 0;
	m_Frame = 0;
	m_Delay = 0;
	m_State = 0;
	m_Type = 0;

	m_Next = NULL;
	m_Prev = NULL;

	m_Tile = pTile;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Create - creates a sprite object
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSprite::Create(CDXScreen *pScreen, const char* Filename, int w, int h, int num)
{
	if(Filename == NULL) return FALSE;

	m_PosX = m_PosY = 0;
	m_VelX = m_VelY = 0;
	m_Frame = 0;
	m_Delay = 0;
	m_State = 0;
	m_Type = 0;

	m_Next = NULL;
	m_Prev = NULL;

	m_Tile = new CDXTile(pScreen, Filename, w, h, num);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite SelectFrame - chooses the current frame, internal use
//////////////////////////////////////////////////////////////////////////////////
void CDXSprite::SelectFrame()
{
	int x1, y1;
	int SCREEN_TW;

	SCREEN_TW = m_Tile->m_PixelWidth / m_Tile->m_BlockWidth;

  x1 = m_Frame % SCREEN_TW;
	x1 *= m_Tile->m_BlockWidth;

	y1 = m_Frame / SCREEN_TW;
	y1 *= m_Tile->m_BlockHeight;

	m_Tile->SrcRect.top = y1;
	m_Tile->SrcRect.left = x1;
	m_Tile->SrcRect.bottom = y1 + m_Tile->m_BlockHeight;
	m_Tile->SrcRect.right = x1 + m_Tile->m_BlockWidth;

	m_Tile->DestRect.top = m_PosY;
	m_Tile->DestRect.left = m_PosX;
	m_Tile->DestRect.bottom = m_PosY + m_Tile->m_BlockHeight;
	m_Tile->DestRect.right = m_PosX + m_Tile->m_BlockWidth;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite Draw - draws a sprite, can do stretch blits
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::Draw(CDXSurface* lpDDS)
{
	SelectFrame();
	return m_Tile->Draw(lpDDS);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawFast - draws a sprite, fast
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::DrawFast(CDXSurface* lpDDS)
{
	SelectFrame();
	return m_Tile->DrawFast(m_PosX, m_PosY, lpDDS);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawTrans - draws a transparent sprite
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::DrawTrans(CDXSurface* lpDDS)
{
	SelectFrame();
	return m_Tile->DrawTrans(m_PosX, m_PosY, lpDDS);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawClipped - draws a clipped sprite
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::DrawClipped(CDXSurface* lpDDS, LPRECT ClipRect)
{
	SelectFrame();
	return m_Tile->DrawClipped(m_PosX, m_PosY, lpDDS, ClipRect);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawWindowed
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::DrawWindowed(CDXSurface* lpDDS)
{
	SelectFrame();
	return m_Tile->DrawWindowed(lpDDS);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawScaled
//////////////////////////////////////////////////////////////////////////////////
HRESULT CDXSprite::DrawScaled(float Factor, CDXSurface* lpDDS)
{
	HRESULT rval;

	SelectFrame();

	m_Tile->DestRect.top = m_PosY;
	m_Tile->DestRect.left = m_PosX;
	m_Tile->DestRect.bottom = (m_PosY + m_Tile->m_BlockHeight) * Factor;
	m_Tile->DestRect.right = (m_PosX + m_Tile->m_BlockWidth) * Factor;

  rval = lpDDS->m_lpDDS->Blt(&m_Tile->DestRect, m_Tile->m_lpDDS, &m_Tile->SrcRect, DDBLT_WAIT | DDBLT_KEYSRC, NULL);
	if(rval == DDERR_SURFACELOST) m_Tile->Restore();

	return rval;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawRotated
//////////////////////////////////////////////////////////////////////////////////
void CDXSprite::DrawRotated(float Angle, CDXSurface* lpDDS)
{
	// NOT IMPLEMENTED
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawHFlip
//////////////////////////////////////////////////////////////////////////////////
void CDXSprite::DrawHFlip(CDXSurface* Dest)
{
	int Pixel;

	SelectFrame();

	for(int j = 0; j < m_Tile->m_BlockHeight; j++)
	{
		for(int i = 0; i < m_Tile->m_BlockWidth; i++)
		{
			Pixel = m_Tile->GetPixel(i + m_Tile->SrcRect.left, j + m_Tile->SrcRect.top);
			if(Pixel != m_Tile->m_ColorKey)
				Dest->PutPixel((m_PosX + m_Tile->m_BlockWidth) - i, m_PosY + j, Pixel);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite DrawVFlip
//////////////////////////////////////////////////////////////////////////////////
void CDXSprite::DrawVFlip(CDXSurface* Dest)
{
	int Pixel;

	SelectFrame();

	for(int j = 0; j < m_Tile->m_BlockHeight; j++)
	{
		for(int i = 0; i < m_Tile->m_BlockWidth; i++)
		{
			Pixel = m_Tile->GetPixel(i + m_Tile->SrcRect.left, j + m_Tile->SrcRect.top);
			if(Pixel != m_Tile->m_ColorKey)
				Dest->PutPixel(m_PosX + i, (m_PosY + m_Tile->m_BlockHeight) - j, Pixel);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite SpriteHit - checks for sprite collisions
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSprite::SpriteHit(CDXSprite* pSprite)
{
	if(pSprite == this) return FALSE;

	RECT Rect1 = { m_PosX, m_PosY,
								 m_PosX + m_Tile->m_BlockWidth,
								 m_PosY + m_Tile->m_BlockHeight };
	RECT Rect2 = { pSprite->m_PosX, pSprite->m_PosY,
								 pSprite->m_PosX + pSprite->m_Tile->m_BlockWidth,
								 pSprite->m_PosY + pSprite->m_Tile->m_BlockHeight };

	if(Rect1.top > Rect2.bottom) return FALSE;
	else if(Rect1.bottom < Rect2.top) return FALSE;
	else if(Rect1.right < Rect2.left) return FALSE;
	else if(Rect1.left > Rect2.right) return FALSE;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXSprite TileHit - checks for tile collisions
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXSprite::TileHit(CDXMap* pMap, int Tile)
{
	int MapX, MapY, TileType;

	// Check top left
  MapX = (pMap->m_PosX + m_PosX) / pMap->m_TileWidth;
  MapY = (pMap->m_PosY + m_PosY) / pMap->m_TileHeight;
  TileType = pMap->GetTile(MapX, MapY);
  if(TileType == Tile) return TRUE;

	// Check top right
  MapX = (pMap->m_PosX + m_PosX + m_Tile->m_BlockWidth) / pMap->m_TileWidth;
  MapY = (pMap->m_PosY + m_PosY) / pMap->m_TileHeight;
  TileType = pMap->GetTile(MapX, MapY);
  if(TileType == Tile) return TRUE;

	// Check bottom left
  MapX = (pMap->m_PosX + m_PosX) / pMap->m_TileWidth;
  MapY = (pMap->m_PosY + m_PosY + m_Tile->m_BlockHeight) / pMap->m_TileHeight;
  TileType = pMap->GetTile(MapX, MapY);
  if(TileType == Tile) return TRUE;

	// Check bottom right
  MapX = (pMap->m_PosX + m_PosX + m_Tile->m_BlockWidth) / pMap->m_TileWidth;
  MapY = (pMap->m_PosY + m_PosY + m_Tile->m_BlockHeight) / pMap->m_TileHeight;
  TileType = pMap->GetTile(MapX, MapY);
  if(TileType == Tile) return TRUE;

	return FALSE;
}
