//////////////////////////////////////////////////////////////////////////////////
// Project Name:   [ CDX Class Library - CDX.lib ]
// Source File:    [ CDXMap Implementation ]
// Author:				 [ Danny Farley - danny@jags.co.uk ]
// Contributions:  [ Keith Fuller ]
// Revision:       [ 1.5 ]
//////////////////////////////////////////////////////////////////////////////////
#include "CDX.h"

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Constructor
//////////////////////////////////////////////////////////////////////////////////
CDXMap::CDXMap(CDXTile *pTiles, CDXScreen *pScreen)
{
	DATA = NULL;
	Tiles = pTiles;

	m_TileWidth = Tiles->m_BlockWidth;
	m_TileHeight = Tiles->m_BlockHeight;

	m_PosX = 0;
	m_PosY = 0;

	SCREEN_W = pScreen->m_dwPixelWidth;
	SCREEN_H = pScreen->m_dwPixelHeight;

	SCREEN_TW = SCREEN_W / m_TileWidth;
	SCREEN_TH = SCREEN_H / m_TileHeight;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Destructor
//////////////////////////////////////////////////////////////////////////////////
CDXMap::~CDXMap()
{
	delete [] DATA;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Create
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::Create(int Width, int Height, int Fill)
{
	m_Width = Width;
	m_Height = Height;

	m_PixelWidth = m_Width * m_TileWidth;
	m_PixelHeight = m_Height * m_TileHeight;

	SIZE = m_Width * m_Height;
  DATA = new int[SIZE];

  for(int i=0; i<SIZE; i++)
		DATA[i] = Fill;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap LoadMap
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXMap::Load(const char *szFilename)
{
	if(szFilename == NULL) return FALSE;
  FILE *fp;

	fp = fopen(szFilename, "rb");
	if(fp == NULL) return FALSE;

	fread(&m_Width, sizeof(int), 1, fp);
	fread(&m_Height, sizeof(int), 1, fp);
	
	SIZE = m_Width * m_Height;
  DATA = new int[SIZE];

	fread(DATA, sizeof(int), SIZE, fp);

  fclose(fp);

	m_PixelWidth = m_Width * m_TileWidth;
	m_PixelHeight = m_Height * m_TileHeight;

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap SaveMap
//////////////////////////////////////////////////////////////////////////////////
BOOL CDXMap::Save(const char *szFilename)
{
  FILE *fp;

	fp = fopen(szFilename, "wb");
  if(fp == NULL) return FALSE;

	fwrite(&m_Width, sizeof(int), 1, fp);
	fwrite(&m_Height, sizeof(int), 1, fp);

	SIZE = m_Width * m_Height;

	fwrite(DATA, sizeof(int), SIZE, fp);

	fclose(fp);

	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Clear
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::Clear()
{
  for(int i=0; i<SIZE; i++)
		DATA[i] = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Fill
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::Fill(int TileNum)
{
  for(int i=0; i<SIZE; i++)
		DATA[i] = TileNum;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap MoveTo
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::MoveTo(int PosX, int PosY)
{
	m_PosX = PosX;
	m_PosY = PosY;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap ScrollUp
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::ScrollUp(int Offset)
{
	m_PosY -= Offset;
	if(m_PosY < 0) m_PosY = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap ScrollDown
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::ScrollDown(int Offset)
{
	m_PosY += Offset;
	if(m_PosY > (m_Height - SCREEN_TH) * m_TileHeight)
		m_PosY = (m_Height - SCREEN_TH) * m_TileHeight;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap ScrollLeft
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::ScrollLeft(int Offset)
{
	m_PosX -= Offset;
	if(m_PosX < 0) m_PosX = 0;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap ScrollRight
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::ScrollRight(int Offset)
{
	m_PosX += Offset;
	if(m_PosX > (m_Width - SCREEN_TW) * m_TileWidth)
		m_PosX = (m_Width - SCREEN_TW) * m_TileWidth;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap WrapScrollUp
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::WrapScrollUp(int Offset)
{
	if(m_PosY - Offset >= 0) m_PosY -= Offset;
	else m_PosY = (m_Height * m_TileHeight) - Offset + m_PosY;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap WrapScrollDown
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::WrapScrollDown(int Offset)
{
	if (m_PosY + Offset < (m_Height * m_TileHeight)) m_PosY += Offset;
	else m_PosY = Offset - (m_Height * m_TileHeight) + m_PosY;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap WrapScrollLeft
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::WrapScrollLeft(int Offset)
{
	if (m_PosX - Offset >= 0) m_PosX -= Offset;
	else m_PosX = (m_Width * m_TileWidth) - Offset + m_PosX;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap WrapScrollRight
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::WrapScrollRight(int Offset)
{
	if (m_PosX + Offset < (m_Width * m_TileWidth)) m_PosX += Offset;
	else m_PosX = Offset - (m_Width * m_TileWidth) + m_PosX;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap ScreenTileSize
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::ScreenTileSize(int Width, int Height)
{
	SCREEN_TW = Width;
	SCREEN_TH = Height;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap GetTile
//////////////////////////////////////////////////////////////////////////////////
int CDXMap::GetTile(int MapX, int MapY)
{
	return DATA[MapX + (MapY * m_Width)];
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap SetTile
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::SetTile(int MapX, int MapY, int Tile)
{
	DATA[MapX + (MapY * m_Width)] = Tile;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap LoadTiles
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::LoadTiles(CDXTile *pTiles)
{
	Tiles = pTiles;
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap BltTile
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::BltTile(CDXSurface* lpDDS, int xdest, int ydest, int w, int h, int xoff, int yoff)
{
	HRESULT rval;
	RECT src;
	int tile_num;
	int x1, y1;
	int mapx, mapy;

	mapx = ((m_PosX + xdest) % m_PixelWidth) / m_TileWidth;
	mapy = ((m_PosY + ydest) % m_PixelHeight) / m_TileHeight;

	tile_num = DATA[(mapy * m_Width) + mapx];

	if(tile_num == 0) return;

	int TILE_SW = Tiles->m_PixelWidth / m_TileWidth;

	x1 = tile_num % TILE_SW;
	x1 = (x1 * m_TileWidth) + xoff;

	y1 = tile_num / TILE_SW;
	y1 = (y1 * m_TileHeight) + yoff;

	src.top = y1;
	src.left = x1;
	src.bottom = y1+h;
	src.right = x1+w;

	rval = lpDDS->m_lpDDS->BltFast(xdest, ydest, Tiles->m_lpDDS, &src, DDBLTFAST_WAIT);
	if(rval == DDERR_SURFACELOST) Tiles->Restore();
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap BltTile
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::BltTileTrans(CDXSurface* lpDDS, int xdest, int ydest, int w, int h, int xoff, int yoff)
{
	HRESULT rval;
	RECT src;
	int tile_num;
	int x1, y1;
	int mapx, mapy;

	mapx = ((m_PosX + xdest) % m_PixelWidth) / m_TileWidth;
	mapy = ((m_PosY + ydest) % m_PixelHeight) / m_TileHeight;

	tile_num = DATA[(mapy * m_Width) + mapx];

	if(tile_num == 0) return;

	int TILE_SW = Tiles->m_PixelWidth / m_TileWidth;

	x1 = tile_num % TILE_SW;
	x1 = (x1 * m_TileWidth) + xoff;

	y1 = tile_num / TILE_SW;
	y1 = (y1 * m_TileHeight) + yoff;

	src.top = y1;
	src.left = x1;
	src.bottom = y1+h;
	src.right = x1+w;

	rval = lpDDS->m_lpDDS->BltFast(xdest, ydest, Tiles->m_lpDDS, &src, DDBLTFAST_WAIT | DDBLTFAST_SRCCOLORKEY);
	if(rval == DDERR_SURFACELOST) Tiles->Restore();
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap Draw
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::Draw(CDXSurface* lpDDS)
{
	int i,j;
	int xoffset, yoffset;
	int xcoord = 0, ycoord = 0;

	xoffset = m_PosX % m_TileWidth;
	yoffset = m_PosY % m_TileHeight;

	// FIRST ROW
	BltTile(lpDDS, 0, 0, m_TileWidth-xoffset, m_TileWidth-yoffset, xoffset, yoffset);

	for(i=0; i<SCREEN_TW-1; i++)
  {
		xcoord += m_TileWidth;
		BltTile(lpDDS, xcoord-xoffset, 0, m_TileWidth, m_TileHeight-yoffset, 0, yoffset);
  }

	xcoord += m_TileWidth;
	BltTile(lpDDS, xcoord-xoffset, 0, xoffset, m_TileHeight-yoffset, 0, yoffset);

	// NEXT X NUMBER OF ROWS
	for(j=0; j<SCREEN_TH-1; j++)
	{
		xcoord = m_TileWidth;
		ycoord += m_TileHeight;
		BltTile(lpDDS, 0, ycoord-yoffset, m_TileWidth-xoffset, m_TileHeight, xoffset, 0);

		for(i=0; i<SCREEN_TW-1; i++)
		{
			BltTile(lpDDS, xcoord-xoffset, ycoord-yoffset, m_TileWidth, m_TileHeight, 0, 0);
			xcoord += m_TileWidth;
		}

		BltTile(lpDDS, xcoord-xoffset, ycoord-yoffset, xoffset, m_TileHeight, 0, 0);
	}

	// LAST ROW
	xcoord = 0;
	ycoord += m_TileHeight;
	BltTile(lpDDS, 0, ycoord-yoffset, m_TileWidth-xoffset, yoffset, xoffset, 0);

	for(i=0; i<SCREEN_TW-1; i++)
	{
		xcoord += m_TileWidth;
		BltTile(lpDDS, xcoord-xoffset, ycoord-yoffset, m_TileWidth, yoffset, 0, 0);
	}

	xcoord += m_TileWidth;
	BltTile(lpDDS, xcoord-xoffset, ycoord-yoffset, xoffset, yoffset, 0, 0);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap DrawTrans
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::DrawTrans(CDXSurface* lpDDS)
{
	int i,j;
	int xoffset, yoffset;
	int xcoord = 0, ycoord = 0;

	xoffset = m_PosX % m_TileWidth;
	yoffset = m_PosY % m_TileHeight;

	// FIRST ROW
	BltTileTrans(lpDDS, 0, 0, m_TileWidth-xoffset, m_TileWidth-yoffset, xoffset, yoffset);

	for(i=0; i<SCREEN_TW-1; i++)
  {
		xcoord += m_TileWidth;
		BltTileTrans(lpDDS, xcoord-xoffset, 0, m_TileWidth, m_TileHeight-yoffset, 0, yoffset);
  }

	xcoord += m_TileWidth;
	BltTileTrans(lpDDS, xcoord-xoffset, 0, xoffset, m_TileHeight-yoffset, 0, yoffset);

	// NEXT X NUMBER OF ROWS
	for(j=0; j<SCREEN_TH-1; j++)
	{
		xcoord = m_TileWidth;
		ycoord += m_TileHeight;
		BltTileTrans(lpDDS, 0, ycoord-yoffset, m_TileWidth-xoffset, m_TileHeight, xoffset, 0);

		for(i=0; i<SCREEN_TW-1; i++)
		{
			BltTileTrans(lpDDS, xcoord-xoffset, ycoord-yoffset, m_TileWidth, m_TileHeight, 0, 0);
			xcoord += m_TileWidth;
		}

		BltTileTrans(lpDDS, xcoord-xoffset, ycoord-yoffset, xoffset, m_TileHeight, 0, 0);
	}

	// LAST ROW
	xcoord = 0;
	ycoord += m_TileHeight;
	BltTileTrans(lpDDS, 0, ycoord-yoffset, m_TileWidth-xoffset, yoffset, xoffset, 0);

	for(i=0; i<SCREEN_TW-1; i++)
	{
		xcoord += m_TileWidth;
		BltTileTrans(lpDDS, xcoord-xoffset, ycoord-yoffset, m_TileWidth, yoffset, 0, 0);
	}

	xcoord += m_TileWidth;
	BltTileTrans(lpDDS, xcoord-xoffset, ycoord-yoffset, xoffset, yoffset, 0, 0);
}

//////////////////////////////////////////////////////////////////////////////////
// CDXMap DrawClipped
//////////////////////////////////////////////////////////////////////////////////
void CDXMap::DrawClipped(CDXSurface* lpDDS, LPRECT ClipRect)
{
	int xoffset = (m_PosX + ClipRect->left) % m_TileWidth;
	int yoffset = (m_PosY + ClipRect->top) % m_TileWidth;
	int xcoord = 0;
	int ycoord = 0;
	int minwidth = (m_TileWidth - xoffset) < (ClipRect->right - ClipRect->left)
									? (m_TileWidth - xoffset) : (ClipRect->right - ClipRect->left);
	int minheight = (m_TileHeight - yoffset) < (ClipRect->bottom - ClipRect->top)
									 ? (m_TileHeight - yoffset) : (ClipRect->bottom - ClipRect->top);

	// FIRST ROW
	BltTile(lpDDS, ClipRect->left, ClipRect->top, minwidth, minheight, xoffset, yoffset);
	xcoord = ClipRect->left + minwidth;

	while ((xcoord + m_TileWidth) < ClipRect->right)
	{
		BltTile(lpDDS, xcoord, ClipRect->top, m_TileWidth, minheight, 0, yoffset);
		xcoord += m_TileWidth;
	}

	BltTile(lpDDS, xcoord, ClipRect->top, ClipRect->right - xcoord,	minheight, 0, yoffset);

	// NEXT X NUMBER OF ROWS
	ycoord = ClipRect->top + minheight;

	while((ycoord + m_TileHeight) < ClipRect->bottom)
	{
		BltTile(lpDDS, ClipRect->left, ycoord, minwidth, m_TileHeight,	xoffset, 0);
		xcoord = ClipRect->left + minwidth;

		while((xcoord + m_TileWidth) < ClipRect->right)
		{
			BltTile(lpDDS, xcoord, ycoord, m_TileWidth, m_TileHeight, 0, 0);
			xcoord += m_TileWidth;
		}

		BltTile(lpDDS, xcoord, ycoord, ClipRect->right - xcoord,	m_TileHeight, 0, 0);
		ycoord += m_TileHeight;
	}

	// LAST ROW
	BltTile(lpDDS, ClipRect->left, ycoord, minwidth, ClipRect->bottom - ycoord, xoffset, 0);
	xcoord = ClipRect->left + minwidth;

	while((xcoord + m_TileWidth) < ClipRect->right)
	{
		BltTile(lpDDS, xcoord, ycoord, m_TileWidth, ClipRect->bottom - ycoord,	0, 0);
		xcoord += m_TileWidth;
	}

	BltTile(lpDDS, xcoord, ycoord, ClipRect->right - xcoord,	ClipRect->bottom - ycoord, 0, 0);
}
