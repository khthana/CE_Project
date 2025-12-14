#include "bb_dd.h"

#include <ddutil.h>

#define szBMPSource	"bubble.bmp"

#define	wall_NOx	0	//block
#define wall_NOy	30  //block

#define FIREBALLX	0
#define FIREBALLY	1054

#define NUMBERX		0
#define NUMBERY		1088

/*********************************************** 
 *
 * init_var() // initial all variable before use
 *
 ***********************************************/
void CBubbleDD::init_var()
{
	lpDD = NULL;
	lpDDSPrimary = NULL;
	lpDDSBack = NULL;
	lpDDSBuffer = NULL;
	lpDDSSource = NULL;
	lpDDPallete = NULL;


	init_value = FALSE;

	width = 640;	// default 
	height = 480;	// default
	bpp = 8;		// default
}

/*********************************************** 
 *
 * DestroyDD() // Destroy all DirectDraw relate
 *
 ***********************************************/
void CBubbleDD::DestroyDD()
{
    if( lpDD != NULL )
    {
		if( lpDDSPrimary != NULL )	
		{
			lpDDSPrimary->Release(); // lpDDSBack also Release
			lpDDSPrimary = NULL;
		}
		if( lpDDSBuffer != NULL )
		{
			lpDDSBuffer->Release();
			lpDDSBuffer = NULL;
		}		
		if( lpDDSSource != NULL )
		{
			lpDDSSource->Release();
			lpDDSSource = NULL;
		}
		if( lpDDPallete != NULL )
		{
			lpDDPallete->Release();
			lpDDPallete = NULL;
		}

		lpDD->Release();
		lpDD = NULL;
    }
}

/*********************************************** 
 *
 * RestoreAll() // Restore all surface
 *
 ***********************************************/
HRESULT CBubbleDD::RestoreAll()
{
    HRESULT	ddrval;

    ddrval = lpDDSPrimary->Restore();
    if( ddrval != DD_OK ) return ddrval;
   
	ddrval = lpDDSBack->Restore();
	if( ddrval != DD_OK ) return ddrval;

	ddrval = lpDDSSource->Restore();
	if( ddrval != DD_OK ) return ddrval;
	DDReLoadBitmap(lpDDSSource, szBMPSource);

	ddrval = lpDDSBuffer->Restore();
	if( ddrval != DD_OK ) return ddrval;
	// insert code after here for update buffer

    return ddrval;
} /* RestoreAll */

/***********************************************
 *
 * BltSrc2Buffer() // Blit from Source to Buffer
 *
 ***********************************************/
void CBubbleDD::BltSrc2Buffer(int _x,int _y,int _top,int _bottom,int _left ,int _right)
{
		HRESULT ddrval;
		RECT	rcRect;
		rcRect.left = _left;
		rcRect.top = _top;
		rcRect.right = _right;
		rcRect.bottom = _bottom;
		while( 1 )
		{
			ddrval = lpDDSBuffer->BltFast( _x, _y, lpDDSSource,
				&rcRect, DDBLTFAST_SRCCOLORKEY );

			if( ddrval == DD_OK )
			{
				break;
			}
			if( ddrval == DDERR_SURFACELOST )
			{
				ddrval = RestoreAll();
				if( ddrval != DD_OK )
				{
				return;
				}
			}
			if( ddrval != DDERR_WASSTILLDRAWING )
			{
				return;
			}
		}
}

/***********************************************
 *
 * BltSrc2Back() // Blit from Source to BackBuffer
 *
 ***********************************************/
void CBubbleDD::BltSrc2Back(int _x,int _y,int _top,int _bottom,int _left ,int _right)
{
		HRESULT ddrval;
		RECT	rcRect;
		rcRect.left = _left;
		rcRect.top = _top;
		rcRect.right = _right;
		rcRect.bottom = _bottom;
		while( 1 )
		{
			ddrval = lpDDSBack->BltFast( _x, _y, lpDDSSource,
				&rcRect, DDBLTFAST_SRCCOLORKEY );

			if( ddrval == DD_OK )
			{
				break;
			}
			if( ddrval == DDERR_SURFACELOST )
			{
				ddrval = RestoreAll();
				if( ddrval != DD_OK )
				{
				return;
				}
			}
			if( ddrval != DDERR_WASSTILLDRAWING )
			{
				return;
			}
		}
}

/*********************************************** 
 *
 * Initial DirectDraw and set display mode
 *
 ***********************************************/
CBubbleDD::CBubbleDD(HWND _hwnd, int _width, int _height, int _bpp)
{
	init_var();

	DDSURFACEDESC	ddsd;
	DDSCAPS			ddscaps;

	width = _width;
	height = _height;
	bpp = _bpp;

	/*
	 * create the main DirectDraw object
	 */
	init_value = DirectDrawCreate(NULL, &lpDD, NULL);
	if( init_value != DD_OK )
	{
		lpDD = NULL;
		return;
	}

	// Get exclusive mode
	init_value = lpDD->SetCooperativeLevel(_hwnd, DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN);
	if( init_value != DD_OK )
	{
		DestroyDD();
		return;
	}

	// Set the video mode
	init_value = lpDD->SetDisplayMode(width, height, bpp);
	if( init_value != DD_OK )
	{
		DestroyDD();
		return;
	}

    // Create the primary surface with 1 back buffer
    ddsd.dwSize = sizeof(ddsd);
    ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
    ddsd.ddsCaps.dwCaps = 
		DDSCAPS_PRIMARYSURFACE |
		DDSCAPS_FLIP |
		DDSCAPS_COMPLEX;
    ddsd.dwBackBufferCount = 1;
	init_value = lpDD->CreateSurface(&ddsd, &lpDDSPrimary, NULL);
	if( init_value != DD_OK )
	{
		DestroyDD();
		return;
	}

	// Get attach back buffer
	ddscaps.dwCaps = DDSCAPS_BACKBUFFER;
	init_value = lpDDSPrimary->GetAttachedSurface(&ddscaps, &lpDDSBack);
	if( init_value != DD_OK )
	{
		DestroyDD();
		return;
	}

	// Create buffer surface size equal primary & back buffer
	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
	ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	ddsd.dwWidth = width;
	ddsd.dwHeight = height;
	init_value = lpDD->CreateSurface(&ddsd, &lpDDSBuffer, NULL);
	if( init_value != DD_OK )
	{
		DestroyDD();
		return;
	}

	// Load and set the palette
	lpDDPallete = DDLoadPalette(lpDD, szBMPSource);

	if( lpDDPallete ) // OK
	{
		lpDDSPrimary->SetPalette(lpDDPallete);
	}
	else // no
	{
		init_value = DDERR_GENERIC;
		DestroyDD();
		return;
	}

	lpDDSSource = DDLoadBitmap(lpDD, szBMPSource, 0, 0);
	if( lpDDSSource == NULL ) // load bitmap fail
	{
		init_value = DDERR_GENERIC;
		DestroyDD();
		return;
    }

	// Set the color key for this bitmap (used upper-left corner)
    DDSetColorKey(lpDDSSource, RGB(0,0,0));

	// Blit backgroud to BufferSurface
	RECT rec;

	rec.left = 136;
	rec.top = 0;
	rec.right = 136+320;
	rec.bottom = 480;
	init_value = lpDDSBuffer->BltFast(0, 0, lpDDSSource, &rec, DDBLTFAST_NOCOLORKEY);

	rec.left = 136;
	rec.top = 480;
	rec.right = 136+320;
	rec.bottom = 960;
	init_value = lpDDSBuffer->BltFast(320, 0, lpDDSSource, &rec, DDBLTFAST_NOCOLORKEY);
}

/*********************************************** 
 *
 * ~CBubbleDD // destructor
 *
 ***********************************************/
CBubbleDD::~CBubbleDD()
{
	DestroyDD();
}

/*********************************************** 
 *
 * init_success() // answer is init DirectDraw success
 *
 ***********************************************/
BOOL CBubbleDD::InitSuccess()
{
	return init_value == DD_OK ? TRUE : FALSE;
}

/*********************************************** 
 *
 * Char2Buffer // Blit character to Buffer surface
 *
 ***********************************************/
void CBubbleDD::Char2Buffer(int _x, int _y, const CHAR_BASE &_c)
{
	if( lpDD != NULL )
	{

		int sourcex,sourcey;

		// blit wall first	
		 BltSrc2Buffer(_x,_y,wall_NOy * BLOCK_WIDE,wall_NOy * BLOCK_WIDE + BLOCK_HIGH,
			wall_NOx * BLOCK_WIDE,wall_NOx * BLOCK_WIDE+ BLOCK_WIDE);

		switch(_c.species)
		{
		case EC_MAGENTA:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 0*BLOCK_HIGH;
			break;
		case EC_BLUE:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 5*BLOCK_HIGH;
			break;
		case EC_RED:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 10*BLOCK_HIGH;
			break;
		case EC_YELLOW:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 15*BLOCK_HIGH;
			break;
		case EC_GREEN:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 20*BLOCK_HIGH;
			break;
		case EC_CYAN:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 25*BLOCK_HIGH;
			break;

		//special case no color example wall
		case EC_NONE:	//nothing to blit - wall
			return;

		} //switch(_c.species)

		switch(_c.action)
		{
		case EA_BOTTOM:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 0*BLOCK_HIGH;
			break;
		case EA_BOTTOM_RIGHT:
			sourcex += 1*BLOCK_WIDE;
			sourcey += 0*BLOCK_HIGH;
			break;
		case EA_BOTTOM_LEFT_RIGHT:
			sourcex += 2*BLOCK_WIDE;
			sourcey += 0*BLOCK_HIGH;
			break;
		case EA_BOTTOM_LEFT:
			sourcex += 3*BLOCK_WIDE;
			sourcey += 0*BLOCK_HIGH;
			break;

		case EA_ABOVE_BOTTOM:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 1*BLOCK_HIGH;
			break;
		case EA_ABOVE_BOTTOM_RIGHT:
			sourcex += 1*BLOCK_WIDE;
			sourcey += 1*BLOCK_HIGH;
			break;
		case EA_ABOVE_BOTTOM_LEFT_RIGHT:
			sourcex += 2*BLOCK_WIDE;
			sourcey += 1*BLOCK_HIGH;
			break;
		case EA_ABOVE_BOTTOM_LEFT:
			sourcex += 3*BLOCK_WIDE;
			sourcey += 1*BLOCK_HIGH;
			break;

		case EA_ABOVE:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 2*BLOCK_HIGH;
			break;
		case EA_ABOVE_RIGHT:
			sourcex += 1*BLOCK_WIDE;
			sourcey += 2*BLOCK_HIGH;
			break;
		case EA_ABOVE_LEFT_RIGHT:
			sourcex += 2*BLOCK_WIDE;
			sourcey += 2*BLOCK_HIGH;
			break;
		case EA_ABOVE_LEFT:
			sourcex += 3*BLOCK_WIDE;
			sourcey += 2*BLOCK_HIGH;
			break;

		case EA_NONE:
		case EA_USRDOWN1:
		case EA_USRDOWN2:
		case EA_USRDOWN3:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 3*BLOCK_HIGH;
			break;
		case EA_RIGHT:
			sourcex += 1*BLOCK_WIDE;
			sourcey += 3*BLOCK_HIGH;
			break;
		case EA_LEFT_RIGHT:
			sourcex += 2*BLOCK_WIDE;
			sourcey += 3*BLOCK_HIGH;
			break;
		case EA_LEFT:
			sourcex += 3*BLOCK_WIDE;
			sourcey += 3*BLOCK_HIGH;
			break;

		//not connect or alone  case

		case EA_BLOCKED:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 4*BLOCK_HIGH;
			break;
		case EA_BOMB:
			sourcex += 1*BLOCK_WIDE;
			sourcey += 4*BLOCK_HIGH;
			break;
		case EA_FALL:
			sourcex += 2*BLOCK_WIDE;
			sourcey += 4*BLOCK_HIGH;
			break;
		}// _c.action

		//blit char in the second
		BltSrc2Buffer(_x,_y,sourcey,sourcey+BLOCK_HIGH,
			sourcex,sourcex+BLOCK_WIDE);
	}
}

/*********************************************** 
 *
 * BltBuffer2Back() // Blit buffer surface to back buffer
 *
 ***********************************************/
void CBubbleDD::BltBuffer2Back()
{
	if( lpDD != NULL )
	{
		HRESULT ddrval;
		RECT	rcRect;

		// blit from buffer surface to back buffer

		rcRect.left = 0;
		rcRect.top = 0;
		rcRect.right = width;
		rcRect.bottom = height;

		while( 1 )
		{
			ddrval = lpDDSBack->BltFast(0, 0, lpDDSBuffer,
				&rcRect, DDBLTFAST_NOCOLORKEY );

			if( ddrval == DD_OK )
			{
				break;
			}

			if( ddrval == DDERR_SURFACELOST )
			{
				ddrval = RestoreAll();
				if( ddrval != DD_OK )
				{
					break;
				}
			}

			if( ddrval != DDERR_WASSTILLDRAWING )
			{
				break;
			}
		}
	}
}

/*********************************************** 
 *
 * OnlyChar2Back() // Blit character to Backbuffer
 *
 ***********************************************/
void CBubbleDD::OnlyChar2Back(int _x, int _y, int _limit_top, const CHAR_BASE &_c)
{
	if( lpDD != NULL )
	{
		int sourcex,sourcey;

		switch(_c.species)
		{
		case EC_MAGENTA:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 0*BLOCK_HIGH;
			break;
		case EC_BLUE:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 5*BLOCK_HIGH;
			break;
		case EC_RED:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 10*BLOCK_HIGH;
			break;
		case EC_YELLOW:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 15*BLOCK_HIGH;
			break;
		case EC_GREEN:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 20*BLOCK_HIGH;
			break;
		case EC_CYAN:
			sourcex = 0*BLOCK_WIDE;
			sourcey = 25*BLOCK_HIGH;
			break;

		case EC_NONE:	//nothing to blit 
			return;

		} //switch(_c.species)

		switch(_c.action)
		{
		case EA_USRDOWN1:
		case EA_USRDOWN2:
		case EA_USRDOWN3:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 3*BLOCK_HIGH;
			break;

		case EA_BLOCKED:
			sourcex += 0*BLOCK_WIDE;
			sourcey += 4*BLOCK_HIGH;
			break;
		}// _c.action

		//blit char in the second
		if( _y <= _limit_top )
		{
			int diff = _limit_top - _y;

			BltSrc2Back( _x, _limit_top, sourcey+diff, sourcey+BLOCK_HIGH, sourcex, sourcex+BLOCK_WIDE);
		}
		else
		{
			BltSrc2Back( _x, _y, sourcey, sourcey+BLOCK_HIGH, sourcex, sourcex+BLOCK_WIDE);
		}
	}
}

/***********************************************
 *
 * Flip() // Flip the primary & back surface
 *
 ***********************************************/
void CBubbleDD::Flip()
{
	if( lpDD != NULL )
	{
		HRESULT		ddrval;

		while( 1 )
		{
			ddrval = lpDDSPrimary->Flip( NULL, 0 );
			if( ddrval == DD_OK )
			{
				break;
			}

			if( ddrval == DDERR_SURFACELOST )
			{
				ddrval = RestoreAll();
				if( ddrval != DD_OK )
				{
					break;
				}
			}

			if( ddrval != DDERR_WASSTILLDRAWING )
			{
				break;
			}
		}
	}
}

/***********************************************
 *
 * Boom_Num() // draw number of bomb
 *
 ***********************************************/
void CBubbleDD::BoomNum( int x,int y ,int boom_num)
{
	x+=2*BLOCK_WIDE;
	div_t result;

	result = div( boom_num, 10 ); 
	BltSrc2Buffer(x,y,NUMBERY,NUMBERY+BLOCK_HIGH,BLOCK_WIDE*result.rem,(BLOCK_WIDE*result.rem)+BLOCK_WIDE);
	result = div( result.quot, 10 ); 
	BltSrc2Buffer(x-BLOCK_WIDE, y,NUMBERY,NUMBERY+BLOCK_HIGH,BLOCK_WIDE*result.rem,(BLOCK_WIDE*result.rem)+BLOCK_WIDE);
	result = div( result.quot, 10 ); 
	BltSrc2Buffer(x-(2*BLOCK_WIDE), y,NUMBERY,NUMBERY+BLOCK_HIGH,BLOCK_WIDE*result.rem,(BLOCK_WIDE*result.rem)+BLOCK_WIDE);
}

