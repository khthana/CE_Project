//////////////////////////////////////////////////////////////////////////////////
// Project Name: [ CDX Class Library - CDX.lib ]
// Source File:  [ CDXTile Implementation ]
// Author:       [ Danny Farley - danny@jags.co.uk ]
// Revision:     [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXTile Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXTile::CDXTile(CDXScreen *pScreen, const char* szFilename, int w, int h, int num)
{
	Create(pScreen, szFilename, w, h, num);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXTile Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXTile::CDXTile()
{
	DestRect.top = 0;
	DestRect.left = 0;
	DestRect.bottom = 0;
	DestRect.right = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXTile Create
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXTile::Create(CDXScreen *pScreen, const char* szFilename, int w, int h, int num)
{
	if(szFilename == NULL) return FALSE;

  m_lpDDS = DDLoadSizeBitmap(pScreen->m_lpDD, szFilename, &m_PixelWidth, &m_PixelHeight);
	if(m_lpDDS == NULL) return FALSE;

	m_pFilename = szFilename;

	Screen = pScreen;

  m_BlockWidth = w;
	m_BlockHeight = h;
	m_BlockNum = num;
	
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
