#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>
#include <dinput.h>
#include "ddutil.h"
LPDIRECTDRAW		lpDD;		// DirectDraw object
LPDIRECTDRAWSURFACE	lpDDSPrimary;//Primary surface
LPDIRECTDRAWSURFACE	lpDDSBack;	// Back Buffer surface
LPDIRECTDRAWSURFACE	lpDDSOne;	// Offscreen surface 1
LPDIRECTDRAWPALETTE	lpDDPal;	// DirectDraw palette
BOOL			bActive;	// is application active?
HINSTANCE	g_hinst;
HWND		g_hwnd	= NULL;
char szBitmap[] = "all.bmp";
static int	xpos = 300;
static int	ypos = 200;

/*
 * restoreAll    : restore all lost objects
 */
HRESULT restoreAll( void )
{
    HRESULT	ddrval;
    ddrval = lpDDSPrimary->Restore();
    if( ddrval == DD_OK )
    {
	ddrval = lpDDSOne->Restore();
	if( ddrval == DD_OK )
	{
            DDReLoadBitmap(lpDDSOne,szBitmap);
	}
    }
    return ddrval;
} /* restoreAll */

 /*
 * finiObjects   :release all object 
 */
static void finiObjects( void )
{
    if( lpDD != NULL )
    {
		if( lpDDSPrimary != NULL )
		{
			lpDDSPrimary->Release();
			lpDDSPrimary = NULL;
		}
		if( lpDDSOne != NULL )
		{
			lpDDSOne->Release();
			lpDDSOne = NULL;
		}
		if( lpDDPal != NULL )
		{
			lpDDPal->Release();
		    lpDDPal = NULL;
		}
		lpDD->Release();
		lpDD = NULL;
    }
}

void updateFrames(void)
{
    RECT		rcRect;
	static int currentframe=0 ;
    HRESULT		ddrval;
	if (currentframe<59)
		currentframe++;
	else currentframe=0;
	//bilt background
    rcRect.left = 0;
    rcRect.top = 0;
    rcRect.right = 640;
    rcRect.bottom = 480;
    while( 1 )
    {
        ddrval = lpDDSBack->BltFast( 0, 0, lpDDSOne,
            &rcRect, DDBLTFAST_NOCOLORKEY );

		if( ddrval == DD_OK )
			break;
		if( ddrval == DDERR_SURFACELOST )
		{
			ddrval = restoreAll();
			if( ddrval != DD_OK )
				return;
		}

		if( ddrval != DDERR_WASSTILLDRAWING )
			return;
	}
		//bilt charactor
        rcRect.left   = currentframe%10*64;
        rcRect.top    = currentframe/10*64 + 480;
        rcRect.right  = currentframe%10*64 + 60;
        rcRect.bottom = currentframe/10*64 + 50 + 480;
	while( 1 )
	{
	    ddrval=lpDDSBack->BltFast( xpos, ypos, lpDDSOne,
              &rcRect, DDBLTFAST_SRCCOLORKEY  );
	    if( ddrval == DD_OK )
			break;
	    if( ddrval == DDERR_SURFACELOST )
		{
			ddrval = restoreAll();
			if( ddrval != DD_OK )
				return;
	    }
	    if( ddrval != DDERR_WASSTILLDRAWING )
			return;
	}
}

/*
* flipFrame() ;exchange between back and primary
*/
void flipFrames(void)
{
    HRESULT		ddrval;
    while( 1 )
    {
		ddrval = lpDDSPrimary->Flip( NULL, 0 );
		if( ddrval == DD_OK )
			break;
		if( ddrval == DDERR_SURFACELOST )
		{
			ddrval = restoreAll();
			if( ddrval != DD_OK )
				break;
		}
		if( ddrval != DDERR_WASSTILLDRAWING )
			break;
    }
}
/*increasex
	increase value but not more than limit
*/
int increasex(int x,int limit)
{
	x=x+3;
	if (x > limit)
		x= limit;
	return x;
}/*increasex*/

/*decreasex
	decreas value but not less than limit
*/
int decreasex(int x,int limit)
{
	x=x-3;
	if (x < limit)
		x = limit;
	return x;
}/*decreasex*/

/*
*initFail() function for manage when initial fail
*/
BOOL initFail( HWND hwnd )
{
    finiObjects();
    MessageBox(hwnd,"DirectDraw Init FAILED","Exam1",MB_OK);
    DestroyWindow( hwnd );
    return FALSE;
}


long FAR PASCAL WindowProc( HWND hWnd, 
	UINT message,WPARAM wParam, LPARAM lParam )
{
    switch( message )
    {
    case WM_ACTIVATEAPP:
    	bActive = wParam;
		break;
    case WM_SETCURSOR:
        SetCursor(NULL);
        return TRUE;
    case WM_CREATE:
		break;
    case WM_DESTROY:
    	finiObjects();
		PostQuitMessage( 0 );
		break;
	case WM_KEYDOWN:
		switch(wParam)
		{
		case VK_UP:	ypos=decreasex(ypos,0);
			break;
		case VK_DOWN:ypos=increasex(ypos,410);
			break;
		case VK_LEFT:xpos=decreasex(xpos,0);
			break;
		case VK_RIGHT:xpos=increasex(xpos,570);
			break;
		case VK_ESCAPE:PostMessage(hWnd,WM_CLOSE,0,0);
			break;
		}
	}
    return DefWindowProc(hWnd, message, wParam, lParam);
}


/*
 * doInit - do work required for every instance of 
 the application ,create the window, initialize data
 */
static BOOL doInit( HINSTANCE hInstance, int nCmdShow )
{
    HWND		hwnd;
    WNDCLASS		wc;
    DDSURFACEDESC	ddsd;
    DDSCAPS		ddscaps;
    HRESULT		ddrval;
    /*
     * set up and register window class
     */
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = WindowProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hIcon = LoadIcon( hInstance, IDI_APPLICATION );
    wc.hCursor = LoadCursor( NULL, IDC_ARROW );
    wc.hbrBackground = GetStockBrush(BLACK_BRUSH);
    wc.lpszMenuName = "donut";
    wc.lpszClassName = "donut";
    RegisterClass( &wc );
    /*
     * create a window
     */
    hwnd = CreateWindowEx(
        0,
	"donut",
	"Donut Project",
	WS_POPUP,
	0,
	0,
        GetSystemMetrics(SM_CXSCREEN),
        GetSystemMetrics(SM_CYSCREEN),
	NULL,
	NULL,
	hInstance,
	NULL );
    if( !hwnd )
		return FALSE;
	g_hwnd = hwnd;
    ShowWindow( hwnd, nCmdShow );
    UpdateWindow( hwnd );
    
    //create the main DirectDraw object
    ddrval = DirectDrawCreate( NULL, &lpDD, NULL );
    if( ddrval != DD_OK )
		return initFail(hwnd);
    // Get exclusive mode
    ddrval = lpDD->SetCooperativeLevel( hwnd,
		DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN );
    if( ddrval != DD_OK )
    	return initFail(hwnd);
    // Set the video mode to 640x480x8
    ddrval = lpDD->SetDisplayMode( 640, 480, 8);
    if( ddrval != DD_OK )
		return initFail(hwnd);
    // Create the primary surface with 1 back buffer
    ddsd.dwSize = sizeof( ddsd );
    ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
    ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE |
			  DDSCAPS_FLIP |
			  DDSCAPS_COMPLEX;
    ddsd.dwBackBufferCount = 1;
    ddrval = lpDD->CreateSurface( &ddsd, &lpDDSPrimary, NULL );
    if( ddrval != DD_OK )
		return initFail(hwnd);
    ddscaps.dwCaps = DDSCAPS_BACKBUFFER;
    ddrval=lpDDSPrimary->GetAttachedSurface(&ddscaps,&lpDDSBack);
    if( ddrval != DD_OK )
		return initFail(hwnd);
    // create and set the palette
    lpDDPal = DDLoadPalette(lpDD,szBitmap);
    if (lpDDPal)
        lpDDSPrimary->SetPalette(lpDDPal);
    // Create the offscreen surface, by loading our bitmap.
    lpDDSOne = DDLoadBitmap(lpDD, szBitmap, 0, 0);
    if( lpDDSOne == NULL )
		return initFail(hwnd);
    // Set the color key for this bitmap (black)
    DDSetColorKey(lpDDSOne, RGB(4,0,0));

	return TRUE;
} /* doInit */

  
/*
 * WinMain - initialization, message loop
 */
int PASCAL WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,
			LPSTR lpCmdLine, int nCmdShow)
{
	g_hinst = hInstance;
    MSG         msg;
    lpCmdLine = lpCmdLine;
    hPrevInstance = hPrevInstance;
    if( !doInit( hInstance, nCmdShow ) )
		return FALSE;

	while (1)
	{
		if(PeekMessage(&msg,NULL,0,0,PM_NOREMOVE))
		{
			if (!GetMessage(&msg,NULL,0,0))
				return msg.wParam;
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
		else 
			if (bActive)
			{
			updateFrames();
			flipFrames();
			Sleep(1000/35);
			}else
				WaitMessage();
	}
} /* WinMain */
