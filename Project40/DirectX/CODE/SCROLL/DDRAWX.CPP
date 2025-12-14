
#include "ddrawx.h"
#include "main.h"
#define szBMPSource	"wallx.bmp"

#define	wall_NOx	0 //block
#define wall_NOy	30  //block

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
	currentx=0;
	currenty=0;
	blt_yet= FALSE;
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
 * Initial DirectDraw and set display mode
 *
 ***********************************************/
CBubbleDD::CBubbleDD(HWND _hwnd, int _width, int _height, int _bpp)
{
	init_var();

	HRESULT			ddrval;
	DDSURFACEDESC	ddsd;
    DDSCAPS			ddscaps;

	width = _width;
	height = _height;
	bpp = _bpp;

    /*
     * create the main DirectDraw object
     */
    ddrval = DirectDrawCreate(NULL, &lpDD, NULL);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
		lpDD = NULL;
		return;
    }

    // Get exclusive mode
    ddrval = lpDD->SetCooperativeLevel(_hwnd, DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
		DestroyDD();
		return;
    }

    // Set the video mode 
    ddrval = lpDD->SetDisplayMode(width, height, bpp);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
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
    ddrval = lpDD->CreateSurface(&ddsd, &lpDDSPrimary, NULL);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
		DestroyDD();
		return;
    }

	// Get attach back buffer
    ddscaps.dwCaps = DDSCAPS_BACKBUFFER;
    ddrval = lpDDSPrimary->GetAttachedSurface(&ddscaps, &lpDDSBack);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
		DestroyDD();
		return;
    }

	// Create buffer surface size more wide primary & back buffer(2block
	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
	ddsd.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
	ddsd.dwWidth = width;
	ddsd.dwHeight = height;
	ddrval = lpDD->CreateSurface(&ddsd, &lpDDSBuffer, NULL);
    if( ddrval != DD_OK )
    {
		init_value = ddrval;
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
BOOL CBubbleDD::init_success()
{
	return init_value == DD_OK ? TRUE : FALSE;
}

/*********************************************** 
 *
 * Char2Buffer // Blit character to Buffer surface
 *
 ***********************************************/
/*
void CBubbleDD::Char2Buffer(int _x, int _y, const CHAR_BASE &_c)
{
	HRESULT	ddrval;

	int sourcex,sourcey;

	// blit wall first	
	RECT rcRect;
	rcRect.left = wall_NOx * BLOCK_WIDE;
    rcRect.top = wall_NOy * BLOCK_WIDE;
    rcRect.right = rcRect.left + BLOCK_WIDE;
    rcRect.bottom = rcRect.top + BLOCK_HIGH;
    while( 1 )
    {
        ddrval = lpDDSBuffer->BltFast( _x, _y, lpDDSSource,
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
				return;
			}
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
		{
			return;
		}
	}

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

	}// _c.action

	//blit char in the second
	rcRect.left = sourcex;
    rcRect.top = sourcey;
    rcRect.right = sourcex+BLOCK_WIDE;
    rcRect.bottom = sourcey+BLOCK_HIGH;
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
}*/

/*********************************************** 
 *
 * BltBuffer2Back() // Blit buffer surface to back buffer
 *
 ***********************************************/
/*
void CBubbleDD::BltBuffer2Back()
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
}*/

/*********************************************** 
 *
 * Flip() // Flip the primary & back surface
 *
 ***********************************************/
void CBubbleDD::Flip()
{
    HRESULT		ddrval;
	if (blt_yet == FALSE)
		return;

	blt_yet = FALSE;  //clear and told that if have been flip
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

/**********************************************
*
* BltBuffer2Back4Part blit four part ,use for scroll screen
*
***********************************************/
void CBubbleDD::BltBuffer2Back4Part()
{
//  1 | 2     4 | 3
//	--+--  => --+--
//	3 | 4     2 | 1
//	
blt_yet = TRUE;//Told flip that it must to flip
int newx =width - currentx;
int newy =height - currenty;

    HRESULT		ddrval;
	RECT rcRect;
if(currentx <width)
{
	//start with 4

	rcRect.left = currentx;
    rcRect.top = currenty;
    rcRect.right = width;
    rcRect.bottom = height;
    while( 1 )
    {
        ddrval = lpDDSBack->BltFast( 0, 0, lpDDSBuffer,
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
				return;
			}
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
		{
			return;
		}
	}
}

	//3
if (currentx >0 )
{
	rcRect.left = 0;
    rcRect.top = currenty;
    rcRect.right = currentx;
    rcRect.bottom = height;
    while( 1 )
    {
        ddrval = lpDDSBack->BltFast( newx, 0, lpDDSBuffer,
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
				return;
			}
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
		{
			return;
		}
	}
}
	//2
if(currentx < width)
{
	rcRect.left = currentx;
    rcRect.top = 0;
    rcRect.right = width;
    rcRect.bottom = currenty;
    while( 1 )
    {
        ddrval = lpDDSBack->BltFast( 0, newy, lpDDSBuffer,
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
				return;
			}
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
		{
			return;
		}
	}
}
	//1
if (currentx >0)
{
	rcRect.left = 0;
    rcRect.top = 0;
    rcRect.right = currentx;
    rcRect.bottom = currenty;
    while( 1 )
    {
        ddrval = lpDDSBack->BltFast( newx,newy, lpDDSBuffer,
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
				return;
			}
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
		{
			return;
		}
	}
}
}

void CBubbleDD::Scrollingx(int step)
{
	currentx += step;
	if (currentx < 0 )
	{
		currentx = width + currentx; //scroll back
	}
	if (currentx >= width)
	{
		currentx = currentx - width; //scroll forword
	}
	BltBuffer2Back4Part();
}
void CBubbleDD::Scrollingy(int step)
{
	currenty += step;
	if (currenty < 0 )
	{
		currenty = height + currenty; //scroll top
	}
	if (currenty >= height)
	{
		currenty = currenty - height; //scroll down
	}
	BltBuffer2Back4Part();
}

void CBubbleDD::BltSource2Buffer()
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
        ddrval = lpDDSBuffer->BltFast(0, 0, lpDDSSource, 
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

/////////
void CBubbleDD::BltSource2Back(int x,int y,int left,int top ,int right ,int bottom )
{
	HRESULT ddrval;
	RECT	rcRect;

	// blit from buffer surface to back buffer

	rcRect.left = left;
    rcRect.top = top;
    rcRect.right = right;
    rcRect.bottom = bottom;

    while( 1 )
    {
        ddrval = lpDDSBack->BltFast(x, y, lpDDSSource, 
			&rcRect,DDBLTFAST_SRCCOLORKEY );

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