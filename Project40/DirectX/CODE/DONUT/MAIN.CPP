//this project not use simple windows timmer
//it up date frame as it imposible and use delay (Sleep() function) to
//simmulate 30 frame per sec
//it use direct input with key board
#define NAME "xoom"
#define TITLE "xoom Project return"
#include <windows.h>
#include <windowsx.h>
#include <ddraw.h>
#include <dinput.h>
//#include "resource.h"
#include "ddutil.h"

#include "dinputx.h"


char szBitmap[] = "all.bmp";
// char szBitmap[] = "IDB_BITMAP1";
LPDIRECTDRAW		lpDD;		// DirectDraw object
LPDIRECTDRAWSURFACE	lpDDSPrimary;	// DirectDraw primary surface
LPDIRECTDRAWSURFACE	lpDDSBack;	// DirectDraw back surface
LPDIRECTDRAWSURFACE	lpDDSOne;	// Offscreen surface 1
LPDIRECTDRAWPALETTE	lpDDPal;	// DirectDraw palette
BOOL			bActive;	// is application active?

static int xpos = 576;
static int ypos = 416;
BYTE diks[256];             /* DirectInput keyboard state buffer */

HINSTANCE	g_hinst;


LPDIRECTINPUT           g_pdi;
LPDIRECTINPUTDEVICE     g_pKeyboard;
HWND					g_hwnd	= NULL;




/*
 * restoreAll
 *
 * restore all lost objects
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
            DDReLoadBitmap(lpDDSOne, szBitmap);
	}
    }
    return ddrval;

} /* restoreAll */

  
 /*
 * finiObjects
 *
 * finished with all objects we use; release them
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

	// finish direct input


    if (g_pKeyboard) {
        /*
         *  Cleanliness is next to godliness.  Unacquire the device
         *  one last time just in case we got really confused and tried
         *  to exit while the device is still acquired.
         */
        g_pKeyboard->Unacquire();

        g_pKeyboard->Release();
        g_pKeyboard = NULL;
    }//(g_pKeyboard)
    /*
     *  Destroy any lingering IDirectInput object.
     */
    if (g_pdi) {
        g_pdi->Release();
        g_pdi = NULL;
    }



} /* finiObjects */

/* update fram of animation at timmer ative */
void updateFrames(void)
{
    RECT		rcRect;
	static int currentframe=0 ;

    HRESULT		ddrval;

	if (currentframe<59)
	{
		currentframe++;
	}
	else currentframe=0;

    // Blit the stuff for the next frame
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
		{
			break;
		}
		if( ddrval == DDERR_SURFACELOST )
		{
			ddrval = restoreAll();
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

    if(ddrval != DD_OK)
    {
	return;
    }

			//bilt charactor
        rcRect.left   = currentframe%10*64;
        rcRect.top    = currentframe/10*64 + 480;
        rcRect.right  = currentframe%10*64 + 60;
        rcRect.bottom = currentframe/10*64 + 50 + 480;

	while( 1 )
	{
	    ddrval = lpDDSBack->BltFast( xpos, ypos, lpDDSOne,
                                 &rcRect, DDBLTFAST_SRCCOLORKEY  );
	    if( ddrval == DD_OK )
	    {
			break;
	    }
	    if( ddrval == DDERR_SURFACELOST )
	    {
			ddrval = restoreAll();
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
}/*updateFrames*/

/* flipFrame()
*/
void flipFrames(void)
{
    // Flip the surfaces
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
			ddrval = restoreAll();
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
 
/*flipFrames */ 
 
/*increasex
	increase value but not more than limit
*/
int increasex(int x,int limit)
{
	x=x+3;
	if (x > limit)
	{
		x= limit;
	}
	return x;
}/*increasex*/

/*decreasex
	decreas value but not less than limit
*/
int decreasex(int x,int limit)
{
	x=x-3;
	if (x < limit)
	{
		x = limit;
	}
	return x;
}/*decreasex*/

long FAR PASCAL WindowProc( HWND hWnd, UINT message, 
			    WPARAM wParam, LPARAM lParam )
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
    }

    return DefWindowProc(hWnd, message, wParam, lParam);

} /* WindowProc */

/*
 * This function is called if the initialization function fails
 */
BOOL initFail( HWND hwnd )
{
    finiObjects();
    MessageBox( hwnd, "DirectDraw Init FAILED", TITLE, MB_OK );
    DestroyWindow( hwnd );
    return FALSE;

} /* initFail */

/*
 * doInit - do work required for every instance of the application:
 *		  create the window, initialize data
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
    wc.lpszMenuName = NAME;
    wc.lpszClassName = NAME;
    RegisterClass( &wc );
    
    /*
     * create a window
     */
    hwnd = CreateWindowEx(
        0,
	NAME,
	TITLE,
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
    {
	return FALSE;
    }
	g_hwnd = hwnd;
    ShowWindow( hwnd, nCmdShow );
    UpdateWindow( hwnd );


    /*
     * create the main DirectDraw object
     */
    ddrval = DirectDrawCreate( NULL, &lpDD, NULL );
    if( ddrval != DD_OK )
    {
	return initFail(hwnd);
    }

    // Get exclusive mode
    ddrval = lpDD->SetCooperativeLevel( hwnd, DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN );
    if( ddrval != DD_OK )
    {
	return initFail(hwnd);
    }

    // Set the video mode to 640x480x8
    ddrval = lpDD->SetDisplayMode( 640, 480, 8);
    if( ddrval != DD_OK )
    {
	return initFail(hwnd);
    }

    // Create the primary surface with 1 back buffer
    ddsd.dwSize = sizeof( ddsd );
    ddsd.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
    ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE |
			  DDSCAPS_FLIP |
			  DDSCAPS_COMPLEX;
    ddsd.dwBackBufferCount = 1;
    ddrval = lpDD->CreateSurface( &ddsd, &lpDDSPrimary, NULL );
    if( ddrval != DD_OK )
    {
	return initFail(hwnd);
    }

    ddscaps.dwCaps = DDSCAPS_BACKBUFFER;
    ddrval = lpDDSPrimary->GetAttachedSurface(&ddscaps, &lpDDSBack);
    if( ddrval != DD_OK )
    {
	return initFail(hwnd);
    }

    // create and set the palette
    lpDDPal = DDLoadPalette(lpDD, szBitmap);

    if (lpDDPal)
        lpDDSPrimary->SetPalette(lpDDPal);

    // Create the offscreen surface, by loading our bitmap.
    lpDDSOne = DDLoadBitmap(lpDD, szBitmap, 0, 0);

    if( lpDDSOne == NULL )
    {
	return initFail(hwnd);
    }

    // Set the color key for this bitmap (black)
    DDSetColorKey(lpDDSOne, RGB(4,0,0));

	if (initDInputx() != TRUE )
	{
	return initFail(hwnd);
	}

	return TRUE;
} /* doInit */


/*
 * WinMain - initialization, message loop
 */
int PASCAL WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
			LPSTR lpCmdLine, int nCmdShow)
{
	g_hinst = hInstance;
    MSG         msg;

    lpCmdLine = lpCmdLine;
    hPrevInstance = hPrevInstance;

    if( !doInit( hInstance, nCmdShow ) )
    {
	return FALSE;
    }

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

			if (updateKeyStatus())
			{
				if (keyStatus(DIK_ESCAPE )){			//exit windows
				  PostMessage(g_hwnd, WM_CLOSE, 0, 0);
				}//if ..exit

				//up or down
				if(keyStatus(DIK_UP )) {
				ypos=decreasex(ypos,0);
		
				}
				else
					{
						if(keyStatus(DIK_DOWN )){
						ypos=increasex(ypos,410);
						}
					}
		
		//-----
				//left or right
				if(keyStatus(DIK_LEFT )) {
				xpos=decreasex(xpos,0);
				}
				else
					{
						if(keyStatus(DIK_RIGHT )){
						xpos=increasex(xpos,570);
						}
					}

			}// updateKeyStatus



			updateFrames();
			flipFrames();
			Sleep(1000/30);
			}else
			{
				WaitMessage();
			}
	}

    

} /* WinMain */







